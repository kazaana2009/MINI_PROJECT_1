<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.foodtruck.vo.ProductVO"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<jsp:include page="../comm/header.jsp"></jsp:include>
<%@include file="../comm/nav.jsp"%>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<!-- 소스시작  -->
<script type="text/javascript">
   $(function() {

      var link = null;
      link = totalPrice;

      function totalPrice() {
         // 최종 가격 뿌려주는 곳
         $(".sumPriceResult").html(function() {
            var i = $(".qtyadd").index(this);
            var ePrice = Number(0);
            $(".sumResult:eq(" + i + ")").html(function() {
               $(".sumResult").each(function() {
                  ePrice += Number($(this).text());
                  test = ePrice;
               });
            });
            return test;
         });
          var box = Number($(".sumPriceResult").html());
          var box2 = "<input type='hidden' name='sumPrice'>";
             // div의 id값      
             $("#sumPrice").html(box2)
          var box3 = $('input[name="sumPrice"]').val(box);
      };

      test = Number(0);

      // 수량 +
      $(".qtyadd").click(
            function() {
               var sum = Number(0);
               var i = $(".qtyadd").index(this);
               var qty = $(".qty:eq(" + i + ")").val();
               qty = $(".qty:eq(" + i + ")").val(qty * 1 + 1).val();
               var price = $(".price:eq(" + i + ")").val();
               sum = parseInt(qty * price);
               $(".sumResult:eq(" + i + ")").html(sum);
               console.log("----------------------------인덱스" + i + "더하는중----------------------------");
               console.log("인덱스번호" + i + " : " + "상품 갯수 " + " : " + qty+ " 상품 가격 " + " : " + price + " = " + " 합계 " + " : " + sum); 
               link();
            });

      // 수량 - 
      $(".qtydel").click(
            function() {
               i = $(".qtydel").index(this);
               var qty = $(".qty:eq(" + i + ")").val();
               console.log(qty)
               if (qty > 0) {
                  qty = $(".qty:eq(" + i + ")").val(qty * 1 - 1).val()
                  var price = $(".price:eq(" + i + ")").val();
                  var sum = Number($(".sumResult:eq(" + i + ")").text());
                  sum -= price;
                  $(".sumResult:eq(" + i + ")").html(sum);
                  console.log("----------------------------인덱스" + i + "빼는중----------------------------");
                  console.log("인덱스번호" + i + " : " + "상품 갯수 " + " : " + qty + " 상품 가격 " + " : " + price + " = " + " 합계 " + " : " + sum);
                  link();
               } else {
                  qty = Number(0)
                  $(".sumResult:eq(" + i + ")").html(0)
                  link();
               }
      });
      
      // 유효성 체크 부분(주문자 이름 / 주문자 연락처)
      $("#signup-form").on("submit", function() {
         // 주문자 이름
         var ordName = $("#ordName").val();
         if(ordName == "") {
            alert("주문자 이름을 입력해 주시기 바랍니다.");
            $("#ordName").focus();
            return false;
         };
         
         // 주문자 연락처          
         var ordTel = $("#ordTel").val();
         if(ordTel == "") {
            alert("주문자 연락처를 입력해 주시기 바랍니다.");
            $("#ordTel").focus();
            return false;
         };
         
         // 예약 하기 버튼, 시간 체크 유효성 검사
         var ordDlyYn = $('input:radio[name=ordDlyYn]').is(':checked');
         if(ordDlyYn == false) {
            alert("예약하기나, 배달하기 버튼을 클릭해 주세요 :-)");
            return false;
         }
         
         var ordRsvDate1 = $("#ordRsvDate1 option:selected").val();
         var ordRsvDate2 = $("#ordRsvDate2 option:selected").val();
         
         if( $('input:radio[id=res]').is(':checked')==true){
        	 if(ordRsvDate1 == "" || ordRsvDate2 == "") {
                 console.log(ordRsvDate1);
                 alert("시간을 체크해주시기 바랍니다 :-)");
                 return false;
              } 
         }
        
         
         return true;
      })
      
      
      $("#ordTel").on("keyup", function() {
         var phone = $("#ordTel").val();
         var phoneHyphen = "";
         
         if(phone.length > 13) {
            $("#ordTel").focus();
            alert("핸드폰 번호 자릿수를 확인해주시기 바랍니다.");
            return false;
         }
         
         if(phone.length == 11) {
            phoneHyphen += phone.substr(0, 3);
            phoneHyphen += "-";
            phoneHyphen += phone.substr(3, 4);
            phoneHyphen += "-";
            phoneHyphen += phone.substr(7);
            $("#ordTel").val(phoneHyphen);
         }
         
         if(!((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || (event.keyCode == 8) || (event.keyCode == 9))) {
            $("#ordTel").val("");
            alert("핸드폰 번호는 숫자로 입력하셔야 합니다 :-)");
            return false;
         };
      })   
   });
   
   $(function() {
	      $("#res").change(function() {
	         var select = document.getElementById("time");
	         var addr = document.getElementById("addr");
	         addr.style.display = 'none';
	         select.style.display = 'block';

	      })
	      $("#dly").change(function() {
	         var select = document.getElementById("time");
	         select.style.display = 'none';
	         var addr = document.getElementById("addr");
	         addr.style.display = 'block';
	      })

	   });	
   
   $(function() {
	   $(".check").click(function() {
		   var price =  $('input[name="sumPrice"]').val();	//현재 총금액
		   var mmmm = $('input:text[name=useM]').val();		//사용한 마일리지
	   		$("#mileage").html("&nbsp;&nbsp;"+mmmm)			//할인금액에 뿌려주기만함
	   		price = (Number(price-mmmm))
	   		$(".sumPriceResult").html(price)
	   		var discount = Number($('input[name="sumPrice"]').val(price))
	   })
   })
   
</script>
<form action="/orderRegit" id="signup-form" onsubmit="return validation();">
   <%
      @SuppressWarnings("unchecked")
      List<ProductVO> list = (List<ProductVO>) request.getAttribute("list");
   %>
   <input type="hidden" name="licenseNo" value="<%=list.get(0).getLicenseNo()%>">
   <%
      String ftruckDlvYn = (String) request.getAttribute("ftruckDlvYn");
   %>   
   <section class="cart-page page fix">
      <!--Start Cart Area-->
      <div class="container">
         <div class="row2">
         <!-- order 테이블에 들어갈 데이터들 -->
            <div class="col-sm-6 col-md-5">
               <div class="product">
                  <h2>Please order</h2>
                  <div>
                  <% if(mvo != null) { %>
                     <%if(ftruckDlvYn.equals("Y")) { %>
                        <input type="radio" name="ordDlyYn" value="N" id="res" style="width: 50px; margin-left: 100px; float: left;">예약하기
                     	<input type="radio" name="ordDlyYn" value="Y" style="width: 50px;" id="dly"> 배달하기 
                  	 <% } else { %>
                  		 <input type="radio" name="ordDlyYn" value="N" id="res" style="width: 50px; margin-left: 150px; float: left;">예약하기 	 
                  	 <% }
               	  	 } else { %>
                  	 	<input type="radio" name="ordDlyYn" value="N" id="res" style="width: 50px; margin-left: 150px; float: left;">예약하기
                  	<% } %>
                  </div><br>
                  
                  <div align="right" id="time" style="display: none"> 예약시간 : 
                     <select style=" width: 50px;" name="ordRsvDate1" id="ordRsvDate1">
                        <option value="">--</option>
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>   
                     </select>
                     
                     <select style=" width: 50px;" name="ordRsvDate2" id="ordRsvDate2">
                        <option value="">--</option>
                        <option value="00">00</option>
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>                  
                     </select>분 뒤
                  </div>
                  
                  <% if(mvo != null) {  %>
                     <label> 회원 아이디</label>
                     <input type="text" name="memId" value="<%=mvo.getMemberId()%> " readonly="readonly">
                     <input type="hidden" name="memId2" value="<%=mvo.getMemberId()%>">
                  <% } %>
                  
                  <label>주문자 이름<span>*</span></label>
                  <input type="text" name="ordName" id="ordName">
                  <label>주문자 연락처<span>*</span></label>
                  <input type="text" name="ordTel" id="ordTel">
                  <div style="display: none;" id="addr">
                     <label>주소<span>*</span></label> 
                     <input type="text" name="dlvAddr1" id="sample5_address" placeholder="주소검색을 클릭해주세요">
                     <input type="text" name="dlvAddr2" placeholder="나머지 주소를 입력해주세요">
                     <input type="button" class="btn" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
                     <div id="map" style="width: 100%; height: 300px; margin-top: 10px; display: none"></div>
                     <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
                     <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2a898d01cf109199d2b5c34d8e1c5835&libraries=services"></script>
                     <script>
                        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                           mapOption = {
                              center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
                              level : 3 // 지도의 확대 레벨
                           };
                     
                        //지도를 미리 생성
                        var map = new daum.maps.Map(mapContainer, mapOption);
                        //주소-좌표 변환 객체를 생성
                        var geocoder = new daum.maps.services.Geocoder();
                        //마커를 미리 생성
                        var marker = new daum.maps.Marker({
                           position : new daum.maps.LatLng(37.537187, 127.005476),
                           map : map
                        });
                     
                     
                        function sample5_execDaumPostcode() {
                           new daum.Postcode({
                              oncomplete : function(data) {
                                 // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                                 var fullAddr = data.address; // 최종 주소 변수
                                 var extraAddr = ''; // 조합형 주소 변수
                     
                                 // 기본 주소가 도로명 타입일때 조합한다.
                                 if (data.addressType === 'R') {
                                    //법정동명이 있을 경우 추가한다.
                                    if (data.bname !== '') {
                                       extraAddr += data.bname;
                                    }
                                    // 건물명이 있을 경우 추가한다.
                                    if (data.buildingName !== '') {
                                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                                    }
                                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                                    fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                                 }
                     
                                 // 주소 정보를 해당 필드에 넣는다.
                                 document.getElementById("sample5_address").value = fullAddr;
                                 // 주소로 상세 정보를 검색
                                 geocoder.addressSearch(data.address, function(results, status) {
                                    // 정상적으로 검색이 완료됐으면
                                    if (status === daum.maps.services.Status.OK) {
                     
                                       var result = results[0]; //첫번째 결과의 값을 활용
                     
                                       // 해당 주소에 대한 좌표를 받아서
                                       var coords = new daum.maps.LatLng(result.y, result.x);
                                       // 지도를 보여준다.
                                       mapContainer.style.display = "block";
                                       map.relayout();
                                       // 지도 중심을 변경한다.
                                       map.setCenter(coords);
                                       // 마커를 결과값으로 받은 위치로 옮긴다.
                                       marker.setPosition(coords)
                                    }
                                 });
                              }
                           }).open();
                        }
                     </script>
                  </div>                  
                  <label>주문 요청 사항</label>
                  <textarea name="ordReq" id="ordReq" rows="5" ></textarea>
               </div><br><br>
            </div>
         </div>
         
         <div class="row">
         <!-- 수량 부분  -->
            <div class="col-sm-12">
               <div class="table-responsive">
                  <table class="table cart-table">
                     <thead class="table-title">
                        <tr>
                           <th class="produ">제품</th>
                           <th class="namedes">제품이름 &amp; 제품설명</th>
                           <th class="unit">가격</th>
                           <th class="quantity">수량</th>
                           <th class="valu">총가격</th>
                        </tr>
                     </thead>
                     
                     <tbody>
                        <%
                           for (int i = 0; i < list.size(); i++) {
                        %>
                        <tr class="table-info">
                           <td class="produ"><a href="#"><img alt="" src="<%=list.get(i).getProdImg()%>"></a></td>
                           <td class="namedes">
                              <h2><a href="#"><%=list.get(i).getProdName()%></a></h2>
                              <p><%=list.get(i).getProdContent()%></p>
                           </td>

                           <td class="unit"><h5><%=list.get(i).getProdPrice()%></h5></td>
                           <td class="quantity">
                              <input type="hidden" name="prodNo" value="<%=list.get(i).getProdNo()%>">
                              <input type="button" value=" - " class="qtydel">
                              <input type="text" class="qty" name="ordQty" value="0" size="3">
                              <input type="button" value=" + " class="qtyadd">
                              <input type="hidden" class="price" name="ordPrice" value="<%=list.get(i).getProdPrice()%>">
                              <input type="hidden" name="prodName" value="<%=list.get(i).getProdName() %>" >
                           </td>
                           <td class="valu">
                              <h5>
                                 <div class="sumResult"></div>
                              </h5>
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
         <!-- 결제수단 선택  -->
         <div class="col-sm-6 col-md-7">
            <div class="coupon">
               <h3>결제수단 선택</h3>
               <div>
                  <input type="radio" name="payment" value="0" checked="checked">&nbsp;&nbsp;&nbsp;푸드트럭에서 결제하기&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="radio" name="payment" value="1">&nbsp;&nbsp;&nbsp;신용카드
               </div><br><br><br>
               <% if(mvo != null) {  %>
               	   <div>
	               		보유 마일리지 : <input type="text" readonly="readonly" value="${mileage}" style="border: 0px; background-color:#ebebeb"><br><br>
	               		사용 마일리지 : <input type="text" name="useM" style="border: 0px;"><input type="button" value="적용" class="check" style="padding-bottom: 2px">
	               </div>
               <% } %>
            </div>
         </div>

         <div class="col-sm-6 col-md-5">
            <div class="proceed fix">
               <div class="total">
                  <h5> 
                     	할인 금액
                     	<span id="mileage"></span><br><br>          
                  		총 금액 
                  		<span class="sumPriceResult"></span>
                     	<div id="sumPrice"></div>
                  </h5>
               </div>
            </div>
              <div class="orderForm">
                  <input type="submit" value="결제하기"><br><br>
              </div>
         </div>
      </div>
   </section>
   <!--End Cart Area-->
   <jsp:include page="../comm/footer.jsp"></jsp:include>
</form>
</body>
</html>