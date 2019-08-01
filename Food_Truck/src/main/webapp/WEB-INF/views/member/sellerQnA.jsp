<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<jsp:include page="../comm/header.jsp"></jsp:include>

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
	
	function hs(no) {
		
	}
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
	<section class="cart-page page fix" style="margin-right:50px; margin-left:100px;" >
      <!--Start Cart Area-->
      <div class="container">
         <div class="row">
            <div class="col-sm-4 col-md-3">
               <div class="single-sidebar">
                  <h2>문의 관리</h2>
                  <ul align="center">
                     <li><a href="/memberQaInfoList">내 문의 내역</a></li>
                     <li><a href="/memberQaInfoList?gubun=1">고객 문의 내역</a></li>
                  </ul>
               </div>
            </div>       	 	 	
               <div class="table-responsive">
                  <table class="table cart-table">      
                     <thead class="table-title">            
                        <tr>
                           <th class="qaScNo">문의번호</th>
                           <th class="ftruckName">상호명</th>
                           <th class="qaScTitle" colspan="5">제목</th>
                           <th class="qaScReg">문의날짜</th>
                           <th class="qaScState">답변상태</th>
                        </tr>
                     </thead>
                     <tbody>
                     	<c:forEach items="${qalist}" var="list" varStatus="status">
							<tr>
								<td class="unit">${status.count}</td>
								<td class="unit">${list.ftruckName}</td>
								<td class="unit" colspan="5"><a href="/sellerQnAReply?qaSelNo=${list.qaSelNo}">${list.qaSelTitle}</a></td>
								<td class="unit">${fn:substring(list.qaSelReg,0,10)}</td>
	                     	<c:choose>
	                     		<c:when test="${list.qaSelStat eq 'Y'}">
	                     			<td class="unit">답변 완료</td> 
	                     		</c:when>
	                     		<c:when test="${list.qaSelStat eq 'N'}">
	                     			<td class="unit">답변 대기</td> 
	                     		</c:when>                     		
	                     	</c:choose>
	                     	</tr>
						</c:forEach>	
                     </tbody>
                  </table>                 
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