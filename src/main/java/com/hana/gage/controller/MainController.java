package com.hana.gage.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

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
	public ModelAndView mainView(HistoryVO hist){
		Calendar now 			= Calendar.getInstance();
		SimpleDateFormat	sdf	= new SimpleDateFormat("yyyy-MM-dd");
        now.set(now.get(Calendar.YEAR) , now.get(Calendar.MONTH) , now.get(Calendar.DATE) );
		ModelAndView mav	= new ModelAndView("index");
		mav.addObject("lastDay" , now.getActualMaximum(Calendar.DATE) );
		mav.addObject("date" , sdf.format(new Date()));
		hist.setSpdDate(sdf.format(new Date()));
		mav.addObject("totalAmount" , expendService.totalAmount(hist,"M"));
		mav.addObject("totalDate" , expendService.histList(hist));
		return mav;
	}
	/**
	 * @지출내역을 저장한다.
	 * @param HistoryVO hist
	 * @return ModelAndView mav
	 */
	@RequestMapping(value="/mergeHist" ,  produces="text/plain; charset=UTF-8")
	public ModelAndView mergeHist(HistoryVO hist){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"	, expendService.mergeHistory(hist) );
		mav.addObject("dateTotal"	, expendService.totalAmount(hist,"D") );
		mav.addObject("monthTotal"	, expendService.totalAmount(hist,"M") );
		mav.setViewName("jsonView");
		return mav;
	}
	
	@RequestMapping(value="/deleteHist" ,  produces="text/plain; charset=UTF-8")
	public ModelAndView deleteHist(HistoryVO hist){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"	, expendService.deleteHist(hist.getOid() ));
		mav.addObject("dateTotal"	, expendService.totalAmount(hist ,"D") );
		mav.addObject("monthTotal"	, expendService.totalAmount(hist  ,"M") );
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * @param hist
	 * @return
	 */
	@RequestMapping(value="/{type}/{value}")
	public ModelAndView histInfoInfo(	@PathVariable("type") String type,
												@PathVariable("value") String value,
												HistoryVO hist){
		HashMap<String ,String> map	= new HashMap<String ,String>();
		map.put("type", type);
		map.put("value", value);
		map.put("spdPayment", hist.getSpdPayment());
		
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"  , expendService.histInfo( map ));
		mav.setViewName("jsonView");
		return mav;
	}
	@RequestMapping(value="/list"  ,  produces="text/plain; charset=UTF-8")
	public ModelAndView histList(HistoryVO hist){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("totalDate" , expendService.histList(hist));
		mav.addObject("monthTotal"	, expendService.totalAmount(hist  ,"M") );
		mav.setViewName("jsonView");
		return mav;
	}
}
