<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <title>money book</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <!-- 부트스트랩 -->
	   <link href="/resources/css/bootstrap.css" rel="stylesheet" media="screen">
		<script src="//code.jquery.com/jquery.js"></script>
		<script src="/resources/js/jquery-ui.custom.min.js"></script>
	</head>
	<body>
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
