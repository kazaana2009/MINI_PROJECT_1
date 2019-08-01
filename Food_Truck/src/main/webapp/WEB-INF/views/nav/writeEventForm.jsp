<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>    
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.0.min.js" type="text/javascript"></script>
<script>

   	$(function() {
   		
   		// 유효성 검사
   		$("#frm").on("submit", function() {
   			var eventTitle = $("#eventTitle").val();
   			var eventContent = $("#eventContent").val();
   			
   			if(eventTitle == "") {
   				alert("제목을 입력해 주세요.")
   				$("#eventTitle").focus();
   				return false;
   			};
   			
   			if(eventContent == "") {
   				alert("내용을 입력해 주세요.")
   				$("#eventContent").focus();
   				return false;
   			};
   			
   			return true;
   		
   		});
  
   		// reset 버튼 눌렀을 때, 
   		$("#cancel").on("click", function() {
   			confirm("정말로 취소 하시겠습니까?");
   		});
   		
   	});
   	
</script>
</head>
<jsp:include page="../comm/header.jsp"></jsp:include>
<body>
<%@include file="../comm/nav.jsp" %>
<section class="checkout-page pagez fix"><!--Start Checkout Area-->
	<div class="container">
		<div class="row">	
			<div class="col-md-9">
				<div class="panel-group" id="checkout-progress">
					<div class="panel panel-default">
						<div class="panel-heading" >
							<h3 class="active" align="center"> 이벤트 등록 </h3>
						</div>
						<div class="panel-body">
							<form id="frm" action="/insertEvent" method="post" onsubmit="return validation();">
								<table>
									<colgroup>
										<col width="16%;">
										<col width="38%;">
										<col width="12%;">
										<col width="*%;">
									</colgroup>
									
									<tbody>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>
										
										<%
											if(mvo.getMemberAuth().equals("2")) {
										%>
											<tr>
												<th scope="row" style="margin-bottom: 10px; width: 50px"> 사업자 번호 </th>
												<td>
													<select id="licenseNo" name="licenseNo">
														<option> 사업자 번호를 선택해주세요 </option>
														<c:forEach items="${licenseList}" var="licenseList">
															<option value="${licenseList.licenseNo }">${licenseList.licenseNo}</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<th>&nbsp;</th>
												<td>&nbsp;</td>
											</tr>
										
										<tr>
											<th scope="row" style="margin-bottom: 10px; width: 50px"> 이벤트 시간 설정 </th>
											<td>
												현재 시간으로 부터
												<select id="eventReg2" name="eventReg2">
													<c:set var="n" value="1"/>
													<c:forEach begin="1" end="12">
														<option value="${n}"> ${n}시간 동안 </option>
														<c:set var="n" value="${n+1}"/>
													</c:forEach>
													<option value="24"> 24시간동안 </option>
												</select>
												진행하겠습니다.
											</td>
										</tr>										
										<%
											}
										%>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>
										
										<tr>
											<th scope="row" style="margin-bottom: 10px; width: 50px"> 이벤트 제목 </th>
											<td>
												<input type="text" id="eventTitle" name="eventTitle" style="width: 587px;" maxlength="100">
											</td>
										</tr>
										<tr>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
											<th>&nbsp;</th>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th scope="row" style="width: 50px;"> 이벤트  내용 </th>
											<td>
												<textarea id="eventContent" name="eventContent" cols="65" rows="14" style="width: 587px; height: 168px;"></textarea>
											</td>
										</tr>
									</tbody>
								</table>
								<input type="hidden" name="memId" value="<%=mvo.getMemberId() %>">						
								<div class="login" align="center">
									<input type="submit" value="이벤트 등록" id="savebutton">&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="reset" value="입력취소" id="cancel">
								</div>
								<br>								
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section><BR><BR><BR><BR>
</body>
<jsp:include page="../comm/footer.jsp"></jsp:include>
</html>