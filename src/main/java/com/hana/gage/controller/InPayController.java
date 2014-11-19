package com.hana.gage.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hana.gage.domain.HistoryVO;
import com.hana.gage.service.ExpendService;

@Controller
public class InPayController {
	@Autowired
	private ExpendService expendService;
	
	@RequestMapping(value="/inPay")
	public ModelAndView outPayView(){
		ModelAndView mav	= new ModelAndView("inPay");
		HistoryVO hist			= new HistoryVO();
		hist.setSpdType("IN");
		Map<String , String > result	= expendService.totalAmount(hist);
		
		mav.addObject("totalInfo" , expendService.totalAmount(hist));
		mav.addObject("totalDate" , expendService.histList(hist));
		hist.setSpdType("OUT");
		
		int	outAmount	= Integer.parseInt(String.valueOf(result.get("MONTHTOTAL")));
		
		result	=	 expendService.totalAmount(hist);
		mav.addObject("restAmount" ,	outAmount  -Integer.parseInt( String.valueOf(result.get("MONTHTOTAL"))) );
		mav.addObject("title" , "수입내역");
		
		return mav;
	}
	
	@RequestMapping(value="/inList")
	public ModelAndView outList(HistoryVO hist){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"  , expendService.histList(hist));
		Map<String ,String > result		=	expendService.totalAmount(hist) ;
		mav.addObject("totalInfo"	, result);
		if ("IN".equals(hist.getSpdType())){
			hist.setSpdType("OUT");
			int	outAmount	= Integer.parseInt(String.valueOf(result.get("MONTHTOTAL")));
			result	=	 expendService.totalAmount(hist);
			mav.addObject("restAmount" ,	outAmount  -Integer.parseInt( String.valueOf(result.get("MONTHTOTAL"))) );
		}
		mav.setViewName("jsonView");
		return mav;
	}
}
