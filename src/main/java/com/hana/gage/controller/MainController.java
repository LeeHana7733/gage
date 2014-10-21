package com.hana.gage.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
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
		Calendar now 			= Calendar.getInstance();
		SimpleDateFormat	sdf	= new SimpleDateFormat("yyyy-MM-dd");
        now.set(now.get(Calendar.YEAR) , now.get(Calendar.MONTH) , now.get(Calendar.DATE) );
		ModelAndView mav	= new ModelAndView("index");
		mav.addObject("lastDay" , now.getActualMaximum(Calendar.DATE) );
		mav.addObject("date" , sdf.format(new Date()));
		mav.addObject("totalAmount" , expendService.totalAmount(sdf.format(new Date()),"M"));
		mav.addObject("totalDate" , expendService.histList(sdf.format(new Date())));
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
		mav.addObject("result"	, expendService.insertHistory(hist) );
		System.out.println(hist.getSpdDate()+"------------------------" );
		mav.addObject("total"	, expendService.totalAmount(hist.getSpdDate()  ,"D") );
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
	@RequestMapping(value="/data/{date}")
	public ModelAndView histInfoInfo(@PathVariable String date){
		System.out.println("==================="+date);
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"  , expendService.histInfo(date) );
		mav.setViewName("jsonView");
		return mav;
	}
}
