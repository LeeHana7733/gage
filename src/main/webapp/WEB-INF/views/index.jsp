<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
  <head>
    <title>money book</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 부트스트랩 -->
    <link href="/resources/css/bootstrap.css" rel="stylesheet" media="screen">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
	<script src="//code.jquery.com/jquery.js"></script>
	<script src="/resources/js/jquery-ui.custom.min.js"></script>
	<script src="/resources/js/jquery-number.js"></script>
	<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
	<script type="text/javascript">
	var timer;
	var subTimer;
	var alertFooterEl;
	$(document).ready(function(){
		$(".col-sm-9 > .input-group > .btn").on({
			mousedown : function(){
				var el	=	$(this);
				timer = setTimeout(function () {
					$("#myModal").modal();
					$("form")[0].reset();
					$("input[name='oid']").val("");
					$.inputDisable(false);
					$("#alertModal > div > div>.modal-header h4").text("결과");
					$("#myModal > div > div >.modal-footer > .btn-primary").removeClass("btn-menu").removeClass("btn-update").addClass("btn-save").text("저장");
					 $("input[name*='spdDate']").val(el.closest(".row").children().first().text().trim());
				}, 1000);		
			},
			click : function(){
				var value = $(this).closest(".row").children().first().text();
				var lastNode= $(this).closest(".row").next().children().first();
				$.getHistInfo(value , lastNode ,"date");
				$(this).closest(".row").next().toggleClass("hide");
				$(this).toggleClass("btn-info");
			},
			mouseup :function(){
				clearTimeout(timer);
			}
		});
		
		$(document).on({
			mousedown: function(event){
				var $this	= $(this);
				subTimer = setTimeout(function () {
					$.getHistInfo($this.attr("id"),"menu", "pop");
				}, 1000);		

			},
			mouseup:function(){
				clearTimeout(subTimer);
			},
			click:function(){
				$("#myModal").modal();
				$.getHistInfo($(this).attr("id"),true, "pop");	
				$("#myModal >div> div>.modal-footer > .btn-primary").removeClass("btn-save").removeClass("btn-update").addClass("btn-menu").text("메뉴열기");
				$("input[name*='spdDate']").val($(this).closest(".row").children().first().text().trim());
			}
		} , ".col-sm-12>.btn");
		
		$(document).on({
			click : function(){
				if ($(this).hasClass("btn-save")||$(this).hasClass("btn-update")){
					var dateVal	= $("input[name*='spdDate']").val();
					$.post("/mergeHist" , 
							$("#modalForm").serialize(),
							function (data){
								$("#myModal").modal("hide");
								$('#myModal').on('hidden.bs.modal', function () {
									$("form")[0].reset();
								});
								$("#alertModal > div > div>.modal-body").text(data.result);
								$("#alertModal").modal();
								if ($("#alertModal > div > div>.modal-footer").length == 0 )
									$("#alertModal > div > div").append("<div class=\"modal-footer center\" >"+alertFooterEl+"</div>");
								$.getHistInfo(dateVal ,$("button[data-date='"+ dateVal + "']").closest(".row").next().children().first() , "date");	
								$("button[data-date='"+ dateVal + "']").parent().next().children().children().text($.number(data.dateTotal) + "원");
								$(".row.all").children().last().text($.number(data.monthTotal) + "원");
							},
							'json'
					);
				}else{
					$("#myModal").modal("hide");
					$.showPaymentPop();
				}
			}
		} ,".modal-footer > .btn-primary");
		
		$("#datepicker").datepicker({
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    showMonthAfterYear: true,
		    yearSuffix: '년'
		  });
		
		$(document).on({
			click : function (){
				if ($(this).hasClass("btn-update")){
					$.getHistInfo($("#alertModal").attr("data-id") , false , "pop" );
					$("#alertModal").modal("hide");
					$("#myModal").modal();
					$("#myModal > div > div >.modal-footer > .btn-primary").removeClass("btn-menu").removeClass("btn-save").addClass("btn-update").text("수정");
				}else if ($(this).hasClass("btn-delete")){
					alert ("Asfadsf");
					$.post("/deleteHist" ,
							$("#modalForm").serialize(),
							function (data){
								$("#myModal").modal("hide");
								$('#myModal').on('hidden.bs.modal', function () {
									$("form")[0].reset();
								});
								$("#alertModal > div > div>.modal-body").text(data.result);
								$("#alertModal").modal();
								if ($("#alertModal > div > div>.modal-footer").length == 0 )
									$("#alertModal > div > div").append("<div class=\"modal-footer center\" >"+alertFooterEl+"</div>");
								$.getHistInfo(dateVal ,$("button[data-date='"+ dateVal + "']").closest(".row").next().children().first() , "date");	
								$("button[data-date='"+ dateVal + "']").parent().next().children().children().text($.number(data.dateTotal) + "원");
								$(".row.all").children().last().text($.number(data.monthTotal) + "원");
							}
							,'json');
				}else{
					
				}
			}
		} , "#alertModal > div > div> .modal-body> .btn.btn-default ");
		
		$('body').animate({
		    scrollTop:$("button[data-date='${date}']").offset().top-124
		}, 500);
		
		/********************************************************************************************************************
		** @function getHistInfo
		** @history를 조회한다
		** @params value  		date or oid
						option			lastNode or menu or boolean
						type			date	날짜를 클릭했을 경우 
										pop	상세정보를 클릭했을 경우
		********************************************************************************************************************/
		$.getHistInfo = function (value ,option,type) {
			$.post("/"+type+"/"+value, 
					"",
					function(data){
						if (type=="date")
							$.getHistInfoBasic(data , option);
						else{
							$.getHistInfoPop(data , option);
							if (option=="menu")
								$.showPaymentPop();
						}
					},
					"json"
			);
		};
				
		/********************************************************************************************************************
		**  @function getHistInfoBasic
		**	@조회한 날짜의 상세 정보를 보여준다.
		**	@params	data		: 날짜
		**				lastNode : 조회한날짜의 마지막 노드
		********************************************************************************************************************/
		$.getHistInfoBasic = function (data , lastNode){
			var html	= "";
			if (data.result != ""){
				$.each(data.result , function (i, val){
					var dataVal	= "";
					dataVal	+= val.spdTime +"<pre>"
								+ $.number(val.spdAmount) + "원</pre> <pre>" + val.spdMemo+ "</pre>";
					html += "<button type=\"button\" class=\"btn btn-default rightTab fix\" id=\""+val.oid+"\">"+dataVal+"</button>";
				});
			}else{
				html	="<input type=\"text\"  class=\"form-control\" value=\"작성된 지출내역이 없습니다.\" >";
			}
			lastNode.html(html);
		};
		
		/********************************************************************************************************************
		** @function getHistInfoPop
		**	@ModalPop Setting
		**	@params 	data : 조회정보 
		**					type : input disable 여부
		********************************************************************************************************************/
		$.getHistInfoPop = function (data , option){
			if (data.result != ""){
				$.each(data.result , function (i, val){
					$("input[name='oid']").val(val.oid);
					$("input[name='spdDate']").val(val.spdDate);
					$("input[name='spdAmount']").val(val.spdAmount);
					$("input[name='spdHistory']").val(val.spdHistory);
					$("input[name='spdMemo']").val(val.spdMemo);
					$("input[name='spdCategory']").val(val.spdCategory);
				});
				$.inputDisable(option);
			}
		};
		
		/********************************************************************************************************************
		** @function inputDisable
		**	@form 전체 input disabled 셋팅
		**	@params 	option : input disable 여부 (menu일 경우 무조건 disabled)
		********************************************************************************************************************/
		$.inputDisable	= function(option){
			var type	= option =="menu" || option ? true : false;
			$("form  input").each(function(index) {
				if (type)
					$(this).attr("disabled","disabled");
				else
					$(this).removeAttr("disabled");				
             });  
		};
		
		/********************************************************************************************************************
		** @function  showPaymentPop
		**	@메뉴를 셋팅한다.
		**	@params 	option : input disable 여부 (menu일 경우 무조건 disabled)
		********************************************************************************************************************/
		$.showPaymentPop = function(){
			$("#alertModal").attr("data-id" , $("input[name='oid']").val());
			$("#alertModal > div > div>.modal-header h4").text($("input[name='spdHistory']").val());
			var html	= "<button type=\"button\" class=\"btn btn-default  btn-block btn-update\">수정하기</button>";
				html += "<button type=\"button\" class=\"btn btn-default  btn-block btn-delete\">삭제하기</button>";
				html += "<button type=\"button\" class=\"btn btn-default  btn-block btn-smart\">스마트정산</button>";
			$("#alertModal > div > div>.modal-body").html(html);
			alertFooterEl	= $("#alertModal > div > div>.modal-footer").html();
			$("#alertModal > div > div>.modal-footer").remove();
			$("#alertModal").modal();
		}
	});
	</script>
  </head>
  <body data-twttr-rendered="true">
  	<img alt="loading" id="loading" src="/resources/images/ajax-loader.gif" />
  	<header class="navbar navbar-inverse navbar-fixed-top bs-docs-nav" role="banner">
		<div class="container">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#">지출내역</a></li>
				<li><a href="#">수입내역</a></li>
				<li><a href="#">예산관리</a></li>
				<li><a href="#">자동통계</a></li>
				<li><a href="#">자료차트</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="row all">
			 	<div class="col-sm-1 col-sm-offset-3"><span class="glyphicon glyphicon-chevron-left"></span></div>
			 	<div class="col-sm-2" id="full_date">${date}</div>
			 	<div class="col-sm-1"><span class="glyphicon glyphicon-chevron-right"></span></div>
				<div class="col-sm-2 col-sm-offset-2"><fmt:formatNumber type="number" pattern="###,###" value="${totalAmount}" />원</div>		
			</div>
		</div>
		<div class="container">
			<div class="row bottom">
				<div class="col-sm-4"><button type="button" class="btn btn-default">카드별</button></div>
				<div class="col-sm-4"><button type="button" class="btn btn-default">분류별</button></div>
				<div class="col-sm-4"><button type="button" class="btn btn-default">세부분류별</button></div>
			</div>
		</div>
	</header>
	<div class="container bs-docs-container" id="date" >
		<div class="row" >
			<div class="col-md-12" role="main">
				<div class="bs-docs-section">
					<c:forEach var="data" items="${totalDate}">
						<div class="row" >
							<div class="row buttom-md" >
								<div class="col-sm-2">
									<button type="button" class="btn btn-primary" disabled="disabled" data-date ="${data.SPD_DATE}">
										${data.SPD_DATE}
									</button>
								</div>
								<div class="col-sm-9">
									<div class="input-group">
										<button type="button" class="btn fix btn-default "><fmt:formatNumber type="number" pattern="###,###" value="${data.SPD_AMOUNT}" />원</button>
									</div>
								</div>
							</div>
							<div class="row bottom hide">
								<div class="col-sm-12">
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal">
		<div class="modal-dialog sm">
			<div class="modal-content">
		    	<div class="modal-header">
		      		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		      		<h4 class="modal-title">지출내역</h4>
		    	</div>
			    <div class="modal-body">
			    	<form role="form" id="modalForm">
				    	<div class="row bottom">
				    		<div class="col-sm-4">지출일</div>
				    		<div class="col-sm-8"><input type="text" name="spdDate" class="form-control" id="datepicker" ></div>
				    	</div>
				    	<div class="row bottom">
				    		<div class="col-sm-4">지출금액</div>
				    		<div class="col-sm-8">
				    			<div class="input-group">
				    				<input type="text" name="spdAmount" class="form-control">
				    				<span class="input-group-addon">원</span>
				    			</div>
				    		</div>
				    	</div>
				    	<div class="row bottom">
				    		<input type="hidden" name="oid" class="form-control">
				    		<div class="col-sm-4">지출내역</div>
				    		<div class="col-sm-8"><input type="text" name="spdHistory" class="form-control"></div>
				    	</div>
				    	<div class="row bottom">
				    		<div class="col-sm-4">메모</div>
				    		<div class="col-sm-8"><input type="text" name="spdMemo" class="form-control"></div>
				    	</div>
				    	<div class="row bottom">
				    		<div class="col-sm-4">분류</div>
				    		<div class="col-sm-8"><input type="text" name="spdCategory"  class="form-control"></div>
				    	</div>
			    	</form>
			    </div>
			    <div class="modal-footer center">
			      	<button type="button" class="btn btn-primary btn-save">저장</button>
			      	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			    </div>
		  	</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<div class="modal fade" id="alertModal">
		<div class="modal-dialog sm">
			<div class="modal-content">
				<div class="modal-header">
		      		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		      		<h4 class="modal-title">결과</h4>
		    	</div>
			    <div class="modal-body">
			    </div>
			    <div class="modal-footer center" >
			      	<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
			    </div>
		  	</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
    <script src="/resources/js/bootstrap.min.js"></script>
  </body>
</html>