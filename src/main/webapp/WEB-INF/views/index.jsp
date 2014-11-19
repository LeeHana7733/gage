<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
	<script type="text/javascript">
	var timer;
	var subTimer;
		$(document).ready(function(){
			$("li:eq(0)").addClass("active");
			$("input[name='paymentType']").val("0");
			$("input[name='cateType']").val("0");
			var alertFooterEl	= $("#alertModal").find(".modal-footer").html();
			$("#datepicker").datepicker();	
			/********************************************************************************************************************
			** @	Click 날짜
			** @	마우스를 길게 누르면 결제입력창 보여줌
					마우스 한번 짧게 누르면 결제 상세정보 보여줌	
			********************************************************************************************************************/
			$(document).on({
				mousedown : function(){
					var el	=	$(this);
					timer = setTimeout(function () {
						$("#myModal").modal();
						$("form")[0].reset();
						$("select[name='spdPayment']").html($.getCateList('select' , 'CA' ,''));
						$("select[name='spdCategory']").html($.getCateList('select' , 'PA' ,''));
						$("input[name='oid']").val("");
						$.inputDisable(false);
						$("#alertModal").find(".modal-title").text("결과");
						$("#myModal").find(".btn-primary").removeClass("btn-menu").removeClass("btn-update").addClass("btn-save").text("저장");
						 $("input[name*='spdDate']").val(el.closest(".row").children().first().text().trim());
					}, 1000);		
				},
				click : function(){
					if (! $(this).hasClass('btn-info')){
						var value = $(this).closest(".row").children().first().text();
						var lastNode= $(this).closest(".row").next().children().first();
						$.getHistInfo(value , lastNode ,"date");
					}
					$(this).closest(".row").next().toggleClass("hide");
					$(this).toggleClass("btn-info");
				},
				mouseup :function(){
					clearTimeout(timer);
				}
			}, ".col-sm-9 > .input-group > .btn");
			
			/********************************************************************************************************************
			** @	상세정보 Click 날짜
			** @	마우스를 길게 누르면 메뉴 보여줌
					마우스 한번 짧게 누르면 결제 상세정보 보여줌	
			********************************************************************************************************************/
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
					$("#myModal").find(".btn-primary").removeClass("btn-save").removeClass("btn-update").addClass("btn-menu").text("메뉴열기");
				}
			} , ".col-sm-12>.btn");
			
			/********************************************************************************************************************
			** @	수정 & 저장
			********************************************************************************************************************/
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
									$("button[data-date='"+ dateVal + "']").parent().next().children().children().text($.number(data.totalInfo.DATETOTAL) + "원");
									$(".row.all").children().last().text($.number(data.totalInfo.MONTHTOTAL) + "원");
								},
								'json'
						);
					}else{
						$("#myModal").modal("hide");
						$.showPaymentPop();
					}
				}
			} ,".modal-footer > .btn-primary");
			
			/********************************************************************************************************************
			** @	메뉴에서 수정하기 클릭시 수정창 보여줌
					메뉴에서 삭제하기 클릭시 삭제
			********************************************************************************************************************/		
			$(document).on({
				click : function(){
					if ($(this).hasClass("btn-update")) {
						$.getHistInfo($("#alertModal").attr("data-id") , false , "pop" );
						$("#alertModal").modal("hide");
						$("#myModal").modal();
						$("#myModal").find(".btn-primary").removeClass("btn-menu").removeClass("btn-save").addClass("btn-update").text("수정");
					} else if ($(this).hasClass("btn-delete")) {
						$.getHistInfo($("#alertModal").attr("data-id") , false , "pop" );
						var oid		= $("input[name=oid]").val();
						var spdDate	= $("input[name=spdDate]").val();
						$.post("/deleteHist",
							$("#modalForm").serialize(),
							function (data){
								$("button[id='"+oid+"']").remove();
								$("#alertModal > div > div>.modal-body").text(data.result);
								$("#alertModal").modal();
								if ($("#alertModal").find(".modal-footer").length == 0 )
									$("#alertModal > div > div").append("<div class=\"modal-footer center\" >"+alertFooterEl+"</div>");
								$("button[data-date='"+ spdDate + "']").parent().next().children().children().text($.number(data.totalInfo.DATETOTAL) + "원");
								$(".row.all").children().last().text($.number(data.totalInfo.MONTHTOTAL) + "원");
								if ($("button[data-date='"+ spdDate + "']").parent().parent().next().children().children().size() == 0 ){
									html	="<input type=\"text\"  class=\"form-control\" value=\"작성된 지출내역이 없습니다.\" >";
									$("button[data-date='"+ spdDate + "']").parent().parent().next().children().html(html);
								}
							},
							'json'
						);
					}else{
						var btnText	= "카드별";
						if ($("#alertModal").attr('data-type') == 'card')
					 		$("input[name='paymentType']").val($(this).attr("data-payment"));
						else if( $("#alertModal").attr('data-type') == 'class'){
							$("input[name='cateType']").val($(this).attr("data-payment"));
							btnText	= "분류별";
						}else{
							$("input[name='cateType']").val($(this).attr("data-payment"));
							btnText	= "세부분류별";
						} 
							
					 	$.getHistList();
						$("#alertModal").modal("hide");
						if ($(this).attr("data-payment") == 0 )  
							$("."+$("#alertModal").attr("data-type") ).text(btnText);
						else
							$("."+$("#alertModal").attr("data-type") ).text($(this).text());
					}
				}
			} , "#alertModal > div > div> .modal-body> .btn.btn-default");
			
			
			$(document).on({
				click : function(){
					if ($(this).hasClass("card")){
						$.showClassPop("카드 상세 분류" , 'CA');
						$("#alertModal").attr("data-type" , 'card');
					}else if ($(this).hasClass("class")){
						$.showClassPop("지출 카테고리 선택" , 'PA');
						$("#alertModal").attr("data-type" , 'class');
					}else{
						$.showClassPop("지출 세부 카테고리 선택" , 'PD' ,$("input[name='cateType']").val() );
						$("#alertModal").attr("data-type" , 'detail');
					}
				}
			}, ".col-sm-4>.btn");
			/********************************************************************************************************************
			** @	현재날짜로 이동
			********************************************************************************************************************/	
			$('body').animate({
			    scrollTop:$("button[data-date='" + $.datepicker.formatDate('yy-mm-dd' , new Date())+"']").offset().top-124
			}, 500);
		});
	</script>
  </head>
  <body>
  	<%@include file="/WEB-INF/views/includes/gnb.jsp" %>
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
	<form role="form" id="modalForm">
		<%@include file="/WEB-INF/views/includes/modal.jsp" %>
		<%@include file="/WEB-INF/views/includes/alertModal.jsp" %>
	</form>
  </body>
</html>