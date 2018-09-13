package com.coffeebeans.auto.dao;

import java.util.List;

import com.coffeebeans.auto.entity.References;

public interface CommonDao {

	List<String> getDistinctNames();

	int deleteReferenceLink(int iRefID);

	List<References> getAllReferences();

	int createReference(References iRef);
	
	List<String> getDistinctEmails();
}
