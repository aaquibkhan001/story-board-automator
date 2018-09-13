package com.coffeebeans.auto.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Provides common redirections within the application
 */
@Controller
public class RedirectController {

	@RequestMapping(value = "/accessfailure", method = RequestMethod.GET)
	public ModelAndView gotoAccessFailure(ModelMap model) {
		return new ModelAndView("AccessFailure");
	}

	@RequestMapping(value = "/automator", method = RequestMethod.GET)
	public ModelAndView gotoAutomator(ModelMap model) {
		return new ModelAndView("automator");
	}

	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public ModelAndView launchUsers(ModelMap model) {
		return new ModelAndView("users");
	}
	
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView invalidate(ModelMap model) {
		return new ModelAndView("logout");
	}
}
