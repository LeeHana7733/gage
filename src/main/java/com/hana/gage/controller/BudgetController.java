package com.hana.gage.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		mav.addObject("title", "예산관리");
		HashMap<String ,String> map	= new HashMap<String ,String>();
		map	=	budgetService.budTotalInfo(bud);
		mav.addObject("totalInfo" , map);
		map.put("BUD_TYPE" , "W");
		mav.addObject("budgetList" , budgetService.budgetList(map));
		return mav;
	}
	@RequestMapping(value="/budgetList",  produces="text/plain; charset=UTF-8")
	public ModelAndView budgetList(BudgetVO bud){
		ModelAndView mav	= new ModelAndView();
		HashMap<String ,String> map	= new HashMap<String ,String>();
		map	=	budgetService.budTotalInfo(bud);
		mav.addObject("totalInfo" , map);
		map.put("BUD_TYPE" , bud.getBudType());
		mav.addObject("budgetList" , budgetService.budgetList(map));
		mav.setViewName("jsonView");
		return mav;
	}
	
	@RequestMapping(value="/budgetMerge",  produces="text/plain; charset=UTF-8")
	public ModelAndView budgetMerge(@RequestParam HashMap<String, String> pMap){
		System.out.println("---------------------------------" + pMap.get("startDate"));
		ModelAndView mav	= new ModelAndView();
		String	result	= "";
		
		result	= budgetService.budgetCheck(pMap);
		if (result == null  || !"add".equals(pMap.get("type")))
			result	= budgetService.budgetMerge(pMap);
		
		mav.addObject("resultMsg" , result);
		mav.setViewName("jsonView");

		return mav;
	}
}
