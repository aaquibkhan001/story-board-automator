/** 
* UserRoleServiceImpl.java 
* CrossDock_Enhancement_Phase4 
* 
* Copyright @ 2016, Pepsico. 
*/
package com.coffeebeans.auto.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coffeebeans.auto.dao.UsersDao;
import com.coffeebeans.auto.entity.UserDb;
import com.coffeebeans.auto.model.UserRole;
import com.coffeebeans.auto.service.MailService;
import com.coffeebeans.auto.service.UserRoleService;
import com.coffeebeans.auto.util.PasswordHandler;

/**
 * Provides actual implementation for the interface related to UserRole
 */
@Service("UserRoleService")
public class UserRoleServiceImpl implements UserRoleService {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserRoleServiceImpl.class);

	@Autowired
	private MailService mailService;

	@Autowired
	private UsersDao usersDao;

	public UserRole authenticateUserAndReturnDetails(String iUserName, String iPassword) {
		UserRole userToReturn = null;
		UserDb userFromDb = usersDao.getUserByName(iUserName);
		if (userFromDb.getUserid() > 0) {
			// validate the password
			if (iPassword.equals(PasswordHandler.decrypt(userFromDb.getPassword()))) {
				LOGGER.info("User is authenticated successfully. User:" + iUserName);
				userToReturn = new UserRole(userFromDb.getUserid(), userFromDb.getUserName(), userFromDb.getUserRole(),
						userFromDb.getEmail());
			}
		}
		return userToReturn;
	}

	public int changePasswordAndReturnDetails(UserRole iUserRole, String iPassword) {
		UserDb anUser = new UserDb(iUserRole.getUserName(), iUserRole.getUserRole(), iUserRole.getEmail());
		anUser.setUserid(iUserRole.getUserID());
		anUser.setPassword(PasswordHandler.encrypt(iPassword));
		return usersDao.updateWholeUser(anUser);
	}

	public int createUser(UserRole iUserRole) {
		UserDb anUser = new UserDb(iUserRole.getUserName(), iUserRole.getUserRole(), iUserRole.getEmail());
		String userName = iUserRole.getUserName();
		if (iUserRole.getUserName().contains(" ")) {
			userName = userName.substring(0, userName.indexOf(" "));
		}
		String tempPassword = userName.toLowerCase() + "123";
		anUser.setPassword(tempPassword);
		String[] toRecipient = { anUser.getEmail() };

		mailService.sendNotification(" [COFFEEBEANS] New account created", toRecipient, getEmailMessage(anUser));

		LOGGER.info("A new user has been created with password " + tempPassword);
		anUser.setPassword(PasswordHandler.encrypt(tempPassword));

		return usersDao.createUser(anUser);

	}

	public int editUser(UserRole iUserRole) {

		UserDb anUser = new UserDb(iUserRole.getUserName(), iUserRole.getUserRole(), iUserRole.getEmail());
		anUser.setUserid(iUserRole.getUserID());
		return usersDao.updateUserDetails(iUserRole);

	}

	public void deleteUser(int iUserId) {
		usersDao.deleteUserById(iUserId);
	}

	public List<UserRole> getAllUsers() {
		List<UserRole> users = new ArrayList<UserRole>();
		List<UserDb> usersFromDb = usersDao.getAllUsers();
		if (!usersFromDb.isEmpty()) {
			for (UserDb eachUser : usersFromDb) {
				UserRole user = new UserRole(eachUser.getUserid(), eachUser.getUserName(), eachUser.getUserRole(),
						eachUser.getEmail());
				users.add(user);
			}
		}
		return users;
	}

	public UserRole getUserById(int iUserId) {
		UserDb userFromDb = usersDao.getUserById(iUserId);
		return new UserRole(userFromDb.getUserid(), userFromDb.getUserName(), userFromDb.getUserRole(),
				userFromDb.getEmail());
	}

	private String getEmailMessage(UserDb usr) {
		StringBuffer msg = new StringBuffer();

		msg.append("<br>Welcome " + usr.getUserName() + " ,<br>");
		msg.append("<br>    You have been successfully registered to Coffeebeans Automator Tool.<br>");
		msg.append("<br> Your login credentials are below <br> <u> User Name: </u> " + usr.getUserName()
				+ "<br><u>Default Password:</u> " + usr.getPassword()
				+ "<br><br> Please use this credentials to <a href=\"http://coffeebeans.wru.ai:8080/Automator/\">Change Password !</a><br> <br> Contact ");
		msg.append(
				"<a href=\"mailto:aaquib@coffeebeans.io?subject=AUTOMATOR : contact developer&body=Hi Aaquib <br> Facing issue with logging into Coffeebeans Automator.\"> <em>Aaquib Javed Khan </em> </a> for any issues !!");
		return msg.toString();
	}
}
