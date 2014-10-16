<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Calendar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 부트스트랩 -->
    <link href="/resources/css/full-calendar.css" rel="stylesheet" media="screen">
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet" media="screen">
      <script src="//code.jquery.com/jquery.js"></script>
      <script src="/resources/js/fullcalendar.js"></script>
      <script src="/resources/js/moment.min.js"></script>
      <script src="/resources/js/jquery-ui.custom.min.js"></script>
    <script type="text/javascript">
    $.getScript('http://arshaw.com/js/fullcalendar-1.6.4/fullcalendar/fullcalendar.min.js',function(){
    	  var date = new Date();
    	  var d = date.getDate();
    	  var m = date.getMonth();
    	  var y = date.getFullYear();
    	  
    	  $('#calendar').fullCalendar({
    		  eventLimit: true, // allow "more" link when too many events
    	    header: {
    	    	left: 'prev,next prevYear,nextYear today', 
   	            center: 'title', 
   	            right: 'month,agendaWeek,agendaDay' 
    	    },
    	    events: [
    	             // my event data
    	         ],
    	         eventTextColor: '#378006',
    	         dragScroll : true,	
    	    dayNamesShort: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
    	    buttonText: {
	    	    today: '오늘',
	    		month: '월',
	    		week: '주',
	    		day: '일'
    		},
    		titleFormat: {
    			month: 'yyyy MMM',
    			week: "MMM d[ yyyy]{ '&#8212;'[ MMM] d yyyy}",
    			day: 'dddd, MMM d, yyyy'
    		},
    		eventClick: function(calEvent, jsEvent, view) {

    	        alert('Event: ' + calEvent.title);
    	        alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
    	        alert('View: ' + view.name);

    	        // change the border color just for fun
    	        $(this).css('border-color', 'red');

    	    },
    		 eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc) {

    		        alert(
    		            event.title + " was moved " +
    		            dayDelta + " days and " +
    		            minuteDelta + " minutes." +
    		            event.id
    		        );

    		        if (allDay) {
    		            alert("Event is now all-day");
    		        }else{
    		            alert("Event has a time-of-day");
    		        }

    		        if (!confirm("Are you sure about this change?")) {
    		            revertFunc();
    		        }

    		    },
    	    editable: true,
    	    dayClick: function(date, allDay, jsEvent, view) 
            { 
                alert( 
                        " date: " + date 
                        + "\n allDay: " + allDay 
                        + "\n jsEvent: " + jsEvent 
                        + "\n view: " + view 
                ); 
                $('#myModal').modal();
            }, 
    	    events: [
    	      {
    	        title: 'All Day Event',
    	        start: new Date(y, m, 1)
    	      },
    	      {
    	        title: 'Long Event',
    	        start: new Date(y, m, d-5),
    	        end: new Date(y, m, d-2)
    	      },
    	      {
    	        id: 999,
    	        title: 'Repeating Event',
    	        start: new Date(y, m, d-3, 16, 0),
    	        allDay: false
    	      },
    	      {
    	        id: 999,
    	        title: 'Repeating Event',
    	        start: new Date(y, m, d+4, 16, 0),
    	        allDay: false
    	      },
    	      {
    	        title: 'Meeting',
    	        start: new Date(y, m, d, 10, 30),
    	        allDay: false
    	      },
    	      {
    	        title: 'Lunch',
    	        start: new Date(y, m, d, 12, 0),
    	        end: new Date(y, m, d, 14, 0),
    	        allDay: false
    	      },
    	      {
    	        title: 'Birthday Party',
    	        start: new Date(y, m, d+1, 19, 0),
    	        end: new Date(y, m, d+1, 22, 30),
    	        allDay: false
    	      },
    	      {
    	        title: 'Click for Google',
    	        start: new Date(y, m, 28),
    	        end: new Date(y, m, 29),
    	        url: 'http://google.com/'
    	      }
    	    ]
    	  });
    	})
    </script>
  </head>
  <body>
	<div class="container" id="calendar">
	</div>
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
		 	<div class="modal-content">
		    	<div class="modal-header">
		      		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		      		<h4 class="modal-title">지출내역</h4>
		    	</div>
		    	<div class="modal-body">
		    	지출일
		    	지출금액
		    	지출내역
		    	메모
		    	분류
		    	결제
		    	</div>
		    	<div class="modal-footer">
		      		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		      		<button type="button" class="btn btn-primary">저장</button>
		    	</div>
		  	</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요한) -->
    <!-- 모든 합쳐진 플러그인을 포함하거나 (아래) 필요한 각각의 파일들을 포함하세요 -->
    <script src="/resources/js/bootstrap.min.js"></script>
 
    <!-- Respond.js 으로 IE8 에서 반응형 기능을 활성화하세요 (https://github.com/scottjehl/Respond) -->
  </body>
</html>