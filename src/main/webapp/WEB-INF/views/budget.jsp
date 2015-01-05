<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("li:eq(2)").addClass("active");
	$(".glyphicon-search").hide();
	$(".col-sm-offset-2").hide();
	$("body").attr("style","padding-top:120px;position:relative;");
	$("#full_date").text("${totalInfo.START_DATE} ~ ${totalInfo.END_DATE}").attr("class" , "col-sm-3")
	.data("today" , "${totalInfo.TO_DAY}")
					.data("start" ,"${data.totalInfo.START_DATE}")
					.data("end" , "${data.totalInfo.END_DATE}");
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
			$.budgetList(dataP);
			$("#myModal").modal("hide");
			$(".budgetType").text($(this).text());
		}
	} ,  '.btn-totalCount');
	
	$(document).on({
		click : function(){
			var budType	 = $(".budgetType").data('type');
			if ($(this).hasClass('allBud')){
				$.post( "/budgetMerge",
						{ 	'budCategory' : '',
							'budType' :budType,
							'startDate' :$('#full_date').data("start"),
							'endDate': $('#full_date').data("end"),
							'oid'  : '',
							'budAmount' : 0,
							'budDate' : $('#full_date').data("today"),
							'type' : 'add'
						},
						function(data){
							$("#myModal").modal().myModal(Modal.Budget.alertModal(data.resultMsg)); 
							var dataP	= {'budDate' :  $('#full_date').data("today") , 'budType' : $(".budgetType").data('type')};
							$.budgetList(dataP);
						},
						'json'
				);
					
			}else if ($(this).hasClass('cateBud')){
				
			}else if ($(this).hasClass('dtlCateBud')){
				
			}
		}
	} , '.btn-addCategory');
});
</script>	
</head>
<body>
  	<%@include file="/WEB-INF/views/includes/gnb.jsp" %>
  	<div class="container">
  		<div class="row  main">
  			<c:choose>
  				<c:when test="${fn:length(budgetList)>0}">
					<c:forEach var="result" items="${budgetList}" >
				  		<table class="table table-hover bottomLine">
							<tbody>
								<tr>
									<td><strong>${result.CATE_NAME}</strong></td>
									<td>${result.BUD_AMOUNT}</td>
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
									<td>${result.FAIR_VALUE}</td>
								</tr>	
								<tr  class="warning money">
									<td>현재 사용금액 (예정금액 포함)</td>
									<td>${result.SUM_AMOUNT}</td>
								</tr>
								<tr  class="warning amountT">
									<td>이번 주 남은 예산(D-${result.D_DAY})</td>
									<td>${result.REM_AMOUNT}</td>	
								</tr>
								<tr  class="warning amountT">
									<td>평균 하루 사용 가능 금액</td>
									<td>${result.AVG_VALUE}</td>
								</tr>
							</tbody>		  		
				  		</table>			
		  			</c:forEach>  				
  				</c:when>
  				<c:otherwise>
  					<p>
  					<table class="table table-hover bottomLine">
						<tbody>
							<tr class="text-center">
								<td>메뉴를 눌러 예산을 추가해 주세요.</td>
							</tr>
						</tbody>
					</table>	
  				</c:otherwise>
  			</c:choose>
		</div>
  	</div>
  	<%@include file="/WEB-INF/views/includes/modal.jsp" %>
</body>
</html>