package com.coffeebeans.auto.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "Leaves")
public class Leave implements Serializable {

	private static final long serialVersionUID = -1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "leaveId")
	private int leaveId;

	@Column(name = "days")
	private int days;

	@Column(name = "addedby")
	private int addedBy;

	@Column(name = "status")
	private String status;

	@Column(name = "reason")
	private String reason;


	@Column(name = "startDate")
	@Temporal(TemporalType.DATE)
	private Date startDate;

	@Column(name = "endDate")
	@Temporal(TemporalType.DATE)
	private Date endDate;

	private Timestamp updatedDate;

	public int getLeaveId() {
		return leaveId;
	}

	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}

	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	public int getAddedBy() {
		return addedBy;
	}

	public void setAddedBy(int addedBy) {
		this.addedBy = addedBy;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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

	    if(!(o instanceof Leave))
	        return false;
 	
	    if(getStartDate() == null && getEndDate() == null)
	        return false;

	    Leave leave = (Leave) o;
	    if(!(getStartDate().equals(leave.getStartDate())))
	        return false;

	    if(!(getEndDate().equals(leave.getEndDate())))
	        return false;

	   return true;
	}

	@Override
	public int hashCode() {
	    int hash = 3;

	    hash = 47 * hash + ((getStartDate() != null) ? getStartDate().hashCode() : 0);
	    hash = 47 * hash + ((getEndDate() != null) ? getEndDate().hashCode() : 0);

	    return hash;
	}
}
