package com.coffeebeans.auto.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coffeebeans.auto.dao.LeaveDao;
import com.coffeebeans.auto.entity.Leave;
import com.coffeebeans.auto.service.LeaveService;

@Service("LeaveService")
public class LeaveServiceImpl implements LeaveService {

	private static final Logger LOGGER = LoggerFactory.getLogger(LeaveServiceImpl.class);

	@Autowired
	private LeaveDao leaveDao;
	
	public int createLeave(Leave iLeave) {	
		return leaveDao.createLeave(iLeave);	
	}
	
	public List<Leave> getLeavesForUser(int iUserId) {
		LOGGER.info("Fetching all the leaves for given userID " + iUserId);
		return leaveDao.getAllLeavesForUSer(iUserId);
	}
	
	public List<Leave> getLeaves() {
		LOGGER.info("Fetching all the leaves");
		return leaveDao.getAllLeaves();
	}
	
	public int cancelLeave(int iLeaveId) {
		LOGGER.info("Cancelling  the leave for given leaveID " + iLeaveId);

		return leaveDao.cancelLeave(iLeaveId);		
	}
	
}
