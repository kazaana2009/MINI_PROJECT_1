<%@page import="com.foodtruck.vo.FoodTruckVO"%>
<%@page import="com.foodtruck.vo.OrderDetailVO"%>
<%@page import="com.foodtruck.vo.OrderVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<script type="text/javascript">
$( document ).ready(function() {
    var check="<%=request.getAttribute("msg")%>";
    var go=document.getElementById("go")
    var fixbtn=document.getElementById("check1");
    var addbtn=document.getElementById("check2");
    if(check!="none"){
    	go.style.display='block';
    	fixbtn.style.display='block';
    	addbtn.style.display='none';
    }
});
	//이미지작업
	function mm() {
		var formData = new FormData(document.getElementById("uploadForm"));
		$.ajax({
			url : "/imggo", //컨트롤러 URL
			data : formData,
			dataType : 'json',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				$('.img2').html('<input type="hidden" value="' + data.path + '" id="path">');
			},
			error : function(jqXHR) {
				alert(jqXHR.responseText);
			}
		});
	}
	//수정할때 이미지 작업
	function mm2() {
		var formData = new FormData(document.getElementById("uploadForm2"));
		$.ajax({
			url : "/imggo", //컨트롤러 URL
			data : formData,
			dataType : 'json',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				$('.img3').html('<input type="hidden" value="' + data.path + '" id="path2">');
			},
			error : function(jqXHR) {
				alert(jqXHR.responseText);
			}
		});
	}
	//푸드트럭 등록하기
	function add() {
		var num=/^[0-9]{10,10}$/;
		var licenseno = document.getElementById("licenseNo").value;
		var name = document.getElementById("name").value;
		var addr = document.getElementById("addr").value;
		var category = $("#select1").val();
		var img = document.getElementById("path").value;
		var ftruckDlvYn = $("input[name='ftruckDlvYn']:checked").val();
		var ftruckRsvYn = $("input[name='ftruckRsvYn']:checked").val();
		if(licenseno==""||num.test(licenseno)!=true){
			alert("사업자 번호를 확인해주세요(10자리숫자)");
			document.getElementById("licenseNo").focus();
			return false;
		}else if(name==""){
			alert("상호명을 확인해주세요");
			document.getElementById("name").focus();
			return false;
		}else if(addr==""){
			alert("주소를 입력해주세요");
			document.getElementById("sample5_address").focus();
			return false;
		}else if(img=="none"){
			alert("이미지를 선택해주세요");			
			return false;
		}
		$.ajax({
			url : "/insertFoodTruck",
			data : {
				"licenseNo" : licenseno,
				"ftruckName" : name,
				"ftruckAddr2" : addr,
				"category" : category,
				"ftruckImg" : img,
				"ftruckDlvYn" : ftruckDlvYn,
				"ftruckRsvYn" : ftruckRsvYn
			},
			type : 'POST',
			success : function(data) {
				if(data==1){
					alert("등록이 완료되었습니다. 추후 검토후 연락드리겟습니다.");				
					location.reload();
					$(".info").html("푸드트럭 승인 대기중입니다");
				}else{
					alert("푸드트럭 등록을 실패했습니다 관리자에게 문의해주세요 ");
				}

			}
		})

	}
	
function fixTruck(e){
	var memId = e.getAttribute("data-id");
	$.ajax({
		url:"/fixTruck",
		data:{
			"memId":memId
		},
		type : "post",
		dataType : "json",
		success : function(data) {
			var dly,dly2,Rsv,Rsv2,s1,s2,s3,s4;
			if(data.ftruckDlvYn=='Y'){
				dly="checked";
				dly2="";
			}else{
				dly="";
				dly2="checked";
			}
			
			if(data.ftruckRsvYn=='Y'){
				Rsv="checked";
				Rsv2="";
			}else{
				Rsv="";
				Rsv2="checked";
			}
			
			if(data.category==1){
				s1="selected";
				s2="";
				s3="";
				s4="";
			}else if(data.category==2){
				s1="";
				s2="selected";
				s3="";
				s4="";
			}else if(data.category==3){
				s1="";
				s2="";
				s3="selected";
				s4="";
			}else if(data.category==4){
				s1="";
				s2="";
				s3="";
				s4="selected";
			}		
			$('#one').html('<input type="text" id="licenseNo2" style="margin-bottom: 0px;" value="'+data.licenseNo+'">');
			$('#two').html('<input type="text" id="name2" style="margin-bottom: 0px;" value="'+data.ftruckName+'">');
			$('#there').html('<input type="text" id="sample5_address2" placeholder="주소" style="margin-top: 5px;" value="'+data.ftruckAddr+'">');
			$('#for').html('<input type=radio name=ftruckDlvYn2 value="Y"'+dly+'>Y <input type=radio name=ftruckDlvYn2 value="N"'+dly2+'>N');
			$('#five').html('<input type=radio name=ftruckRsvYn2 value="Y" '+Rsv+'>Y<input type=radio name=ftruckRsvYn2 value="N"'+Rsv2+'>N</div>');
			$('#six').html('<select name=category2 id="select1"><option value="1" '+s1+'>한식</option><option value="2"'+s2+' >중식</option><option value="3" '+s3+'>양식</option><option value="4" '+s4+'>일식</option></select>');
			$('.memid2').html('<input type="hidden" value="' + data.memId + '" id="member">');
			$('.prelicenseNo').html('<input type="hidden" value="' + data.licenseNo + '" id="pastlicenseNo">');
			
		}
	})
	
}	
	
	function updateBtn(){
		var num=/^[0-9]{10,10}$/;
		var pastlicenseno = document.getElementById("pastlicenseNo").value;
		var licenseno = document.getElementById("licenseNo2").value;
		var name = document.getElementById("name2").value;
		var addr = document.getElementById("sample5_address2").value;
		var category = $("#select1").val();
		var img = document.getElementById("path2").value;
		var ftruckDlvYn = $("input[name='ftruckDlvYn2']:checked").val();
		var ftruckRsvYn = $("input[name='ftruckRsvYn2']:checked").val();
		var memid=document.getElementById("member").value;
		if(licenseno==""||num.test(licenseno)!=true){
			alert("사업자 번호를 확인해주세요(10자리숫자)");
			document.getElementById("licenseNo").focus();
			return false;
		}else if(name==""){
			alert("상호명을 확인해주세요");
			document.getElementById("name").focus();
			return false;
		}else if(addr==""){
			alert("주소를 입력해주세요");
			document.getElementById("sample5_address").focus();
			return false;
		}else if(img=="none"){
			alert("이미지를 선택해주세요");			
			return false;
		}
		$.ajax({
			url:"/updateFoodTruck2",
			data : {
				"pastlicenseno":pastlicenseno,
				"memId":memid,
				"licenseNo" : licenseno,
				"ftruckName" : name,
				"ftruckAddr2" : addr,
				"category" : category,
				"ftruckImg" : img,
				"ftruckDlvYn" : ftruckDlvYn,
				"ftruckRsvYn" : ftruckRsvYn
			},
			type : 'POST',
			success : function(data) {
				if(data==1){
					alert("수정요청이 완료되었습니다. 추후 검토후 연락드리겟습니다.");				
					location.reload();
					$(".info").html("푸드트럭 승인 대기중입니다");
				}else{
					alert("푸드트럭 등록을 실패했습니다 관리자에게 문의해주세요 ");
				}

			}
		})
		
		
		
		
		
		
	}
</script>
<style>
th {
	margin: 0px;
	width: 100px;
	background-color: #fafafa;
}

td {
	width: 100% auto;
}

textarea {
	width: 400px;
	resize: none;
}
</style>
<body>
	<%@include file="../comm/header2.jsp"%>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3" id="sidebar">
				<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">

				</ul>
			</div>

			<!--/span-->
			<div class="span9" id="content">

				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">푸드트럭이 없습니다</div>
							<div class="muted pull-right">
								<button class="btn" style="margin-top: -5px;"
									data-toggle="modal" data-target="#tutorialsplaneModal" id="check2">푸드트럭
									등록하기</button>
								<button class="btn" style="margin-top: -5px; display: none;"
									data-toggle="modal" data-target="#tutorialsplaneModal2" id="check1" data-id="<%=request.getAttribute("Id") %>" onclick="fixTruck(this)">수정하기</button>	
							</div>
						</div>
						<h4 align="center" class="info">푸드트럭이 없습니다. 푸드트럭을 등록해 주세요.</h4>
					</div>
					<div class="block" style="display: none;" id="go">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">알림</div>						
						</div>
						<h4 align="center" class="info">신청이 거부되었습니다  <br> 내용: &nbsp;  &nbsp;  "<%=request.getAttribute("msg")%>"</h4>
					</div>
					
				</div>
			</div>
		</div>
		<!-- insert부분 모달창 -->
		<div id="tutorialsplaneModal" class="modal fade" role='dialog' style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">푸드트럭 등록하기</h4>
					</div>
					<div class="modal-body" style="margin-left: 10px;">
						<form id="uploadForm" action="/insertFoodTruck" method="post"
							class="insertFoodTruck">
							<table class="table">
								<tr>
									<th>사업자번호</th>
									<td><input type="text" id="licenseNo"
										style="margin-bottom: 0px;"></td>
								</tr>
								<tr>
									<th>상호명</th>
									<td><input type="text" id="name"></td>
								</tr>
								<tr>
									<th>주소</th>
									<td><input type="text" id="addr"
										placeholder="주소" style="margin-top: 5px;"> <input
										type="button" class="btn" onclick="sample5_execDaumPostcode()"
										value="주소 검색"><br>
										<div id="map"
											style="width: 300px; height: 300px; margin-top: 10px; display: none"></div>
										<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
										<script
											src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a898d01cf109199d2b5c34d8e1c5835&libraries=services"></script>
										<script>
											var mapContainer = document.getElementById('map'), // 지도를 표시할 div
												mapOption = {
													center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
													level : 3 // 지도의 확대 레벨
												};
										
											//지도를 미리 생성
											var map = new daum.maps.Map(mapContainer, mapOption);
											//주소-좌표 변환 객체를 생성
											var geocoder = new daum.maps.services.Geocoder();
											//마커를 미리 생성
											var marker = new daum.maps.Marker({
												position : new daum.maps.LatLng(37.537187, 127.005476),
												map : map
											});
										
										
											function sample5_execDaumPostcode() {
												new daum.Postcode({
													oncomplete : function(data) {
														// 각 주소의 노출 규칙에 따라 주소를 조합한다.
														// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
														var fullAddr = data.address; // 최종 주소 변수
														var extraAddr = ''; // 조합형 주소 변수
										
														// 기본 주소가 도로명 타입일때 조합한다.
														if (data.addressType === 'R') {
															//법정동명이 있을 경우 추가한다.
															if (data.bname !== '') {
																extraAddr += data.bname;
															}
															// 건물명이 있을 경우 추가한다.
															if (data.buildingName !== '') {
																extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
															}
															// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
															fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
														}
										
														// 주소 정보를 해당 필드에 넣는다.
														document.getElementById("addr").value = fullAddr;
														// 주소로 상세 정보를 검색
														geocoder.addressSearch(data.address, function(results, status) {
															// 정상적으로 검색이 완료됐으면
															if (status === daum.maps.services.Status.OK) {
										
																var result = results[0]; //첫번째 결과의 값을 활용
										
																// 해당 주소에 대한 좌표를 받아서
																var coords = new daum.maps.LatLng(result.y, result.x);
																// 지도를 보여준다.
																mapContainer.style.display = "block";
																map.relayout();
																// 지도 중심을 변경한다.
																map.setCenter(coords);
																// 마커를 결과값으로 받은 위치로 옮긴다.
																marker.setPosition(coords)
															}
														});
													}
												}).open();
											}
										</script></td>
								</tr>
								<tr>
									<th>배달여부</th>
									<td><input type=radio name=ftruckDlvYn value="Y" checked>Y
										<input type=radio name=ftruckDlvYn value="N">N</td>
								</tr>
								<tr>
									<th>예약여부</th>
									<td><input type=radio name=ftruckRsvYn value="Y" checked>Y
										<input type=radio name=ftruckRsvYn value="N">N</td>
								</tr>
								<tr>
									<th>카테고리</th>
									<td><select name=category id="select1">
											<option value="1">한식</option>
											<option value="2">중식</option>
											<option value="3">양식</option>
											<option value="4">일식</option>
									</select></td>
								</tr>
								<tr>
									<th>대표이미지</th>
									<td><input type=file name=ftruckImg id="fileImg"
										enctype="multipart/form-data" onchange="mm()">
								</tr>

							</table>
							<div class="img2"><input type="hidden" value="none" id="path"></div>
						</form>

					</div>

					<div class="modal-footer">
						<button class="btn btn-default" onclick="add()">등록하기</button>					
						<button type="button" class="btn btn-default" data-dismiss="modal"
							onclick="cl()">닫기</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 수정부분 모달창 -->
		<div id="tutorialsplaneModal2" class="modal fade" role='dialog' style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">푸드트럭 수정하기</h4>
					</div>
					<div class="modal-body" style="margin-left: 10px;">
						<form id="uploadForm2"  method="post"
							class="insertFoodTruck">
							<table class="table">
								<tr>
									<th>사업자번호</th>
									<td><div id="one"><input type="text" id="licenseNo2"
										style="margin-bottom: 0px;" value=""></div></td>
								</tr>
								<tr>
									<th>상호명</th>
									<td><div id="two"><input type="text" id="name2"></div></td>
								</tr>
								<tr>
									<th>주소</th>
									<td><div id="there"><input type="text" id="sample5_address2"
										placeholder="주소" style="margin-top: 5px;"></div><input
										type="button" class="btn" onclick="sample5_execDaumPostcode()"
										value="주소 검색"><br>
										<div id="map"
											style="width: 300px; height: 300px; margin-top: 10px; display: none"></div>
										<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
										<script
											src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a898d01cf109199d2b5c34d8e1c5835&libraries=services"></script>
										<script>
											var mapContainer = document.getElementById('map'), // 지도를 표시할 div
												mapOption = {
													center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
													level : 3 // 지도의 확대 레벨
												};
										
											//지도를 미리 생성
											var map = new daum.maps.Map(mapContainer, mapOption);
											//주소-좌표 변환 객체를 생성
											var geocoder = new daum.maps.services.Geocoder();
											//마커를 미리 생성
											var marker = new daum.maps.Marker({
												position : new daum.maps.LatLng(37.537187, 127.005476),
												map : map
											});
										
										
											function sample5_execDaumPostcode() {
												new daum.Postcode({
													oncomplete : function(data) {
														// 각 주소의 노출 규칙에 따라 주소를 조합한다.
														// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
														var fullAddr = data.address; // 최종 주소 변수
														var extraAddr = ''; // 조합형 주소 변수
										
														// 기본 주소가 도로명 타입일때 조합한다.
														if (data.addressType === 'R') {
															//법정동명이 있을 경우 추가한다.
															if (data.bname !== '') {
																extraAddr += data.bname;
															}
															// 건물명이 있을 경우 추가한다.
															if (data.buildingName !== '') {
																extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
															}
															// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
															fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
														}
										
														// 주소 정보를 해당 필드에 넣는다.
														document.getElementById("sample5_address2").value = fullAddr;
														// 주소로 상세 정보를 검색
														geocoder.addressSearch(data.address, function(results, status) {
															// 정상적으로 검색이 완료됐으면
															if (status === daum.maps.services.Status.OK) {
										
																var result = results[0]; //첫번째 결과의 값을 활용
										
																// 해당 주소에 대한 좌표를 받아서
																var coords = new daum.maps.LatLng(result.y, result.x);
																// 지도를 보여준다.
																mapContainer.style.display = "block";
																map.relayout();
																// 지도 중심을 변경한다.
																map.setCenter(coords);
																// 마커를 결과값으로 받은 위치로 옮긴다.
																marker.setPosition(coords)
															}
														});
													}
												}).open();
											}
										</script></td>
								</tr>
								<tr>
									<th>배달여부</th>
									<td><div id="for"><input type=radio name=ftruckDlvYn2 value="Y" checked>Y
										<input type=radio name=ftruckDlvYn2 value="N">N</div></td>
								</tr>
								<tr>
									<th>예약여부</th>
									<td><div id="five"><input type=radio name=ftruckRsvYn2 value="Y" checked>Y
										<input type=radio name=ftruckRsvYn2 value="N">N</div></td>
								</tr>
								<tr>
									<th>카테고리</th>
									<td><div id="six"><select name=category id="select1">
											<option value="1">한식</option>
											<option value="2">중식</option>
											<option value="3">양식</option>
											<option value="4">일식</option>
									</select></div></td>
								</tr>
								<tr>
									<th>대표이미지</th>
									<td><input type=file name=ftruckImg id="fileImg"
										enctype="multipart/form-data" onchange="mm2()">
								</tr>

							</table>
							<div class="img3"><input type="hidden" value="none" id="path2"></div>
							<div class="memid2"></div>
							<div class="prelicenseNo"></div>
						</form>

					</div>

					<div class="modal-footer">
						<button class="btn btn-default" onclick="updateBtn()">수정하기</button>					
						<button type="button" class="btn btn-default" data-dismiss="modal"
							onclick="cl()">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>