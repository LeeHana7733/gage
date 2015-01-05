package com.hana.gage.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.hana.gage.domain.BudgetVO;
@Transactional
public interface BudgetService {
	public HashMap<String ,String> budTotalInfo(BudgetVO bud);
	public List<HashMap<String ,String>> budgetList(HashMap<String,String> map);
	public String	budgetMerge(HashMap<String, String> map);
	public String budgetCheck(HashMap<String, String> map);
}
