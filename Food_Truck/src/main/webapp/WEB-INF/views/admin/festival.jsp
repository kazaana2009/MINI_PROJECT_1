<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>* 운영자 - 축제 관리</title>
<script src="//code.jquery.com/jquery.min.js"></script>
<style>
	.wrap-loading 
	{ 
		/*화면 전체를 어둡게 합니다.*/
		position: fixed;
		left: 0;
		right: 0;
		top: 0;
		bottom: 0;
		background: rgba(0, 0, 0, 0.2); /*not in ie */
		filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000'); /* ie */
	}

	.wrap-loading div 
	{ 
		/*로딩 이미지*/
		position: fixed;
		top: 50%;
		left: 50%;
		margin-left: -21px;
		margin-top: -21px;
	}

	.display-none 
	{ 
		/*감추기*/
		display: none;
	}
</style>
<script type="text/javascript">
	
	$(function() {
		$("#re").click(function() {
			alert("약 30초 정도 소요가 됩니다.");
			$.ajax({
				url : "/api",
				success : function(data) {
					alert("축제 정보 받아오기 완료!");
					location.reload();
				},
				error : function(data) {
					alert("축제정보 받아오기 실패!");
				},
				beforeSend : function() {
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');

				}
			})
		})
	})
	
</script>
</head>
<%@include file="../comm/header2.jsp"%>
<body>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span3" id="sidebar">
			<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
				<li><a href="/stute?pageNo=1"><i class="icon-chevron-right"></i>푸드트럭 현황&상태</a></li>
				<li><a href="/sellerQnA?pageNo=1"><i class="icon-chevron-right"></i>판매자 Q&A</a></li>
				<li><a href="/memberQnA?pageNo=1"><i class="icon-chevron-right"></i>일반회원 Q&A</a></li>
				<li class="active"><a href="/festival?pageNo=1"><i class="icon-chevron-right"></i>축제관리</a></li>
				<li><a href="/foodtruck?pageNo=1"><i class="icon-chevron-right"></i>푸드트럭 관리</a></li>
			</ul>
		</div>
		
	<!--/span-->
	<div class="span9" id="content">
		<div class="row-fluid">
		<!-- block -->
			<div class="block">
				<div class="navbar navbar-inner block-header">
					<div class="muted pull-left">
						<p><button class="btn" id="re">축제 새로고침</button></p>
					</div>
				</div>
				
				<div class="block-content collapse in">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th width="80px"></th>
								<th>행사 이름</th>
								<th>행사 주소</th>
								<th>행사 전화번호</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach items="${list}" var="all">
								<tr class="odd gradeX">
									<td><img src="${all.fesImg2}" style="width: 80px; height: 80px;"></td>
									<td>${all.fesName}</td>
									<td>${all.fesAddr}</td>
									<td>${all.fesTel}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="wrap-loading display-none">
					<div>
						<img src="/resources/img/viewLoading.gif" />
					</div>
				</div>
				<!-- /block -->
				<div class="pagination" align="center">
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
								<li><a href="festival?pageNo=1">처음</a></li>
							<%
							} 
							if (currentPage > 1) {
							%>
								<li><a href="festival?pageNo=<%=currentPage - 1%>"><i class="fa fa-angle-left"></i><</a></li>
							<%
							} 
								for (int iCount = startPage; iCount <= endPage; iCount++) {
									if (iCount == currentPage) {
								%>
									<li class="active"><span><%=iCount%></span></li>
								<%
									} else {
								%>
									<li><a href="festival?pageNo=<%=iCount%>"><%=iCount%></a><li>
								<%
									}
								}
								if (currentPage < totalPage) {
								%>
									<li><a href="festival?pageNo=<%=currentPage + 1%>"><i class="fa fa-angle-right">></i></a></li>
							<%
								}
								if (endPage < totalPage) {
								%>
									<li><a href="festival?pageNo=<%=totalPage%>">끝</a></li>
								<%
								}
							%>
						</ul>
					</div>
				</div>
			</div>
		<!-- /block -->
		</div>
	</div>
</div>
</body>
</html>