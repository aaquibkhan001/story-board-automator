package com.coffeebeans.auto.dao;

import java.util.List;

import com.coffeebeans.auto.entity.UserDb;
import com.coffeebeans.auto.model.UserRole;

public interface UsersDao {

	int createUser(UserDb iUser);

	int updateWholeUser(UserDb iUser);

	List<UserDb> getAllUsers();

	int deleteUserById(int iUserId);

	UserDb getUserById(int iUserId);

	UserDb getUserByName(String iUserName);

	int updateUserDetails(UserRole iUserRole);
}
