package com.hana.gage.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.hana.gage.domain.HistoryVO;

@Repository
public class ExpendDaoImpl extends SqlSessionDaoSupport implements ExpendDao {

	@Override
	public int insertHistory(HistoryVO hist) {
		// TODO Auto-generated method stub
		return getSqlSession().insert("history.insertHistory" , hist);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<HistoryVO> histList(String date) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("history.historyList",date);
	}

}
