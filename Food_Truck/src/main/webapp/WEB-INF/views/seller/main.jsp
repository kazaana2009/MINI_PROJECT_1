<%@page import="com.foodtruck.vo.OrderDetailVO"%>
<%@page import="com.foodtruck.vo.OrderVO"%>
<%@page import="com.foodtruck.vo.FestivalVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
::-webkit-scrollbar {
   width: 8px;
   height: 8px;
   border: 3px solid #fff;
}

::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment
   {
   display: block;
   height: 10px;
   background: #efefef
}

::-webkit-scrollbar-track {
   background: #efefef;
   -webkit-border-radius: 10px;
   border-radius: 10px;
   -webkit-box-shadow: inset 0 0 4px rgba(0, 0, 0, .2)
}

::-webkit-scrollbar-thumb {
   height: 50px;
   width: 50px;
   background: rgba(0, 0, 0, .2);
   -webkit-border-radius: 8px;
   border-radius: 8px;
   -webkit-box-shadow: inset 0 0 4px rgba(0, 0, 0, .1)
}

.collapse.in.ins {
   height: 150px;
   overflow-y: scroll;
}
</style>
<script type="text/javascript"
   src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function() { 
//페이지 로드하자마자 묻는 JS   
<%String check=(String)request.getAttribute("check");%>
var check='<%=check%>';
var slide=document.getElementById("myCarousel");
if(check=='Y'){
   slide.style.display = 'block';
}else{
   slide.style.display = 'none';
}

});


$(function() {
    $('.chart').easyPieChart({
       animate : 1000
    });
    
    $('.carousel').carousel()
 })
 
 function ch(){
   var sel = $("select").val();
   location.href = "/sellerMain?licenseNo=" + sel;
}


</script>


</head>
<%@include file="../comm/header2.jsp"%>
<body>
   <div class="container-fluid">
      <div class="row-fluid">
         <%
            String no = (String) request.getAttribute("licenseNo");
         %>
         <%
            List<SellerVO> list = (List<SellerVO>) request.getAttribute("license");
         %>
         <select name="licenseNo" id="ch" onchange="ch()">
            <%
               for (int i = 0; i < list.size(); i++) {
            %>
            <option value="<%=list.get(i).getLicenseNo()%>"
               <%=no.equals(list.get(i).getLicenseNo()) ? "selected" : ""%>><%=list.get(i).getFtruckName()%></option>
            <%
               }
            %>
         </select>
         <div class="span3" id="sidebar">
            <ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
               <%--             
            <%
               if(mvo.getMemberAuth().equals("2")) {
                  List<SellerVO> list3 = (List<SellerVO>)session.getAttribute("licenseNo");
                        SellerVO ssvo = null;
                        if(!list3.isEmpty()) {
                           ssvo = (SellerVO)list3.get(0);
                        }  
            %>
 --%>
               <li class="active"><a
                  href="/sellerMain?licenseNo=${licenseNo}"> <i
                     class="icon-chevron-right"></i>주문 및 예약·배달
               </a></li>
               <li><a href="/sellerCalendar?licenseNo=${licenseNo}"><i
                     class="icon-chevron-right"></i>매출 통계</a></li>
               <li><a href="/sellerProduct?licenseNo=${licenseNo}"><i
                     class="icon-chevron-right"></i>내 푸드트럭 메뉴</a></li>
               <li><a href="/sellerInfo?licenseNo=${licenseNo}"><i
                     class="icon-chevron-right"></i>내 푸드트럭 설정</a></li>
            </ul>
         </div>

         <!--/span-->
         <div class="span9" id="content">
            <div class="row-fluid"></div>
            <div class="row-fluid">
               <!-- block -->
               <div class="block" style="height: 500px;">
                  <div class="navbar navbar-inner block-header">
                     <div class="muted pull-left">오늘의 추천 축제</div>
                  </div>
                  <!-- 슬라이드 시작 -->
                  <%int number=(int)request.getAttribute("numlist"); %>
                  <%if(check.equals("Y")){ %>
                  <div id="myCarousel"
                     class="carousel slide" 
                     style="height: 500px; width: 100%;  display: none" >

                     <ol class="carousel-indicators">
                          <li data-target="#myCarousel" data-slide-to="0"
                                 class="active"></li>
                        <%for(int i=1;i<=number;i++){ %>
                        <li data-target="#myCarousel" data-slide-to="<%=i%>" class=""></li>                  
                        <%} %>
                        

                     </ol>
                     <div class="carousel-inner" style="height: 500px; width: 100%;"
                        >
                        <%
                           List<FestivalVO> festivalList = (List<FestivalVO>) request.getAttribute("list3");
                        %>

                        <%
                           for (int j = 0; j < festivalList.size(); j++) {
                        %>
                        <%
                           if (j == 0) {
                        %>
                        <div class="item active">
                           <img src="<%=festivalList.get(j).getFesImg2()%>"
                              style="height: 500px; width: 100%;">
                           <div class="carousel-caption">
                              <p><%=festivalList.get(j).getFesName()%></p>
                           </div>
                        </div>
                        <%
                           } else {
                        %>
                        <div class="item">
                           <img src="<%=festivalList.get(j).getFesImg2()%>"
                              style="height: 500px; width: 100%;">
                           <div class="carousel-caption">
                              <p><%=festivalList.get(j).getFesName()%></p>
                           </div>
                        </div>
                        <%} %>
                        <%
                           }
                        %>
                        <a class="left carousel-control"
                           href="#myCarousel" role="button"
                           data-slide="prev"> &lsaquo;<span
                           class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                           <span class="sr-only"></span>
                        </a> <a class="right carousel-control"
                           href="#myCarousel" role="button"
                           data-slide="next">&rsaquo; <span
                           class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                           <span class="sr-only"></span>
                        </a>
                     </div>
                     <!-- carousel-inner close -->
                  </div>
                  <%}else{ %>
                  <div align="center"><h3>현재 푸드트럭위치 주변에 축제정보가 없습니다</h3></div>
                  
                  <%} %>
               </div>
               <div class="block">
                  <div class="navbar navbar-inner block-header">
                     <div class="muted pull-left">매출</div>
                     <div class="pull-right">
                        <span class="badge badge-warning" id="close"> </span>

                     </div>
                  </div>
                  <div class="block-content collapse in">

                     <c:if test="${payment ne null}">
                        <c:forEach var="payment" items="${payment}">
                           <div class="span3">
                              <div class="chart" data-percent="${payment.ratio}">${payment.ratio}%</div>
                              <div class="chart-bottom-heading">
                                 <span>${payment.payment}</span>
                                 <p>
                                    <span>주문건수 : ${payment.count}</span>
                                 <p>
                                    <span>금액 : ${payment.sumPrice}</span>
                              </div>
                           </div>
                        </c:forEach>
                     </c:if>
                     <c:if test="${empty payment}">
                        <div class="span3">
                           <div class="chart" data-percent="0">0%</div>
                           <div class="chart-bottom-heading">
                              <span>주문이 없습니다.</span>
                              <p>
                           </div>
                        </div>
                     </c:if>
                  </div>
               </div>
               <!-- /block -->
            </div>
            

            <div class="row-fluid">

               <div class="span6">

                  <!-- block -->
                  <div class="block">
                     <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">배달</div>
                        
                     </div>
                     <div class="block-content collapse in ins">
                        <table class="table table-striped">
                           <thead>
                              <tr>
                                 <th>주문 시간</th>
                                 <th>주문자 명</th>
                                 <th>음식</th>
                                 <th>요청사항</th>
                              </tr>
                           </thead>
                           <tbody>
                              <c:forEach var="todayDlv" items="${todayDlv}">
                                 <tr>
                                    <td>${todayDlv.ordDate}</td>
                                    <td>${todayDlv.ordName}</td>
                                    <td>${todayDlv.prodName}</td>
                                    <td>${todayDlv.ordReq}</td>
                                 </tr>
                              </c:forEach>
                           </tbody>
                        </table>
                     </div>
                  </div>
                  <!-- /block -->
               </div>
               <div class="span6">
                  <!-- block -->
                  <div class="block">
                     <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">예약</div>                     
                     </div>
                     <div class="block-content collapse in ins">
                        <table class="table table-striped">
                           <thead>
                              <tr>
                                 <th>예약시간</th>
                                 <th>주문자 명</th>
                                 <th>음식</th>
                                 <th>요청사항</th>
                              </tr>
                           </thead>
                           <tbody>
                              <c:forEach var="todayRsv" items="${todayRsv}">
                                 <tr>
                                    <td>${todayRsv.ordRsvDate}</td>
                                    <td>${todayRsv.ordName}</td>
                                    <td>${todayRsv.prodName}</td>
                                    <td>${todayRsv.ordReq}</td>
                                 </tr>
                              </c:forEach>
                           </tbody>
                        </table>
                     </div>
                  </div>
                  <!-- /block -->
               </div>
            </div>
            <div class="row-fluid">
               <div class="span6">
                  <!-- block -->
                  <div class="block">
                     <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">현금</div>
                        
                     </div>
                     <div class="block-content collapse in ins">
                        <table class="table table-striped">
                           <thead>
                              <tr>
                                 <th>날짜</th>
                                 <th>주문자명</th>
                                 <th>음식</th>
                                 <th>요청사항</th>
                              </tr>
                           </thead>
                           <tbody>
                              <c:forEach var="todayOrder" items="${todayOrder}">
                                 <c:if test="${todayOrder.payment eq '0' }">
                                    <tr>
                                       <td>${todayOrder.ordDate}</td>
                                       <td>${todayOrder.ordName}</td>
                                       <td>${todayOrder.prodName}</td>
                                       <td>${todayOrder.ordReq}</td>
                                    </tr>
                                 </c:if>
                              </c:forEach>
                           </tbody>
                        </table>
                     </div>
                  </div>
                  <!-- /block -->
               </div>
               <div class="span6">
                  <!-- block -->
                  <div class="block">
                     <div class="navbar navbar-inner block-header">
                        <div class="muted pull-left">카드</div>
                        
                     </div>
                     <div class="block-content collapse in ins">
                        <table class="table table-striped">
                           <thead>
                              <tr>
                                 <th>날짜</th>
                                 <th>주문자명</th>
                                 <th>음식</th>
                                 <th>요청사항</th>

                              </tr>
                           </thead>
                           <c:forEach var="todayOrder" items="${todayOrder}">
                              <c:if test="${todayOrder.payment eq '1' }">
                                 <tr>
                                    <td>${todayOrder.ordDate}</td>
                                    <td>${todayOrder.ordName}</td>
                                    <td>${todayOrder.prodName}</td>
                                    <td>${todayOrder.ordReq}</td>
                                 </tr>
                              </c:if>
                           </c:forEach>
                        </table>
                     </div>
                  </div>
                  <!-- /block -->
               </div>
            </div>

         </div>
      </div>
   </div>
</body>
</html>