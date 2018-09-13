package com.coffeebeans.auto.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

@Entity
@Table(name = "Bugs")
public class Bugs implements Serializable {

	private static final long serialVersionUID = -1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "bugId")
	private int bugId;

	@Column(name = "bugName")
	private String bugName;

	@Column(name = "addedby")
	private String addedBy;

	@Column(name = "status")
	private String status;

	@Column(name = "updatedby")
	private String updatedBy;

	@Column(name = "description")
	@Type(type = "text")
	private String description;
	
	@Column(name = "resolution")
	@Type(type = "text")
	private String resolution;

	@Column(name = "createdDate", updatable = false)
	private Timestamp createdDate;

	private Timestamp updatedDate;

	public int getBugId() {
		return bugId;
	}

	public void setBugId(int bugId) {
		this.bugId = bugId;
	}

	public String getBugName() {
		return bugName;
	}

	public void setBugName(String bugName) {
		this.bugName = bugName;
	}

	public String getAddedBy() {
		return addedBy;
	}

	public void setAddedBy(String addedBy) {
		this.addedBy = addedBy;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Timestamp getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}

	@Override
	public boolean equals(Object o) {
	    if(o == null)
	        return false;

	    if(!(o instanceof Bugs))
	        return false;

	    if(getBugName() == null && getDescription() == null)
	        return false;

	    Bugs bug = (Bugs) o;
	    if(!(getBugName().equals(bug.getBugName())))
	        return false;

	    if(!(getDescription().equals(bug.getDescription())))
	        return false;

	   return true;
	}

	@Override
	public int hashCode() {
	    int hash = 3;

	    hash = 47 * hash + ((getBugName() != null) ? getBugName().hashCode() : 0);
	    hash = 47 * hash + ((getDescription() != null) ? getDescription().hashCode() : 0);

	    return hash;
	}
}
