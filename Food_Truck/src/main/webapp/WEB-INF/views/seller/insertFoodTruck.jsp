<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<%@include file="../comm/header2.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	jQuery(function($) {

		// var id = /^[a-z0-9_-]{3,16}$/; // 아이디 검사식
		var id = /^[a-z0-9_-]{3,16}$/;
		var pw = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$/; // 비밀번호 검사식
		var tel = /^[0-9]{8,11}$/; // 전화번호 검사식

		var form = $('.insertFoodTruck'), 
			licenseNo = $('input[name="licenseNo"]'), 
			ftruckName = $('input[name="ftruckName"]'), 
			ftruckTel = $('input[name="ftruckTel"]');
		
		$('#checkNo').after(
				'<p></p>');

		// 사업자번호 중복 체크
		$("#checkNo").click(
				function() {
					$.ajax({
						url : '/licenseNoCheck',
						type : 'get',
						data : licenseNo.serialize(),
						success : function(getId) {
							if (licenseNo.val() == ""
									|| id.test(licenseNo.val()) != true) {
								alert("사업자 번호를 확인해 주세요.");
							} else if ($.trim(getId) == 0) {
								alert("사용 가능한 번호 입니다.");
								$("#checkNo").attr("result", "checked");
								$("#checkNo").css("display", "none");
								$("#comform").css("display", "inline");
							} else {
								alert("이미 사용하고 있는 번호 입니다.");
							}
						},
					});
				});
		
		// 사업자번호 체크
		licenseNo.keyup(function() {
			var s = $("#checkNo").next('p');
			if (isNaN(licenseNo.val())) {
				s.text("숫자만 입력 가능합니다.").css("color", "red");
			} else if(licenseNo.toString().length != 10){
				s.text("사업자 번호는 10자 입니다.").css("color", "red");
			} else {
				s.text(" ");
			}
		});
		
	});
	
	// 이미지 파일 첨부
	function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#ftruckImg').attr('src', e.target.result).css('width', '300px;').css('height', '200px');
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#fileImg").change(function(){
        readURL(this);
    });
	
	
</script>

<style>
th {
	margin:0px;
	width:15%;
	background-color: #fafafa;
}

td {
	width:100% auto;
}

input[type=text] {
	margin:0px;
	width:300px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    border:1px solid #CCC;
}
textarea {
	width:300px;
	resize: none;
}


</style>
</head>


<body>

	<div class="container-fluid">
		<div class="row-fluid">
		<div class="span3" id="sidebar">
				<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
					<li ><a
						href="/sellerMain?licenseNo=${licenseNo}"> <i
							class="icon-chevron-right"></i>주문 및 예약·배달
					</a></li>
					<li class="active"><a href="/sellerCalendar?licenseNo=${licenseNo}"><i
							class="icon-chevron-right"></i>매출 통계</a></li>
					<li><a href="/sellerChart?licenseNo=${licenseNo}"><i
							class="icon-chevron-right"></i>차트</a></li>
					<li><a href="/sellerProduct?licenseNo=${licenseNo}"><i
							class="icon-chevron-right"></i>내 푸드트럭 메뉴</a></li>
				</ul>
			</div> 
			<div class="span9" id="content">
				<!-- morris stacked chart -->
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">푸드트럭 등록</div>
						</div>
						<div class="block-content collapse in ins">
						<form id="signup-form" action="/insertFoodTruck" method="post" class="insertFoodTruck">
							<table class="table">
									<tr>
										<th>사업자번호</th>
										<td>
											<input type="text" name="licenseNo" style="margin-bottom:0px">
											<input class="btn btn-default" type="button" id="checkNo" value="중복확인" result="unchecked" style="display: inline;"> 
										</td>
									</tr>
									<tr>
										<th>푸드트럭 명</th>
										<td><input type="text" name="ftruckName"></td>
									</tr>
									<tr>
										<th>휴대폰 번호 </th>
										<td>
											<input type="text" name="ftruckTel"> 											
										</td>
									</tr>
									<tr>
										<th>주소</th>
										<td>
											<input type=text name=ftruckAddr readonly> 
											<input type=button class="btn btn-default" value="주소검색"><p>
											<input type=text name=ftruckAddr2>
										</td>
									</tr>
									<tr>
										<th>푸드트럭 소개</th>
										<td><textarea name=ftruckIntro rows="7"></textarea></td>
									</tr>
									<tr>
										<th>배달여부</th>
										<td>
											<input type=radio name=ftruckDlvYn value="Y" checked>Y
											<input type=radio name=ftruckDlvYn value="N">N
										</td>
									</tr>
									<tr>
										<th>예약여부</th>
										<td>
											<input type=radio name=ftruckRsvYn value="Y"checked>Y
											<input type=radio name=ftruckRsvYn value="N">N
										</td>
									</tr>
									
									<tr>
										<th>카테고리</th>
										<td>
											<select name=category>
												<option value="1">한식</option>
												<option value="2">중식</option>
												<option value="3">양식</option>
												<option value="4">일식</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>파일첨부</th>
										<td>
											<input type=file name=ftruckImg id="fileImg">
											<img id="ftruckImg" src="#"/>
										
										</td>
									</tr>
									
							</table>
							
							<input type="reset" class="btn btn-default" value="Reset"> 
							<input type="submit" class="btn btn-default" value="Sign up">
						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>