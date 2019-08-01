<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.foodtruck.vo.SellerVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>상품</title>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">
	function modal(e) {
		var licenseNo = e.getAttribute("data-id");
		$.ajax({
			url : "/modal",
			data : {
				"licenseNo" : licenseNo
			},
			type : "post",
			dataType : "json",
			success : function(data) {
				$(".num").html('<input type="hidden" value="' + data.licenseNo + '" id="licenseNo">');
			}
		})
	}
	function ch() {
		var licenseNo = $("select").val();
		$.ajax({
			url : "/sellerProduct",
			data : {
				"licenseNo" : licenseNo
			},
			type : "post",
			dataType : "json",
			success : function(data) {
				$(".block-content collapse in").html();
			}
		})
		location.href = "sellerProduct?licenseNo=" + sel;
	}
	function add() {
		var name = document.getElementById("name").value;
		var price = document.getElementById("price").value;
		var content = document.getElementById("pcontent").value;
		var pimg = document.getElementById("path2").value;
		var origin = document.getElementById("origin").value;
		var licenseNo = document.getElementById("licenseNo").value;
		if(name==""){
			$('name').focus();
			alert("상품이름을 입력해주세요")
			return false;
		}else if(price==""){
			alert("가격을 입력해주세요")
			return false;
		}else if(content==""){
			alert("상품설명을 입력해주세요")
			return false;
		}else if(pimg=="none"){
			alert("이미지를 선택해주세요");
			return false;
		}else if(origin==""){
			alert("원산지를 입력해주세요")
			return false;
		}	
		$.ajax({
			url : "/insertProduct",
			data : {
				"licenseNo" : licenseNo,
				"prodName" : name,
				"prodPrice" : price,
				"prodContent" : content,
				"prodImg" : pimg,
				"prodOrgin" : origin
			},
			type : "post",
			dataType : "json",
			success : function(data) {
				if (data == 1) {
					alert("상품이 등록되었습니다")
				} else {
					alert("상품등록이 실패했습니다 관리자에게 문의해주세요!");
				}
				location.reload();
			}
		})
	}
	//상품등록 이미지 업로드
	function mm() {
	var formData = new FormData(document.getElementById("uploadForm"));	
	$.ajax({
		url : "/imggo", //컨트롤러 URL
		data : formData,
		dataType : 'json',
		processData : false,
		contentType : false,
		type : 'POST',
		success : function(data) {
			$('.img2').html('<input type="hidden" value="' + data.path + '" id="path2">');
		},
		error : function(jqXHR) {
			alert(jqXHR.responseText);
		}
	});

}
	//상품수정 이미지 업로드
	function mm2() {
		var formData = new FormData(document.getElementById("uploadForm2"));
		$.ajax({
			url : "/imggo", //컨트롤러 URL
			data : formData,
			dataType : 'json',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				$('.img5').html('<input type="hidden" value="' + data.path + '" id="path3">');
			},
			error : function(jqXHR) {
				alert(jqXHR.responseText);
			}
		});

	}
	//상품 디테일 모달창 진입시
	function proInfo(a) {
		var prodNo = a.getAttribute("data-id2");
		$.ajax({
			url : "/productInfo",
			data : {
				"prodNo" : prodNo
			},
			dataType : 'json',
			type : 'POST',
			success : function(data) {
				
				$('.imgInfo').html('<img data-src="holder.js/260x180" alt="260x180" style="width: 100%; height: 180px;" src="'+data.prodImg+'">');
				$('.nameInfo').html('<input type="text" style="width: 350px;" id="na" value="'+data.prodName+'">');
				$('.priceInfo').html('<input type="text" style="width: 350px;" id="pr" value="'+data.prodPrice+'">');
				$('.contentInfo').html('<textarea rows="5" cols="8" style="width: 350px;" id="pcon">'+data.prodContent+'</textarea>');
				$('.regionInfo').html('<textarea rows="5" cols="8" style="width: 350px;" id="porg">'+data.prodOrgin+'</textarea>');
				$('.num2').html('<input type="hidden" value="'+data.prodNo+'" id="pno">');
				$('.img5').html('<input type="hidden" value="'+data.prodImg+'" id="path3">');
			},
			error : function(jqXHR) {
				alert("에러");
			}
		})
	}
	
function update(){
	var upproimg =document.getElementById("path3").value;
	var na=document.getElementById("na").value;
	var pr=document.getElementById("pr").value;
	var pcon=document.getElementById("pcon").value;
	var porg=document.getElementById("porg").value;
	var pno1=document.getElementById("pno").value;
	$.ajax({
		url : "/productUpdate",
		data : {
			"prodImg" : upproimg,
			"prodName" : na,
			"prodPrice" : pr,
			"prodContent" : pcon,
			"prodOrgin" : porg,
			"prodNo":pno1
		},
		dataType : 'json',
		type : 'POST',
		success : function(data) {
			if(data==1){
			alert("수정되었습니다!");
			location.reload();
				}
			}
		})
}	

function del(){
	var pno=document.getElementById("pno").value;
	
	if(confirm("정말로 삭제하시겟습니까? 삭제한 데이터는 복구가 불가능합니다.")==true){
		$.ajax({
			url:"/productDelete",
			data:{
				"prodNo":pno
			},
			dataType : 'json',
			type : 'POST',
			success : function(data) {
				if(data==1){
					alert("상품이 삭제되었습니다.");
					location.reload();
				}
			}
		})
	}
}
</script>
<style>
.row-fluid [class*="span"] {
	display: block;
	float: left;
	width: 100%;
	min-height: 30px;
	margin-left: 0.12766%;
	*margin-left: 0.12766%;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box
}

.gfd {
	margin-left: 60px;
}
</style>
</head>
<%@include file="../comm/header2.jsp"%>
<body>
	<%
		List<SellerVO> list = (List<SellerVO>) request.getAttribute("list");
	%>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3" id="sidebar">
				<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
					<li><a href="/sellerMain?licenseNo=${licenseNo}"> <i
							class="icon-chevron-right"></i>주문 및 예약·배달
					</a></li>
					<li><a href="/sellerCalendar?licenseNo=${licenseNo}"><i
							class="icon-chevron-right"></i>매출 통계</a></li>
					<li class="active"><a
						href="/sellerProduct?licenseNo=${licenseNo}"><i
							class="icon-chevron-right"></i>내 푸드트럭 메뉴</a></li>
					<li><a href="/sellerInfo?licenseNo=${licenseNo}"><i
							class="icon-chevron-right"></i>내 푸드트럭 설정</a></li>
				</ul>
			</div>
			<div class="span9" id="content">
				<!-- morris stacked chart -->
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">나의 상품&nbsp;&nbsp;&nbsp;&nbsp;
							</div>
							<div class="muted pull-right">
								<button class="btn" style="margin-top: -5px;"
									data-toggle="modal" data-target="#tutorialsplaneModal"
									data-id="${licenseNo}" onclick="modal(this)">상품 등록하기</button>
							</div>
						</div>
						<div class="block-content collapse in">
							<div class="gfd">
								<!-- 상품 리스트 뿌려주기  1행 MAX 4개 상품 -->
								<c:forEach items="${list2}" var="all">
									<div class="span3">
										<a href="#tutorialsplaneModal2" class="thumbnail"> <img
											data-src="holder.js/260x180" alt="260x180"
											style="width: 260px; height: 180px;" src="${all.prodImg}"
											data-toggle="modal" data-target="#tutorialsplaneModal2"
											onclick="proInfo(this)" data-id2="${all.prodNo}">
										</a>
										<div align="center">
											<table>
												<tr>
													<td><h5>${all.prodName}(&#8361;${all.prodPrice})</h5></td>
												</tr>
											</table>
										</div>
									</div>
								</c:forEach>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 상품등록 모달창 -->
	<div id="tutorialsplaneModal" class="modal fade" role='dialog'
		style="display: none; z-index: 1080;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">상품 등록하기</h4>
				</div>
				<div class="modal-body" style="margin-left: 10px;">
					<form class="form-horizontal" name="addProduct"
						enctype="multipart/form-data" id="uploadForm">
						<table border=1 class="table table-striped table-bordered">
							<tr>
								<td align="center" style="width: 100px;">상품이름</td>
								<td colspan=3><input type="text" style="width: 350px;"
									id="name" ></td>
							</tr>
							<tr>
								<td align="center">상품 가격</td>
								<td colspan=3><input type="text" style="width: 350px;"
									id="price"></td>
							</tr>
							<tr>
								<td rowspan=3>상품 설명</td>
								<td rowspan=3 colspan=3><textarea rows="5" cols="8"
										style="width: 350px;" id="pcontent"></textarea></td>
							</tr>
							<tr></tr>
							<tr></tr>
							<tr>
							<tr>
								<td>이미지 파일</td>
								<td colspan=3 id="mg" style="width: 350px;">
								<input class="input-file uniform_on" id="img"
												type="file" name="img" enctype="multipart/form-data"
												onchange="mm()">
							</tr>


							<tr>
								<td rowspan=2>원산지</td>
								<td rowspan=2 colspan=3><textarea rows="5" cols="5"
										style="width: 350px;" id="origin"></textarea></td>
							</tr>
							<tr></tr>
							
							
						</table>
						<div class="num"></div>
						<div class="img2"></div>
					</form>
				</div>

				<div class="modal-footer">
					<button class="btn btn-default" onclick="add()">등록하기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="cl()">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 상품등록 모달창 끝 -->
	<!-- 상품 디테일 모달창 -->
	<div id="tutorialsplaneModal2" class="modal fade" role='dialog'
		style="display: none; z-index: 1080;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">상품 정보</h4>
				</div>
				<div class="modal-body" style="margin-left: 10px;">
					<form class="form-horizontal" name="addProduct"
						enctype="multipart/form-data" id="uploadForm2">
						<table border=1 class="table table-striped table-bordered">
							<tr>
								<td rowspan="2">이미지 파일</td>
								<td><div class="imgInfo"></div></td>
							</tr>
							<tr>
								<td colspan=3 id="mg" style="width: 100px;"><input
									type="file" style="width: 350px;" name="img"
									enctype="multipart/form-data" onchange="mm2()"></td>
							</tr>
							<tr>
								<td align="center" style="width: 100px;">상품이름</td>
								<td colspan=3><div class="nameInfo"></div></td>
							</tr>
							<tr>
								<td align="center">상품 가격</td>
								<td colspan=3><div class="priceInfo"></div></td>
							</tr>
							<tr>
								<td rowspan=3>상품 설명</td>
								<td rowspan=3 colspan=3><div class="contentInfo"></div></td>
							</tr>
							<tr></tr>
							<tr></tr>
							<tr>
							<tr>
								<td rowspan=2>원산지</td>
								<td rowspan=2 colspan=3 class="regionInfo"></td>
							</tr>
							<tr></tr>
						</table>
						<div class="num2"></div>
						<div class="img5"></div>
					</form>
				</div>

				<div class="modal-footer">
					<button class="btn btn-default" onclick="update()">수정하기</button>
					<button class="btn btn-default" onclick="del()">삭제하기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 상품디테일 모달창 끝 -->
</body>

</html>