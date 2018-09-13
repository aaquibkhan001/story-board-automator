package com.coffeebeans.auto.dao.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.type.IntegerType;
import org.hibernate.type.StringType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.coffeebeans.auto.dao.UsersDao;
import com.coffeebeans.auto.entity.UserDb;
import com.coffeebeans.auto.model.UserRole;

@Repository
public class UsersDaoImpl implements UsersDao {

    private static final Logger LOGGER = LoggerFactory.getLogger(UsersDaoImpl.class);

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public int createUser(UserDb iUser) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        try {
            session.save(iUser);
            LOGGER.info("Inserted User record with ID = {} at time = {} ", iUser.getUserid(), Calendar.getInstance().getTime());

            /*
             * if hibernate has failed to commit transaction, commit it if (!transaction.wasCommitted()) { transaction.commit(); }
             */
        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while saving user into Users table." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        return iUser.getUserid();
    }


    @Transactional
    public int updateWholeUser(UserDb iUser) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        try {
            session.update(iUser);
            LOGGER.info("Updated User with ID = {} at time = {} ", iUser.getUserid(), Calendar.getInstance().getTime());

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while updating user." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        return iUser.getUserid();
    }

    @Transactional
    public int updateUserDetails(UserRole iUserRole) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        int updatedRecords = 0;
        try {
            String queryToFire = "update Users set userName=?, userRole=?, email=? where userID=?";

            SQLQuery query = session.createSQLQuery(queryToFire).addScalar("max", new IntegerType());
            query.setString(0, iUserRole.getUserName());
            query.setString(1, iUserRole.getUserRole());
            query.setString(2, iUserRole.getEmail());
            query.setInteger(3, iUserRole.getUserID());

            updatedRecords = query.executeUpdate();

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while updating user details for UserID : {}, EXCEPTION={} ", iUserRole.getUserID(), e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("Successfully updated User details for the given userID ={} , number of records updated={} at ={} ", iUserRole.getUserID(), updatedRecords);
        return updatedRecords;
    }
    
    @Transactional
    @SuppressWarnings("unchecked")
    public List<UserDb> getAllUsers() {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        final List<UserDb> usersFromDb = new ArrayList<UserDb>();
        try {
            String queryToFire = "select * from Users order by userName";
            SQLQuery query = session.createSQLQuery(queryToFire).addScalar("userid", new IntegerType()).addScalar("userName", new StringType()).addScalar("userRole", new StringType()).addScalar("email", new StringType()).addEntity(UserDb.class);

            List<Object[]> allLogsForGivenQuery = (List<Object[]>) query.list();

            for (Iterator<Object[]> it = allLogsForGivenQuery.iterator(); it.hasNext();) {
                Object[] myResult = (Object[]) it.next();
                UserDb user = new UserDb((String) myResult[1], (String) myResult[2], (String) myResult[3]);
                user.setUserid((Integer) myResult[0]);
                usersFromDb.add(user);
            }

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching all Users from database." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("The number of users from database are " + usersFromDb.size());
        return usersFromDb;
    }

    @Transactional
    @SuppressWarnings("unchecked")
    public UserDb getUserById(int iUserID) {

        Session session = this.sessionFactory.getCurrentSession();
        UserDb body = new UserDb();
        try {
            String queryToFire = "select * from Users where userID=?";

            SQLQuery query = session.createSQLQuery(queryToFire).addEntity(UserDb.class);
            query.setInteger(0, iUserID);

            List<Object[]> allLogsForGivenQuery = (List<Object[]>) query.list();

            if (!query.list().isEmpty()) {
                LOGGER.info("Retrieved User for given user ID. Size : " + allLogsForGivenQuery.size());
                body = (UserDb) query.list().get(0);
            }
        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching User for given ID = {}, EXCEPTION={}", iUserID, e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("The User fetched successfully for given UserID={}", iUserID);
        return body;
    }

    @Transactional
    @SuppressWarnings("unchecked")
    public UserDb getUserByName(String iUserName) {

        Session session = this.sessionFactory.getCurrentSession();
        UserDb body = new UserDb();
        try {
            String queryToFire = "select * from Users where userName=?";

            SQLQuery query = session.createSQLQuery(queryToFire).addEntity(UserDb.class);
            query.setString(0, iUserName);

            List<Object[]> allLogsForGivenQuery = (List<Object[]>) query.list();

            if (!query.list().isEmpty()) {
                LOGGER.info("Retrieved User for given user name. Size : " + allLogsForGivenQuery.size());
                body = (UserDb) query.list().get(0);
            }

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching User for given user name = {}, EXCEPTION={}", iUserName, e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        return body;
    }

    @Transactional
    public int deleteUserById(int iUserId) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        int deletedRecords = 0;
        try {
            String queryToFire = "delete from Users where userID=?";

            SQLQuery query = session.createSQLQuery(queryToFire).addScalar("max", new IntegerType());
            query.setInteger(0, iUserId);

            deletedRecords = query.executeUpdate();

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while deleting user for UserID : {}, EXCEPTION={} ", iUserId, e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("Successfully deleted User for the given userID ={} , number of records deleted={} at ={} ", iUserId, deletedRecords);
        return deletedRecords;
    }
}
