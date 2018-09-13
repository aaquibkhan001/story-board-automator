package com.coffeebeans.auto.service;

import java.util.List;

import com.coffeebeans.auto.entity.Leave;

public interface LeaveService {

	int createLeave(Leave iLeave);

	List<Leave> getLeavesForUser(int iLEaveId);

	int cancelLeave(int iLeaveId);

	List<Leave> getLeaves();
}
