package com.hana.gage.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hana.gage.domain.BudgetVO;
import com.hana.gage.service.BudgetService;

@Controller
public class BudgetController {
	
	@Autowired
	private BudgetService budgetService;
	
	@RequestMapping(value="/budget")
	public ModelAndView budgetView (BudgetVO bud){
		ModelAndView mav	= new ModelAndView("budget");
		mav.addObject("title", "�������");
		HashMap<String ,String> map	= new HashMap<String ,String>();
		map	=	budgetService.budTotalInfo(bud);
		mav.addObject("totalInfo" , map);
		map.put("BUD_TYPE" , "M");
		mav.addObject("budgetList" , budgetService.budgetList(map));
		return mav;
	}
	@RequestMapping(value="/budgetList",  produces="text/plain; charset=UTF-8")
	public ModelAndView budgetList(BudgetVO bud){
		ModelAndView mav	= new ModelAndView();
		HashMap<String ,String> map	= new HashMap<String ,String>();
		map	=	budgetService.budTotalInfo(bud);
		mav.addObject("totalInfo" , map);
		map.put("BUD_TYPE" , "M");
		mav.addObject("budgetList" , budgetService.budgetList(map));
		mav.setViewName("jsonView");
		return mav;
	}
}
