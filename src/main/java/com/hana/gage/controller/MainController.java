package com.hana.gage.controller;

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
	 * ����ȭ�� ȣ��
	 * @return ModelAndView mav
	 */
	@RequestMapping (value="/" )
	public ModelAndView mainView(){
		HistoryVO hist			= new HistoryVO();
		ModelAndView mav	= new ModelAndView("index");
		mav.addObject("totalInfo" , expendService.totalAmount(hist));
		mav.addObject("totalDate" , expendService.histList(hist));
		return mav;
	}
	/**
	 * @���⳻���� �����Ѵ�.
	 * @param HistoryVO hist
	 * @return ModelAndView mav
	 */
	@RequestMapping(value="/mergeHist" ,  produces="text/plain; charset=UTF-8")
	public ModelAndView mergeHist(HistoryVO hist){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"	, expendService.mergeHistory(hist) );
		mav.addObject("totalInfo"	, expendService.totalAmount(hist) );
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * ���⳻���� �����Ѵ�. 
	 * @param hist
	 * @return ModelAndView mav
	 */
	@RequestMapping(value="/deleteHist" ,  produces="text/plain; charset=UTF-8")
	public ModelAndView deleteHist(HistoryVO hist){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"	, expendService.deleteHist(hist.getOid() ));
		mav.addObject("totalInfo"	, expendService.totalAmount(hist));
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * �������� ��ȸ�Ѵ�. (JSON)
	 * @param hist
	 * @return ModelAndView mav
	 */
	@RequestMapping(value="/{type}/{value}")
	public ModelAndView histInfo(	@PathVariable("type") String type,
											@PathVariable("value") String value,
											HistoryVO hist){
		HashMap<String ,String> map	= new HashMap<String ,String>();
		map.put("type", type);
		map.put("value", value);
		map.put("paymentType", hist.getPaymentType());
		map.put("cateType", hist.getCateType());
		map.put("spdType", hist.getSpdType());
		
		ModelAndView mav	= new ModelAndView();
		mav.addObject("result"  , expendService.histInfo( map ));
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * �޺� ����Ʈ�� ��ȸ�Ѵ� 
	 * @param hist
	 * @return ModelAndView mav
	 * ���� - ��¥,�з���
	 */ 
	@RequestMapping(value="/list"  ,  produces="text/plain; charset=UTF-8")
	public ModelAndView histList(HistoryVO hist){
		ModelAndView mav	= new ModelAndView();
		mav.addObject("totalDate" , expendService.histList(hist));
		mav.addObject("totalInfo"	, expendService.totalAmount(hist) );
		mav.setViewName("jsonView");
		return mav;
	}
}
