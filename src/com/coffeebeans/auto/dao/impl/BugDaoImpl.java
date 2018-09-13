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

import com.coffeebeans.auto.dao.BugDao;
import com.coffeebeans.auto.entity.Bugs;

@Repository
public class BugDaoImpl implements BugDao {

	private static final Logger LOGGER = LoggerFactory.getLogger(BugDaoImpl.class);

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	@SuppressWarnings("unchecked")
	public List<Bugs> getAllBugs() {

		Session session = this.sessionFactory.getCurrentSession();
		// Transaction transaction = session.getTransaction();
		List<Bugs> bugsFromDb = new ArrayList<Bugs>();
		try {
			String queryToFire = "select * from Bugs order by updatedDate desc";
			SQLQuery query = session.createSQLQuery(queryToFire).addEntity(Bugs.class);

			bugsFromDb = (List<Bugs>) query.list();

		} catch (Exception e) {
			// transaction.rollback();
			LOGGER.error("Exception occurred while fetching all Bugs from database." + e.getMessage());
		} finally {
			// session.flush();
			// session.close();
		}
		LOGGER.info("The number of bugs from database are " + bugsFromDb.size());
		return bugsFromDb;
	}

	@Transactional
	public int openBug(Bugs iBug) {

		Session session = this.sessionFactory.getCurrentSession();
		// Transaction transaction = session.getTransaction();
		try {
			session.save(iBug);
			LOGGER.info("Inserted Bug record with ID = {} at time = {} ", iBug.getBugId(),
					Calendar.getInstance().getTime());

		} catch (Exception e) {
			// transaction.rollback();
			LOGGER.error("Exception occurred while saving bug into bugs table." + e.getMessage());
		} finally {
			// session.flush();
			// session.close();
		}
		return iBug.getBugId();
	}

	@Transactional
	public int updateBug(Bugs iBugToUpdate) {

		Session session = this.sessionFactory.getCurrentSession();
		// Transaction transaction = session.getTransaction();
		try {
			session.update(iBugToUpdate);
			LOGGER.info("Updated Bug with ID = {} at time = {} ", iBugToUpdate.getBugId(),
					Calendar.getInstance().getTime());

		} catch (Exception e) {
			// transaction.rollback();
			LOGGER.error("Exception occurred while updating bug." + e.getMessage());
		} finally {
			// session.flush();
			// session.close();
		}
		return iBugToUpdate.getBugId();
	}

	@Transactional
	public int deleteBugById(int iBugId) {

		Session session = this.sessionFactory.getCurrentSession();
		// Transaction transaction = session.getTransaction();
		int deletedRecords = 0;
		try {
			String queryToFire = "delete from Bugs where bugId=?";

			SQLQuery query = session.createSQLQuery(queryToFire).addScalar("max", new IntegerType());
			query.setInteger(0, iBugId);

			deletedRecords = query.executeUpdate();

		} catch (Exception e) {
			// transaction.rollback();
			LOGGER.error("Exception occurred while deleting bug for BugID : {}, EXCEPTION={} ", iBugId, e.getMessage());
		} finally {
			// session.flush();
			// session.close();
		}
		LOGGER.info("Successfully deleted Bug for the given bugId ={} , number of records deleted={} at ={} ", iBugId,
				deletedRecords);
		return deletedRecords;
	}
}
