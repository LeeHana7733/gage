package com.hana.gage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BaseStatsController {
	
	@RequestMapping(value="/baseStats")
	public ModelAndView baseStatsView(){
		ModelAndView mav	= new ModelAndView("baseStats");
		mav.addObject("title", "자동통계");
		
		return mav;
		
	}
}
