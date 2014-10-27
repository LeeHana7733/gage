package com.hana.gage.service;

import java.util.HashMap;
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
	public String mergeHistory(HistoryVO hist) {
		String result	= "결제내역이 실패하였습니다";
		if (expendDao.mergeHistory(hist) == 1){
			result	= "결제내역이 저장되었습니다.";
		}
		return result;
	}
	@Override
	public String totalAmount(HistoryVO hist,String type) {
		// TODO Auto-generated method stub
		return expendDao.totalAmount(hist , type);
	}
	@Override
	public List<HistoryVO> histInfo(HashMap<String,String> map) {
		// TODO Auto-generated method stub
		return expendDao.histInfo(map);
	}
	@Override
	public String deleteHist(String oid) {
		// TODO Auto-generated method stub
		String result	= "결제내역 삭제가 실패하였습니다";
		if (expendDao.deleteHist(oid) ==1 )
			result	= "결제내역 삭제 되었습니다.";
		return result;
	}
	@Override
	public List<HashMap<String, String>> histList(HistoryVO hist) {
		// TODO Auto-generated method stub
		return expendDao.histList(hist);
	}

}
