<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<jsp:include page="../comm/header.jsp"></jsp:include>
<body>
<%@include file="../comm/nav.jsp"%>
<section class="cart-page page fix" >
	<div class="container">
		<div class="row2">
			<div class="col-sm-12">
               <div class="product">
                  <div class="table-responsive">
                  	<h1>이벤트</h1><br>
                     	<table class="table cart-table">
                        	<thead class="table-title">
                        		<tr>
                        			<th class="quantity"> 글번호 </th>
                              		<th class="unit" style="width: 100px;"> 제목 </th>
                              		<th class="unit"> 조회수 </th>
                              		<th class="unit"> 등록일 </th>
                              		<th class="unit"> 작성자 </th>
                           		</tr> 
                        	</thead>
                        
                        	<tbody id="pastOrder">
 		                      	<c:forEach items='${rank}' var="rank">
         		              		<tr class="table-info">
                	    	   			<td class="quantity">${rank.eventNo}</td>
                    	   				<td class="unit"><a href="/detailEventForm?eventNo=${rank.eventNo}">${rank.eventTitle}</a></td>
                       					<td class="unit">${rank.eventCnt}</td>
                       					<td class="unit">${fn:substring(rank.eventReg, 0, 10)}</td>
                       					<td class="unit">${rank.memId}</td>
                          			</tr>
                         		</c:forEach>
                       		</tbody>
                   	 	</table>
	            
	                   	<%
							//로그인 체크!
							if (mvo != null) {
								isLogin = true;
								if(mvo.getMemberAuth().equals("1") || mvo.getMemberAuth().equals("2")) {
							%>
								<div class="eventBtn" style="float: right;"><button onclick="location.href='/writeEventForm'">글쓰기</button></div>
							<% 
								}
							} 
						%>
                 	</div>
              	</div>
           	</div>
        </div>
     </div>
 </section>
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
				<li><a href="eventBoard?pageNo=1">처음</a></li>
			<%
			}
			if (currentPage > 1) {
			%>
				<li><a href="eventBoard?pageNo=<%=currentPage - 1%>"><i class="fa fa-angle-left"></i></a></li>
			<%
			}
			for (int iCount = startPage; iCount <= endPage; iCount++) {
				if (iCount == currentPage) {
			%>
					<li class="active"><span><%=iCount%></span></li>
				<%
				} else {
				%>
					<li><a href="eventBoard?pageNo=<%=iCount%>"><%=iCount%></a><li>
			<%
				}
			}
			if (currentPage < totalPage) {
			%>
				<li><a href="eventBoard?pageNo=<%=currentPage + 1%>"><i class="fa fa-angle-right"></i></a></li>
			<%
			}
			if (endPage < totalPage) {
			%>
				<li><a href="eventBoard?pageNo=<%=totalPage%>">끝</a></li>
			<%
			}
		%>
	</ul>
</div><br><br>
<jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>
