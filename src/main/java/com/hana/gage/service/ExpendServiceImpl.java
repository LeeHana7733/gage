package com.hana.gage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hana.gage.dao.ExpendDao;
import com.hana.gage.domain.HistoryVO;

@Service("expendService")
public class ExpendServiceImpl implements ExpendService{

	@Autowired
	private ExpendDao	expendDao;
	@Override
	public int insertHistory(HistoryVO hist) {
		
		return expendDao.insertHistory(hist);
	}
	@Override
	public List<HistoryVO> histList(String month) {
		// TODO Auto-generated method stub
		return expendDao.histList(month);
	}

}
