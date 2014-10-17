package com.hana.gage.domain;

public class HistoryVO {
	private String 	spdDate		=""; 
	private int 		spdAmount 	=0 ;
	private String 	spdHistory	=""; 
	private String 	spdMemo	=""; 
	private String 	spdCategory	=""; 
	private int 		spdPayment	=0; 
	private String 	spdUpdate_date	=""; 
	private String 	spdCreate_date	="";
	public String getSpdDate() {
		return spdDate;
	}
	public void setSpdDate(String spdDate) {
		this.spdDate = spdDate;
	}
	public int getSpdAmount() {
		return spdAmount;
	}
	public void setSpdAmount(int spdAmount) {
		this.spdAmount = spdAmount;
	}
	public String getSpdHistory() {
		return spdHistory;
	}
	public void setSpdHistory(String spdHistory) {
		this.spdHistory = spdHistory;
	}
	public String getSpdMemo() {
		return spdMemo;
	}
	public void setSpdMemo(String spdMemo) {
		this.spdMemo = spdMemo;
	}
	public String getSpdCategory() {
		return spdCategory;
	}
	public void setSpdCategory(String spdCategory) {
		this.spdCategory = spdCategory;
	}
	public int getSpdPayment() {
		return spdPayment;
	}
	public void setSpdPayment(int spdPayment) {
		this.spdPayment = spdPayment;
	}
	public String getSpdUpdate_date() {
		return spdUpdate_date;
	}
	public void setSpdUpdate_date(String spdUpdate_date) {
		this.spdUpdate_date = spdUpdate_date;
	}
	public String getSpdCreate_date() {
		return spdCreate_date;
	}
	public void setSpdCreate_date(String spdCreate_date) {
		this.spdCreate_date = spdCreate_date;
	}

}
