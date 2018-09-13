package com.coffeebeans.auto.dao;

import java.util.List;

import com.coffeebeans.auto.entity.Bugs;

public interface BugDao {

	int openBug(Bugs iUser);

	int updateBug(Bugs iUser);

	List<Bugs> getAllBugs();

	int deleteBugById(int iUserId);

}
