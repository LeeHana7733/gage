package com.hana.gage.controller;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
	 * 메인화면 호출
	 * @return ModelAndView mav
	 */
	@RequestMapping (value="/" )
	public ModelAndView mainView(){
		Calendar now = Calendar.getInstance();
        now.set(2014,10,1);
		ModelAndView mav	= new ModelAndView("index");
		mav.addObject("lastDay" , now.getActualMaximum(Calendar.DATE) );
		return mav;
	}
	/**
	 * @지출내역을 저장한다.
	 * @param HistoryVO hist
	 * @return ModelAndView mav
	 */
	@RequestMapping(value="/insertHist" ,  produces="text/plain; charset=UTF-8")
	public ModelAndView insertHist(HistoryVO hist){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"  , expendService.insertHistory(hist) );
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 
	 * 
	 * 
	 * @param hist
	 * @return
	 */
	@RequestMapping(value="/{date}")
	public ModelAndView histInfoList(@PathVariable String date){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"  , expendService.histList(date) );
		mav.setViewName("jsonView");
		return mav;
	}
	@RequestMapping(value="/expendInfo")
	public ModelAndView expendInfo(@RequestParam HistoryVO hist){
		ModelAndView mav	= new ModelAndView("/expend/expendInfo");
		return mav;
	}
}
