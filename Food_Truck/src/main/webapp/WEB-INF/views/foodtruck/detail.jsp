<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.foodtruck.vo.FoodTruckVO"%>
<%@ page import="com.foodtruck.vo.ReviewVO"%>
<%@ page import="com.foodtruck.vo.ProductVO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.*"%>

<%
   @SuppressWarnings("unchecked")
   List<ReviewVO> list = (List<ReviewVO>) request.getAttribute("review");
   @SuppressWarnings("unchecked")
   List<ProductVO> list2 = (List<ProductVO>) request.getAttribute("product");
   FoodTruckVO vo = (FoodTruckVO) request.getAttribute("vo");
%>

<!DOCTYPE html>
<html>

<jsp:include page="../comm/header.jsp"></jsp:include>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<head>
<script type="text/javascript">
function goOrder() {
   var licenseNo = <%=vo.getLicenseNo()%>;
   var ftruckNo = <%=vo.getFtruckNo()%>;
   order.action = "order?licenseNo=" + licenseNo +"&ftruckNo="+ftruckNo
   order.method = "post"
   order.submit();
}
//필요없는부분 표정이바뀜..
$(function() {   
   var ck= "<%=vo.getFtruckCondtion()%>";
   var alert=document.getElementById("alert");
   if(ck=="Y"){
      alert.style.display = 'block';
   }else{
      alert.style.display = 'none';
   }
})   
</script>
<body onload="map()">

    <%@include file="../comm/nav.jsp"%>
   <section class="product-page page fix">
      <!--Start Product Details Area-->
      <div class="container">
         <div class="row">
            <div class="col-sm-6">
               <div class="details-pro-tab">
                  <!-- Tab panes -->
                  <div class="tab-content details-pro-tab-content">
                     <div class="tab-pane fade in active" id="image-1">
                        <div class="simpleLens-big-image-container">
                           <img src="<%=vo.getFtruckImg()%>" alt="" class="simpleLens-big-image" style="width: 600px; height: 500px;">
                        </div>
                     </div>
               </div>
               <img src="" >
                  <!-- Nav tabs -->
            </div>
         </div>
         <div class="col-sm-6">
            <div class="shop-details">
            <!-- Product Name -->
               <h2><%=vo.getFtruckName()%></h2><br>
                  <!-- Product Ratting -->
               <div class="pro-ratting">
                  <span style="width:<%=vo.getFtruckGrade()*20%>%"></span>
               </div>                  
               <div class="infomation" style="font-size: 15px; color: #5e636d">
                  평점 : <%=vo.getFtruckGrade()%>점<br>
                  주소 : <%=vo.getFtruckAddr()%><br>
                  전화번호 : <%=vo.getFtruckTel()%><br> 
                  <!-- 예약 여부 -->
                  <%
                     String ftruckRsvYn = vo.getFtruckRsvYn();
                     if("y".equals(ftruckRsvYn) || "Y".equals(ftruckRsvYn)) {
                  %>
                     예약여부 : 가능 &emsp;
                  <%
                     } else {
                  %>
                     예약여부 : 불가능  &emsp;
                  <%      
                     }
                  %>
                  
                  <!-- 배달 여부  -->
                  <%
                     String ftruckDlvYn = vo.getFtruckDlvYn();
                     if("y".equals(ftruckDlvYn) || "Y".equals(ftruckDlvYn)) {
                  %>
                     배달여부 : 가능 &emsp;
                  <%
                     } else {
                  %>
                     배달여부 : 불가능  &emsp;
                  <%      
                     }
                  %>
               </div><br><br>
                  
                  <%@include file="map.jsp"%>
                  <%String ck=vo.getFtruckCondtion(); %>
                  <div class="alert alert-danger" role="alert" id="alert" style="display: none;">
                     <i class="fa fa-exclamation-triangle fa-5x pull-left"></i>
                     <div style="margin-top: 20px;">현재 이 푸드트럭은 대기자수가 많습니다. </div><br>
                  </div>
                  <form name="order" >            
                  <div align="center" class="orderForm">
                  <input type="submit" value="주문하러가기" style="width: 100%;" onclick="goOrder()"><br><br>
                  </div>
                  
                  
               </form>
            </div>
         </div>
      </div>
      <br>
      <br>
         <div class="col-sm-12 fix">
            <div class="description">
               <!-- Nav tabs -->
               <ul class="nav product-nav">
                  <li class="active">
                     <a data-toggle="tab" href="#description">푸드트럭소개</a>
                  </li>
                  <li class="">
                     <a data-toggle="tab" href="#review">리뷰</a>
                  </li>
                  <li class="">
                     <a data-toggle="tab" href="#tags">상품</a>
                  </li>
               </ul>
               <!-- Tab panes -->
               <div class="tab-content">
                  <div id="description" class="tab-pane fade active in" role="tabpanel">
                     <%=vo.getFtruckIntro()%>
                  </div>
                  <!-- 상품 리스트 시작 -->
                  <div id="tags" class="tab-pane fade" role="tabpanel">
                     <table class="reviewlist2">
                        <%
                           for (int i = 0; i < list2.size(); i++) {
                        %>
                        <tr style="width: 860px; height: 95.2px;">
                           <td style="width: 120px; height: 94.8px;"><img src="<%=list2.get(i).getProdImg() %>"></td>
                           <td style="width: 840px; height: 95.2px;"><%=list2.get(i).getProdName()%><%=list2.get(i).getProdContent()%></td>
                           <td style="width: 140px; height: 95.2px;">
                              <dl class="comment">
                                 <dt>가격</dt>
                                    <dd><%=list2.get(i).getProdPrice()%></dd>
                              </dl>
                           </td>
                        </tr>
                        <%
                           }
                        %>
                     </table>
                  </div>
                  
                  <!-- 상품리스트 끝 -->
                  <div id="review" class="tab-pane fade" role="tabpanel">
                     <!-- 리뷰 리스트 시작 -->
                     <table class="reviewlist">
                        <%
                           for (int i = 0; i < list.size(); i++) {
                        %>
                        <tr style="width: 860px; height: 95.2px;">
                           <td style="width: 120px; height: 94.8px;">
                              <div class="reply-ratting">
                                 <span style="width: <%=list.get(i).getGrade() * 20%>%"></span>
                              </div>
                           </td>
                           <td style="width: 840px; height: 95.2px;"><%=list.get(i).getRevContent()%></td>
                           <td style="width: 140px; height: 95.2px;">
                              <dl class="comment">
                                 <dt>작성자</dt>
                                    <dd><%=list.get(i).getMemId()%></dd>
                                 <dt>등록일</dt>
                                    <dd><%=list.get(i).getRevDtm().substring(0, 10)%></dd>
                              </dl>
                           </td>
                        </tr>
                        <%
                           }
                        %>
                     </table>
                     <!-- 리뷰 리스트 끝 -->
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
      
   </section>
<!--End Product Details Area-->
<jsp:include page="../comm/footer.jsp"></jsp:include>
</body>