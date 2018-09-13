package com.coffeebeans.auto.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonProperty;
import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "Tasks")
public class Tasks implements Serializable {

	private static final long serialVersionUID = -1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "taskid")
	private int taskid;

	@Column(name = "percentcomplete")
	private int percentComplete;

	@Column(name = "taskname")
	private String name;

	@Column(name = "priority")
	private String priority;

	@Column(name = "addedby")
	private String addedBy;

	@Column(name = "assignee")
	private String assignee;

	@Column(name = "status")
	private String status;

	@Column(name = "project")
	private String project;

	@Column(name = "updatedby")
	private String updatedBy;

	@Column(name = "description")
	@Type(type = "text")
	private String description;

	@Column(name = "acceptance")
	@Type(type = "text")
	private String acceptance;

	@Column(name = "createdDate", updatable = false)
	private Timestamp createdDate;

	private Timestamp updatedDate;

	@OneToMany(mappedBy = "taskHist", fetch = FetchType.EAGER)
	@Cascade({ CascadeType.ALL })
	private Set<TaskHistory> historyItems;

	public int getTaskid() {
		return taskid;
	}

	public void setTaskid(int taskid) {
		this.taskid = taskid;
	}

	public int getPercentComplete() {
		return percentComplete;
	}

	public void setPercentComplete(int percentComplete) {
		this.percentComplete = percentComplete;
	}

	public String getAssignee() {
		return assignee;
	}

	public String getAcceptance() {
		return acceptance;
	}

	public void setAcceptance(String acceptance) {
		this.acceptance = acceptance;
	}

	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddedBy() {
		return addedBy;
	}

	public void setAddedBy(String addedBy) {
		this.addedBy = addedBy;
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

	@JsonIgnore
	public Set<TaskHistory> getHistoryItems() {
		return historyItems;
	}

	@JsonDeserialize(as = LinkedHashSet.class)
	@JsonProperty
	public void setHistoryItems(Set<TaskHistory> historyItems) {
		this.historyItems = historyItems;
	}

	public void addTaskHistory(TaskHistory iTaskHist) {
		this.historyItems.add(iTaskHist);
		iTaskHist.setTaskHist(this);
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	@Override
	public boolean equals(Object o) {
		if (o == null)
			return false;

		if (!(o instanceof References))
			return false;

		if (getStatus() == null && getDescription() == null)
			return false;

		Tasks ref = (Tasks) o;
		if (!(getStatus().equals(ref.getStatus())))
			return false;

		if (!(getDescription().equals(ref.getDescription())))
			return false;

		return true;
	}

	@Override
	public int hashCode() {
		int hash = 3;

		hash = 47 * hash + ((getStatus() != null) ? getStatus().hashCode() : 0);
		hash = 47 * hash + ((getDescription() != null) ? getDescription().hashCode() : 0);

		return hash;
	}
}
