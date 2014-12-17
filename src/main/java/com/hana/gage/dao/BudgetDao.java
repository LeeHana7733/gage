package com.hana.gage.dao;

import java.util.HashMap;
import java.util.List;

import com.hana.gage.domain.BudgetVO;

public interface BudgetDao {
	public HashMap<String ,String> budTotalInfo(BudgetVO bud);
	public List<BudgetVO> budgetList(HashMap<String,String> map);

}
