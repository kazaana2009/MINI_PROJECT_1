<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<jsp:include page="../comm/header.jsp"></jsp:include>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>



<script type="text/javascript">
	function time(){
		var cookStat = $("#cookStat option:selected").val();
		var time= document.getElementById("time");
		if(cookStat==1){
			 time.style.display = 'block';
		}else{
			 time.style.display = 'none';
		}
	}
	function exampleModal(e) {
		var data = e.getAttribute("data-id");
		
		$("#changeBtn").on("click", function() {		
			var cookStat = $("#cookStat option:selected").val();	
			var cktime = $("#time option:selected").val();
			if(cookStat==1&&cktime==""){
				alert("배달시간을 설정해주세요!");
			}
			else{
				console.log(cookStat + " / " + data);
				var ordNo = data;
				var dlever= document.getElementById("dlever").value;
				
				$.ajax ({
					type : "post",
					url : "/cookStatChange",
					data : {	"dlvDate": cktime,
								"cookStat" : cookStat,
								"ordNo" : ordNo,
								"dlever" :dlever
						   },
					success : function(data) {
						location.reload();
						selectList();				
					} 
				})
			}
		
		})
	}     

   $(document).ready(function() {
		
		selectList();

   });

</script>
<body>
<%@include file="../comm/nav.jsp"%>
<!-- test -->
<div></div>
<section class="cart-page page fix" >
	<!--Start Cart Area-->
	<div class="container">
		<div class="row2">
			<div class="col-sm-12">
               <div class="product">
                  <div class="table-responsive" >
                  <h2>오늘 배달 내역</h2>
                     <p> 오늘의 기준 - 배달현황 <br><br>사업자 번호 선택 후, 날짜를 선택하시면 지난 배달 내역도 확인 가능하답니다 :-) </p><br><br>
                     <!-- 사업자 기준으로 통계 -->
                     <div>
                     	<select id="licenseList" name="licenseNo" >
                     		<option value=""> 사업자 번호 </option>
                     		<c:forEach items="${licenseList}" var="licenseList">
                     			<option value="${licenseList.licenseNo}">${licenseList.licenseNo}</option>
                     		</c:forEach>
                     	</select>

                     <!-- 사업자번호 & 달력  -->	
                     	<input type="text" placeholder="원하는 날짜를 선택하세요" id="cal" style="float: right; width: 210px; text-align:center;" ><br><br>
                     </div>
                     <input type="hidden" value="${ORD_DLV_YN}" id="dlever">
                     <!-- 테이블 뿌려주자!!! -->
                     <table class="table cart-table">
                        <thead class="table-title">
                           <tr>
                              <th class="unit" style="width: 200px;"> 주문 번호 </th>
                              <th class="unit"> 제품 이름 </th>
                              <th class="unit" style="width: 100px;"> 수량 </th>
                              <th class="unit"> 주문 총 가격 </th>
                              <th class="unit"> 요청 사항 </th>
                              <th class="quantity"> 상태 </th>
                              <th class="namedes" > 주소 </th>
                           </tr> 
                        </thead>
                        
                        <tbody id="pastOrder">
                        <!-- 주문 번호  -->
                        <c:set var="temp" value="" />
                        	<c:forEach items='${dleverDetailList}' var="detailList">
                        		<tr class="table-info">
                        			
                        			<c:choose>
                        				<c:when test="${detailList.ordNo eq temp}">
                        					<td></td>
                        				</c:when>
                        				
                        				<c:when test="${detailList.ordNo ne temp}">
                        					<td class="valu">${detailList.ordNo} <br> (${detailList.ftruckName})</td>
                                        </c:when>
                                    </c:choose>
                                 	<c:set var="temp" value="${detailList.ordNo}" />
	                           		<!-- 제품 이름 -->
	                            	<td class="unit">${detailList.prodName}</td>
	                             	<!-- 수량-->
	                             	<td class="unit">${detailList.ordQty}개</td>
	                             	<!-- 주문 총 가격 -->
	                             	<td class="unit">${detailList.ordPrice}원</td>
	                             	<!-- 요청 사항 -->
	                             	<c:choose>
	                       	  	    	<c:when test="${detailList.ordReq eq null}">
	                             			<td class="unit">요청사항이 없습니다.</td>
	                             		</c:when>
	                             		
	                             		<c:when test="${detailList.ordReq ne null}">
	                             			<td class="unit">${detailList.ordReq}</td>
	                             		</c:when>
	                             	</c:choose>
	                             	<!-- 상태  -->
	                             	<c:choose>
	                             		<c:when test="${detailList.cookStat eq 0}">
	                             			<td class="quantity" style="color: #6262dd; font-weight: bold; font-family: Raleway, sans-serif; "> 대기중
	                             				<button type="button" class="btn btn-primary2" data-toggle="modal" data-id="${detailList.ordNo}" data-target="#exampleModal" data-whatever="@getbootstrap" onclick="exampleModal(this);">
	                             				<img src="/resources/img/chef2.png"></button>
	                                    	</td>
	                                	</c:when>
	                                       
	                               		<c:when test="${detailList.cookStat eq 1}">
	                                		<td class="quantity" style="color: #ea5f8b; font-weight: bold; font-family: Raleway, sans-serif; "> 조리중 
												<button type="button" class="btn btn-primary2" data-toggle="modal" data-id="${detailList.ordNo}" data-target="#exampleModal" data-whatever="@getbootstrap" onclick="exampleModal(this);">
												<img src="/resources/img/pan2.png"></button>
	                                   		</td>
	                               		</c:when>
	                               	
	                               		<c:when test="${detailList.cookStat eq 2}">
	                               			<td class="quantity" style="font-weight: bold; font-family: Raleway, sans-serif; "> 배달중
												<button type="button" class="btn btn-primary2" data-toggle="modal" data-id="${detailList.ordNo}" data-target="#exampleModal" data-whatever="@getbootstrap" onclick="exampleModal(this);">
												<img src="/resources/img/tray.png"></button>
	                                    	</td>
	                                	</c:when>
	                                	<c:when test="${detailList.cookStat eq 3}">
	                               			<td class="quantity" style="font-weight: bold; font-family: Raleway, sans-serif; "> 배달완료
												<button type="button" class="btn btn-primary2"  data-toggle="modal" data-id="${detailList.ordNo}" data-target="#exampleModal" data-whatever="@getbootstrap" onclick="exampleModal(this);">
													<img src="/resources/img/waiter.png">
												</button>
	                                    	</td>
	                                	</c:when>
	                            	</c:choose>
	                            	<td class="quantity">${detailList.dlvAddr}</td>
                           		</tr>
                          	</c:forEach>
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
 
	<!-- modal test 중 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="exampleModalLabel"> Change the status of your order </h4>
	      		</div>
	      		
		      	<div class="modal-body">
		      		<div class="form-group">
		      			<select class="form-control" name="cookStat" id="cookStat" onchange="time()">
		      				<option value=""> [조리중/ 배송중 / 배달완료] 중 하나를 선택해 주세요 </option>
							<option value="0"> 대기중 </option>
							<option value="1"> 조리중 </option>
							<option value="2"> 배송중 </option>
							<option value="3"> 배달완료 </option>
						</select > <select class="form-control" style="display: none;" id="time">
							<option value="">--</option>
							<option value="20">20분</option>
							<option value="30">30분</option>
							<option value="40">40분</option>
							<option value="50">50분</option>
							<option value="60">60분</option>
							<option value="70">70분</option>
						</select>
					</div>
					
						
					
					<div class="modal-footer">
		        		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        		<button type="button" class="btn btn-primary" id="changeBtn">Change</button>
		      		</div>
	    		</div>
	 	 	</div>
		</div>
	</div>
<!-- 모달 끝  -->
</body>
<script>

<!-- datepicker & licenseNoList -->
	
	var selectList = function A() {
		$("#licenseList").on("change", function() {
			var licenseNo = $("#licenseList option:selected").val();
// 			alert(licenseNo);
			$("#cal").datepicker({
				dateFormat: 'y/mm/dd',
			    changeMonth: true, 
			    dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
			    dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
			    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    maxDate: 0,
			    onSelect: function(dateText, inst, licenseNo){
// 			    	var licenseNo = $("#licenseList option:selected").val();
			    	$.ajax ({
			    		type: "post",
			            url: "/orderDetail2",
			            data: {
			                	"ordDate" : dateText,
			                	"licenseNo" : $("#licenseList option:selected").val()
			                  }, 
			            dataType : "json",
			            success : function(data) {
			            	// test중 나중에 지워야햄! -> 데이터 확인
// 			            	var jsondata = JSON.stringify(data);
// 							alert(jsondata);
							
							var rowLength = 0;
							var htmlObj = "";
							var htmlObj2 = "";
							var calselectList = data.orderDetailList;
							
							if (data != null && data != "") {
								rowLength = calselectList.length;
							}
								
							// 해당 날짜에 데이터가 있을 경우,
							if(rowLength > 0) {
								for(var i = 0; i < rowLength; i++) {
									
									var licenseNo = calselectList[i].licenseNo;
									var ordNo = calselectList[i].ordNo;
									var prodName = calselectList[i].prodName;
									var ordQty = calselectList[i].ordQty;
									var ordPrice = calselectList[i].ordPrice;
									var cookStat = calselectList[i].cookStat;
									var cookStatHangul;
									var ordDate = calselectList[i].ordDate;
									var ordDateCut = ordDate.substring(0,10);
									var date = new Date();
									var month = date.getMonth() + 1;
									var day = date.getDate();
									var year = date.getFullYear();
								
									if(month < 10 && day < 10) {
										month = '0' + month;
										day = '0' + day;
									}
								
									// 판매자가 오늘날짜로 다시 셀렉할 경우, 함수 호출 -> 다른 날짜 인식 안함
									if(ordDate.substring(0, 4) == year && ordDate.substring(5, 7) == month && ordDate.substring(8, 10)) {
										selectList();
									}
									
									// 표 부분
									switch (cookStat) {
										case 0:
											cookStatHangul = "대기중"
											break;
										case 1:
											cookStatHangul = "조리중"
											break;
										case 2:
											cookStatHangul = "배송중"
											break;
										case 3:
											cookStatHangul = "배달완료"
											break;
									}	//switch
									   
									htmlObj += "<tr class='table-info'>";
									htmlObj += "	<td class='unit'>" + ordNo + "</td>";
									htmlObj += "	<td class='unit'>" + prodName + "</td>";
									htmlObj += "	<td class='unit'>" + ordQty+"개</td>";
									htmlObj += "	<td class='unit'>" + ordPrice + "원</td>";
									htmlObj += "	<td class='quantity'>" + cookStatHangul + "</td>";
									htmlObj += "</tr>";
								} // for
									
								// 없을 경우,
							} else {
								htmlObj += "<tr class='table-info'>";
								htmlObj += "	<td class='unit' colspan='7'> 해당 날짜에는 데이터가 없습니다. </td>";
								htmlObj += "</tr>";
							}
							
							$("#pastOrder").html(htmlObj);
						} 
	           		})	//ajax
	           	}
			})
		})
	}
</script>
</html>