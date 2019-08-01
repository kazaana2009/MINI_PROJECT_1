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
</script>
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
                     <thead class="table-title">            
                        <tr>
                           <th class="ftruckNo">푸드 트럭</th>
                           <th class="ordDate">주문일</th>
                           <th class="prodName">상품명</th>
                           <th class="ordQty">수량</th>
                           <th class="ordPrice">가격</th>
                           <th class="ordPrice">주문 현황</th>
                        </tr>
                     </thead>
                     <tbody>
                     <c:set var = "sum" value="0" />
                        <c:forEach items='${list}' var="MemberInfo">
                           <tr class="table-info">
                              <!-- 푸드트럭 이름 -->
                              <td class="unit" id="ftruckName">${MemberInfo.ftruckName}
                              <!-- 주문일 -->
                              <td class="unit">${fn:substring(MemberInfo.ordDate,0,11)}</td>      
                              <!-- 상품명 -->
                              <td class="unit">${MemberInfo.prodName}</td>
                              <!-- 상품 갯수  -->
                              <td class="unit">${MemberInfo.ordQty}개</td>
                              <!-- 제품 가격 -->
                              <td class="unit">${MemberInfo.ordPrice}원</td>
                              <!-- 결제 취소 하기 버튼 -->
                              <c:if test="${MemberInfo.cookStat eq 0 }">
                                 <td class="unit">
                                    <input type="button" value="결제취소하기" onclick="location.href='/orderCancel?ordNo=${MemberInfo.ordNo}&ordDlyYn=${MemberInfo.ordDlyYn}'">
                                 </td>
                              </c:if>
                                 
                              <c:if test="${MemberInfo.cookStat eq 1 }">
                                 <td class="unit"> 조리중 </td>
                              </c:if>
                                 
                              <c:if test="${MemberInfo.cookStat eq 2 }">
                                 <td class="unit"> 주문 완료 </td>
                              </c:if>
                           </tr>
                              <c:set var="sum" value="${sum+MemberInfo.ordPrice}" />
                        </c:forEach>
                     </tbody>
                  </table>
               </div>
               <div class="col-sm-6 col-md-7"></div>               
               <div class="col-sm-6 col-md-5">
                  <div class="proceed fix">
                     <div class="total">
                        <h6>총 금액 <span class="totalPriceTest"><c:out value="${sum}" />원</span></h6>
                     </div>
                   <div class="reviewBtn"><input type="button" value="리뷰등록" id="reviewBtn"></div>
                  </div>
               </div>   
            </div>         
         </div>
      </div>
   </section>
   <!--End Cart Area-->
      <%@include file="../form/reviewForm.jsp" %>
   <br><br><br>
   
   <jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>