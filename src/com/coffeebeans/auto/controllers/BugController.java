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

import com.coffeebeans.auto.entity.Bugs;
import com.coffeebeans.auto.service.BugService;

/**
 * Provides service end points for Bugs page related functionalities
 */
@Controller
@RequestMapping("/bug")
public class BugController {

	@Autowired
	BugService bugService;

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public @ResponseBody int createBug(@RequestBody Bugs iBug) {
		// invoke the service to save the new bug
		return bugService.openBug(iBug);
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public @ResponseBody int resolveBug(@RequestBody Bugs iTask) {
		// invoke the service to save the bug with updated details
		return bugService.updateBug(iTask);
	}

	@RequestMapping(value = "/delete/{bugid}", method = RequestMethod.POST)
	public @ResponseBody void deleteBug(@PathVariable("bugid") int iBugId) {
		// invoke the service to delete the given bug
		bugService.deleteBug(iBugId);
	}

	@RequestMapping(value = "/fetchAll", method = RequestMethod.GET)
	public @ResponseBody List<Bugs> getAllTasks() {
		// invoke the service to return all the bugs
		StopWatch sw = new StopWatch();
		sw.start();
		List<Bugs> tasks = bugService.getAllBugs();
		sw.stop();

		return tasks;
	}

}
