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
	public int mergeHistory(HistoryVO hist) {
		// TODO Auto-generated method stub
		return sqlSession.update("history.mergeHistory" , hist);
	}

	@Override
	public String totalAmount(HistoryVO hist ,String type) {
		// TODO Auto-generated method stub
		HashMap<String ,Object> map = new HashMap<String ,Object>();
		map.put("date" , hist);
		map.put("type" , type);
		return sqlSession.selectOne("history.totalAmount", map);
	}

	@Override
	public List<HistoryVO> histInfo(HashMap<String,String> map) {
		// TODO Auto-generated method stub
		return  sqlSession.selectList("history.historyInfo",map);
	}

	@Override
	public int deleteHist(String oid) {
		// TODO Auto-generated method stub
		return sqlSession.delete("history.historyDelete" , oid);
	}

	@Override
	public List<HashMap<String, String>> histList(HistoryVO hist) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("history.historyList",hist);
	}

}
