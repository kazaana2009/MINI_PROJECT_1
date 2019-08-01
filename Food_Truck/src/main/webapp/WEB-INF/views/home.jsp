<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>    
<html>
<jsp:include page="comm/header.jsp"></jsp:include>
<body>
<%@include file="comm/nav.jsp" %>
	<!--start Featured Product Area-->
	<div class="featured-product section fix">
		<div class="container">
			<div class="row">
				<div class="section-title">
					<h2>Weekly Featured FoodTrucks</h2>
					<div class="underline"></div>
				</div>
				<div class="col-sm-12">
					<!-- Featured slider Area Start -->
					<div class="feature-pro-slider owl-carousel">
						<!-- Single Product Start -->
						<c:forEach var="rank" items="${rank}" >
						<fieldset>
						<div class="product-item fix">
							<div class="product-img-hover">
								<!-- Product image -->
								<a href="/read?ftruckNo=${rank.ftruckNo}" class="pro-image fix"><img src="${rank.ftruckImg}" alt="featured" style="width: 240.5px;height: 180.14px;"/></a>
								<!-- Product action Btn -->
								<div class="product-action-btn">
									<a class="quick-view" href="#"><i class="fa fa-search"></i></a>
									<a class="favorite" href="#"><i class="fa fa-heart-o"></i></a>
									<a class="add-cart" href="#"><i class="fa fa-shopping-cart"></i></a>
								</div>
							</div>
							<div class="pro-name-price-ratting">
								<!-- Product Name -->
								<div class="pro-name">
									<a href="/read?ftruckNo=${rank.ftruckNo }">${rank.ftruckName}</a>
								</div>
								<!-- Product Ratting -->
								<div class="pro-ratting">
									<span style="width: ${rank.ftruckGrade*20}%"></span>
								</div>
								<!-- Product Price -->
								<div class="pro-price fix">
									<p>
										<span class="new">평점 : ${rank.ftruckGrade }</span>
									</p>
								</div>
							</div>
						</div>
						</fieldset>
						</c:forEach>
						<!-- Single Product End -->
					</div>
					<!-- Featured slider Area End -->
				</div>
			</div>
		</div>
	</div>
	<!--End Featured Product Area-->
	<!--start Featured Product Area-->
	<div class="featured-product section fix">
		<div class="container">
			<div class="row">
				<div class="section-title">
					<h2>New FoodTrucks</h2>
					<div class="underline"></div>
				</div>
				<div class="col-sm-12">
					<!-- Featured slider Area Start -->
					<div class="feature-pro-slider owl-carousel">
						<!-- Single Product Start -->
						<c:forEach var="newTruck" items="${newTruck}" >
						<fieldset>
						<div class="product-item fix">
							<div class="product-img-hover">
								<!-- Product image -->
								<a href="/read?ftruckNo=${newTruck.ftruckNo}" class="pro-image fix"><img src="${newTruck.ftruckImg}" alt="featured" style="width: 240.5px;height: 180.14px;"/></a>
								<!-- Product action Btn -->
								<div class="product-action-btn">
									<a class="quick-view" href="#"><i class="fa fa-search"></i></a>
									<a class="favorite" href="#"><i class="fa fa-heart-o"></i></a>
									<a class="add-cart" href="#"><i class="fa fa-shopping-cart"></i></a>
								</div>
							</div>
							<div class="pro-name-price-ratting">
								<!-- Product Name -->
								<div class="pro-name">
									<a href="/read?ftruckNo=${newTruck.ftruckNo }">${newTruck.ftruckName}</a>
								</div>
								<!-- Product Ratting -->
								<div class="pro-ratting">
									<span style="width: ${newTruck.ftruckGrade*20}%"></span>
								</div>
								<!-- Product Price -->
								<div class="pro-price fix">
									<p>
										<span class="new">평점 : ${newTruck.ftruckGrade }</span>
									</p>
								</div>
							</div>
						</div>
						</fieldset>
						</c:forEach>
						<!-- Single Product End -->
					</div>
					<!-- Featured slider Area End -->
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="comm/footer.jsp"></jsp:include>
</body>
</html>