<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>    
<html>
<style>
/* for MS계열 브라우저 */
	@keyframes blink {
		0% {color: #e8da1e;}
		50% {color: #5ba2b3 ;}
	}
	 
/* for Chrome, Safari */
	@-webkit-keyframes blink {
		0% {color: #e8da1e;}
	 	50% {color: #5ba2b3;}
	}
	 
/* blink CSS 브라우저 별로 각각 애니메이션을 지정해 주어야 동작한다. */
	.blinkcss 
	{
	 font-weight:bold;
	 animation: blink 1s step-end infinite;
	 -webkit-animation: blink 1s step-end infinite;
	}
</style>
<jsp:include page="../comm/header.jsp"></jsp:include>
<body>
 <%@include file="../comm/nav.jsp" %>

<!-- Shop Product Area Start -->
<div class="shop-product-area section fix">
	<div class="container">
		<div class="row">
			<div class="col-md-9">
				<div class="row">
					<!-- Shop Tool Bar -->
					<div class="shop-tool-bar col-sm-12 fix">
						<div class="view-mode">
							<a href="/CategoryFood2?pageNo=1&category=${categoryno}">
								<i class="fa fa-th"></i>
							</a>
							<a href="/CategoryFood?pageNo=1&category=${categoryno}" class="active">
								<i class="fa fa-th-list"></i>
							</a>
						</div>
					</div>
					<div class="shop-products">
						<!-- Single Product -->
						<c:forEach items="${list}" var="all">
						<fieldset>
						<div class="single-list-product col-sm-12">
							<div class="list-pro-image">
								<a href="/read?ftruckNo=${all.ftruckNo}">
									<img src="${all.ftruckImg}">
								</a>
							</div>
						<div class="list-pro-des fix">
							<a class="pro-name" href="/read?ftruckNo=${all.ftruckNo}">${all.ftruckName}</a>
							<!-- 이벤트 설정된 시간에 맞게 반짝반짝 작은이벤트~~~~ 아름답게 비추네~~~ -->
							<%
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
								Date currentTime = new Date();
								String dTime = sdf.format(currentTime);
							%>
							<c:set var="time" value="<%=dTime %>"/>					
							<c:set var="endEventTime" value="${fn:substring(all.eventReg2, 0, 16)}"/>
							<c:if test="${all.ftruckEvent ne null }">
								<c:if test="${time < endEventTime }">
									<a class="eventA blinkcss" href="/detailEventForm?eventNo=${all.eventNo}">이벤트 중입니다.</a><br><br>
								</c:if>
							</c:if>
							<!-- 이벤트 끝! -->
						<div class="pro-ratting">
							<span style="width: ${all.ftruckGrade*20}%"></span>
						</div>
						<div>&nbsp;&nbsp;${all.ftruckGrade}점&nbsp;&nbsp;/&nbsp;리뷰수 : ${all.count} 개</div>
								<p>${all.ftruckIntro}</p>
							</div>
						</div>
						</fieldset><br>
						</c:forEach>
						<!-- Pagination -->
						<div class="pagination" >
							<ul>
								<%
									int pageNo;//페이지번호
									int tot = (int) request.getAttribute("pagecount");//전체 게시물수
									try {
										pageNo = (int) request.getAttribute("pageNo");//페이지번호
									} catch (Exception e) {
										pageNo = 1;
									}
									int currentPage = pageNo;//페이지번호
									int countList = 10;
									int countPage = 10;
									int totalPage = tot / countList;//페이지당 게시물수()--  만약 게시물이 10개이면 페이지 수는 1개가된다.
									if (tot % countList > 0) {
										totalPage++;
									}
									///////////////////////////////////적용완료

									if (totalPage < currentPage) {
										currentPage = totalPage;
									} //게시물이 없을경우  0개의 게시물일떄 페이지는 1로 해준다.

									////////////////////////////
									int startPage = ((currentPage - 1) / 10) * 10 + 1;
									int endPage = startPage + countPage - 1;
									if (endPage > totalPage) {
										endPage = totalPage;
									}
									if (startPage > 1) {
								%>
								<li><a href="CategoryFood?pageNo=1&category=<%=request.getAttribute("categoryno")%>">처음</a></li>
								<%
									}
									if (currentPage > 1) {
								%>
								<li><a href="CategoryFood?pageNo=<%=currentPage - 1%>&category=<%=request.getAttribute("categoryno")%>"><i class="fa fa-angle-left"></i></a></li>
								<%
									}
									for (int iCount = startPage; iCount <= endPage; iCount++) {
										if (iCount == currentPage) {
								%>
								<li class="active"><span><%=iCount%></span></li>
								<%
									} else {
								%>
								<li><a href="CategoryFood?pageNo=<%=iCount%>&category=<%=request.getAttribute("categoryno")%>"><%=iCount%></a><li>
								<%
									}
									}
									if (currentPage < totalPage) {
								%>
								<li><a href="CategoryFood?pageNo=<%=currentPage + 1%>&category=<%=request.getAttribute("categoryno")%>"><i class="fa fa-angle-right"></i></a></li>
								<%
									}
									if (endPage < totalPage) {
								%>
								<li><a href="CategoryFood?pageNo=<%=totalPage%>&category=<%=request.getAttribute("categoryno")%>">끝</a></li>
								<%
									}
								%>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div><!-- Shop Product Area End -->
<jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>