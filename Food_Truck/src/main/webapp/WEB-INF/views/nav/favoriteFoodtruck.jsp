<%@page import="com.foodtruck.vo.OrderVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>    
<html>

<jsp:include page="../comm/header.jsp"></jsp:include>
<body>
<%@include file="../comm/nav.jsp" %>
<%
	List<OrderVO> list = (List<OrderVO>) request.getAttribute("list");
%>
<!-- test -->
<div></div>
<section class="cart-page page fix">
	<!--Start Cart Area-->
	<div class="container">
		<div class="row2">
			<div class="col-sm-12">
               <div class="product">
                  <div class="table-responsive">
                  <h2>TOP5 푸드트럭</h2>
                     <p> 주문횟수가 많은 푸드트럭을 5개 보여드립니다.<br>
                     	 푸드트럭의 이름을 클릭하시면 바로 주문이 가능하답니다 :-)
                     </p><br><br>
                     <!-- 사업자 기준으로 통계 -->
                     
                     <!-- 테이블 뿌려주자!!! -->
                     <table class="table cart-table">
                        <thead class="table-title">
                           <tr>
                              <th class="unit"> 순위 </th>
                              <th class="unit"> 주문 횟수 </th>
                              <th class="unit"> 푸드트럭 이름 </th>  
                           </tr> 
                        </thead>
                        
                        <tbody id="pastOrder">
                        <!-- 주문 번호  -->
                        	<%
                        		for(int i = 0; i < list.size(); i++) {
                        	%>
                        		<tr class="table-info">
	                             	<!-- 순위 -->
	                             	<td class="unit"><%=list.get(i).getRank() %></td>
	                           		<!-- 주문 횟수 -->
	                            	<td class="unit"><%=list.get(i).getFavoriteCount() %></td>
	                             	<!-- 푸드트럭 이름 -->
	                             	<td class="unit">
	                             		<a href="/order?licenseNo=<%=list.get(i).getLicenseNo() %>&ftruckNo=<%=list.get(i).getFtruckNo() %>">
	                             			<%=list.get(i).getFtruckName() %>
	                             		</a>
	                             	</td>
                           		</tr>
                           	<%
                        		}
                           	%>
                        </tbody>
                     </table>
                  </div>
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