package com.hana.gage.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.hana.gage.domain.BudgetVO;
@Transactional
public interface BudgetService {
	public HashMap<String ,String> budTotalInfo(BudgetVO bud);
	public List<BudgetVO> budgetList(HashMap<String,String> map);
}
