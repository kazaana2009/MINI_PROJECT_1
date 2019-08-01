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
		$(".hihide").hide()
		$(".reviewBtn2").hide()
		
		
		$("#reviewBtn").on("click", function() {
			$(".hihide").show()
			$("#reviewBtn").hide()
			$(".reviewBtn2").show()
		})
	});

	$(function() {
		$("#listQnA").click(function() {
			history.back()
		})
	})
	
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
   <section class="cart-page page fix">
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
            <div class="col-sm-8 col-md-9">
               <div class="table-responsive">
                  <table class="table cart-table">
                        <tr class="table-title">
                           <th class="qaScNo">문의번호</th>
                           <th class="qaScTitle">제목</th>
                           <th class="qaScReg">등록일</th>
                           <th class="qaSelCategory">카테고리</th>
                        </tr>
                     	<tr>
                     	<c:choose>
                     		<c:when test="${qaInfo.qaScNo ne 0}">
                     			<td class="unit">${qaInfo.qaScNo}</td>
                     			<c:set var="ScCategory" value="${qaInfo.qaScCategory1}(${qaInfo.qaScCategory2})"/>
                     		</c:when>
                            <c:when test="${qaInfo.qaSelNo ne 0}">
                     			<td class="unit">${qaInfo.qaSelNo}</td>
                     			<c:set var="SelCategory1" value="${qaInfo.qaSelCategory1}(${qaInfo.qaSelCategory2})"/>
                     		</c:when>	         			
                     	</c:choose>	
                     		<td class="unit">${qaInfo.qaSelTitle}${qaInfo.qaScTitle}</td>
                     		<td class="unit">${fn:substring(qaInfo.qaSelReg,0,10)}${fn:substring(qaInfo.qaScReg,0,10)}</td>
                     		<td class="unit">${ScCategory}${SelCategory1}</td>
                     	</tr>
                     	<tr class="table-title">
                     		<th class="qaScContent" colspan="4">문의내용</th>
                     	</tr>
                     	<tr>
                     		<td class="unit" colspan="4">${qaInfo.qaSelContent}${qaInfo.qaScContent}</td>
                     	</tr>
                  </table>
               </div>
               	<c:set var="temp" value="${qaInfo.qaSelStat}" />
               	<c:set var="temp2" value="${qaInfo.qaScStat}" />
               	<c:if test="${temp eq 'N' || temp2 eq 'N'}">
					<div class="reviewBtn"><input type="button" value="목록으로" id="listQnA" style="float:right"></div>
               	</c:if>
               	<c:if test="${temp eq 'Y' || temp2 eq 'Y'}">
               		<div class="reviewBtn"><input type="button" value="답변내용" id="reviewBtn" style="float: right"></div>
               		<div class="reviewBtn2"><input type="button" value="목록으로" id="listQnA" style="float:right"></div>
               	</c:if>
               <br><br><br><br><br>
               <div class="table-responsive hihide">
               		<table class="table cart-table">
               			<tr class="table-title">
               				<th class="replyScContent" colspan="2">답변내용</th>
               			</tr>
               			<tr>
               				<td class="unit" colspan="2" align="center">${qaReply.replySelContent}${qaReply.replyScContent}</td>
               			</tr>
               			<tr class="table-title">
               				<th class="memId">관리자</th>
               				<th class="replyScReg">답변일</th>
               			</tr>
               			<tr>
							<td class="unit">${qaReply.memId}</td>
							<td class="unit">${fn:substring(qaReply.replySelReg,0,10)}${fn:substring(qaReply.replyScReg,0,10)}</td>               			
               			</tr>
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