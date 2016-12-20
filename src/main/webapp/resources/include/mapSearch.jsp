<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String lat=request.getParameter("lat");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>장소목록 지도에 불러오기</title>
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<style></style>
	</head>
	<body>
		<!-- 지도를 표시할 div 입니다 -->
		<div id="map" style="width:100%;height:350px;"></div>



	
	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=eea8daf781b745669919ab906f673fea&libraries=services"></script>
	<script>
	if(<%=lat%>==null){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
			center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			
	        level: 3 // 지도의 확대 레벨
	    };
	}else{
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
			center: new daum.maps.LatLng(<%=lat%>, 126.570667), // 지도의 중심좌표
			
	        level: 3 // 지도의 확대 레벨
	    };
	}
	

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new daum.maps.Map(mapContainer, mapOption); 

//마커가 표시될 위치입니다 
if(<%=lat%>==null){
	var markerPosition  = new daum.maps.LatLng(33.450701, 126.570667); 	
}
else{
	var markerPosition  = new daum.maps.LatLng(<%=lat%>, 126.570667); 	
	console.log(<%=lat%>);
}

// 마커를 생성합니다
var marker = new daum.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    

var positions = [
       {
            content: '<div>인천축구전용경기장</div>', 
            latlng: new daum.maps.LatLng(37.4660211, 126.64305495)
        },
        {
            content: '<div>인천문학경기장</div>', 
            latlng: new daum.maps.LatLng(37.43514542, 126.6909023)
        }
      
   ];

   // 마커 이미지의 이미지 주소입니다
   var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
       
   for (var i = 0; i < positions.length; i ++) {
       
       // 마커 이미지의 이미지 크기 입니다
       var imageSize = new daum.maps.Size(24, 35); 
       
       // 마커 이미지를 생성합니다    
       var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
       
       // 마커를 생성합니다
       var marker = new daum.maps.Marker({
           map: map, // 마커를 표시할 지도
           position: positions[i].latlng, // 마커를 표시할 위치
           title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
           image : markerImage // 마커 이미지 
       });
   }
	
</script>
</body>
</html>