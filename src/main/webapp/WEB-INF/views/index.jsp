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
	$(document).ready(function(){
		$(".input-group > .btn").mousedown(function(){
			count=0;
			var el	=	$(this);
			timer = setTimeout(function () {
				$("#myModal").modal();
				 $("input[name*='spdDate']").val(el.parents(".row").children().first().text().trim());
			}, 1000);
		});
		$(".input-group > .btn").mouseup(function() {
			clearTimeout(timer);
		});
		$(".input-group >.btn").click(function(){
				var value = $(this).parents(".row").children().first().text();
				var lastNode= $(this).parents(".row").next().children().first();
				$.getHistInfo(value , lastNode);
				$(this).parents(".row").next().toggleClass("hide");
		});
		$(".modal-footer > .btn-primary").click(function(){
			var dateVal	= $("input[name*='spdDate']").val();
			$.post("/insertHist" , 
					$("#modalForm").serialize(),
					function (data){
						$("#myModal").modal("hide");
						$('#myModal').on('hidden.bs.modal', function () {
							$("form")[0].reset();
						});
						$("#alertModal > div > div>.modal-body").text(data.result);
						$("#alertModal").modal();
						$.getHistInfo(dateVal ,$("button[data-date='"+ dateVal + "']").parents(".row").next().children().first());	
						$("button[data-date='"+ dateVal + "']").parent().next().children().children().text($.number(data.total) + "원");
					},
					'json'
			);
		});
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
		$.getHistInfo = function (value ,lastNode) {
			var html	= "";
			$.post("/data/"+value, 
					"",
					function(data){
						if (data.result != ""){
							$.each(data.result , function (i, val){
								html += "<input type=\"text\"  class=\"form-control\" value=\""+$.number(val.spdAmount)+" 원\" >";
							});
						}else{
							html	="<input type=\"text\"  class=\"form-control\" value=\"작성된 지출내역이 없습니다.\" >";
						}
						lastNode.html(html);
					},
					"json"
			);
		}
	});
	</script>
  </head>
  <body>
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
	<div class="container" id="date">
		<c:forEach var="data" items="${totalDate}">
			<div class="row" >
				<div class="row" >
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
			    <div class="modal-footer">
			      	<button type="button" class="btn btn-primary">저장</button>
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