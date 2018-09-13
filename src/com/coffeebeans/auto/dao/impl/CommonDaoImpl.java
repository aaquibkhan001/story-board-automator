package com.coffeebeans.auto.dao.impl;

import java.util.ArrayList;
import java.util.Calendar;
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

import com.coffeebeans.auto.dao.CommonDao;
import com.coffeebeans.auto.entity.References;

@Repository
public class CommonDaoImpl implements CommonDao {

    private static final Logger LOGGER = LoggerFactory.getLogger(CommonDaoImpl.class);

    @Autowired
    private SessionFactory sessionFactory;
      
   
    @Transactional
    public int createReference(References iTypeSector) {

        int record = 0;
        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        try {
            session.save(iTypeSector);
            LOGGER.info("Inserted reference link record at time = {} ", Calendar.getInstance().getTime());

            record = 1;
          
        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while saving reference link into table." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        return record;
    }
    
   

    @Transactional
    public int deleteReferenceLink(int iRefId) {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        int deletedRecords = 0;
        try {
            String queryToFire = "delete from ref_links where refId=?";

            SQLQuery query = session.createSQLQuery(queryToFire).addScalar("max", new IntegerType());
            query.setInteger(0, iRefId);

            deletedRecords = query.executeUpdate();
        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while deleting mapping for RefID : " +iRefId + " , EXCEPTION={} ", e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("Successfully deleted User for the given for Type : " + iRefId  + " number of records deleted={} ", deletedRecords);
        return deletedRecords;
    }
    
   
    @Transactional
    @SuppressWarnings("unchecked")
    public List<String> getDistinctNames() {
        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        List<String> countries = new ArrayList<String>();
        try {

            String str = "select distinct userName from Users order by userName ";

            SQLQuery finalQuery = session.createSQLQuery(str).addScalar("userName", new StringType());

            countries = (List<String>) finalQuery.list();

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching all user names from database." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("The number of distinct user names from database are " + countries.size());
        return countries;
    }
    
    @Transactional
    @SuppressWarnings("unchecked")
    public List<String> getDistinctEmails() {
        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        List<String> countries = new ArrayList<String>();
        try {

            String str = "select distinct email from Users order by email ";

            SQLQuery finalQuery = session.createSQLQuery(str).addScalar("email", new StringType());

            countries = (List<String>) finalQuery.list();

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching all user emails from database." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("The number of distinct user mails from database are " + countries.size());
        return countries;
    }
    
    @Transactional
    @SuppressWarnings("unchecked")
    public List<References> getAllReferences() {

        Session session = this.sessionFactory.getCurrentSession();
        // Transaction transaction = session.getTransaction();
        List<References> mappingsFromdb = new ArrayList<References>();
        try {
            String queryToFire = "select * from ref_links order by updatedDate desc";
            SQLQuery query = session.createSQLQuery(queryToFire).addEntity(References.class);
            
            mappingsFromdb = (List<References>) query.list();

        } catch (Exception e) {
            // transaction.rollback();
            LOGGER.error("Exception occurred while fetching all references from database." + e.getMessage());
        } finally {
            // session.flush();
            // session.close();
        }
        LOGGER.info("The number of references from database are " + mappingsFromdb.size());
        return mappingsFromdb;
    }
    
   
}
