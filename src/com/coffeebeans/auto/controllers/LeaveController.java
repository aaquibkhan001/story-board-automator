package com.coffeebeans.auto.controllers;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.time.StopWatch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coffeebeans.auto.entity.Leave;
import com.coffeebeans.auto.service.LeaveService;

/**
 * Provides service end points for Leave page related functionalities
 */
@Controller
@RequestMapping("/leave")
public class LeaveController {

	@Autowired
	LeaveService leaveService;

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody int applyLeave(@RequestBody Leave iLeave) {
		return leaveService.createLeave(iLeave);
	}

	@RequestMapping(value = "/fetchAll/{userId}", method = RequestMethod.GET)
	public @ResponseBody List<Leave> getAllLeavesOfUser(@PathVariable("userId") int iUserId) {
		StopWatch sw = new StopWatch();
		sw.start();
		List<Leave> tasks = leaveService.getLeavesForUser(iUserId);
		sw.stop();

		return tasks;
	}

	@RequestMapping(value = "/fetchAll", method = RequestMethod.GET)
	public @ResponseBody List<Leave> getAllTasks1() {
		StopWatch sw = new StopWatch();
		sw.start();
		List<Leave> leaves = leaveService.getLeaves();

		sw.stop();

		return leaves;
	}

	@RequestMapping(value = "/cancel/{leaveId}", method = RequestMethod.POST)
	public @ResponseBody int cancelLeave(@PathVariable("leaveId") int iUserId) {
		// invoke the service to cancel leave
		return leaveService.cancelLeave(iUserId);

	}
}
