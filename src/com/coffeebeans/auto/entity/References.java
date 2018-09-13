package com.coffeebeans.auto.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ref_links")
public class References implements Serializable {

	private static final long serialVersionUID = -1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "refId")
	private int refId;

	@Column(name = "title")
	private String title;

	@Column(name = "type")
	private String type;
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "addedBy")
	private String addedBy;

	
	@Column(name = "reference")
	private String reference;

	private Timestamp updatedDate;

	public int getRefId() {
		return refId;
	}

	public void setRefId(int refId) {
		this.refId = refId;
	}

	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public Timestamp getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getAddedBy() {
		return addedBy;
	}

	public void setAddedBy(String addedBy) {
		this.addedBy = addedBy;
	}

	@Override
	public boolean equals(Object o) {
	    if(o == null)
	        return false;

	    if(!(o instanceof References))
	        return false;

	    if(getTitle() == null && getReference() == null && getType() == null)
	        return false;

	    References ref = (References) o;
	    if(!(getTitle().equals(ref.getTitle())))
	        return false;

	    if(!(getReference().equals(ref.getReference())))
	        return false;

	    if(!(getType().equals(ref.getType())))
	        return false;
	    
	   return true;
	}

	@Override
	public int hashCode() {
	    int hash = 3;

	    hash = 47 * hash + ((getTitle() != null) ? getTitle().hashCode() : 0);
	    hash = 47 * hash + ((getReference() != null) ? getReference().hashCode() : 0);
	    hash = 47 * hash + ((getType() != null) ? getType().hashCode() : 0);

	    return hash;
	}
}
