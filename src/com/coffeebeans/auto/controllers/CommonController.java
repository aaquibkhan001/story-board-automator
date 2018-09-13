package com.coffeebeans.auto.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coffeebeans.auto.dao.CommonDao;
import com.coffeebeans.auto.entity.References;

/**
 * Provides service end points for common functionalities
 */
@Controller
public class CommonController {

	@Autowired
	private CommonDao commonDao;

	@RequestMapping(value = "name/fetchAll", method = RequestMethod.GET)
	public @ResponseBody List<String> getAllNames() {
		return commonDao.getDistinctNames();
	}

	@RequestMapping(value = "mailid/fetchAll", method = RequestMethod.GET)
	public @ResponseBody List<String> getAllEmails() {
		return commonDao.getDistinctEmails();
	}
	
	@RequestMapping(value = "ref/fetchAll", method = RequestMethod.GET)
	public @ResponseBody List<References> getAllReferences() {
		return commonDao.getAllReferences();
	}

	@RequestMapping(value = "ref/delete/{refId}", method = RequestMethod.POST)
	public @ResponseBody int deleteReference(@PathVariable("refId") int iRefId) {
		return commonDao.deleteReferenceLink(iRefId);

	}

	@RequestMapping(value = "ref/create", method = RequestMethod.POST)
	public @ResponseBody int createReferenceLink(@RequestBody References iReferenceDetails) {
		// there are two types of references. One is normal link and other is file upload.
		iReferenceDetails.setType("Link");
		return commonDao.createReference(iReferenceDetails);

	}
}
