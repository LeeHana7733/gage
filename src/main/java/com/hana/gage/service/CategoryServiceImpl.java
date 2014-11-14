package com.hana.gage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hana.gage.dao.CategoryDao;
import com.hana.gage.domain.CategoryVO;

@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	private CategoryDao	categoryDao;
	
	@Override
	public List<CategoryVO> cateList(Map<String ,String> map) {
		// TODO Auto-generated method stub
		return categoryDao.cateList(map);
	}

	@Override
	public String cateMerge(CategoryVO cate) {
		// TODO Auto-generated method stub
		String result	= "ī�װ� ������ �����Ͽ����ϴ�.";
		if (categoryDao.cateMerge(cate) == 0 )
			result	= "ī�װ� ������ �����Ͽ����ϴ�.";
		return result;
	}

	@Override
	public String cateDelete(CategoryVO cate) {
		// TODO Auto-generated method stub
		String result	= "ī�װ� ������ �Ϸ�Ǿ����ϴ�..";
		if (categoryDao.cateDelete(cate) == 0 )
			result	= "ī�װ� ������ �����Ͽ����ϴ�.";
		return result;
	}

}
