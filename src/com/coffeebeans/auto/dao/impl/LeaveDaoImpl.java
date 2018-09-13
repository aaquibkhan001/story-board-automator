package com.coffeebeans.auto.dao.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.type.IntegerType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.coffeebeans.auto.dao.LeaveDao;
import com.coffeebeans.auto.entity.Leave;

@Repository
public class LeaveDaoImpl implements LeaveDao {

	private static final Logger LOGGER = LoggerFactory.getLogger(LeaveDaoImpl.class);

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	public int createLeave(Leave iLeave) {

		Session session = this.sessionFactory.getCurrentSession();
		// Transaction transaction = session.getTransaction();
		try {
			session.save(iLeave);
			LOGGER.info("Inserted Leave record with ID = {} at time = {} ", iLeave.getLeaveId(),
					Calendar.getInstance().getTime());

		} catch (Exception e) {
			// transaction.rollback();
			LOGGER.error("Exception occurred while saving leave into leaves table." + e.getMessage());
		} finally {
			// session.flush();
			// session.close();
		}
		return iLeave.getLeaveId();
	}

	@Transactional
	public int cancelLeave(int iLeaveId) {

		Session session = this.sessionFactory.getCurrentSession();
		// Transaction transaction = session.getTransaction();
		int updatedRecords = 0;
		try {
			String queryToFire = "update Leaves set status='CANCELLED', updatedDate=current_timestamp where leaveId=?";

			SQLQuery query = session.createSQLQuery(queryToFire).addScalar("max", new IntegerType());
			query.setInteger(0, iLeaveId);

			updatedRecords = query.executeUpdate();
		} catch (Exception e) {
			// transaction.rollback();
			LOGGER.error("Exception occurred while cancelling leave  for LeaveID : {}, EXCEPTION={} ", iLeaveId,
					e.getMessage());
		} finally {
			// session.flush();
			// session.close();
		}
		LOGGER.info("Successfully cancelled leave for the given leaveID ={} , number of records updated={} at ={} ",
				iLeaveId, updatedRecords);
		return updatedRecords;
	}

	@Transactional
	@SuppressWarnings("unchecked")
	public List<Leave> getAllLeavesForUSer(int iLeaveId) {

		Session session = this.sessionFactory.getCurrentSession();
		// Transaction transaction = session.getTransaction();
		// final List<Tasks> usersFromDb = new ArrayList<Tasks>();
		List<Leave> usersFromDb = new ArrayList<Leave>();
		try {
			String queryToFire = "select * from Leaves where addedBy=? order by updatedDate";
			SQLQuery query = session.createSQLQuery(queryToFire).addEntity(Leave.class);

			// List<Object[]> alTasksForGivenQuery = (List<Object[]>) query.list();
			query.setInteger(0, iLeaveId);
			usersFromDb = (List<Leave>) query.list();
		} catch (Exception e) {
			// transaction.rollback();
			LOGGER.error("Exception occurred while fetching all leaves for user from database." + e.getMessage());
		} finally {
			// session.flush();
			// session.close();
		}
		LOGGER.info("The number of leaves for user from database are " + usersFromDb.size());
		return usersFromDb;
	}
	
	@Transactional
	@SuppressWarnings("unchecked")
	public List<Leave> getAllLeaves() {

		Session session = this.sessionFactory.getCurrentSession();
		// Transaction transaction = session.getTransaction();
		// final List<Tasks> usersFromDb = new ArrayList<Tasks>();
		List<Leave> usersFromDb = new ArrayList<Leave>();
		try {
			String queryToFire = "select * from Leaves order by updatedDate";
			SQLQuery query = session.createSQLQuery(queryToFire).addEntity(Leave.class);
			usersFromDb = (List<Leave>) query.list();
		} catch (Exception e) {
			// transaction.rollback();
			LOGGER.error("Exception occurred while fetching all leaves from database." + e.getMessage());
		} finally {
			// session.flush();
			// session.close();
		}
		LOGGER.info("The number of leaves from database are " + usersFromDb.size());
		return usersFromDb;
	}
}
