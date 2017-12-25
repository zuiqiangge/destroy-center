package cn.com.pengyue.dao.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import cn.com.pengyue.dao.IApplyConditionHistoryDao;
import cn.com.pengyue.dao.IApplyarticleDao;
import cn.com.pengyue.pojo.Apply;
import cn.com.pengyue.pojo.ApplyConditionHistory;
import cn.com.pengyue.pojo.Applyarticle;
import cn.com.pengyue.pojo.PageInfo;
@Repository
public class ApplyConditionHistoryDao extends BaseDao<ApplyConditionHistory, Integer> implements IApplyConditionHistoryDao {

	@Override
	public void add(ApplyConditionHistory history) {
		Session session = getHibernateTemplate().getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		session.merge(history);
		//session.saveOrUpdate(apply);
		tx.commit();
		session.close();
	}

	@Override
	public List<ApplyConditionHistory> listByUserId(Integer userId,int start,int length) {
		 Session session = getHibernateTemplate().getSessionFactory().openSession();
		 Query query =session.createQuery("from "+ApplyConditionHistory.class.getName());
		 query.setFirstResult(start);
		 query.setMaxResults(length);
		 List list = query.list();
		 session.close();
		 return list;
	}
	
	@Override
	public int getCount(Integer userId) {
		 Session session = getHibernateTemplate().getSessionFactory().openSession();
		 Query query =session.createQuery("from "+ApplyConditionHistory.class.getName());
		 int total = query.list().size();
		 session.close();
		 return total;
	}

	

}
