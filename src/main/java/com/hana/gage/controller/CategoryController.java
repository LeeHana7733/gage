package com.hana.gage.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hana.gage.service.CategoryService;

@Controller
public class CategoryController {

	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping(value="/cateList" ,  produces="text/plain; charset=UTF-8")
	public ModelAndView cateList(	@RequestParam(value="cateType",required=false) String cateType,
											@RequestParam(value="cateOid",required=false) String cateOid){
		ModelAndView mav	= new ModelAndView();
		Map<String ,String> map = new HashMap<String , String>();
		map.put("cateType", cateType);
		map.put("cateOid", cateOid);
		mav.addObject("result" , categoryService.cateList(map));
		mav.setViewName("jsonView");
		return mav;
	}
}
