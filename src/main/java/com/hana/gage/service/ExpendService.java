package com.hana.gage.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.hana.gage.domain.HistoryVO;

@Transactional
public interface ExpendService {
	public String insertHistory(HistoryVO hist);
	public List<HashMap<String,String>> histList(String date);
	public List<HistoryVO> histInfo(String date);
	public String totalAmount(String date , String type);
}
