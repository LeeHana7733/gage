<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<header class="navbar navbar-inverse navbar-fixed-top bs-docs-nav" role="banner">
	<div class="container">
		<ul class="nav nav-tabs">
			<li><a href="/">지출내역</a></li>
			<li><a href="/inPay">수입내역</a></li>
			<li><a href="/budget">예산관리</a></li>
			<li><a href="/baseStats">자동통계</a></li>
			<li><a href="/dataCharts">자료차트</a></li>
			<li class="navbar-right dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					<span class="glyphicon glyphicon-align-justify"></span>
				</a>
             	<ul class="dropdown-menu" role="menu">
	             	<li><a href="#">이전 문자 등록</a></li>
	             	<li><a href="#">즐겨찾기 편집</a></li>
	             	<li><a href="#">엑셀(CSV) 내보내기</a></li>
	             	<li><a href="#">도움말</a></li>
	             	<li><a href="#">환경설정</a></li>
             	</ul>
			</li>
			<li class="navbar-right a"><span class="glyphicon glyphicon-pencil"></span></li>
			<li class="navbar-right a"><span class="glyphicon glyphicon-search"></span></li>
		</ul>
	</div>
	<div class="container">
		<div class="row all">
		 	<div class="col-sm-1 col-sm-offset-3 pointer" ><span class="glyphicon glyphicon-chevron-left"></span></div>
		 	<div class="col-sm-2" id="full_date">${totalInfo.TODATE}</div>
		 	<div class="col-sm-1 pointer"><span class="glyphicon glyphicon-chevron-right"></span></div>
			<div class="col-sm-2 col-sm-offset-2"><fmt:formatNumber type="number" pattern="###,###" value="${totalInfo.MONTHTOTAL}" />원</div>		
		</div>
	</div>
	<div class="container">
		<div class="row bottom">
			<div class="col-sm-4"><button type="button" class="btn btn-default card">카드별</button></div>
			<div class="col-sm-4"><button type="button" class="btn btn-default  class">분류별</button></div>
			<div class="col-sm-4"><button type="button" class="btn btn-default detail">세부분류별</button></div>
		</div>
	</div>
</header>