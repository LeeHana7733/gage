package com.hana.gage.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hana.gage.dao.BudgetDao;
import com.hana.gage.domain.BudgetVO;

@Service("budgetService")
public class BudgetServiceImpl implements BudgetService{

	@Autowired
	private BudgetDao budgetDao;
	@Override
	public HashMap<String, String> budTotalInfo(BudgetVO bud) {
		// TODO Auto-generated method stub
		if ("".equals(bud.getBudType().trim()) || bud.getBudType() == null)
			bud.setBudType("W");
		if ("".equals(bud.getBudDate().trim())){
			java.util.Date d = new java.util.Date();
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd"); 
			String todate = sd.format(d); 
			bud.setBudDate(todate);
		}
		return budgetDao.budTotalInfo(bud);
	}
	@Override
	public List<HashMap<String ,String>> budgetList(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return budgetDao.budgetList(map);
	}
	@Override
	public String budgetMerge(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		if (budgetDao.budgetMerge(map) == 0)
			return "���� �����Ͱ� �߰��� �����Ͽ����ϴ�.";
		else
			return "���� �����Ͱ� �߰� �Ǿ����ϴ�.";
	}
	@Override
	public String budgetCheck(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		if (budgetDao.budgetCheck(map) == 1)
			return	"���� �����Ͱ� �̹� �����մϴ�."; 
		return null;
	}
}