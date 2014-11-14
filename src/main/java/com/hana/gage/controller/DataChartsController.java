package com.hana.gage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DataChartsController {
	
	@RequestMapping (value="/dataCharts")
	public ModelAndView dataChartsView(){
		ModelAndView mav	= new ModelAndView("dataCharts");
		mav.addObject("title", "자료차트");
		return mav;
	}
}
