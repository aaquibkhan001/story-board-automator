package com.coffeebeans.auto.dao.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Set;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.type.IntegerType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.coffeebeans.auto.dao.TasksDao;
import com.coffeebeans.auto.entity.TaskHistory;
import com.coffeebeans.auto.entity.Tasks;

@Repository
public class TasksDaoImpl implements TasksDao {

    private static final Logger LOGGER = LoggerFactory.getLogger(TasksDaoImpl.class);

    @Autowired
    private SessionFactory sessionFactory;
   
    @Transactional
    @SuppressWarnings("unchecked")
    public List<Tasks> getAllDataRecordsForGivenEmails(List<Integer> iTaskIds) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        final List<Tasks> tasksFromDb = new ArrayList<Tasks>();
        try {
            String queryToFire = "select * from Tasks where taskId in (:taskIds) order by updatedDate desc";
            SQLQuery query = session.createSQLQuery(queryToFire).addEntity(Tasks.class);
            query.setParameterList("taskIds", iTaskIds);

            List<Tasks> tasksFromDb1 = (List<Tasks>) query.list();
            
            for(Tasks eachTask : tasksFromDb1) {
            	 Set<TaskHistory> history = eachTask.getHistoryItems();
            	 eachTask.setHistoryItems(history);
            	 tasksFromDb.add(eachTask);
            }
            LOGGER.info("The number of tasks for given taskIds are " + tasksFromDb.size());

            /*
             * if hibernate has failed to commit transaction, commit it if (!transaction.wasCommitted()) { transaction.commit(); }
             */
        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching all tasks for given task Ids from database." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        return tasksFromDb;
    }
    
    @Transactional
    @SuppressWarnings("unchecked")
    public List<Tasks> getAllTasks() {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        final List<Tasks> tasksFromDb = new ArrayList<Tasks>();
        try {
            String queryToFire = "select * from Tasks order by updatedDate desc";
            SQLQuery query = session.createSQLQuery(queryToFire).addEntity(Tasks.class);
  
            List<Tasks> tasksFromDb1 = (List<Tasks>) query.list();
            
            for(Tasks eachTask : tasksFromDb1) {
            	 Set<TaskHistory> history = eachTask.getHistoryItems();
            	 eachTask.setHistoryItems(history);
            	 tasksFromDb.add(eachTask);
            }
          
        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching all Users from database." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("The number of users from database are " + tasksFromDb.size());
        return tasksFromDb;
    }

    
    @Transactional
    @SuppressWarnings("unchecked")
    public List<TaskHistory> getTaskHistory(int iTaskId) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        //final List<Tasks> usersFromDb = new ArrayList<Tasks>();
        List<TaskHistory> taskHistory = new ArrayList<TaskHistory>();
        try {
            String queryToFire = "select * from Task_History where taskId=? order by createdDate desc";
            SQLQuery query = session.createSQLQuery(queryToFire).addEntity(TaskHistory.class);
            		query.setInteger(0, iTaskId);

            taskHistory = (List<TaskHistory>) query.list();
        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching task History from database." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("The number of records as task history, from database are " + taskHistory.size());
        return taskHistory;
    }
   
    @Transactional
    @SuppressWarnings("unchecked")
    public Tasks getTaskById(int iTaskId) {

        Session session = this.sessionFactory.getCurrentSession();
        Tasks body = new Tasks();
        try {
            String queryToFire = "select * from Tasks where taskId=?";

            SQLQuery query = session.createSQLQuery(queryToFire).addEntity(Tasks.class);
            query.setInteger(0, iTaskId);

            List<Object[]> allLogsForGivenQuery = (List<Object[]>) query.list();

            if (!query.list().isEmpty()) {
                LOGGER.info("Retrieved Task for given task ID. Size : " + allLogsForGivenQuery.size());
                body = (Tasks) query.list().get(0);
            }
        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching User for given ID = {}, EXCEPTION={}", iTaskId, e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("The User fetched successfully for given UserID={}", iTaskId);
        return body;
    }
    
    @Transactional
    public int createTask(Tasks iTask) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        try {
            session.save(iTask);
            LOGGER.info("Inserted Task record with ID = {} at time = {} ", iTask.getTaskid(), Calendar.getInstance().getTime());

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while saving task into Tasks table." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        return iTask.getTaskid();
    }

    @Transactional
    public int updateTask(Tasks iTaskToUpdate) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        try {
            session.update(iTaskToUpdate);
            LOGGER.info("Updated Task with ID = {} at time = {} ", iTaskToUpdate.getTaskid(), Calendar.getInstance().getTime());

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while updating task." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        return iTaskToUpdate.getTaskid();
    }
    
    @Transactional
    public int deleteTaskById(int iTaskId) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        int deletedRecords = 0;
        try {
            String queryToFire = "delete from Tasks where taskId=?";

            SQLQuery query = session.createSQLQuery(queryToFire).addScalar("max", new IntegerType());
            query.setInteger(0, iTaskId);

            deletedRecords = query.executeUpdate();

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while deleting task for TaskID : {}, EXCEPTION={} ", iTaskId, e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("Successfully deleted Task for the given taskID ={} , number of records deleted={} at ={} ", iTaskId, deletedRecords);
        return deletedRecords;
    }
}
