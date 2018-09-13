package com.coffeebeans.auto.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.coffeebeans.auto.dao.CommonDao;
import com.coffeebeans.auto.entity.References;
import com.coffeebeans.auto.entity.UserDb;
import com.coffeebeans.auto.service.ExcelUtilityService;
import com.coffeebeans.auto.service.MailService;

/**
 * Provides service end points for report generation related functionalities
 */
@Controller
@RequestMapping("/export")
public class ExcelController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ExcelController.class);

	@Value("${exportFilePath}")
	private String exportFilePath;

	@Value("${excelUploadPath}")
	private String excelUploadPath;

	@Autowired
	private CommonDao commonDao;

	@Autowired
	private ExcelUtilityService excelService;

	@Autowired
	private MailService mailService;

	@RequestMapping(value = "/excel", method = RequestMethod.POST)
	public @ResponseBody void exportSelectedDataToReport(@RequestParam("selectedRecs") List<Integer> iData,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		// get the file path and file name
		String fileName = "Report.xlsx";
		String filePath = exportFilePath;

		// if file has been generated successfully, then no exception would have
		// occurred
		excelService.exportDetailedReportToExcel(filePath + fileName, iData);

		exportFile(filePath, fileName, request, response);
		LOGGER.info("Exported the requested Detailed Report to user's system. ");
		File fileToDelete = new File(filePath + fileName);

		try {
			if (fileToDelete.exists()) {
				fileToDelete.delete();
			}
		} catch (Exception e) {
			LOGGER.error("Exception occurred while deleting file." + e.getMessage() + " for file : "
					+ fileToDelete.getAbsolutePath());
		}
	}

	@RequestMapping(value = "/file", method = RequestMethod.POST)
	public @ResponseBody void exportSelectedDataToReport(@RequestParam("link") String iLink, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// get the file path and file name
		String fileName = iLink.substring(iLink.lastIndexOf('/') + 1);
		String filePath = iLink.substring(0, iLink.lastIndexOf(File.separator));

		LOGGER.info("Exporting the requested reference file. " + filePath + "/" + fileName);
		exportFile(filePath + "/", fileName, request, response);
		LOGGER.info("Exported the requested file to user's system. ");
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public void firstUpload(HttpServletRequest request, @RequestParam("dataFile") MultipartFile multipartFile,
			@RequestParam("filename") String filename, @RequestParam("title") String title,
			@RequestParam("addedBy") String addedBy, @RequestParam("emails") List<String> emails) {
		// LOGGER.info("fileUpload info:" + multipartFile.getOriginalFilename());
		try {
			String destFolder = excelUploadPath;

			CommonsMultipartFile cf = (CommonsMultipartFile) multipartFile;
			DiskFileItem fi = (DiskFileItem) cf.getFileItem();
			File newFile = fi.getStoreLocation();

			String oldName = multipartFile.getOriginalFilename();
			// System.out.println("-----"+oldName);
			String ext = oldName.substring(oldName.indexOf('.') + 1);
			try {
				uploadFile(newFile, destFolder + filename);

				LOGGER.info("Uploaded file to shared drive Successfully ");

				References refToSave = new References();
				refToSave.setAddedBy(addedBy);
				refToSave.setTitle(title);
				refToSave.setType("Upload");
				refToSave.setReference(destFolder + filename);

				commonDao.createReference(refToSave);

				if (!emails.isEmpty()) {
					String[] allRecipients = new String[emails.size()];
					allRecipients = emails.toArray(allRecipients);
					mailService.sendNotification(" [COFFEEBEANS] New document uploaded into repository", allRecipients,
							getEmailMessage(refToSave));
				}
			} catch (Exception e) {
				LOGGER.error("firstUpload failed!", e);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void exportFile(String iFilePath, String iFileName, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		// check if the format is of Excel, set contentType appropriately
		if (iFileName.endsWith("xls") || iFileName.endsWith("xlsx")) {
			response.setContentType("application/vnd.ms-excel");
		} else {
			response.setContentType("APPLICATION/OCTET-STREAM");
		}
		response.setHeader("Content-Disposition", "attachment; filename=\"" + iFileName + "\"");

		FileInputStream fileInputStream = new FileInputStream(iFilePath + iFileName);

		int i;
		while ((i = fileInputStream.read()) != -1) {
			out.write(i);
		}
		fileInputStream.close();
		out.close();
	}

	/**
	 * Method to upload given file onto the server with given file Name
	 * 
	 * @param file
	 * @param fileName
	 * @throws Exception
	 */
	private void uploadFile(File file, String fileName) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Length: " + file.length());
			// LOGGER.info("Type: " + file.getContentType());
			LOGGER.debug("Name: " + file.getName());
			// LOGGER.info("lastNam: " + file.getOriginalFilename());
			LOGGER.debug("========================================");
		}
		try {
			FileOutputStream outputStream = new FileOutputStream(fileName);
			FileInputStream inputStream = new FileInputStream(file);

			int byteCount = 0;
			byte[] bytes = new byte[1024];
			while ((byteCount = inputStream.read(bytes)) != -1) {
				outputStream.write(bytes, 0, byteCount);
			}
			outputStream.close();
			inputStream.close();
		} catch (IOException e) {
			LOGGER.info("Exception occurred while uploading presentation file " + e.getMessage());
		}
	}

	private String getEmailMessage(References ref) {
		StringBuffer msg = new StringBuffer();

		msg.append("<br>Hello All ,<br>");
		msg.append("<br>    A new document has been uploaded into Coffeebeans Central Repository.<br>");
		msg.append("<br> <u> Reference Title: </u> " + ref.getTitle() + "<br><u>Added by</u> : " + ref.getAddedBy()
				+ "<br><br> You may download the document by logging in <a href=\"http://coffeebeans.wru.ai:8080/Automator/\"> here !</a><br> <br> Contact ");
		msg.append(
				"<a href=\"mailto:aaquib@coffeebeans.io?subject=AUTOMATOR : contact developer&body=Hi Aaquib <br> Facing issue downloading the document.\"> <em>Aaquib Javed Khan </em> </a> for any issues !!");
		return msg.toString();
	}

}
