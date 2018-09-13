package com.coffeebeans.auto.dao;

import java.util.List;

import com.coffeebeans.auto.entity.Leave;

public interface LeaveDao {

	int createLeave(Leave iLeave);

	List<Leave> getAllLeavesForUSer(int iLeaveId);

	int cancelLeave(int iLeaveId);

	List<Leave> getAllLeaves();
}
