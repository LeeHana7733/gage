package com.hana.gage.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.hana.gage.domain.HistoryVO;

@Transactional
public interface ExpendService {
	public String mergeHistory(HistoryVO hist);
	public String deleteHist(String oid);
	public List<HashMap<String,String>> histList(String date);
	public List<HistoryVO> histInfo(HashMap<String,String> map);
	public String totalAmount(String date , String type);
}
