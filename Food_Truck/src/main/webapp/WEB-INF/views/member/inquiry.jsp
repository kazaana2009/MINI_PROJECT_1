<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="//code.jquery.com/jquery-1.11.0.min.js" type="text/javascript"></script>
<jsp:include page="../comm/header.jsp"></jsp:include>
<%@include file="../comm/nav.jsp"%>
<script type="text/javascript">

	// 유효성 체크할꺼얌!
	$(function() {
		$("#go").click(function() {
			
			// NOT NULL
			var title = $("#title").val();
			var txtContents = $("#txtContents").val();
			var qaScTel = $("#qaScTel").val();
			var qaSelTel = $("#qaSelTel").val()
			var ordNo = $("#ordNo option:selected").val()
			
			if(title == "") {
				alert("문의하실 제목을 입력해 주시기 바랍니다.");
				$("#title").focus();
				return false;  
			}
			
			if(txtContents == "") {
				alert("문의하실 내용을 입력해 주시기 바랍니다.");
				$("#txtContents").focus();
				return false;
			}
		
			if(qaScTel == "") {
				alert("연락받으실 SMS을 입력해 주시기 바랍니다.");
				$("#qaScTel").focus();
				return false;
			}
			
			
			
			
			alert("나의설정 -> 내문의내역 리스트에서 확인가능합니다");
			return true;
		});
		
		// SMS 자릿수 & 입력칸에 숫자만 올 수 있도록 
		$("#qaScTel").on("keyup", function() {
			
			var phone = $("#qaScTel").val();
			var phoneHyphen = "";
			
			if(phone.length > 13) {
				$("#qaScTel").focus();
				alert("핸드폰 번호 자릿수를 확인해주시기 바랍니다.");
				return false;
			}
			
			if(phone.length == 11) {
				phoneHyphen += phone.substr(0, 3);
				phoneHyphen += "-";
				phoneHyphen += phone.substr(3, 4);
				phoneHyphen += "-";
				phoneHyphen += phone.substr(7);
				$("#qaScTel").val(phoneHyphen);
			}
			
			if(!((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || (event.keyCode == 8) || (event.keyCode == 9))) {
				$("#qaScTel").val("");
				alert("핸드폰 번호는 숫자로 입력하셔야 합니다.");
				return false;
			};
		});
		
		$("#qaSelTel").on("keyup", function() {
			
			var phone = $("#qaSelTel").val();
			var phoneHyphen = "";
			
			if(phone.length > 13) {
				$("#qaSelTel").focus();
				alert("핸드폰 번호 자릿수를 확인해주시기 바랍니다.");
				return false;
			}
			
			if(phone.length == 11) {
				phoneHyphen += phone.substr(0, 3);
				phoneHyphen += "-";
				phoneHyphen += phone.substr(3, 4);
				phoneHyphen += "-";
				phoneHyphen += phone.substr(7);
				$("#qaSelTel").val(phoneHyphen);
			}
			
			if(!((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || (event.keyCode == 8) || (event.keyCode == 9))) {
				$("#qaSelTel").val("");
				alert("핸드폰 번호는 숫자로 입력하셔야 합니다.");
				return false;
			};
		});		
	});
	
<% 
	String gubun2  = (String)session.getAttribute("memberGubun");
%>
	
	if(<%=gubun2%>=="3") {
		function itemChange() {
			
			var info = [ "가입/탈퇴", "정보확인/수정" ];
			var pay = [ "주문/거래확인", "영수증", "카드결제", "무통장입금" ];
			var deliver = [ "배달진행상태", "배달지연/누락" ];
			var cancel = [ "취소 환불정보", "취소 신청/철회" ];
			var event = [ "이벤트문의", "기타" ];
			var de	= [ "선택 " ];
	
			var selectItem = $("#select1").val();
	
			var changeItem;
	
			if (selectItem == "고객정보") {
				changeItem = info;
			} else if (selectItem == "주문/결제") {
				changeItem = pay;
			} else if (selectItem == "배송/예약") {
				changeItem = deliver;
			} else if (selectItem == "취소") {
				changeItem = cancel;
			} else if (selectItem == "이벤트/기타") {
				changeItem = event;
			} else if (selectItem == "선택") {
				changeItem = de;
			}
	
			$('#select2').empty();
	
			for (var count = 0; count < changeItem.length; count++) {
				var option = $("<option>" + changeItem[count] + "</option>");
				$('#select2').append(option);
			}			
		}
	}else if(<%=gubun2%>=="2"){
		
		function itemChange() {
			
			var info = [ "상품수정", "정보수정/이미지 호스팅", "상품품절", "할인" ];
			var pay = [ "제한/탈퇴", "등급/상태", "정보번경" ];
			var deliver = [ "상담불만족/건의", "상담추천/칭찬" ];
			var cancel = [ "예약정보확인", "배송정보확인" ];
			var event = [ "이용료", "정산내역/일정" ];
			var de	= [ "선택 " ];
			
			var selectItem = $("#select1").val();

			var changeItem;

			if (selectItem == "상품") {
				changeItem = info;
			} else if (selectItem == "내푸드트럭") {
				changeItem = pay;
			} else if (selectItem == "고객의 소리") {
				changeItem = deliver;
			} else if (selectItem == "배달") {
				changeItem = cancel;
			} else if (selectItem == "이용료/정산/부과세") {
				changeItem = event;
			} else if (selectItem == "선택") {
				changeItem = de;
			}

			$('#select2').empty();

			for (var count = 0; count < changeItem.length; count++) {
				var option = $("<option>" + changeItem[count] + "</option>");
				$('#select2').append(option);
			}		
		}
	}
	
	function check(num) {
		if(num == 1) {
			$(".ordNoChk1,.ordNoChk2").hide()
		}else{
			$(".ordNoChk1,.ordNoChk2").show()
		}
	}
	
	$(function(){
		$("#backPage").click(function() {
			history.back()
		})
	})
</script>
<body>
<section class="checkout-page pagez fix"><!--Start Checkout Area-->
	<div class="container">
		<div class="row">	
			<div class="col-md-9">
				<div class="panel-group" id="checkout-progress">
					<div class="panel panel-default">
						<div class="panel-heading" >
							<h1 class="active" align="center">문의하기</h3>
						</div>
						<div class="panel-body">
							<form id="frm" action="/inquriy" method="post">
								<input type="hidden" value="${id}" name="memId">
								<%if(gubun2 == "2")  { %>							
								<table>
									<colgroup>
										<col width="16%;">
										<col width="38%;">
										<col width="12%;">
										<col width="*%;">
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">사업자번호</th>
											<td>
												<select name="licenseNo">
													<c:forEach items="${list}" var="all">
														<option>${all.licenseNo}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>										
										<tr>
											<th scope="row" style="width: 50px">문의 종류</th>
											<td>
											<!-- 중분류 시작 --> 
											
												<select id="select1" name="qaScCategory1" onchange="itemChange()" title="문의종류 선택 정보1"style="width: 110px;">
													<option>선택</option>
													<option>상품</option>
													<option>내푸드트럭</option>
													<option>고객의 소리</option>
													<option>배달</option>
													<option>이용료/정산/부과세</option></select> 
												<select id="select2" name="qaScCategory2" title="문의종류 선택 정보2" style="width: 130px;">
													<option value="ALL">선택</option>
												</select>
											</td>														
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th scope="row" style="margin-bottom: 10px; width: 50px" >문의 제목</th>
											<td id="thTitle">
												<input type="text" name="qaScTitle" id="title" class="txt" style="width: 261px;" maxlength="100" title="문의 제목 입력">
											</td>
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th scope="row" style="width: 50px;">문의 내용</th>
											<td>
												<textarea name="qaScContent" id="txtContents" cols="65" rows="14" style="width: 587px; height: 168px;" onfocus="TextAreaFocused(this);" onkeydown="getsize(this);" wrap="VIRTUAL" class="txtbox" title="문의 내용 입력"></textarea>
												<div class="byte">
													<br>
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row">연락 받으실 SMS</th>
											<td>
												<input type="text" class="txt" style="width: 200px;" name="qaScTel" title="핸드폰번호 " id="qaScTel">
											</td>
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th scope="row">답변 받으실 E-mail</th>
											<td>${sessionScope.memberId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<span style="font-size: 8pt">
												 	<font color="gray" face="돋움">회원정보 변경을 하려면 ? </font>
												 </span> 
												 <a href="" target="_blank">
												 	<u>
												 		<font color="blue" face="돋움">
												 			<span style="FONT-SIZE: 8pt">&gt;&gt;나의설정 바로가기</span>
												 		</font>
												 	</u>
												 </a>
												 </p>
											</td>
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>																										
									</tbody>
								</table>											
										<% } else { %>
								<table>
									<colgroup>
										<col width="16%;">
										<col width="38%;">
										<col width="12%;">
										<col width="*%;">
									</colgroup>
									<tbody>							
										<tr>
											<th scope="row">문의자 선택</th>
											<td>
												<input type="radio" name="radioChk" onclick="check(1)">관리자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" name="radioChk" onclick="check(2)" checked>판매자
											</td>	
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>				
										<tr class="ordNoChk1">
											<th scope="row">주문 번호</th>
											<td>
												<select name="ordNo" id="ordNo">
														<option value="">선택</option>
													<c:forEach items="${list}" var="all">
														<option>${all.ordNo}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr class="ordNoChk2">
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>										
										<tr>
											<th scope="row" style="width: 50px">문의 종류</th>
											<td>
											<!-- 중분류 시작 --> 
											
												<select id="select1" name="qaSelCategory1" onchange="itemChange()" title="문의종류 선택 정보1"style="width: 110px;">
													<option>선택</option>
													<option>고객정보</option>
													<option>주문/결제</option>
													<option>배송/예약</option>
													<option>취소</option>
													<option>이벤트/기타</option></select> 
												<select id="select2" name="qaSelCategory2" title="문의종류 선택 정보2" style="width: 130px;">
													<option value="ALL">선택</option>
												</select>
											</td>														
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>										
										<tr>
											<th scope="row" style="margin-bottom: 10px; width: 50px" >문의 제목</th>
											<td id="thTitle">
												<input type="text" name="qaSelTitle" id="title" class="txt" style="width: 261px;" maxlength="100" title="문의 제목 입력">
											</td>
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th scope="row" style="width: 50px;">문의 내용</th>
											<td>
												<textarea name="qaSelContent" id="txtContents" cols="65" rows="14" style="width: 587px; height: 168px;" onfocus="TextAreaFocused(this);" onkeydown="getsize(this);" wrap="VIRTUAL" class="txtbox" title="문의 내용 입력"></textarea>
												<div class="byte">
													<br>
												</div>
											</td>
										</tr>
										<tr>
											<th scope="row">연락 받으실 SMS</th>
											<td>
												<input type="text" class="txt" style="width: 200px;" name="qaSelTel" title="핸드폰번호 " id="qaSelTel">
											</td>
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th scope="row">답변 받으실 E-mail</th>
											<td>${sessionScope.memberId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<span style="font-size: 8pt">
												 	<font color="gray" face="돋움">회원정보 변경을 하려면 ? </font>
												 </span> 
												 <a href="" target="_blank">
												 	<u>
												 		<font color="blue" face="돋움">
												 			<span style="FONT-SIZE: 8pt">&gt;&gt;나의설정 바로가기</span>
												 		</font>
												 	</u>
												 </a>
												 </p>
											</td>
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>																										
									</tbody>
								</table>	
									<% } %>
								<div class="btn_center_box" align="center">
									<input type="submit" class="btn btn-danger btn-large" value="문의하기 등록" id="go" onsubmit="return validation();">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="button" class="btn btn-danger btn-large" value="입력취소" id="backPage">
								</div>								
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<br><br><br><br><br>
</body>
<jsp:include page="../comm/footer.jsp"></jsp:include>
</html>