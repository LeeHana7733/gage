<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
  <head>
    <title>money book</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 부트스트랩 -->
    <link href="/resources/css/bootstrap.css" rel="stylesheet" media="screen">
	<script src="//code.jquery.com/jquery.js"></script>
	<script src="/resources/js/jquery-ui.custom.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$(".input-group > .btn").mousedown(function(){
			count=0;
			timer = setTimeout(function () {
				$("#myModal").modal();
			}, 1000);
		});
		$(".input-group > .btn").mouseup(function() {
			clearTimeout(timer);
		});
		$(".col-sm-11 > div >.btn").click(function(){
			alert ($(this).next().text());
		});
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
		 	<div class="col-sm-2" id="full_date"></div>
		 	<div class="col-sm-1"><span class="glyphicon glyphicon-chevron-right"></span></div>
			<div class="col-sm-1 col-sm-offset-2">0$ / 일 </div>		
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
		<div class="row">
			<div class="col-sm-1">
				<button type="button" class="btn btn-primary" disabled="disabled">sample</button>
			</div>
			<div class="col-sm-11">
				<div class="input-group">
					<button type="button" class="btn btn-default  btn-block">20,400원</button>
				</div>
			</div>
			<div class="col-sm-11  col-sm-offset-1 hide">
					<input type="text" class="form-control">
					<input type="text" class="form-control">
					<input type="text" class="form-control">
					<input type="text" class="form-control">
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
		      	<div class="row bottom">
		      		<div class="col-sm-4">지출일</div>
		      		<div class="col-sm-8"><input type="text" class="form-control"></div>
		      	</div>
		      	<div class="row bottom">
		      		<div class="col-sm-4">지출금액</div>
		      		<div class="col-sm-8"><input type="text" class="form-control"></div>
		      	</div>
		      	<div class="row bottom">
		      		<div class="col-sm-4">지출내역</div>
		      		<div class="col-sm-8"><input type="text" class="form-control"></div>
		      	</div>
		      	<div class="row bottom">
		      		<div class="col-sm-4">메모</div>
		      		<div class="col-sm-8"><input type="text" class="form-control"></div>
		      	</div>
		      	<div class="row bottom">
		      		<div class="col-sm-4">분류</div>
		      		<div class="col-sm-8"><input type="text" class="form-control"></div>
		      	</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary">저장</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
    <script src="/resources/js/bootstrap.min.js"></script>
  </body>
</html>