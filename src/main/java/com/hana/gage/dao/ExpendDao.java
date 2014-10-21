package com.hana.gage.dao;

import java.util.HashMap;
import java.util.List;

import com.hana.gage.domain.HistoryVO;

public interface ExpendDao {
	public int insertHistory(HistoryVO hist);
	public List<HashMap<String,String>> histList(String date);
	public List<HistoryVO> histInfo(String date);
	public String totalAmount(String date ,String type);
}
