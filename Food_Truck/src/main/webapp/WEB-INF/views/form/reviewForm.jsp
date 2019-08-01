<%@page import="com.foodtruck.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<!-- <script src="/resources/js/star.js"></script> -->
<link rel="stylesheet" type="text/css" href="/resources/style.css" />
<!-- 소스시작 -->
<script type="text/javascript">
   
   $(function() {
      // 평점남기는 별 함수
      var starRating = function(){
         var $star = $(".star-input"),
             $result = $star.find("output>b");
            
              $(document)
              
              .on("focusin", ".star-input>.input", function() {
                   $(this).addClass("focus");
             })
                
               .on("focusout", ".star-input>.input", function() {
                var $this = $(this);
                setTimeout(function() {
                     if($this.find(":focus").length === 0) {
                         $this.removeClass("focus");
                     };
                  }, 100);
              })
           
             .on("change", ".star-input :radio", function() {
                $result.text($(this).next().text());
                test = $("#starGrade").index('select', this);
                console.log(test);
              })
             
             .on("mouseover", ".star-input label", function(){
                $result.text($(this).text());
             })
             .on("mouseleave", ".star-input>.input", function(){
                var $checked = $star.find(":checked");
                   if($checked.length === 0){
                      $result.text("0");
                      } else {
                         $result.text($checked.next().text());
                   }
              });
         };
         
         starRating();
      
   });
   
   // 유효성 검사 & 폼전송
   $(function() {
	   
       $("#reviewForm").on("submit", function() {
    	   var ftruckNo = $("#ftrukNameList option:selected").val();
    	   var revContent = $("#revContent").val();
    	   var grade = Number($(":input:radio[name=grade]:checked").val());
         
    	   // 이용한 푸드트럭 
           if(ftruckNo == "") {
          	 alert("이용한 푸드트럭을 선택해주시기 바랍니다.");
          	 $("#ftrukNameList").focus();
          	 return false;
           }
           
    	   // 리뷰
           if(revContent == "") {
        	   alert("리뷰 작성부탁드립니다.");
        	   $("#revContent").focus();
        	   return false;
           }
    	   
           return true;
           
        });
       
   })
   
</script>
<div class="login-page page fix">
	<div class="row" style="padding-left: 380px;">
		<form id="reviewForm" method="post" action="/reviewRegit" onsubmit="return validation();">
			<div class="col-md-9">
				<div class="reviewForm">
				<label> 이용한 푸드트럭 </label>
					<select class="form-control" id="ftrukNameList" name="ftruckNo">
						<option value=""> -- 이용한 푸드트럭  -- </option>
						<c:set var="temp" value="" />
						<c:forEach items="${reviewList}" var="reviewList">
							<c:choose>
								<c:when test="${reviewList.ftruckName ne temp}">
									<option value="${reviewList.ftruckNo}">${reviewList.ftruckName}</option>
                                </c:when>
                            </c:choose>
                            <c:set var="temp" value="${reviewList.ftruckName}" />
                       </c:forEach>
					</select><BR><Br>
					
					<label> 고객님의 리뷰가 저희에게는 힘이 됩니다 :-) </label>
					<textarea class="form-control" rows="3" id="revContent" name="revContent"></textarea>
					<label> 평점 </label>
					<span class="star-input">
						<span class="input">
							<input type="radio" name="grade" value="1" id="p1">
				          	<label for="p1">1</label>
				          	<input type="radio" name="grade" value="2" id="p2">
						    <label for="p2">2</label>
						    <input type="radio" name="grade" value="3" id="p3">
						    <label for="p3">3</label>
						    <input type="radio" name="grade" value="4" id="p4">
						    <label for="p4">4</label>
						    <input type="radio" name="grade" value="5" id="p5">
						    <label for="p5">5</label>
						</span>
					    <output for="star-input"><b id="starGrade">0</b>점</output>
					</span>
					<P><button style="float: right;" type="submit" class="btn btn-default"> 리뷰 등록 </button></P>
				</div>
			</div>
		</form>
	</div>
</div>
