<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>* 운영자 - 판매자 Q&A </title>
<script src="//code.jquery.com/jquery-1.11.0.min.js" type="text/javascript"></script>
<script type="text/javascript">
	
	function modal(e) {
		var qno = e.getAttribute("data-id");
		
		$.ajax({
			url : "/MQnAdetail",
			data : 
				{
					"qno" : qno
				},
			type : "post",
			dataType : "json",
			success : function(data) {
				$(".a").html(data.content);
				$(".b").html('<input type="hidden" value="' + data.id + '" id="email">');
				$(".c").html('<input type="hidden" value="' + data.qno + '" id="qno">');
			}
		})
	}
	
	function reply() {
		var email = document.getElementById("email").value;
		var reply = document.getElementById("reply").value;
		var qno = document.getElementById("qno").value;
		
		$.ajax({
			url : "/MinquryReply",
			data : 
				{
					email : email,
					reply : reply,
					qno : qno
				},
			type : "post",
			dataType : "JSON",
			success : function(data) {
				if (data == 1) {
					alert("댓글 등록완료");
					location.reload();
				}
			}
		})
	}
</script>

</head>
<%@include file="../comm/header2.jsp"%>
<body>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span3" id="sidebar">
			<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
				<li><a href="/stute?pageNo=1"><i class="icon-chevron-right"></i>푸드트럭 현황&상태</a></li>
				<li class="active"><a href="/sellerQnA?pageNo=1"><i class="icon-chevron-right"></i>판매자 Q&A</a></li>
				<li><a href="/memberQnA?pageNo=1"><i class="icon-chevron-right"></i>일반회원 Q&A</a></li>
				<li><a href="/festival?pageNo=1"><i class="icon-chevron-right"></i>축제관리</a></li>
				<li><a href="/foodtruck?pageNo=1"><i class="icon-chevron-right"></i>푸드트럭 관리</a></li>
			</ul>
		</div>
			
	<!--/span-->
	<div class="span9" id="content">
		<div class="row-fluid">
			<!-- block -->
			<div class="block">
				<div class="navbar navbar-inner block-header">
					<div class="muted pull-left"> 답변하지않은 Q&A - ${pagecount}개 </div>
				</div>
						
				<div class="block-content collapse in">
					<table class="table table-bordered">							
						<thead align="center">
							<tr align="center">
								<th width="80px">사업자번호</th>
								<th width="80px">대분류</th>
								<th width="80px">소분류</th>
								<th width="180px">제목</th>
								<th width="140px">Email</th>
								<th width="150px">등록일</th>
								<th style="width: 60px;">답변여부</th>
							</tr>
						</thead>
									 
						<tbody>
							<c:forEach items="${list}" var="all">
								<tr class="odd gradeX" align="center">
									<td>${all.licenseNo}</td>
									<td>${all.qaScCategory1}</td>
									<td>${all.qaScCategory2}</td>
									<td><a href="#myModal" data-toggle="modal" data-id="${all.qaScNo}" onclick="modal(this)">${all.qaScTitle}</a></td>
									<td>${all.memId }</td>
									<td class="center">${all.qaScReg }</td>
									<td class="center" align="center">${all.qaScStat}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
							
					<div class="modal fade">
						<div class="modal-dialog">
							<div class="modal-content"><!-- remote ajax call이 되는영역 --></div>
						</div>
					</div>
							
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
									<li><a href="memberQnA?pageNo=1">처음</a></li>
								<%
								} 
								if (currentPage > 1) {
								%>
									<li><a href="memberQnA?pageNo=<%=currentPage - 1%>"><i class="fa fa-angle-left"></i><</a></li>
								<%
								} 
									for (int iCount = startPage; iCount <= endPage; iCount++) {
										if (iCount == currentPage) {
									%>
										<li class="active"><span><%=iCount%></span></li>
									<%
										} else {
									%>
										<li><a href="memberQnA?pageNo=<%=iCount%>"><%=iCount%></a><li>
									<%
										}
									}
									if (currentPage < totalPage) {
									%>
										<li><a href="memberQnA?pageNo=<%=currentPage + 1%>"><i class="fa fa-angle-right">></i></a></li>
								<%
									}
									if (endPage < totalPage) {
									%>
										<li><a href="memberQnA?pageNo=<%=totalPage%>">끝</a></li>
									<%
									}
								%>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- /block -->
				
			<!-- Modal(팝업창 같은것) -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-lg">
					<!-- class="modal-dialog"에 modal-lg추가하면 큰모달,  modal-sm추가하면 작은모달, 아무것도 안쓰면 중간크기의 모달이 만들어진다. -->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">판매자회원 Q&A 답글달기</h4>
						</div>

						<div class="modal-body">
							<table>
								<tr>
									<td class="c"></td>
								</tr>
								<tr>
									<td class="b"><input type="hidden" id="email" value="a"></td>
								</tr>
								<tr>
									<td width="520px"><h4>내용</h4></td>
								</tr>
								<tr>
									<td id="content" class="a"></td>
								</tr>
								<tr>
									<td><h4>답변</h4></td>
								</tr>
								<tr>
									<td><textarea style="width: 100%; height: 100%;"rows="5" id="reply"></textarea></td>
								</tr>
							</table>
						</div>
							
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" onclick="reply()">댓글 저장</button>
						</div>
					<!-- data-dismiss="modal" : 모달을 닫는 기능을 갖고있다. -->
					</div>
				<!-- 모달 콘텐츠 -->
				</div>
			<!-- 모달 다이얼로그 -->
			</div>
		<!-- 모달 전체 윈도우 -->
		</div>
	</div><hr>
</div>
<!--/.fluid-container-->
</body>
</html>