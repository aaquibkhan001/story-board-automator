package com.coffeebeans.auto.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coffeebeans.auto.dao.BugDao;
import com.coffeebeans.auto.entity.Bugs;
import com.coffeebeans.auto.service.BugService;

@Service("BugService")
public class BugServiceImpl implements BugService {

	private static final Logger LOGGER = LoggerFactory.getLogger(BugServiceImpl.class);

	@Autowired
	private BugDao bugDao;

	public int openBug(Bugs iTask) {
		
		
		return bugDao.openBug(iTask);
	}

	public int updateBug(Bugs iBug) {
	
		iBug.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
		return bugDao.updateBug(iBug);
	}

	public void deleteBug(int iUserId) {
		bugDao.deleteBugById(iUserId);
	}

	public List<Bugs> getAllBugs() {
		return bugDao.getAllBugs();
	}
}
