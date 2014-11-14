<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".navbar").children().last().remove();
			$("body").attr("style","padding-top:85px;");
			$("li:eq(1)").addClass("active");

			$(document).on({
				mousedown : function(){
					subTimer = setTimeout(function () {
						$("#myModal").modal().myModal({
							title	:  	$(this).data('id'),
							body 	:	{
											'btn'	: [
											     	   	{'class' : 'update' , 'name' : '수정하기'},
											     	   	{'class' : 'delte' , 'name' : '삭제하기'}
											     	  ]
										}
						});
						$.showPaymentPop($(this).data("id") , 'IN');
					}, 1000);		
				},
				mouseup:function(){
					clearTimeout(subTimer);
				},
				click : function () {
					$("#myModal").modal().myModal({
						title : '수입 내역',
						body : {	'수입일'	:	{'name' :'spdDate' , 'id':'datepicker'} ,
									'수입금액'	:	{'name' :'spdAmount' , 'group' : '원'}	,
									'수입내역'	:	{'name' :'spdHistory'},
									'메모'		:	{'name' :'spdMemo'},
									'분류'		:	{'type' : 'select' ,'name' :'spdCategory'}
								},
						footer : ['취소,즐겨찾기,입력:btn-primary']
					} , 'IN');
					$.getHistInfo($(this).data("id") ,true , "pop" );
				}
			} , '.bottomLine > tbody > tr.pointer');
			
			
			$(document).on({
				click: function(){
					$this	= $(this);
					if ($this.hasClass("btn-update")){
						
					}else if ($this.hasClass("btn-delete")) {
						
					}else{
						
					}
				}
			} , '#alertModal > div > div> .modal-body> .btn.btn-default');
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
					<c:forEach var="data" items="${totalDate}">
						<tr class="pointer" data-id= "${data.OID}">
							<td>${data.SPD_DATE}</td>
							<td>${data.SPD_HISTORY}</td>
							<td>${data.SPD_MEMO}</td>
							<td><fmt:formatNumber type="number" pattern="###,###" value="${data.SPD_AMOUNT}" /></td>
						</tr>
					</c:forEach>
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
