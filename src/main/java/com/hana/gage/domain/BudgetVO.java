package com.hana.gage.domain;

public class BudgetVO extends CategoryVO {
	private String budDate			= "";
	private String budAmount	= "0";
	private String budCategory	= "";
	private String budType		= "";
	
	public String getBudDate() {
		return budDate;
	}
	public void setBudDate(String budDate) {
		this.budDate = budDate;
	}
	public String getBudAmount() {
		return budAmount;
	}
	public void setBudAmount(String budAmount) {
		this.budAmount = budAmount;
	}
	public String getBudCategory() {
		return budCategory;
	}
	public void setBudCategory(String budCategory) {
		this.budCategory = budCategory;
	}
	public String getBudType() {
		return budType;
	}
	public void setBudType(String budType) {
		this.budType = budType;
	}
}
