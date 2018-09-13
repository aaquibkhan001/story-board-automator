package com.coffeebeans.auto.dao;

import java.util.List;

import com.coffeebeans.auto.entity.TaskHistory;
import com.coffeebeans.auto.entity.Tasks;

public interface TasksDao {

	int createTask(Tasks iTask);

	int openBug(Tasks iTask);

	int updateTask(Tasks iTask);

	List<Tasks> getAllTasks();

	int deleteTaskById(int iTaskId);

	Tasks getTaskById(int iTaskId);

	List<TaskHistory> getTaskHistory(int iTaskId);

	List<Tasks> getAllDataRecordsForGivenEmails(List<Integer> iTaskIds);

}
