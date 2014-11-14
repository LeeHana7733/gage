package com.hana.gage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hana.gage.domain.HistoryVO;

public interface ExpendDao {
	public int mergeHistory(HistoryVO hist);
	public int deleteHist(String oid);
	public List<HashMap<String,String>> histList(HistoryVO hist);
	public List<HistoryVO> histInfo(HashMap<String,String> map);
	public Map<String, String> totalAmount(HistoryVO hist);
}
