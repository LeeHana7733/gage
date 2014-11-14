package com.hana.gage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hana.gage.domain.CategoryVO;

@Repository
public class CategoryDaoImpl  implements CategoryDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<CategoryVO> cateList(Map<String ,String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("category.cateList", map);
	}

	@Override
	public int cateMerge(CategoryVO cate) {
		// TODO Auto-generated method stub
		return sqlSession.update("category.cateMerge",cate);
	}

	@Override
	public int cateDelete(CategoryVO cate) {
		// TODO Auto-generated method stub
		return sqlSession.delete("category.cateDelete",cate);
	}
}
