<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<jsp:include page="../comm/header.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<!-- 소스시작  -->
<script type="text/javascript">
	alert("주문이 완료 되었습니다.");
</script>
<body>

	<%@include file="../comm/nav.jsp"%>
	<%String dlvAddr=(String)request.getAttribute("dlvAddr"); %>
	<!-- test -->
	<div></div>
	<section class="cart-page page fix">
		<!--Start Cart Area-->
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="table-responsive">
						<table class="table cart-table">
							<thead class="table-title">
								<tr>
									<th class="ordNo">주문 번호</th>
									<th class="ordName">이름</th>
									<th class="ordTel">전화 번호</th>
									<th class="ordDate">주문일</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="unit">${ordNo}</td>
									<td class="unit">${ordName}</td>
									<td class="unit">${ordTel}</td>
									<td class="unit">${ordDate}</td>
								</tr>
							</tbody>
							<thead class="table-title" style="<%=dlvAddr.equals("none") ? "display: none;" : ""%>">
								<tr>
									<th class="ordReq" colspan="4">배달주소</th>
								</tr>
							</thead>
							<tbody style="<%=dlvAddr.equals("none") ? "display: none;" : ""%>">
								<tr>
									<td class="unit" colspan="4"><%=dlvAddr%></td>
									</tr>
							</tbody>
							<thead class="table-title">
								<tr>
									<th class="ordReq" colspan="4">요구 사항</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${ordReq == null}">
									<tr>
										<td class="unit" colspan="4">요청하신 주문 사항이 없습니다 :-)</td>
									</tr>
								</c:if>
								<tr>
									<td class="unit" colspan="4">${ordReq}</td>
								</tr>
							</tbody>
							<thead class="table-title">
								<tr>
									<th class="prodName" colspan="2">상품명</th>
									<th class="ordQty">수량</th>
									<th class="ordPrice">가격</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items='${orderInfolist}' var="orderInfolist">
									<tr class="table-info">
										<td class="unit" colspan="2">${orderInfolist.prodName}</td>
										<!-- 상품 갯수  -->
										<td class="unit">${orderInfolist.ordQty}개</td>
										<!-- 제품 가격 -->
										<td class="unit">${orderInfolist.ordPrice}원</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="col-sm-6 col-md-7"></div>
					<div class="col-sm-6 col-md-5">
						<div class="proceed fix">
							<div class="total">
								<h6>
									총 금액 <span class="totalPriceTest">${sumPrice}</span>
								</h6>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!--End Cart Area-->

	<br>
	<br>
	<br>

	<jsp:include page="../comm/footer.jsp"></jsp:include>

</body>
</html>