<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("li:eq(2)").addClass("active");
	$(".glyphicon-search").hide();
	$(".col-sm-offset-2").hide();
	$("body").attr("style","padding-top:120px;position:relative;");
	$("#full_date").text("${totalInfo.START_DATE} ~ ${totalInfo.END_DATE}").attr("class" , "col-sm-3");
	$(document).on({
		click : function(){
			var hasClass	= $(this).children('span').attr('class');
			if (hasClass.indexOf("pencil") > -1) {
				$("#myModal").modal().myModal(Modal.Budget.menuModal()); 
			}
		}
	} , ".navbar-right");
	
	$(document).on({
		click: function (){
			alert ("Asdfasdf");
		}
	} , ".navbar>.bottom>div");
	
	$(document).on({
		click : function(){
			$(".money").toggleClass("hide");
			$(this).toggleText("금액 표시" , "금액 숨김");			  
		}
	} , ".amountMoney");
	$(document).on({
		click : function(){
			$(".amountT").toggleClass("hide");
			$(this).toggleText("가능액 표시" , "가능액 숨김");			  
		}
	} , ".amount");
	
	$(document).on({
		click : function(){
			$("#myModal").modal().myModal(Modal.Budget.budgetType()); 
		}
	} , ".budgetType");
	
	$(document).on({
		click : function(){
			var dataP;
			var $thisDate 	= $('#full_date').data("today");
			if ($(this).hasClass("week")){
				dataP	= {'budType':'W' , 'budDate':$thisDate};
				$(".budgetType").data('type' , 'W');
			}else if ($(this).hasClass("month")){
				dataP	= {'budType':'M' , 'budDate':$thisDate};
				$(".budgetType").data('type' , 'M');
			}else{
				dataP	= {'budType':'Y' , 'budDate':$thisDate};
				$(".budgetType").data('type' , 'Y');
			}
			$.post("/budgetList",
					dataP,
					function(data){
						$('#full_date').text(data.totalInfo.START_DATE+" ~ " +data.totalInfo.END_DATE).data("today" , data.totalInfo.TO_DAY);
						$(".main").children().remove();
						if (data.budgetList.length > 0){
							$.each(data.budgetList, function ( i ,val){
								$(".main").htmlAppend(val);
							});
						}else{
							$(".main").append('	<div class="jumbotron">'+
									  					'<div class="container">'+
									  						'<p class="text-center">메뉴를 눌러 예산을 추가해 주세요</p>'+
									  					'</div>'+
									  				'</div>'
									);
						}
					},
					'json');
			$("#myModal").modal("hide");
			$(".budgetType").text($(this).text());
		}
	} , ".btn-totalCount");
});
</script>	
</head>
<body>
  	<%@include file="/WEB-INF/views/includes/gnb.jsp" %>
  	<div class="container">
  		<div class="row  main">
  			<c:forEach var="result" items="${budgetList}" >
		  		<table class="table table-hover bottomLine">
					<tbody>
						<tr>
							<td><strong>${result.CATE_NAME}</strong></td>
							<td><fmt:formatNumber type="number" pattern="###,###" value="${result.BUD_AMOUNT}" />원</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="progress bottom10">
								  <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="${result.AVG_PROCESS}" aria-valuemin="0" aria-valuemax="100" style="width: ${result.AVG_PROCESS}%">
								    <span class="sr-only"></span>
								  </div>
								</div>
							</td>
						</tr>
						<tr  class="warning money">
							<td>금일 기준 적정 사용금액</td>
							<td><fmt:formatNumber type="number" pattern="###,###" value="${result.FAIR_VALUE}" />원</td>
						</tr>	
						<tr  class="warning money">
							<td>현재 사용금액 (예정금액 포함)</td>
							<td><fmt:formatNumber type="number" pattern="###,###" value="${result.SUM_AMOUNT}" />원</td>
						</tr>
						<tr  class="warning amountT">
							<td>이번 주 남은 예산(D-${result.D_DAY})</td>
							<td><fmt:formatNumber type="number" pattern="###,###" value="${result.REM_AMOUNT}" />원</td>	
						</tr>
						<tr  class="warning amountT">
							<td>평균 하루 사용 가능 금액</td>
							<td><fmt:formatNumber type="number" pattern="###,###" value="${result.AVG_VALUE}" />원</td>
						</tr>
					</tbody>		  		
		  		</table>			
  			</c:forEach>
		</div>
  	</div>
  	<%@include file="/WEB-INF/views/includes/modal.jsp" %>
</body>
</html>