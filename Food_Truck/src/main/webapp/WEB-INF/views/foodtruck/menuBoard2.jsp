<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<jsp:include page="../comm/header.jsp"></jsp:include>
<body>
<%@include file="../comm/nav.jsp"%>
<div class="shop-product-area section fix">
	<div class="container">	
		<div class="col-md-9">
			<div class="row">
				<div class="shop-tool-bar col-sm-12 fix">
					<div class="view-mode">
						<a href="/menuBoard2?pageNo=1" class="active">
							<i class="fa fa-th"></i>
						</a>
						<a href="/menuBoard?pageNo=1">
							<i class="fa fa-th-list"></i>
						</a>
					</div>
				</div>
				<div class="shop-products">
				<!-- Single Product Start -->
					<c:forEach items="${list}" var="all">
						<div class="col-sm-4 fix">
						<fieldset>
							<div class="product-item fix">
								<div class="product-img-hover">
									<!-- Product image -->
									<a href="/read?ftruckNo=${all.ftruckNo}">
										<img src="${all.ftruckImg}" />
									</a>
								</div>
								<div class="pro-name-price-ratting">
									<!-- Product Name -->
									<div class="pro-name">
										<a href="/read?ftruckNo=${all.ftruckNo}">${all.ftruckName}</a>
									</div>
									<!-- Product Ratting -->
									<div class="pro-ratting">
										<span style="width: ${all.ftruckGrade*20}%"></span>
									</div>
									<div>&nbsp;&nbsp;${all.ftruckGrade}점&nbsp;&nbsp;/&nbsp;리뷰수 : ${all.count} 개</div>
								</div>
							</div>
						</fieldset><br>	
						</div><!-- Single Product End -->
					</c:forEach>
					<!-- Pagination -->
					<div class="pagination">
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
							<li><a href="menuBoard2?pageNo=1">처음</a></li>
							<%
								}
								if (currentPage > 1) {
							%>
							<li><a href="menuBoard2?pageNo=<%=currentPage - 1%>"><i class="fa fa-angle-left"></i></a></li>
							<%
								}
								for (int iCount = startPage; iCount <= endPage; iCount++) {
									if (iCount == currentPage) {
							%>
							<li class="active"><span><%=iCount%></span></li>
							<%
								} else {
							%>
							<li><a href="menuBoard2?pageNo=<%=iCount%>"><%=iCount%></a><li>
							<%
								}
								}
								if (currentPage < totalPage) {
							%>
							<li><a href="menuBoard2?pageNo=<%=currentPage + 1%>"><i class="fa fa-angle-right"></i></a></li>
							<%
								}
								if (endPage < totalPage) {
							%>
							<li><a href="menuBoard2?pageNo=<%=totalPage%>">끝</a></li>
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
<!-- Shop Product Area End -->
<jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>