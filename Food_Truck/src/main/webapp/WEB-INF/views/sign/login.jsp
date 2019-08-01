<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>    
<html>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<script>
   // 라디오버튼 회원 / 비회원 체크 
   function memberCheck(num) {
      
      if(num == 1) {
         mem_login.style.display = 'block';
         non_login.style.display = 'none';
      } else if(num == 2) {
         mem_login.style.display = 'none';
         non_login.style.display = 'block';
      }
   }

   $(function() {
	   $("#nonMember_form").on("submit", function() {
		   var ordNo = $("#ordNo").val();
		   var ordTel = $("#ordTel").val();
		   
		   if(ordNo == "") {
			   alert("주문 번호를 입력해주세요.");
			   return false;
		   }
		   
		   if(ordTel == "") {
			   alert("휴대폰 번호를 입력해주세요.")
			   return false;
		   }
		   
		   return true;
	   })
   })
   
</script>


<jsp:include page="../comm/header.jsp"></jsp:include>
<body>

<%@include file="../comm/nav.jsp" %>

<div class="login-page page fix"><!--start login Area-->
   <div class="container">
      <div class="row2">
         <div class="col-sm-6 col-md-5">
            <div class="login">
               <form name="login_form" method="post" action="/login">
                  <div class="join" align="center">
                        <label><input type="radio" name="gubun" id="memberY" value="1" onclick ="memberCheck(1)" checked>회원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="gubun" id="memberN" value="2" onclick ="memberCheck(2)">비회원</label>
                  </div><br><br>
                  <div id="mem_login" style="display:block">
					 <h2>로그인</h2>
             	     <p>환영합니다!</p>
                     <label>아이디<span>*</span></label>
                     <input type="text" name="id" />
                     <label>비밀번호<span>*</span></label>
                     <input type="password" name="pw"/>
                     <div class="remember">
                        <input type="checkbox" />
                        <p>Remember me!</p>
                        <a href="/findAccount">비밀번호를 잊어 버리셨다구요?</a>
                     </div>
                     <p><input type=submit value="로그인" /></p>
                  </div>
               </form>
               <form id="nonMember_form" name="nonMember_form" method="post" action="/nonMemberOrderDetail">
                  <div id="non_login" style="display:none">
					 <h2>로그인</h2>
             	     <p>주문번호 & 휴대폰 번호를 입력해주세요.</p>                  
                     <label>주문 번호<span>*</span></label>
                     <input type="text" name="ordNo" id="ordNo"/>
                     <label>휴대폰 번호<span>*</span></label>
                     <input type="text" name="ordTel" id="ordTel" />
                     <p><input type="submit" value="조회" /></p>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
</div>
<!--End login Area-->  

<BR><BR><BR><BR>

<jsp:include page="../comm/footer.jsp"></jsp:include>

</body>
</html>