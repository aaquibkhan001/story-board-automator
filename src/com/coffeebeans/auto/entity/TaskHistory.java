package com.coffeebeans.auto.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

@Entity
@Table(name = "Task_History")
public class TaskHistory implements Serializable {

	private static final long serialVersionUID = -1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "taskHistoryId")
	private int taskHistoryId;

	@Column(name = "taskHistoryAddedBy")
	private String taskHistoryAddedBy;

	@Column(name = "taskHistoryDescription")
	@Type(type = "text")
	private String taskHistoryDescription;

	private Timestamp createdDate;

	@ManyToOne
	@JoinColumn(name = "taskId", insertable = true, updatable = true, nullable = false)
	private Tasks taskHist;

	// Hibernate requires no-args constructor
	public TaskHistory() {
	}

	public TaskHistory(String addedBy, String desc, Tasks c) {
		this.taskHistoryAddedBy = addedBy;
		this.taskHistoryDescription = desc;
		this.taskHist = c;
	}
	// Getter Setter methods

	public long getTaskHistoryId() {
		return taskHistoryId;
	}

	public void setTaskHistoryId(int taskHistoryId) {
		this.taskHistoryId = taskHistoryId;
	}

	public String getTaskHistoryAddedBy() {
		return taskHistoryAddedBy;
	}

	public void setTaskHistoryAddedBy(String taskHistoryAddedBy) {
		this.taskHistoryAddedBy = taskHistoryAddedBy;
	}

	public String getTaskHistoryDescription() {
		return taskHistoryDescription;
	}

	public void setTaskHistoryDescription(String taskHistoryDescription) {
		this.taskHistoryDescription = taskHistoryDescription;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public Tasks getTaskHist() {
		return taskHist;
	}

	public void setTaskHist(Tasks taskHist) {
		this.taskHist = taskHist;
	}

	@Override
	public boolean equals(Object o) {
	    if(o == null)
	        return false;

	    if(!(o instanceof References))
	        return false;

	    if(getTaskHistoryAddedBy() == null && getTaskHistoryDescription() == null)
	        return false;

	    TaskHistory ref = (TaskHistory) o;
	    if(!(getTaskHistoryAddedBy().equals(ref.getTaskHistoryAddedBy())))
	        return false;

	    if(!(getTaskHistoryDescription().equals(ref.getTaskHistoryDescription())))
	        return false;

	   return true;
	}

	@Override
	public int hashCode() {
	    int hash = 3;

	    hash = 47 * hash + ((getTaskHistoryAddedBy() != null) ? getTaskHistoryAddedBy().hashCode() : 0);
	    hash = 47 * hash + ((getTaskHistoryDescription() != null) ? getTaskHistoryDescription().hashCode() : 0);

	    return hash;
	}
}