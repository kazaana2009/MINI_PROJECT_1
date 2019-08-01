<%@page import="java.util.List"%>
<%@page import="com.foodtruck.vo.SellerVO"%>
<%@page import="com.foodtruck.vo.MemberVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav>
	<!--Start Header Top Area-->
	<div class="header-top">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 col-md-4">
					<div class="info">
						<div class="phn-num float-left"></div>
						<div class="mail-id float-left"></div>
					</div>
				</div>
				<div class="col-sm-12 col-md-4">
					<div class="socials text-center"></div>
				</div>
				<div class="col-sm-12 col-md-4">
					<div id="top-menu" class="float-right">
						<ul>

							<!-- 로그인 로직 -->
							<%
								boolean isLogin = false;
								MemberVO mvo = null;
								
								mvo = (MemberVO) session.getAttribute("member");
								
								//로그인 체크!
								if (mvo != null) {
									isLogin = true;
								} 
								
								//로그인 안했을때
								if (!isLogin) {
							%>
							<li><a href="/loginform">로그인</a></li>
							<li><a href="/joinform">회원가입</a></li>

							<%
								} else {
							%>
							
							<%
								switch (mvo.getMemberAuth()) {
								
									//일반회원
									case "3":
							%>
							<li id="dlvTime">
							</li>	
							<li><a href="#">나의 주문<i class="fa fa-angle-down"></i></a>
								<ul style="width: 120px;">
									<li><a href="/memberOrderInfo">전체 주문 내역</a></li>
									<li><a href="/favoriteFoodtruck">관심 푸드트럭</a></li>
									<li><a href="/memberInfo">나의 설정</a></li>
								</ul></li>
							<%
                        break;
                           //판매자
                           case "2":
                        	   List<SellerVO> list3 = (List<SellerVO>)session.getAttribute("licenseNo");
                               SellerVO ssvo = null;
                               if(!list3.isEmpty()) {
                                  ssvo = (SellerVO)list3.get(0);
                               }  
                           
                   			  %>
							<li>
								<a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src='/resources/img/ms3.png' ><i class="fa fa-angle-down"></i></a>
								<ul>
									<li><a id="newRsv">예약<b id="newCountRsv"></b></a></li>
									<li><a id="newDlv">배달<b id="newCountDlv"></b></a></li>
								</ul>
							</li>									
							<li><a href="#">판매자 메뉴<i class="fa fa-angle-down"></i></a>
								<ul style="width: 120px;">
									<li><a href="/orderDetail">예약 내역</a></li>
									<li><a href="/DeliveryDetail">배달 내역</a></li>
									<li><a href="/sellerMain<%=list3.isEmpty()?"":"?licenseNo="+ssvo.getLicenseNo() %>">푸드트럭 관리</a></li>
								</ul>
							</li>
							<%
								break;
									//운영자
									case "1":
							%>
							<li><a href="/stute?pageNo=1">관리자 페이지<i class="fa fa-angle-down"></i></a>
							<%
								break;
									default:
							%>
							<li>로그인되지 않았습니다.</li>
							<%
								break;
									}
								}
							%>
												
							<li><a href="#">고객센터<i class="fa fa-angle-down"></i></a>
								<ul>
									<li><a href="/noticeBoard?pageNo=1">공지사항</a></li>
									<li><a href="/eventBoard?pageNo=1">이벤트</a></li>
								<c:if test="${sessionScope.memberGubun ne '1'}">		
									<li><a href="/memberQaInfoList">1:1 문의</a></li>
								</c:if>
								</ul>
							</li>
							<% if(isLogin) { %>
								<li><a href="/logout">로그아웃</a></li>
							<% } %>														
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--Start Header Top Area-->
	<!--Start Header Area-->
	<div class="header-area">
		<div class="container">
			<div class="row">
				<div class="col-sm-4 col-lg-3">
					<div class="log-link"></div>
				</div>
				<div class="col-sm-4 col-lg-6">
					<div class="logo text-center">
						<a href="/"> <img src="/resources/img/header/home.png" alt="" />
							<!-- 푸드 트럭 이미지  /  h4 밑에 설명 --> <!-- 						<h4>online jewelry store</h4> -->
						</a>
					</div>
				</div>
				<div class="col-sm-4 col-lg-3">
					<div class="search float-right">
						<div id="search1">
							<button onclick="getLocation()" id="getLocation" class="ico-loc">
							</button>
						</div>

						<form action="/search" method="get">

							<div id="search2">
								<input type="hidden" name="pageNo" value="1"> <input
									type="text" id="search" name="search" placeholder="예) 강남구, 서초구"
									value="" />

							</div>
							<div id="search3">
								<!-- 
							<input type="image" id="locbtn" class="submit">
							-->
								<button class="submit" id="locbtn">
									<i class="fa fa-search"></i>
								</button>

							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--End Header Area-->

	<!--Start Main Menu Area-->
	<!--Start Main Menu Area-->
	<div class="menu-area">
		<div class="container">
			<div class="row">
				<div class="clo-md-12">
					<div class="main-menu hidden-sm hidden-xs">
						<nav>
							<ul>
								<!-- 푸드트럭 리스트 -->
								<li><a href="/menuBoard?pageNo=1" class="active">푸드트럭 리스트</a></li>

								<!-- 한식  -->
								<li><a href="/CategoryFood?pageNo=1&category=1">한식</a></li>

								<!-- 중식  -->
								<li><a href="/CategoryFood?pageNo=1&category=2">중식</a></li>

								<!-- 양식  -->
								<li><a href="/CategoryFood?pageNo=1&category=3">양식</a></li>

								<!-- 일식  -->
								<li><a href="/CategoryFood?pageNo=1&category=4">일식</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
</nav>