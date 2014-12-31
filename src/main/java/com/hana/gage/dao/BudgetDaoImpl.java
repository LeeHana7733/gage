package com.hana.gage.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hana.gage.domain.BudgetVO;

@Repository
public class BudgetDaoImpl implements BudgetDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public HashMap<String, String> budTotalInfo(BudgetVO bud) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("budget.budTotalInfo" , bud);
	}

	@Override
	public List<HashMap<String ,String>> budgetList(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("budget.budgetList" , map) ;
	}
}
