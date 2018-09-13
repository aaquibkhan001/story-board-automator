package com.coffeebeans.auto.service.impl;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coffeebeans.auto.dao.TasksDao;
import com.coffeebeans.auto.dao.UsersDao;
import com.coffeebeans.auto.entity.TaskHistory;
import com.coffeebeans.auto.entity.Tasks;
import com.coffeebeans.auto.entity.UserDb;
import com.coffeebeans.auto.service.MailService;
import com.coffeebeans.auto.service.TasksService;

@Service("TasksService")
public class TasksServiceImpl implements TasksService {

	private static final Logger LOGGER = LoggerFactory.getLogger(TasksServiceImpl.class);

	@Autowired
	private MailService mailService;

	@Autowired
	private TasksDao tasksDao;

	@Autowired
	private UsersDao usersDao;

	public Tasks getUserById(int iUserId) {
		return new Tasks();
	}

	public int createTask(Tasks iTask) {
		Set<TaskHistory> historySet = iTask.getHistoryItems();
		iTask.setHistoryItems(new HashSet<TaskHistory>());
		for (TaskHistory eachHistory : historySet) {
			iTask.addTaskHistory(eachHistory);
		}
		UserDb usr = usersDao.getUserByName(iTask.getAssignee());
		String to = usr.getEmail();
		String[] toRecipient = {to};
		mailService.sendNotification(" [COFFEEBEANS] New task has been created for you", toRecipient,
				getEmailMessage(iTask, usr));
		LOGGER.info("Email Sent. A new task created with Name " + iTask.getName());
		return tasksDao.createTask(iTask);
	}

	public int editTask(Tasks iTask) {
		Set<TaskHistory> historySet = iTask.getHistoryItems();
		iTask.setHistoryItems(new HashSet<TaskHistory>());
		for (TaskHistory eachHistory : historySet) {
			iTask.addTaskHistory(eachHistory);
		}
		iTask.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
		return tasksDao.updateTask(iTask);
	}

	public int deleteTask(int iTaskId) {
		return tasksDao.deleteTaskById(iTaskId);
	}

	public List<Tasks> getAllTasks() {
		return tasksDao.getAllTasks();
	}

	public List<TaskHistory> getTaskHistory(int iTaskId) {
		return tasksDao.getTaskHistory(iTaskId);
	}

	private String getEmailMessage(Tasks iTask, UserDb usr) {
		String addedBy = iTask.getAddedBy().equalsIgnoreCase(iTask.getAssignee()) ? "yourself" : iTask.getAddedBy();

		StringBuffer msg = new StringBuffer();

		msg.append("<br>Hello " + usr.getUserName() + " ,<br>");
		msg.append("<br>    A new task \" <u>" + iTask.getName() + " </u>\" has been created for you by " + addedBy
				+ " . <br>");
		msg.append("<br><strong><em>Task Description: </em></strong><br>" + iTask.getDescription()
				+ "<br> <br> <strong><u> Priority </u></strong>: " + iTask.getPriority());
		if (iTask.getAcceptance() != null) {
			msg.append("<br> <br> <strong><u> Acceptance Criteria </u></strong>: " + iTask.getAcceptance());
		}
		msg.append("<br> <br> <br> You may check and update the task <a href=\"http://coffeebeans.wru.ai:8080/Automator/\"> here !</a><br>");
				+ "<br> <br> <strong><u> Priority </u></strong>: " + iTask.getPriority()
				+ "<br> You may check and update the task <a href=\"http://coffeebeans.wru.ai:8080/Automator/\"> here !</a><br>");

		return msg.toString();
	}
}
