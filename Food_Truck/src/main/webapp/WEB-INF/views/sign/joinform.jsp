<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<%@include file="../comm/header.jsp"%>
<head>
<style type=text/css>
.login input {
	color: red;
}
</style>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	jQuery(function($) {

		// var id = /^[a-z0-9_-]{3,16}$/; // 아이디 검사식
		var id = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var pw = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$/; // 비밀번호 검사식
		var tel = /^[0-9]{8,11}$/; // 전화번호 검사식

		var form = $('.joinForm'), memberId = $('input[name="memberId"]'), memberPw = $('input[name="memberPw"]'), memberPw1 = $('input[name="memberPw1"]'), memberName = $('input[name="memberName"]'), memberTel = $('input[name="memberTel"]');

		// 전송 버튼을 눌렀을 시 유효성 체크
		form.submit(function() {
			if (memberId.val() == "" || id.test(memberId.val()) != true) {
				alert('아이디를 확인해 주세요.');
				memberId.focus();
				return false;
			} else if (memberPw.val() == "" || pw.test(memberPw.val()) != true
					|| memberPw.val() != memberPw1.val()) {
				alert('비밀번호를 확인해 주세요.');
				memberPw.focus();
				return false;
			} else if (memberName.val() == "") {
				alert('이름을 입력해 주세요.');
				memberName.focus();
				return false;
			} else if (memberTel.val() == "") {
				alert("휴대폰번호를 입력해 주세요.");
				memberTel.focus();
				return false;
			} else if ($("#checkId").attr("result") == "unchecked") {
				alert("아이디 중복체크를 해주세요.");
				return false;
			} else if($("#finalcheck").attr("result") == "unchecked"){
				alert("이메일 인증을 해주세요");
				return false;
			}
		});

		$('#checkId, input[name="memberPw"], input[name="memberPw1"]').after(
				'<p></p>');

		// 아이디 중복 체크
		$("#checkId").click(
				function() {
					$.ajax({
						url : '/idCheck',
						type : 'get',
						data : memberId.serialize(),
						success : function(getId) {
							if (memberId.val() == ""
									|| id.test(memberId.val()) != true) {
								alert("아이디를 확인해 주세요.");
							} else if ($.trim(getId) == 0) {
								alert("사용 가능한 아이디 입니다.");
								$("#checkId").attr("result", "checked");
								$("#checkId").css("display", "none");
								$("#comform").css("display", "inline");
							} else {
								alert("이미 사용하고 있는 아이디 입니다.");
							}
						},
					});
				});
		
		
		//이메일 인증
		//var finalnum;
		$('#comform').click(function() {
			$.ajax({
				url: '/check',
				type: 'post',
				data: memberId.serialize(),
				async:false,
				success:function(test){
					$("#comform").css("display", "none");
					$("#cknum").css("display", "inline");
					$("#finalcheck").css("display", "inline");
					$('#finalcheck').click(function(){
						var number=document.getElementById('cknum').value;
						var ck=test
						if(ck==number){
							alert("인증완료!");
							$("#finalcheck").attr("result", "checked");
						}else{
							alert("인증번호를 확인해주세요!");
							
						}
					})
				} 
			});
		});
		
		
		
		// 아이디 체크
		memberId.keyup(function() {
			var s = $("#checkId").next('p');
			if (id.test(memberId.val()) != true) {
				s.text("이메일 형식이 맞지 않습니다.").css("color", "red").font("Raleway");
			} else {
				s.text(" ");
			}
		});

		// 비밀번호 체크
		memberPw
				.keyup(function() {
					var s = $(this).next('p');
					if (memberPw.val().length == 0) { // 입력 값이 없을 때
						s.text('비밀번호를 입력해 주세요.');
					} else if (pw.test(memberPw.val()) != true) {
						s.text('비밀번호는 최소 8자리의 영문 및 숫자를 포함해야 합니다.').css("color",
								"red").font("Raleway");
						;
					} else {
						s.text('사용 가능한 비밀번호 입니다.').css("color", "gray").font(
								"Raleway");
					}
				});

		// 비밀번호 확인 체크
		memberPw1.keyup(function() {
			var s = $(this).next('p');
			// 입력한 비밀번호와 다를 때
			if (memberPw.val() != memberPw1.val()) {
				s.text('입력하신 비밀번호와 다릅니다.').css("color", "red").font("Raleway");
			} else {
				s.text("위의 비밀번호와 일치합니다.").css("color", "gray").font("Raleway");
			}
		});

		/* 
		 // 휴대폰번호 체크
		 memberTel.keydown( function() {
		 if(event.keyCode==109 || event.keyCode==189) {
		 return false;
		 }
		 });
		 */

		// 이용 약관 불러오기
		$("textarea[name=textarea]").load("test1.txt");

	});
</script>

</head>
<body>
<%@include file="../comm/nav.jsp"%>
	<!--start create member Area-->
	<div class="login-page page fix">
		<div class="container">
			<div class="row2">
				<div class="col-sm-6 col-md-5">
					<div class="join">
						<form id="signup-form" action="/join" method="post"
							class="joinForm">
							<h2>회원 가입</h2>
							<p>자신만의 계정을 만들어 보세요!</p>
							<!-- 회원 구분  -->
							<label>일반 회원 / 판매자<span>*</span></label> <label><input
								type="radio" name="gubun" value="member" checked> 일반 회원
								<input type="radio" name="gubun" value="seller"> 판매자 </label>
							<!-- 이메일 (id) -->
							<label>아이디 (이메일 형식)<span>*</span></label> <input type="text"
								name="memberId" placeholder="이메일 형식으로 작성해주세요."> <input type="button" id="checkId"
								value="중복확인" result="unchecked" style="display: inline;">
							<input type="button" id="comform" value="인증하기" result="unchecked"
								style="display: none;">
								<input type="text" style="display: none;" id="cknum">
								<input type="button" id="finalcheck" value="인증완료" result="unchecked"
								style="display: none;">
							<!-- 비밀번호 (memberPw) -->
							<label>비밀 번호<span>*</span></label> <input type="password"
								name="memberPw">
							<!-- 비밀번호확인 (memberPw1) -->
							<label>비밀 번호 체크<span>*</span></label> <input
								type="password" name="memberPw1">
							<!-- 이름 -->
							<label>이름<span>*</span></label> <input type="text"
								name="memberName">
							<!-- 휴대폰 번호  -->
							<label>휴대폰 번호<span>*</span></label> <input type="text"
								name="memberTel">
							<!-- 이벤트 정보 수신 동의 -->
							<label>이벤트 정보 수신 동의<span>*</span></label>
							<div class="remember">
								<input type="checkbox" name="checkSNS">
								<p>sns</p>
							</div>
							<div class="remember">
								<input type="checkbox" name="checkEmail">
								<p>email</p>
							</div>
							<!-- 버튼 -->
							<p>
								<input type="reset" value="재작성"> <input type="submit"
									value="가입">
							</p>
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