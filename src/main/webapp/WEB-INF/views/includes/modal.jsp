<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
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
			    		<div class="col-sm-8"><input type="text" name="spdDate" class="form-control" id="datepicker" ></div>
			    	</div>
			    	<div class="row bottom">
			    		<div class="col-sm-4">지출금액</div>
			    		<div class="col-sm-8">
			    			<div class="input-group">
			    				<input type="text" name="spdAmount" class="form-control">
			    				<span class="input-group-addon">원</span>
			    			</div>
			    		</div>
			    	</div>
			    	<div class="row bottom">
			    		<input type="hidden" name="oid" class="form-control">
			    		<input type="hidden" name="paymentType" class="form-control">
			    		<input type="hidden" name="cateType" class="form-control">
			    		<div class="col-sm-4">지출내역</div>
			    		<div class="col-sm-8"><input type="text" name="spdHistory" class="form-control"></div>
			    	</div>
			    	<div class="row bottom">
			    		<div class="col-sm-4">메모</div>
			    		<div class="col-sm-8"><input type="text" name="spdMemo" class="form-control"></div>
			    	</div>
			    	<div class="row bottom">
			    		<div class="col-sm-4">분류</div>
			    		<div class="col-sm-8"><select name="spdCategory"  class="form-control"></select></div>
			    	</div>
			    	<div class="row bottom">
			    		<div class="col-sm-4">결제</div>
			    		<div class="col-sm-8"><select class="form-control"  name="spdPayment" ></select></div>
			    	</div>
		    </div>
		    <div class="modal-footer center">
		      	<button type="button" class="btn btn-primary btn-save">저장</button>
		      	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		    </div>
	  	</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->