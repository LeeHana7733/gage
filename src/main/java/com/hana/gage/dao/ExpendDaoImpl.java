package com.hana.gage.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hana.gage.domain.HistoryVO;

@Repository
public class ExpendDaoImpl implements ExpendDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertHistory(HistoryVO hist) {
		// TODO Auto-generated method stub
		return sqlSession.insert("history.insertHistory" , hist);
	}

	@Override
	public List<HashMap<String,String>> histList(String date) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("history.historyList",date);
	}

	@Override
	public String totalAmount(String date ,String type) {
		// TODO Auto-generated method stub
		HashMap<String ,String> map = new HashMap<String ,String>();
		map.put("date" , date);
		map.put("type" , type);
		return sqlSession.selectOne("history.totalAmount", map);
	}

	@Override
	public List<HistoryVO> histInfo(String date) {
		// TODO Auto-generated method stub
		return  sqlSession.selectList("history.historyInfo",date);
	}

}
