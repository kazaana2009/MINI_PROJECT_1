<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<jsp:include page="../comm/header.jsp"></jsp:include>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
   .table-responsive, .unit, .table-info{
      border: hidden;
   }
</style>
<!-- 소스시작  -->
<script type="text/javascript">

	$(function() {
		
		$("#reviewForm").hide();
		
		$("#reviewBtn").on("click", function() {
			$("#reviewForm").show();
		})
	});
	
</script>
<style>
	 a:link { color: black; text-decoration: none;}
 	a:visited { color: black; text-decoration: none;}
	 a:hover { color: blue; text-decoration: underline;

</style>
<body>

   <%@include file="../comm/nav.jsp"%>
   <!-- test -->
   <div></div>
   <c:choose>
	   <c:when test="${sessionScope.memberGubun eq '2'}">
	  	 	<section class="cart-page page fix" style="margin-right:50px; margin-left:100px;" >
	   </c:when>
	   <c:when test="${sessionScope.memberGubun eq '3'}">
	   		<section class="cart-page page fix">
	   </c:when>
   </c:choose>
      <!--Start Cart Area-->
      <div class="container">
         <div class="row">
 		 <c:choose>        
	         <c:when test="${sessionScope.memberGubun eq '3'}">
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
	       	 </c:when>
       	 	 <c:when test="${sessionScope.memberGubun eq '2'}">
	            <div class="col-sm-4 col-md-3">
	               <div class="single-sidebar">
	                  <h2>문의 관리</h2>
	                  <ul align="center">
	                     <li><a href="/memberQaInfoList">내 문의 내역</a></li>
	                     <li><a href="/memberQaInfoList?gubun=1">고객 문의 내역</a></li>
	                  </ul>
	               </div>
	            </div>       	 	 	
       	 	 </c:when>
       	 </c:choose>
               <div class="table-responsive">
                  <table class="table cart-table">      
                     <thead class="table-title">            
                        <tr>
                           <th class="qaScNo">문의번호</th>
                           <th class="qaScTitle" colspan="5">제목</th>
                           <th class="qaScReg">문의날짜</th>
                           <th class="qaScState">답변상태</th>
                        </tr>
                     </thead>
                     <tbody>
                     	<c:forEach items="${qalist}" var="list" varStatus="status">
                     	<tr>
                     		<td class="unit">${status.count}</td>
                     	<c:choose>
                     		<c:when test="${list.qaSelNo eq 0 }">
                     		<td class="unit" colspan="5"><a href="/memberQaScInfo?qaScNo=${list.qaScNo}">${list.qaScTitle}</a></td>
							</c:when>
							<c:when test="${list.qaScNo eq 0 }">
							<td class="unit" colspan="5"><a href="/memberQaSelInfo?qaSelNo=${list.qaSelNo}">${list.qaSelTitle}</a></td>		
							</c:when>
                     	</c:choose>
                     		<td class="unit">${fn:substring(list.qaSelReg,0,10)}${fn:substring(list.qaScReg,0,10)}</td>
                     	<c:choose>
                     		<c:when test="${list.qaScStat eq 'Y' || list.qaSelStat eq 'Y'}">
                     			<td class="unit">답변 완료</td> 
                     		</c:when>
                     		<c:when test="${list.qaScStat eq 'N' || list.qaSelStat eq 'N'}">
                     			<td class="unit">답변 대기</td> 
                     		</c:when>                     		
                     	</c:choose>	
                     	</tr>
                     	</c:forEach>	
                     </tbody>
                  </table>
			   <form action="/inquiryPage">
			   		<div class="QnA" >
			   			<input type="submit" value="문의하기" style="float: right" id="insertQnA">
			   		</div>
			   </form>                  
               </div>
            </div>
         </div>
      </div>
   </section>
   <!--End Cart Area-->
   <br><br><br>
   
   <jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>