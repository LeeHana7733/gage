var Modal	=	{
						 InPay		:	{
										 	myModal	:	function (footerTag){
																 return 	{	
																		title : '수입 내역',
																		body : {	
																					'input'	:	{
																									'수입일'	:	{'name' :'spdDate' , 'id':'datepicker' } ,
																									'수입금액'	:	{'name' :'spdAmount' , 'group' : '원'}	,
																									'수입내역'	:	{'name' :'spdHistory'},
																									'메모'		:	{'name' :'spdMemo'},
																									'분류'		:	{'type' : 'select' ,'name' :'spdCategory'}
																								}
																				},
																		footer : footerTag};
															},
											menuModal	:	function (titleName) {
																	return		{	
																					title	:  	titleName,
																					body 	:	{	'btn'	:	{
																													'수정하기'  : {'className':'update'},
																													'삭제하기'  : {'className':'delete'}
																												}
																								}
																				};
																},
					
											alertModal	:	function(bodyText){
																	return {
																					title	:  	'결과',
																					alertBody	: 	bodyText,
																					footer	:	[ '확인:btn-primary btn-close']
																			};		
																},
											serachModal	:	function(){
																	return	{
																				title	: 	"수입내역검색",
																				body	: 	{
																								"input"	: {
																													'검색어' : {'name' : 'searchKey'},
																													'검색 시작일' : {'name' : 'searchStrDate'},
																													'검색 종료일' : {'name' : 'searchEndDate'},
																													'검색 분류'	: {'name':'searchSpdType'}
																												}
																							},
																				footer	:	[ '검색:btn-primary btn-search' , '취소:btn-default btn-close']
																			};
												
																}
																
					 					}
};
var datePickerDefaults	= {
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
};
