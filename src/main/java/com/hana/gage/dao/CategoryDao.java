package com.hana.gage.dao;

import java.util.List;
import java.util.Map;

import com.hana.gage.domain.CategoryVO;

public interface CategoryDao {
	public List<CategoryVO> cateList(Map<String ,String> map);
	public int	cateMerge(CategoryVO cate);
	public int	cateDelete(CategoryVO cate);
}
