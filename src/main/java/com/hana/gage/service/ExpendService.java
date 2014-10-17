package com.hana.gage.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.hana.gage.domain.HistoryVO;

@Transactional
public interface ExpendService {
	public int insertHistory(HistoryVO hist);
	public List<HistoryVO> histList(String month);
}
