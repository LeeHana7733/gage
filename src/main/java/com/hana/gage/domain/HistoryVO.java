package com.hana.gage.domain;

public class HistoryVO {
	private String	oid				= "";
	private String 	spdDate		= ""; 
	private int 		spdAmount 	= 0 ;
	private String 	spdHistory	= ""; 
	private String 	spdMemo	= ""; 
	private String 	spdCategory	= "0"; 
	private String	spdPayment	= "0"; 
	private String 	spdUpdate_date	= ""; 
	private String 	spdCreate_date	= "";
	private String	spdTime		= "";
	private String	paymentType	= "0";
	private String	cateType	= "0";
	private String 	spdType		= "";
	
	
	public String getSpdType() {
		return spdType;
	}
	public void setSpdType(String spdType) {
		this.spdType = spdType;
	}
	public String getCateType() {
		return cateType;
	}
	public void setCateType(String cateType) {
		this.cateType = cateType;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public String getSpdTime() {
		return spdTime;
	}
	public void setSpdTime(String spdTime) {
		this.spdTime = spdTime;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
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
	public String getSpdPayment() {
		return spdPayment;
	}
	public void setSpdPayment(String spdPayment) {
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
