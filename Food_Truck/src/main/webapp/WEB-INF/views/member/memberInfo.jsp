<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<jsp:include page="../comm/header.jsp"></jsp:include>
<%@include file="../comm/nav.jsp"%>
<head>
<script>
$(function() {
	$("#infoupdateBtn").click(function() {
		
		var memberPw = $('input[name="memberPw"]')
		var check = prompt("비밀번호를 입력하세요")
		if(check == memberPw.val()) {
			frm.action = "/memberInfoUpdateGet"
			frm.method = "POST"
			frm.submit()
		}else{
			alert("정보가 틀렸습니다.")
			return false;
		}
	})
})	
</script>
<style>
.login input {
	color: red;
}
#frm {
	padding-left: 200px;
}
h1 {
	padding-left: 220px;
}
.btnEdit {
	margin-left: 130px;
} 
.box {
	border : 0px;
	background-color: #ebebeb
}
.table-title {
	background-color: #ebebeb 
}
</style>
</head>
<body>
<!--start create member Area-->
<div class="login-page page fix">
	<div class="container">
		<div class="row">
			<div class="col-sm-4 col-md-3">
				<div class="single-sidebar">
					<h2>내 정보</h2>
					<ul align="center">
						<li><a href="/memberInfo">회원 정보</a></li>
						<li><a href="/memberOrderInfo">주문 내역</a></li>
	                    <li><a href="/memberQaInfoList">문의 내역(판매자)</a></li>
	                    <li><a href="/memberQaInfoList?gubun=1">문의 내역(관리자)</a></li>
					</ul>
				</div>
			</div>
			<div class="col-sm-6 col-md-5" style="margin-left: 100px">
				<div class="myInfo">																																									
					<form id="frm" action="/join" method="post" class="joinForm">
						<input type="hidden" name="memberPw" value="${memberInfo.memberPw}" class="box" style="width: 100%">
						<!-- 이메일 (id) -->
						<table class="table cart-table">
						<tr class="table-title">
							<th width="100px">아이디</th>
							<td><input type="text" name="memberId" readonly="readonly" value="${memberInfo.memberId}" class="box" style="width: 100%"></td>
							<th></th>
						</tr>
						<tr class="table-title">
							<th width="100px">이름</th>
							<td><input type="text" name="memberName" readonly="readonly" value="${memberInfo.memberName}" class="box" style="width: 100%"></td>							
							<th></th>
						</tr>				
						<tr class="table-title">
							<th width="100px">전화번호</th>
							<td><input type="text" name="memberTel" readonly="readonly" value="${memberInfo.memberTel}" class="box" style="width: 100%"></td>							
							<th></th>
						</tr>																		
						<tr class="table-title">
							<th width="100px"></th>
							<td><input type="button" value="수정" id="infoupdateBtn" style="float: right"></td>
							<th></th>
						</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!--End create member Area-->
<br>
<br>
<br>
<br>
<br>
<jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>