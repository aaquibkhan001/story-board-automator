/** 
* UserRoleController.java 
* CrossDock_Enhancement_Phase4 
* 
* Copyright @ 2016, Pepsico. 
*/
package com.coffeebeans.auto.controllers;

import com.coffeebeans.auto.model.UserRole;
import com.coffeebeans.auto.service.UserRoleService;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.time.StopWatch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Provides service end points for User/UserRole related functionalities
 */
@Controller
@RequestMapping("/role")
public class UserRoleController {

    @Autowired
    UserRoleService userRoleService;
   
    @RequestMapping(value = "/authenticate", method = RequestMethod.POST)
    public @ResponseBody UserRole authenticate(@RequestParam("userid") String iUserId, @RequestParam("pass") String iPassword, HttpSession session) {
        // invoke the service to authenticate the given user and return the page to be shown

        return userRoleService.authenticateUserAndReturnDetails(iUserId, iPassword);
    }

    @RequestMapping(value = "/changePass", method = RequestMethod.POST)
    public @ResponseBody int changePassword(@RequestBody UserRole iUserRole, @RequestParam("pass") String iPassword, HttpSession session) {
        return userRoleService.changePasswordAndReturnDetails(iUserRole, iPassword);
    }
    
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public @ResponseBody int createUser(@RequestBody UserRole iUserRole) {
        // invoke the service to save the new user
        return userRoleService.createUser(iUserRole);
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public @ResponseBody int editUser(@RequestBody UserRole iUserRole) {
        // invoke the service to save the new user with updated details
       return userRoleService.editUser(iUserRole);

    }
   
    @RequestMapping(value = "/fetch/{userid}", method = RequestMethod.GET)
    public @ResponseBody UserRole getUserByGpid(@PathVariable("userid") int iUserId) {
        return userRoleService.getUserById(iUserId);
    }
    
    @RequestMapping(value = "/delete/{userid}", method = RequestMethod.POST)
    public @ResponseBody void deleteUser(@PathVariable("userid") int iUserId) {
        // invoke the service to delete the given user
        userRoleService.deleteUser(iUserId);

    }

    @RequestMapping(value = "/fetchAll", method = RequestMethod.GET)
    public @ResponseBody List<UserRole> getAllUsers() {
        // invoke the service to return all the users
        StopWatch sw = new StopWatch();
        sw.start();
        List<UserRole> users = userRoleService.getAllUsers();
        sw.stop();
       
        return users;
    }

}
