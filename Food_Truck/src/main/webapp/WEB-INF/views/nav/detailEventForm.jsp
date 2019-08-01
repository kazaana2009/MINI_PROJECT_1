<%@page import="com.foodtruck.vo.EventVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.0.min.js" type="text/javascript"></script>
</head>
<jsp:include page="../comm/header.jsp"></jsp:include>
<body>
<%@include file="../comm/nav.jsp" %>
<!-- Start Blog Details-->
<section class="blog-page page fix">
   <div class="container">
      <div class="row2">
         <div class="col-sm-12">
            <div class="product">
               <div class="content fix">
                  <h2>${vo.eventTitle}</h2>
                  <div class="meta" style="margin-left: 420px;">
                     <i class="fa fa-pencil-square-o"></i> ${vo.memId}&nbsp;&nbsp;
                     <i class="fa fa-calendar"></i> ${fn:substring(vo.eventReg, 0, 10)}&nbsp;&nbsp;
                     <i class="glyphicon glyphicon-sunglasses"></i>${vo.eventCnt}
                  </div><br><br>
                  <p>${vo.eventContent}</p>
                  <br><br>
                  <fmt:parseDate value="${vo.eventReg2 }" pattern="yyyy-MM-dd HH:mm" var="endDate"/>
<%--                   <p>이벤트 진행 시간은 ${fn:substring(vo.eventReg2, 0, 13)}시  ${fn:substring(vo.eventReg2, 14, 15)} 분 까지 진행됩니다.</p> --%>
                  <p>이벤트 진행 시간은  <fmt:formatDate value="${endDate }" pattern="yyyy-MM-dd HH:mm"/> 까지 진행됩니다.</p>
               </div>
            </div>

            <%
               EventVO vo = (EventVO)request.getAttribute("vo");
               String sellerId = vo.getMemId();
               //로그인 체크!
               if (mvo != null) {
                  isLogin = true;
                  if(mvo.getMemberId().equals(sellerId)) {
                  %>
               <br><br><br>
               <div style="float: right;">
                  <button class="notice-btn" onclick="location.href='/updateEventForm?eventNo=${vo.eventNo}'">수정</button>
                  <button class="notice-btn" id=delete onclick="location.href='/deleteEvent?eventNo=${vo.eventNo}'">삭제</button>
                  <button class="notice-btn" onclick="location.href='/eventBoard?pageNo=1'">목록</button>
               </div>
                  <% 
                  }
               }
            %>
            <br><br><br><br>
            <!-- 댓글(comment)  -->
            <div id="comments">
               <div class="comments-list">
                  <h4 class="heading">Comments</h4>
                  <ol class="commentlists">
                     <li class="sin-comment">
                        <div class="the-comment">
                           <div class="comment-box">
<!--                               <div class="comment-author"> -->
<!--                                  <p class="com-name"><strong></strong></p> -->
<!--                                  <a href="#" class="repost-link"></a> -->
<!--                                  <a href="#" class="comment-reply-link"></a> -->
<!--                               </div> -->
                              <div class="comment-text">
                                 <p></p>
                              </div>
                           </div>
                        </div>
                     </li><!-- #comment-## -->
                  </ol>
               </div>
               
               <br><br>
               <!-- 댓글 다는 폼 -->
               <div class="commentform">
                  <h4 class="heading">Leave a Comment</h4>
                  <form class="comment-form" id="commentform" method="post" action="#">
                     <div class="row2">
                        <div class="col-md-4">
                           <div class="form-input">
                              <label for="author">Your Name<span>*</span></label>
                              <input type="text" aria-required="true" value="" id="author" name="author">
                           </div>
                        </div>
                        <div class="col-md-4">
                           <div class="form-input">
                              <label for="email">Your Email<span>*</span></label>
                              <input type="email" aria-required="true" value="" name="email" id="email">
                           </div>
                        </div>
                        <div class="col-md-4">
                           <div class="form-input">
                              <label for="title">Title<span>*</span></label>
                              <input type="text" aria-required="true" value="" name="title" id="title">
                           </div>
                        </div>
                     </div>
                     <div class="form-input">
                        <label for="comment" class="field-label">Your Comment<span>*</span></label>
                        <textarea aria-required="true" name="comment" id="comment" rows="4"></textarea>
                     </div>
                     <p class="join" style="float: right;">
                        <input type="submit" value="submit" id="submit" name="submit">
                     </p>
                  </form>
               </div><!-- end commentform -->
            </div>
         </div>
      </div>
   </div>
</section><br><br>
<!-- Start Blog Details-->
<jsp:include page="../comm/footer.jsp"></jsp:include>
</body>
</html>