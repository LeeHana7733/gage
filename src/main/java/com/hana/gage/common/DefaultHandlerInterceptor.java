package com.hana.gage.common;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class DefaultHandlerInterceptor extends HandlerInterceptorAdapter {
	protected final Log logger = LogFactory.getLog(getClass());

    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {
        if( logger.isDebugEnabled() ) {
            logger.debug("afterCompletion method called");
        }
        System.out.println("==================== after~~~======================");
    }

    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object obj) throws Exception {
        return true;
    }
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    	
    }
}
