<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<script src="//code.jquery.com/jquery.js"></script>
<script src="/resources/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript">
  	$(document).ready(function(){
  		$('body').animate({
		    scrollTop:$("button[data-date='${date}']").offset().top-124
		}, 500);
  	});
  </script>
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
