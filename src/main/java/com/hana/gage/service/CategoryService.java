package com.hana.gage.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.hana.gage.domain.CategoryVO;

@Transactional
public interface CategoryService {
	public List<CategoryVO> cateList(Map<String ,String> map);
	public String	cateMerge(CategoryVO cate);
	public String	cateDelete(CategoryVO cate);
}
