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
	public String insertHistory(HistoryVO hist) {
		String result	= "결제내역이 실패하였습니다";
		if (expendDao.insertHistory(hist) == 1){
			result	= "결제내역이 저장되었습니다.";
		}
		System.out.println(result);
		return result;
	}
	@Override
	public List<HistoryVO> histList(String date) {
		return expendDao.histList(date);
	}

}
