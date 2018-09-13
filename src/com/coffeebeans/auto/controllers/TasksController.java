package com.coffeebeans.auto.controllers;

import java.util.List;

import org.apache.commons.lang3.time.StopWatch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coffeebeans.auto.entity.TaskHistory;
import com.coffeebeans.auto.entity.Tasks;
import com.coffeebeans.auto.service.TasksService;

/**
 * Provides service end points for Tasks related functionalities
 */
@Controller
@RequestMapping("/tasks")
public class TasksController {

	@Autowired
	TasksService tasksService;

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody int createTask(@RequestBody Tasks iTask) {
		// invoke the service to save the new task
		return tasksService.createTask(iTask);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public @ResponseBody int editTask(@RequestBody Tasks iTask) {
		// invoke the service to save the new task with updated details
		return tasksService.editTask(iTask);
	}

	@RequestMapping(value = "/fetch/{taskid}", method = RequestMethod.GET)
	public @ResponseBody Tasks getTaskById(@PathVariable("taskid") int iUserId) {
		return tasksService.getUserById(iUserId);
	}

	@RequestMapping(value = "/delete/{taskid}", method = RequestMethod.POST)
	public @ResponseBody int deleteTask(@PathVariable("taskid") int iTaskId) {
		return tasksService.deleteTask(iTaskId);
	}

	@RequestMapping(value = "/fetchAll", method = RequestMethod.GET)
	public @ResponseBody List<Tasks> getAllTasks() {
		// invoke the service to return all the tasks
		StopWatch sw = new StopWatch();
		sw.start();
		List<Tasks> tasks = tasksService.getAllTasks();
		sw.stop();

		return tasks;
	}

	@RequestMapping(value = "history/{taskid}", method = RequestMethod.GET)
	public @ResponseBody List<TaskHistory> getAllTaskHistory(@PathVariable("taskid") int iTaskId) {
		StopWatch sw = new StopWatch();
		sw.start();
		List<TaskHistory> tasks = tasksService.getTaskHistory(iTaskId);
		sw.stop();

		return tasks;
	}
}
