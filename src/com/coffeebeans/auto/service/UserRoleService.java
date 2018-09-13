/** 
* UserRoleService.java 
* CrossDock_Enhancement_Phase4 
* 
* Copyright @ 2016, Pepsico. 
*/
package com.coffeebeans.auto.service;

import com.coffeebeans.auto.model.UserRole;

import java.util.List;

/**
 * Service interface to handle all the business logic related to the functionalities of User/UserRole
 */
public interface UserRoleService {

    
    UserRole authenticateUserAndReturnDetails(String iUserId, String iPassword);
    
    int changePasswordAndReturnDetails(UserRole iUserRole, String iPassword);
    
    UserRole getUserById(int iUserId);
    
    /**
     * To create a new user and persist into database
     * @param iUserRole
     */
    int createUser(UserRole iUserRole);

    /**
     * to update any details for the given user
     * @param iUserRole
     */
    int editUser(UserRole iUserRole);

    /**
     * To delete the given user from database
     * @param iUserId
     */
    void deleteUser(int iUserId);

    /**
     * To obtain all the existing users from database
     * @return
     */
    List<UserRole> getAllUsers();

}
