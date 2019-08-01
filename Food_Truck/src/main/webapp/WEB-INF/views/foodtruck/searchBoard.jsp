<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.foodtruck.vo.FoodTruckVO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>

<jsp:include page="../comm/header.jsp"></jsp:include>

<body onload="map()">
	<%@include file="../comm/nav.jsp"%>
	<!-- Shop Product Area Start -->
	<div class="shop-product-area section fix">
		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div class="row">
						<!-- Shop Tool Bar -->
						<div class="shop-tool-bar col-sm-12 fix">
							<!-- 지도 -->
							<div id="map" style="width: 1200px; height: 400px;"></div>
							<script type="text/javascript"
								src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a898d01cf109199d2b5c34d8e1c5835&libraries=services,clusterer,drawing"></script>
							<script type="text/javascript">
function map() {
	var mapContainer = document
			.getElementById('map'), // 지도를 표시할 div  
	mapOption = {
		center : new daum.maps.LatLng(
				33.450701, 126.570667), // 지도의 중심좌표
		level : 7
	// 지도의 확대 레벨
	};
	
	var map = new daum.maps.Map(mapContainer,
			mapOption);
	
	<%List<FoodTruckVO> list = (List<FoodTruckVO>) request.getAttribute("list");%>
	   
	   <%for (int i = 0; i < list.size(); i++) {%>
	      
	   var geocoder = new daum.maps.services.Geocoder();
	   // 주소로 좌표를 검색합니다
	   
	   geocoder.addressSearch('<%=list.get(i).getFtruckAddr()%>', function(result, status) {
			
	       // 정상적으로 검색이 완료됐으면 
	        if (status === daum.maps.services.Status.OK) {
	        	var truck="<%=list.get(i).getFtruckName()%>";
	           var coords = new daum.maps.LatLng(result[0].y, result[0].x);

	           // 결과값으로 받은 위치를 마커로 표시합니다
	           var marker = new daum.maps.Marker({
	               map: map,
	               position: coords
	           });
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	           var iwRemoveable = true;
	           var infowindow = new daum.maps.InfoWindow({                                
	              content: '<div style="width:150px;text-align:center;padding:6px 0;"><a href="read?ftruckNo=<%=list.get(i).getFtruckNo()%>">'+truck+'</a></div>',
	              removable : iwRemoveable	  
	           });
	           infowindow.open(map, marker);
	           daum.maps.event.addListener(marker, 'click', function() {
	        	      // 마커 위에 인포윈도우를 표시합니다
	        	      infowindow.open(map, marker);  
	        	});
	       
	       } 
	   });    
	   <%}%>

	
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        
	        var locPosition = new daum.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
	        
	        // 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
	            
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    
	    var locPosition = new daum.maps.LatLng(33.450701, 126.570667),    
	        message = 'geolocation을 사용할수 없어요..'
	        
	    displayMarker(locPosition, message);
	}

	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(locPosition, message) {

	    // 마커를 생성합니다
	    var marker = new daum.maps.Marker({  
	        map: map, 
	        position: locPosition
	    }); 
	    
	    var iwContent = message, // 인포윈도우에 표시할 내용
	        iwRemoveable = true;

	    // 인포윈도우를 생성합니다
	    var infowindow = new daum.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // 인포윈도우를 마커위에 표시합니다 
	    infowindow.open(map, marker);
	    
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setCenter(locPosition); 
	}
}
</script>
							<a href=""></a>
						</div>
						<div class="shop-products">
							<!-- Single Product -->
							<c:forEach items="${list}" var="all">
							<fieldset>
								<div class="single-list-product col-sm-12">
									<div class="list-pro-image">
										<a href="/read?licenseNo=${all.licenseNo}"> <img
											src="${all.ftruckImg}">
										</a>
									</div>
									<div class="list-pro-des fix">
										<a class="pro-name" href="/read?ftruckNo=${all.ftruckNo}">${all.ftruckName}</a>
										<div class="pro-ratting">
											<span style="width: ${all.ftruckGrade*20}%"></span>
										</div>
										<div>&nbsp;&nbsp;${all.ftruckGrade}점&nbsp;&nbsp;/&nbsp;리뷰수 : ${all.count} 개</div>
										<p>${all.ftruckIntro}</p>

									</div>
								</div>
								</fieldset><br>
							</c:forEach>
							<!-- Pagination -->
							<div class="pagination">
								<ul>
									<%
										int pageNo;//페이지번호
										int tot = (int) request.getAttribute("pagecount");//전체 게시물수
										try {
											pageNo = (int) request.getAttribute("pageNo");//페이지번호
										} catch (Exception e) {
											pageNo = 1;
										}
										int currentPage = pageNo;//페이지번호
										int countList = 10;
										int countPage = 10;
										int totalPage = tot / countList;//페이지당 게시물수()--  만약 게시물이 10개이면 페이지 수는 1개가된다.
										if (tot % countList > 0) {
											totalPage++;
										}
										///////////////////////////////////적용완료

										if (totalPage < currentPage) {
											currentPage = totalPage;
										} //게시물이 없을경우  0개의 게시물일떄 페이지는 1로 해준다.

										////////////////////////////
										int startPage = ((currentPage - 1) / 10) * 10 + 1;
										int endPage = startPage + countPage - 1;
										if (endPage > totalPage) {
											endPage = totalPage;
										}
										if (startPage > 1) {
									%>
									<li><a
										href="search?pageNo=1&search=<%=request.getAttribute("search")%>">처음</a></li>
									<%
										}
										if (currentPage > 1) {
									%>
									<li><a
										href="search?pageNo=<%=currentPage - 1%>&search=<%=request.getAttribute("search")%>"><i
											class="fa fa-angle-left"></i></a></li>
									<%
										}
										for (int iCount = startPage; iCount <= endPage; iCount++) {
											if (iCount == currentPage) {
									%>
									<li class="active"><span><%=iCount%></span></li>
									<%
										} else {
									%>
									<li><a
										href="search?pageNo=<%=iCount%>&search=<%=request.getAttribute("search")%>"><%=iCount%></a>
									<li>
										<%
											}
											}
											if (currentPage < totalPage) {
										%>
									
									<li><a
										href="search?pageNo=<%=currentPage + 1%>&search=<%=request.getAttribute("search")%>"><i
											class="fa fa-angle-right"></i></a></li>
									<%
										}
										if (endPage < totalPage) {
									%>
									<li><a
										href="search?pageNo=<%=totalPage%>&search=<%=request.getAttribute("search")%>">끝</a></li>
									<%
										}
									%>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<!-- Shop Product Area End -->
	<jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>