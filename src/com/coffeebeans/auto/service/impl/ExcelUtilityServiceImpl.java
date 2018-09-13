package com.coffeebeans.auto.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coffeebeans.auto.dao.TasksDao;
import com.coffeebeans.auto.entity.Tasks;
import com.coffeebeans.auto.service.ExcelUtilityService;
import com.coffeebeans.auto.util.AutomatorException;

@Service("ExportService")
public class ExcelUtilityServiceImpl implements ExcelUtilityService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ExcelUtilityServiceImpl.class);
	private static Pattern pattern = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$",
			Pattern.CASE_INSENSITIVE);

	@Autowired
	private TasksDao tasksDao;

	public void exportDetailedReportToExcel(String iFile, List<Integer> iSelectedTasks) throws AutomatorException {
		try {
			// get the data from database
			List<Tasks> recordsToWrite = tasksDao.getAllDataRecordsForGivenEmails(iSelectedTasks);

			// write to excel
			writeDataToExcel(recordsToWrite, iFile);

		} catch (Exception e) {
			throw new AutomatorException("DETAILED_REPORT_EXPORT_ERROR", "Exception while exporting detailed report ");
		}
	}

	
	private Object getCellValue(Cell cell, int column) {
		cell.setCellType(Cell.CELL_TYPE_STRING);
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_STRING:
			return cell.getStringCellValue();

		case Cell.CELL_TYPE_BOOLEAN:
			return cell.getBooleanCellValue();

		case Cell.CELL_TYPE_NUMERIC:
			if (HSSFDateUtil.isCellDateFormatted(cell)) {
				return cell.getDateCellValue();
			}
			return String.valueOf(cell.getStringCellValue());

		case Cell.CELL_TYPE_BLANK:
			if (column == 3 || column == 4 || column == 5) {
				return 0;
			} else {
				return "";
			}
		}
		return "";
	}

	private boolean isRowEmpty(Row row) {
		for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {
			Cell cell = row.getCell(c);
			if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK)
				return false;
		}
		return true;
	}

	private void writeDataToExcel(List<Tasks> iReportItems, String iFile) throws AutomatorException {
		// Blank workbook
		XSSFWorkbook workbook = new XSSFWorkbook();
		int sheetIndex = 0;
		String sheetName = "Requested_Data";
		XSSFSheet sheet = workbook.createSheet(sheetName);
		workbook.setSheetName(sheetIndex++, sheetName);

		LOGGER.info("Sheet index " + sheetIndex + " and name " + sheet.getSheetName());

		int rownum = 0;
		// create header row object
		Tasks header = _createHeaderRow();
		_createRow(header, workbook, rownum++, sheet, true);
		for (Tasks detail : iReportItems) {
			_createRow(detail, workbook, rownum++, sheet, false);
		}

		try {
			// Write the workbook in file system
			FileOutputStream out = new FileOutputStream(new File(iFile));
			workbook.write(out);
			out.close();
			LOGGER.info("Filtered excel report successfully generated. File : " + iFile);
		} catch (Exception e) {
			LOGGER.error("Exception during generation of filtered excel report file " + e.getMessage());
		}
	}

	private Tasks _createHeaderRow() {
		Tasks header = new Tasks();
		header.setName("Task Name");
		header.setAddedBy("Added By");
		header.setAssignee("Assigned To");
		header.setDescription("Task Description");
		//header.setUpdatedDate(new Timestamp(System.currentTimeMillis()));

		return header;

	}

	private Row _createRow(Tasks detail, XSSFWorkbook workbook, int rowNum, XSSFSheet sheet, boolean isHeader) {

		Row row = sheet.createRow(rowNum);
		int cellnum = 0;

		Cell cell = row.createCell(cellnum++);
		cell.setCellValue(detail.getName());

		Cell cell1 = row.createCell(cellnum++);
		cell1.setCellValue(detail.getAddedBy());

		Cell cell2 = row.createCell(cellnum++);
		cell2.setCellValue(detail.getAssignee());

		Cell cell3 = row.createCell(cellnum++);
		cell3.setCellValue(detail.getDescription());

		return row;
	}

	private boolean validateFirstRowHeader(Row row) {
		boolean valid = false;
		if (!isRowEmpty(row)) {
			Iterator<Cell> cellIterator = row.cellIterator();
			Tasks aRecord = new Tasks();
			while (cellIterator.hasNext()) {
				Cell nextCell = cellIterator.next();
				String name = (String) getCellValue(nextCell, 0);
				if (name.equals("Name")) {
					valid = true;
					break;
				}
			}
		}
		return valid;
	}
}
