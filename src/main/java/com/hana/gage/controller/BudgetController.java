package com.hana.gage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BudgetController {
	
	@RequestMapping(value="/budget")
	public ModelAndView budgetView (){
		ModelAndView mav	= new ModelAndView("budget");
		mav.addObject("title", "예산관리");
		return mav;
	}
}
