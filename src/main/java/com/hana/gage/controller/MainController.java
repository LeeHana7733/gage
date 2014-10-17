package com.hana.gage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hana.gage.domain.HistoryVO;
import com.hana.gage.service.ExpendService;

@Controller
public class MainController {
	
	@Autowired
	private ExpendService expendService;
	
	/**
	 * ����ȭ�� ȣ��
	 * @return ModelAndView mav
	 */
	@RequestMapping (value="/" )
	public ModelAndView mainView(){
		ModelAndView mav	= new ModelAndView("index");
		return mav;
	}
	/**
	 * @���⳻���� �����Ѵ�.
	 * @param HistoryVO hist
	 * @return ModelAndView mav
	 */
	@RequestMapping(value="/insertHist")
	public @ResponseBody String insertHist(HistoryVO hist){
		System.out.println("===============" +hist.getSpdAmount());
		return "{\"result\" : \"" + expendService.insertHistory(hist) + "\"}";
	}
	@RequestMapping(value="/expendInfo")
	public ModelAndView expendInfo(@RequestParam HistoryVO hist){
		ModelAndView mav	= new ModelAndView("/expend/expendInfo");
		return mav;
	}
}
