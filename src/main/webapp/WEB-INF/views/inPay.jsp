<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".navbar").children().last().remove();
			$("body").attr("style","padding-top:85px;position: relative;");
			$("li:eq(1)").addClass("active");
			var InPay	=	Modal.InPay;
			var subTimer		=null	;
			$(document).on({
				click : function(){
					var hasClass	= $(this).children('span').attr('class');
					if (hasClass.indexOf("search") > -1 ) {
						$("#myModal").modal().myModal(InPay.serachModal() , 'IN');
					  	$("select[name='searchSpdCategory']").html($.getCateList('select' , 'IN' ,''));
					    $.dateMulti("input[name=searchStrDate]","input[name=searchEndDate]");
					}else if (hasClass.indexOf("pencil") > -1) {
						var	 footer	= ['취소:btn-default btn-close','즐겨찾기','입력:btn-primary btn-save'];
						$("#myModal").data("id" , "").modal().myModal(InPay.myModal(footer) , 'IN');
						$("select[name='spdCategory']").html($.getCateList('select' , 'IN' ,''));
						$(document).find("input[name=spdDate]").removeClass('hasDatepicker').datepicker(); 
					}else{
						
					}
				}
			} , ".navbar-right");
			
			$(document).on({
				mousedown : function(){
					$this	= $(this);
					$("#myModal").data("id" ,   $(this).data("id") );
					subTimer = setTimeout(function (){
						$("#myModal").modal().myModal(InPay.menuModal($this.children().eq(1).text()) , 'IN');
					}, 1000);
				},
				mouseup:function(){
					clearTimeout(subTimer);
				},
				click  : function (event , param , dataId) {
					var footer	=	['메뉴 열기:btn-primary btn-menu' , '취소:btn-default btn-close'];
					if (param != null )
						footer	= ['취소:btn-default btn-close','즐겨찾기','입력:btn-primary btn-save'];
					$("#myModal").modal().myModal(InPay.myModal(footer) , 'IN');
					$("#myModal").data("id" ,   $(this).data("id") );
					$.getHistInfo($(this).data("id") , true, "pop" );
				}
			} , '.bottomLine > tbody > tr.pointer');
			
			$(document).on({
				click: function(){
					$this	= $(this);
					if ($this.hasClass("btn-update")){
						footer	= ['취소:btn-default btn-close','즐겨찾기','입력:btn-primary btn-save'];
						$("#myModal").myModal(InPay.myModal(footer),  'IN');
						$.getHistInfo( $("#myModal").data("id") , false, "pop" );
					}else if ($this.hasClass("btn-delete")) {
						$.post(	"/deleteHist",
									$("#modalForm").serialize(),
									function(data){
										$("tr[data-id='"+$("#myModal").data("id")+"']").remove();
										$("#myModal").myModal(InPay.alertModal(data.result) , 'IN');
										$.getInHistList();
									},
									'json'
								);
					}else if ($this.hasClass("btn-menu")){
						$("#myModal").myModal(InPay.menuModal($("input[name='spdHistory']").val()) ,  'IN');
					}else if ($this.hasClass("btn-save")){
						$.post(	"/mergeHist" , 
									$("#modalForm").serialize(),
									function (data){
										$("#myModal").myModal(InPay.alertModal(data.result) , 'IN');
										$.getInHistList();
									},
									'json'
								);
					}
				}
			} , '#myModal div >.btn');
		});
	</script>
</head>
<body>
  	<%@include file="/WEB-INF/views/includes/gnb.jsp" %>
	<div class="container">
		<div class="row bottom" >
			<table class="table">
				<tbody>
					<tr>
						<td>이번달 잔여금 (수입-지출)</td>
						<td><fmt:formatNumber type="number" pattern="###,###" value="${restAmount}" />원</td>
					</tr>
				</tbody>
			</table>
		</div>	
	</div>
	<div class="container">
		<div class="row">
			<table class="table table-hover bottomLine">
				<tbody>
					<c:choose>
						<c:when test="${fn:length(totalDate) >0 }">
							<c:forEach var="data" items="${totalDate}">
								<tr class="pointer" data-id= "${data.OID}">
									<td>${data.SPD_DATE}</td>
									<td>${data.SPD_HISTORY}</td>
									<td>${data.SPD_MEMO}</td>
									<td><fmt:formatNumber type="number" pattern="###,###" value="${data.SPD_AMOUNT}" /></td>
								</tr>
							</c:forEach>						
						</c:when>
						<c:otherwise>
							<tr rowspan='4' class='text-center'>
								<td>수입 내역이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<form role="form" id="modalForm">
		<%@include file="/WEB-INF/views/includes/alertModal.jsp" %>
		<%@include file="/WEB-INF/views/includes/modal.jsp" %>
	</form>
</body>
</html>
