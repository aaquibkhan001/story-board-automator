package com.coffeebeans.auto.model;

/*
 * This model class is used to map the user object from database to Json required at front end
 */
public class UserRole {
    private int userID;
    private String userRole;
    private String userName;
    private String email;

    public UserRole() {}

    public UserRole(int id, String name, String role, String email) {
        this.userID = id;
        this.userName = name;
        this.userRole = role;
        this.email = email;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // =================================================
    // Accessors
    // =================================================

}