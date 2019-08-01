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
            var noticeTitle = $("#noticeTitle").val();
            var noticeContent = $("#noticeContent").val();
            
            if(noticeTitle == "") {
               alert("제목을 입력해 주세요.")
               $("#noticeTitle").focus();
               return false;
            };
            
            if(noticeContent == "") {
               alert("내용을 입력해 주세요.")
               $("#noticeContent").focus();
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
                     <h3 class="active" align="center"> 공지사항 등록 </h3>
                  </div>
                  <div class="panel-body">
                     <form id="frm" action="/insertNotice" method="post" onsubmit="return validation();">
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
                              <tr>
                                 <th scope="row" style="margin-bottom: 10px; width: 50px"> 공지할 제목 </th>
                                 <td>
                                    <input type="text" id="noticeTitle" name="noticeTitle" style="width: 587px;" maxlength="100">
                                 </td>
                              </tr>
                              <tr>
                                 <th>&nbsp;</th>
                                 <td>&nbsp;</td>
                                 <th>&nbsp;</th>
                                 <td>&nbsp;</td>
                              </tr>
                              <tr>
                                 <th scope="row" style="width: 50px;"> 공지할  내용 </th>
                                 <td>
                                    <textarea id="noticeContent" name="noticeContent" cols="65" rows="14" style="width: 587px; height: 168px;"></textarea>
                                 </td>
                              </tr>
                           </tbody>
                        </table>
                        <input type="hidden" name="memId" value="<%=mvo.getMemberId() %>">                  
                        <div class="login" align="center">
                           <input type="submit" value="공지사항 등록" id="savebutton">&nbsp;&nbsp;&nbsp;&nbsp;
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