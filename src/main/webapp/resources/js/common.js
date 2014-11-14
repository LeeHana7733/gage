$(document).ready(function(){
	$.ajaxSetup({
		async: false
	});
	var tab	=  $(".nav-tabs").find(".active > a").attr("href") ;
	$.getHistInfo = function (value ,option,type) {
		$.post("/"+type+"/"+value, 
				{
					'paymentType' 	: $("input[name='paymentType']").val() ,
					'cateType'			: $("input[name='cateType']").val(),
					'spdType'			: $("#myModal").data("spdtype")
				},
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
				if ($("#alertModal").data("spdtype") == "IN") {
					$("select[name='spdCategory']").html($.getCateList('select' , 'IN' , ''));
					$("select[name='spdCategory'] > option[value='"+val.spdCategory+"']").attr("selected", "ture");
				}else{
					$("select[name='spdCategory']").html($.getCateList('select' , 'PA' , ''));
					$("select[name='spdCategory'] > option[value='"+val.spdCategory+"']").attr("selected", "ture");
					$("select[name='spdPayment']").html($.getCateList('select' , 'CA' , ''));
					$("select[name='spdPayment'] > option[value='"+val.spdPayment+"']").attr("selected", "ture");
				}
			});
			$.inputDisable(option);
		}
	};
	
	/********************************************************************************************************************
	** @function getHistList
	**	@리스트를 json으로 받아옴
	**	@params 	payment : 조회정보 
	********************************************************************************************************************/
	$.getHistList	=	function () {
			$.post("/list",
					{
						'paymentType'	: $("input[name='paymentType']").val(),
						'cateType'			: $("input[name='cateType']").val(),
						'spdDate': $("#full_date").text(),
						'spdType' : 'OUT'
					},
					function(data){
						var html	= "";
						$.each(data.totalDate , function (i, val){
							html	+= "<div class=\"row\" ><div class=\"row buttom-md\" >";
							html	+=	 "<div class=\"col-sm-2\"><button type=\"button\" class=\"btn btn-primary\" disabled=\"disabled\" data-date =\""+val.SPD_DATE+"\">"+val.SPD_DATE;
							html	+= "</button></div><div class=\"col-sm-9\"><div class=\"input-group\">";
							html	+= "<button type=\"button\" class=\"btn fix btn-default\">"+$.number(val.SPD_AMOUNT)+"원</button>";
							html	+= "</div></div></div><div class=\"row bottom hide\"><div class=\"col-sm-12\"></div></div></div>";
						});
						$(".bs-docs-section").html(html);
						$(".row.all").children().last().text($.number(data.totalInfo.MONTHTOTAL) + "원");
					},
					'json'
			);
	};

	/********************************************************************************************************************
	** @function getOutHistList
	**	@리스트를 json으로 받아옴
	**	@params 	payment : 조회정보 
	********************************************************************************************************************/
	$.getOutHistList	=	function () {
			$.post("/outList",
					{
						'spdDate': $("#full_date").text(),
						'spdType': 'IN'
					},
					function(data){
						var html	= "";
						if (data.result != ""){
							$.each(data.result , function (i, val){
								html	+= "<tr class=\"pointer\" data-id=\""+val.OID+"\">";
								html	+=	 "<td>"+val.SPD_DATE+"</td>";
								html	+= "<td>"+val.SPD_HISTORY+"</td>";
								html	+= "<td>"+val.SPD_MEMO+"</td>";
								html	+= "<td>"+$.number(val.SPD_AMOUNT)+"</td>";
								html	+= "</tR>";
							});
						}else{
							html	+= "<tr rowspan='4' class='text-center'><td>수입 내역이 없습니다.</td></tr>";
						}
							
						$(".bottomLine").find('tbody').html(html);
					},
					'json'
			);
	};
	
	/********************************************************************************************************************
	** @function getCateList
	**	@카테고리를 json으로 받아옴
	**	@params 	type : pop , select
						cateType : category type
						cateOid  : category oid
	********************************************************************************************************************/
	$.getCateList	=	function(type, cateType , cateOid){
		var html= "" ;
		$.post("/cateList" , 
				{'cateType' : cateType , 'cateOid' : cateOid} ,
				function(data){
					$.each(data.result,function(i,val){
						if (type == "pop")
							html	+= "<button type=\"button\" class=\"btn btn-default  btn-block\" data-payment=\""+val.cateOid+"\">"+val.cateName+"</button>";
						else
							html	+= "<option value=\""+val.cateOid+"\">"+val.cateName+"</option>";
					});	
				},
				"json"
		);
		return html;
	};
	
	/********************************************************************************************************************
	** @function inputDisable
	**	@form 전체 input disabled 셋팅
	**	@params 	option : input disable 여부 (menu일 경우 무조건 disabled)
	********************************************************************************************************************/
	$.inputDisable	= function(option){
		var type	= option =="menu" || option ? true : false;
		$("form input , form select").each(function(index) {
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
	$.showPaymentPop = function(oid , spdType){
		oid			= $("input[name='oid']").val()||oid;
		spdType	= spdType || "OUT";
		$("#alertModal").attr("data-id" , oid);
		$("#alertModal").attr("data-spdType" , spdType);
		$("#alertModal").find(".modal-title").text($("input[name='spdHistory']").val());
		var html	= "<button type=\"button\" class=\"btn btn-default  btn-block btn-update\">수정하기</button>";
			html += "<button type=\"button\" class=\"btn btn-default  btn-block btn-delete\">삭제하기</button>";
			html += "<button type=\"button\" class=\"btn btn-default  btn-block btn-smart\">스마트정산</button>";
		$("#alertModal").find(".modal-body").html(html);
		$("#alertModal").find(".modal-footer").remove();
		$("#alertModal").modal();
	};
	
	/********************************************************************************************************************
	** @function  showClassPop
	**	@카드별 , 분류별,상세분류별 팝업 호출
	**	@params 	title : modal title)
	********************************************************************************************************************/
	$.showClassPop = function(title , cateType , cateOid){
		cateOid	= cateOid == 'undefined' ? '' : cateOid;
		$("#alertModal > div > div>.modal-header h4").text(title);
		var html	= "<button type=\"button\" class=\"btn btn-default  btn-block\" data-payment=\"0\">전체</button>";
		html		+= $.getCateList('pop' , cateType , cateOid );
		$("#alertModal > div > div>.modal-body").html(html);
		$("#alertModal > div > div>.modal-footer").remove();
		$("#alertModal").modal();
	};
	/********************************************************************************************************************
	** @날짜를 이동시킨다.
	********************************************************************************************************************/
	$(document).on({
		click : function(){
			var dt 	= new Date($('#full_date').text());
			dt.setDate(1);
			if ($(this).hasClass("glyphicon-chevron-right")){
				dt.setMonth(dt.getMonth()+1);
			}else{
				dt.setMonth(dt.getMonth()-1);
			}
			$('#full_date').text($.datepicker.formatDate('yy-mm-dd' , dt));
			tab  == "/" ? $.getHistList() : $.getOutHistList();
		}
	} , ".glyphicon");

	var OptionData	= function(option){
		this.type		= option.type  	|| "text";
		this.name		= option.name 	|| "";
		this.id			= option.id		|| "";
		this.val		= option.val		|| "";
		this.group	= option.group	|| "";
	};
	
	$.fn.myModal	= function(option ,spdtype){
		$(this).data('spdtype' , spdtype||'OUT');
		var modal	=	new MyModal(option);
		modal.set();
	};
	
	var MyModal	= function(option){
		this.option	=	this.getOptions(option) ;
	};
	
	MyModal.DEFAULTS = 
	{
		title : '지출내역',
		footer : ""
	};
	MyModal.prototype.getDefaults = function () {
	    return MyModal.DEFAULTS;
	 };
	 MyModal.prototype.getOptions	= function(option){
		 var options	= $.extend(false , this.getDefaults(),option);
		 return options;
	 };
	
	MyModal.prototype.set	=	 function(){
		$.each(this.option , function( key, val){
			var html	=	"";
			if (key == 'title'){
				$("#myModal").find(".modal-title").text(val);
			}else if (key == 'body'){
				$elBody	=	 $("#myModal").find(".modal-body");
				$.each(val, function (name, option ){
					var optionData	=	 new OptionData(option);
					html	+=	"<div class=\"row bottom\"><div class=\"col-sm-4\">"+name+"</div>";
					html	+= "<div class=\"col-sm-8\">" ;
					if (optionData.group	!= ""  )
						html	+= "<div class=\"input-group\">";
					if (optionData.type	== 'select'){
						html	+= "<select name=\""+optionData.name+"\" class=\"form-control\"></select>";
					}else{
						html	+= "<input type=\""+ optionData.type+"\" name=\""+optionData.name+"\" class=\"form-control\" value=\""+optionData.val+"\" id=\""+optionData.id+"\">";
					}
					if (optionData.group	!= "")
	    				html	+= "<span class=\"input-group-addon\">"+optionData.group+"</span></div>";
					html	+= "</div></div>";
				});
				$elBody.html(html);
			}else{
				console.log(val);
				if (val != ""){
					var arr	= val.toString().split(",");
					$elFooter	= $("#myModal").find(".modal-footer").show();
					$.each( arr , function (i,text){
						text	=	text.toString().split(":");
						var btnClass	= text[1] || "btn-default";
						html	+= "<button type=\"button\" class=\"btn "+btnClass+" btn-save\">"+text[0]+"</button>";
					});
					$elFooter.html(html);
				}else{
					$("#myModal").find(".modal-footer").hide();
				}
			}
		});
	};
});