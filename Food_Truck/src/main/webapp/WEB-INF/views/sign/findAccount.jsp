<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@include file="../comm/header.jsp"%>
<head>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<script>

	// 아이디 찾기
	function findId() {
		var tel = $('input[name="memberTel"]')
		
		if(tel.val() == "") {
			alert("번호를 입력하세요")
			tel.focus()
			return false;
		}
		
		$.ajax({
			url : '/findId',
			type : 'post' ,
			data :  tel.serialize() ,
			success : function(getId) {
				if(getId.memberId != null) {
					alert("조회하신 아이디는 " + getId.memberId + "입니다.")
				}else{
					alert("조회하신 아이디는 없습니다.")
				}
			}
		})
	}
	
	// 비밀번호 찾기
	function findPw() {
		var memberTel = $('input[name="memberTel2"]')
		var memberId  = $('input[name="memberId"]')
		var result = memberTel.serialize()+"&"+memberId.serialize()
		
		if(memberId.val() == "") {
			alert("아이디를 입력하세요")
			memberId.focus()
			return false;
		} else if(memberTel.val() == "") {
			alert("전화번호를 입력하세요")
			memberTel.focus()
			return false;
		}
		
		$.ajax({
			url : '/findPw',
			type : 'post' ,
			data : result,
			success : function(getPw) {
				if(getPw.memberPw != null) {
					alert("조회하신 아이디의 비밀번호는 " + getPw.memberPw + "입니다.")
				}else{
					alert("정보 없음")
				}
			}
		
		})
		
	}
	
	
</script>
</head>
<%@include file="../comm/nav.jsp"%>
<body>
	<!--start create member Area-->
	<div class="login-page page fix">
		<div class="container">
			<div class="row2">
				<div class="col-sm-6 col-md-5">
					<div class="join">
						<form id="findId" class="findForm">
							<h2>Find Account</h2>
							<p>Find your own account</p>
							<!-- 이메일 (id) -->
							<label align="center">ID 찾기<span>*</span></label><br>
							<input type="text" name="memberTel" placeholder="핸드폰 번호를 입력하세요"> 
							<input type="button" value="조회" onclick="findId()">
							</form>
							<span id="showId"></span>
							<br><br><br>
						<form id="findPw" class="findFormPw">
							<!-- 비밀번호 (memberPw) -->
							<label align="center">Password 찾기<span>*</span></label> 
							<input type="text" name="memberId" placeholder="아이디를 입력하세요">
							<label><span></span></label> 
							<input type="text" name="memberTel2" placeholder="핸드폰 번호를 입력하세요"> 
							<input type="button" value="조회" onclick="findPw()">
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