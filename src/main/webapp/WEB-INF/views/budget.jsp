<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("li:eq(2)").addClass("active");
	$("body").attr("style","padding-top:120px;position:relative;");
	$("#full_date").text("${totalInfo.START_DATE} ~ ${totalInfo.END_DATE}").attr("class" , "col-sm-3");
});
</script>	
</head>
<body>
  	<%@include file="/WEB-INF/views/includes/gnb.jsp" %>
  	<div class="container">
  		<div class="row">
			<table class="table table-hover bottomLine">
				<tbody>
					<tr>
						<td>전체예산</td>
						<td>1,222,222원</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="progress">
							  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
							    <span class="sr-only"></span>
							  </div>
							</div>
						</td>
					</tr>
					<tr>
						<td>금일 기준 적정 사용금액</td>
						<td>1,222,000원</td>
					</tr>
					<tr>
						<td>현재 사용금액 (예정금액 포함)</td>
						<td>1,222,000원</td>
					</tr>
					<tr>
						<td>이번 주 남은 예산(D-0)</td>
						<td>1,222,000.000원</td>	
					</tr>
					<tr>
						<td>평균 하루 사용 가능 금액</td>
						<td>0원</td>
					</tr>
					
					<tr >
						<td  colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td>전체예산</td>
						<td>1,222,222원</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="progress">
							  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
							    <span class="sr-only"></span>
							  </div>
							</div>
						</td>
					</tr>
					<tr>
						<td>금일 기준 적정 사용금액</td>
						<td>1,222,000원</td>
					</tr>
					<tr>
						<td>현재 사용금액 (예정금액 포함)</td>
						<td>1,222,000원</td>
					</tr>
					<tr>
						<td>이번 주 남은 예산(D-0)</td>
						<td>1,222,000.000원</td>	
					</tr>
					<tr>
						<td>평균 하루 사용 가능 금액</td>
						<td>0원</td>
					</tr>
				</tbody>
			</table>
		</div>
  	</div>
  	<%@include file="/WEB-INF/views/includes/modal.jsp" %>
</body>
</html>