<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*, java.text.*" %>
<%
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	String today = format.format(new Date());
%>
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
		$("#qaScInsert").hide()
		
		$("#reviewBtn").on("click", function() {
			$(".hihide").show();
			$(".reviewBtn").hide()
			$("#qaScInsert").show()
			$("#qaScInsert").attr("class","reviewBtn")			
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
	     	<div class="col-sm-4 col-md-3">
	        	<div class="single-sidebar">
	            	<h2>문의 관리</h2>
	                  	<ul align="center">
	                    	 <li><a href="/memberQaInfoList">내 문의 내역</a></li>
	                    	 <li><a href="/memberQaInfoList?gubun=1">고객 문의 내역</a></li>
	                 	</ul>
	               </div>
	            </div> 
            <div class="col-sm-8 col-md-9">
               <div class="table-responsive">
                  <table class="table cart-table">
                        <tr class="table-title">
                           <th class="qaScNo">문의번호</th>
                           <th class="qaScTitle">제목</th>
                           <th class="qaScReg">등록일</th>
                           <th class="qaCategory">카테고리</th>
                        </tr>
                     	<tr>
                     	<c:choose>
                            <c:when test="${qaInfo.qaSelNo ne 0}">
                     			<td class="unit">${qaInfo.qaSelNo}</td>
                     		</c:when>	         			
                     	</c:choose>	
                     		<td class="unit">${qaInfo.qaSelTitle}</td>
                     		<td class="unit">${fn:substring(qaInfo.qaSelReg,0,10)}</td>
                     		<c:set var="qaSelCategory" value="${qaInfo.qaSelCategory1}(${qaInfo.qaSelCategory2})"/>
                     		<td class="unit">${qaSelCategory}</td>
                     	</tr>
                     	<tr class="table-title">
                     		<th class="qaScContent" colspan="4">문의내용</th>
                     	</tr>
                     	<tr>
                     		<td class="unit" colspan="4">${qaInfo.qaSelContent}</td>
                     	</tr>
                  </table>
               </div>
               	<c:set var="temp" value="${qaInfo.qaSelStat}" />
               	<c:if test="${temp eq 'N'}">
               
               <div class="table-responsive hihide">
               <br><br><br><br><br>
               <form action="/qaScInsert">
               		<table class="table cart-table">
               			<tr class="table-title">
               				<th class="replySelContent" colspan="2">답변내용</th>
               			</tr>
               			<tr>
               				<td class="unit" colspan="2" align="center"><textarea name="replySelContent" rows="5" cols="112"></textarea></td>
               			</tr>
               			<tr class="table-title">
               				<th class="memId">관리자</th>
               				<th class="replySelReg">답변일</th>
               			</tr>
               			<tr>
							<td class="unit">${sessionScope.memberId}</td>
							<td class="unit"><%=today%></td>
               			</tr>
               			<tr>
               				<td><input type="hidden" name="memId" value="${sessionScope.memberId}"></td>
               				<td><input type="hidden" name="replySelReg" value="<%=today%>"></td>
               				<td><input type="hidden" name="qaSelNo" value="${qaInfo.qaSelNo}"></td>
               			</tr>	
               		</table>
               	<div class="reviewBtn2"><input type="button" value="목록" id="listQnA" style="float:right"></div>
               	<div class="QnA"><input type="submit" value="확인" id="qaScInsert" style="float: right"></div>
               	</form>
               	</div>
               	<div class="reviewBtn"><input type="button" value="답변" id="reviewBtn" style="float: right"></div>
               	</c:if>
               	
               	
               	<c:if test="${temp eq 'Y'}">
               	<br><br><br><br><br>
	               <div class="table-responsive">
	               		<table class="table cart-table">
	               			<tr class="table-title">
	               				<th class="replySelContent" colspan="2">답변내용</th>
	               			</tr>
	               			<tr>
	               				<td class="unit" colspan="2" align="center">${qaReply.replySelContent}</td>
	               			</tr>
	               			<tr class="table-title">
	               				<th class="memId">관리자</th>
	               				<th class="replySelReg">답변일</th>
	               			</tr>
	               			<tr>
								<td class="unit">${qaReply.memId}</td>
								<td class="unit">${fn:substring(qaReply.replySelReg,0,10)}</td>               			
	               			</tr>
	               		</table>
	               </div>
	               <div class="reviewBtn"><input type="button" value="목록" id="listQnA" style="float:right"></div> 		
               	</c:if>
               <br><br><br><br><br>              
            </div>         
         </div>
      </div>
   </section>   
   <!--End Cart Area-->
   <br><br><br>
   
   <jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>