package com.hana.gage.dao;

import java.util.List;

import com.hana.gage.domain.HistoryVO;

public interface ExpendDao {
	public int insertHistory(HistoryVO hist);
	public List<HistoryVO> histList(String month);
}
