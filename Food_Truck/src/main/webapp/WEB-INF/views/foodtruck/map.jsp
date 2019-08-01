<%@page import="com.foodtruck.vo.FoodTruckVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	FoodTruckVO vo2 = (FoodTruckVO) request.getAttribute("vo");
%>
</head>

<body>
			<div class="review">
				<div id="map" style="width: 550px; height: 370px;"></div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a898d01cf109199d2b5c34d8e1c5835&libraries=services,clusterer,drawing"></script>
					<script type="text/javascript">
						function map() {
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
							mapOption = { center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
													level : 8 // 지도의 확대 레벨
							};
							var map = new daum.maps.Map(mapContainer,mapOption);// 주소-좌표 변환 객체를 생성합니다
							var geocoder = new daum.maps.services.Geocoder();
							// 주소로 좌표를 검색합니다
							geocoder.addressSearch('<%=vo2.getFtruckAddr()%>', function(result, status) {

							// 정상적으로 검색이 완료됐으면 
							if (status === daum.maps.services.Status.OK) {
							
							 var coords = new daum.maps.LatLng(result[0].y, result[0].x);
									        
									        // 결과값으로 받은 위치를 마커로 표시합니다
									        var marker = new daum.maps.Marker({
									            map: map,
									            position: coords
									            
									        });
											var content='<div class="wrap">' + 
								            '    <div class="info">' + 
								            '        <div class="title">' + 
								            '            <%=vo2.getFtruckName()%>' +  
								            '        </div>' + 
								            '        <div class="body">' + 
								            '            <div class="img">' +//이미지 작업후 수정예정
								            '                <img src="<%=vo2.getFtruckImg() %>" width="73" height="70">' +
								            '           </div>' + 
								            '            <div class="desc">' + 
								            '                <div class="ellipsis"><%=vo2.getFtruckAddr()%></div>' +
								            '                <div><a href="http://map.daum.net/link/search/<%=vo2.getFtruckAddr()%>"style="color:blue" target="_blank">길찾기</a></div>' + 
								            '            </div>' + 
								            '        </div>' + 
								            '    </div>' +    
								            '</div>'
									        // 인포윈도우로 장소에 대한 설명을 표시합니다
									      
									        var overlay = new daum.maps.CustomOverlay({
									            content: content,
									            map: map,
									            position: marker.getPosition(),
									            
									        });
									        
									     // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
									        daum.maps.event.addListener(marker, 'click', function() {
									            overlay.setMap(map);
									        });

									        // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
									        function closeOverlay() {
									            overlay.setMap(null);     
									        }

									    
									     // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									        map.setCenter(coords); 
									        
									    } 
									});
								}
							</script>
</body>
</html>