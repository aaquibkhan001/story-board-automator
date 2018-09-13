package com.coffeebeans.auto.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Users")
public class UserDb implements Serializable {

	private static final long serialVersionUID = 1L;

	// =================================================
	// Constructors
	// =================================================

	public UserDb() {

	}

	public UserDb(String name, String role, String email) {
		this.userName = name;
		this.userRole = role;
		this.email = email;
	}

	@Id
	@Column(name = "userid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userid;

	private String userRole;

	private String userName;
	private String email;
	private String password;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getUserid() {
		return userid;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "userid=" + this.userid + ", name=" + this.userName + ", role=" + this.userRole + ", email=" + this.email;
	}
	
	@Override
	public boolean equals(Object o) {
	    if(o == null)
	        return false;

	    if(!(o instanceof References))
	        return false;

	    if(getEmail() == null && getUserName() == null)
	        return false;

	    UserDb ref = (UserDb) o;
	    if(!(getEmail().equals(ref.getEmail())))
	        return false;

	    if(!(getUserName().equals(ref.getUserName())))
	        return false;

	   return true;
	}

	@Override
	public int hashCode() {
	    int hash = 3;

	    hash = 47 * hash + ((getEmail() != null) ? getEmail().hashCode() : 0);
	    hash = 47 * hash + ((getUserName() != null) ? getUserName().hashCode() : 0);

	    return hash;
	}

}
