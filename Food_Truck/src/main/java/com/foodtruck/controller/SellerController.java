package com.foodtruck.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodtruck.service.FestivalService;
import com.foodtruck.service.FoodTruckService;
import com.foodtruck.service.ProductService;
import com.foodtruck.service.SellerService;
import com.foodtruck.vo.FestivalVO;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.MemberVO;
import com.foodtruck.vo.ProductVO;
import com.foodtruck.vo.SellerVO;

@Controller
public class SellerController {

	@Autowired
	SellerService sellerService;
	@Autowired
	ProductService productService;
	@Autowired
	FoodTruckService foodtruckService;
	@Autowired
	FestivalService festivalService;

	// 내 푸드트럭 관리 -> 내 푸드트럭 설정
	@RequestMapping("/sellerInfo")
	public String sellerInfo(@RequestParam(value = "licenseNo", required = false) String licenseNo,
							 HttpServletRequest request, HttpSession session, Model model) throws Exception {	
		
		String num = licenseNo;
		FoodTruckVO vo = new FoodTruckVO();
		vo = foodtruckService.getFoodTruck2(licenseNo);
		if (vo.getFtruckAddr() == null) {
			vo.setFtruckAddr(vo.getFtruckAddr2());
		}
		if (vo.getFtruckTel() == null) {
			vo.setFtruckTel("없음");
		}
		if (vo.getFtruckIntro() == null) {
			vo.setFtruckIntro("없음");
		}
		request.setAttribute("vo", vo);
		model.addAttribute("licenseNo", num);
		return "seller/Info";
	}

	// 새좌표 업데이트
	@RequestMapping("/updatePosition")
	@ResponseBody
	public int updatePosition(FoodTruckVO vo) throws Exception {
		int num = foodtruckService.updateTruckPosition(vo);
		return num;
	}
	
	// 내 푸드트럭 관리 -> 매출 통계
	@RequestMapping("/sellerCalendar")
	public String sellerCalendar(HttpSession session, HttpServletRequest request, Model model,
								 @RequestParam(value = "licenseNo", required = false) String licenseNo, SellerVO vo) throws Exception {
		
		String memId = (String) session.getAttribute("memberId");
		List<SellerVO> list = new ArrayList<SellerVO>();
		JSONObject jsonObject = new JSONObject(); // 푸드트럭 매출 최종
		JSONArray dateArray = new JSONArray(); // 푸드트럭 매출 json 배열
		JSONObject dateInfo = null; // 매출 정보
		if(memId != null) {
			if (licenseNo != null) {
				String num=licenseNo;
				list = (List<SellerVO>)sellerService.getPrice(num);
				model.addAttribute("licenseNo", num); 
				model.addAttribute("license", sellerService.getLicense(memId));
				for(SellerVO vvo : list) {
					dateInfo = new JSONObject();
					System.out.println("salesDate : " + vvo.getSalesDate());
					System.out.println("salesDate : " + vvo.getSumPrice());
					
					// 정보 입력(날짜, 매출)
					dateInfo.put("ordDate", vvo.getSalesDate());
					dateInfo.put("sumPrice", vvo.getSumPrice());
					
					// 입력한 정보를 배열에 담는다.
					dateArray.add(dateInfo);
				}
				
				// 전체의 jsonObject에 monthly 라는 이름으로 배열의 value값을 입력
				jsonObject.put("monthly", dateArray);
				System.out.println("state : " + foodtruckService.getFoodTruck2(num));
				request.setAttribute("state", foodtruckService.getFoodTruck2(num));
			}
			request.setAttribute("monthly", jsonObject.toJSONString());
			
			return "seller/calendar";
			
		} else return "sign/login";
		
	}
	
	// 마감
	@RequestMapping("/closeFoodTruck")
	public String closeFoodTruck(@RequestParam(value = "licenseNo", required = false) String licenseNo,
								 FoodTruckVO fvo, SellerVO svo, HttpSession session) {
		
		String memId = (String) session.getAttribute("memberId");
		String no = null;
		if (memId != null) {
			if (licenseNo != null) {
				no = licenseNo;
				sellerService.closeFoodTruck(fvo);
				System.out.println("test : " + sellerService.getPrice(no));
				if(sellerService.getPrice(no).isEmpty()) {
					System.out.println("insertinsertinsert");
					sellerService.insertPrice(svo);
				} else {
					System.out.println("updateupdateupdate");
					sellerService.updatePrice(svo);
				}
			}
		}
		return "redirect:/sellerCalendar?licenseNo="+no;
	}
	
	// 운영
	@RequestMapping("/openFoodTruck")
	public String openFoodTruck(@RequestParam(value = "licenseNo", required = false) String licenseNo,
								FoodTruckVO fvo, SellerVO svo, HttpSession session) {
		
		String memId = (String) session.getAttribute("memberId");
		String no = null;
		if (memId != null) {
			if (licenseNo != null) {
				no = licenseNo;
				sellerService.openFoodTruck(fvo);
			}
		}
		return "redirect:/sellerCalendar?licenseNo="+no;
	}
	
	// 내 푸드트럭 관리 -> 주문 및 예약 & 배달
	@RequestMapping("/sellerMain")
	public String sellerMain(@RequestParam(value = "licenseNo", required = false) String licenseNo,
							 HttpServletRequest request, Model model, HttpSession session) throws Exception {
		
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		if (mvo != null) {
			if (licenseNo == null) {
				List<SellerVO> list = sellerService.getLicense2(mvo.getMemberId());
				int count = list.size();
				if (count == 0) {
					List<LicenseVO> list2=sellerService.getCheckList(mvo.getMemberId());
					System.out.println("진입");
					if(list2.size()==0) {
						System.out.println("진입1");
						request.setAttribute("msg", "none");
					}else {
						System.out.println("진입2");
						request.setAttribute("Id", mvo.getMemberId());
						request.setAttribute("msg",list2.get(0).getAppMsg());
					}
					return "seller/null";
				} else {
					return "seller/ing";
				}
			} else {
				List<SellerVO> list = sellerService.getLicense(mvo.getMemberId());
				request.getSession().setAttribute("member", mvo);
				String num = licenseNo;
				
				// 해당 푸드트럭의 라이센스번호를 가져와서 해당 지역의 이름의 축제정보 가져오기
				FoodTruckVO vo = foodtruckService.getFoodTruck2(licenseNo);				
				if (vo.getFtruckAddr() == null) {
					vo.setFtruckAddr(vo.getFtruckAddr2());
				}
				System.out.println("현재 내위치는?="+vo.getFtruckAddr());
				// 주소의 앞부분 2자리까지 자르기
				String addr = vo.getFtruckAddr().substring(0, 2);
				// 주소로 축제 정보 리스트 가져오기
				List<FestivalVO> list3 = (List<FestivalVO>) festivalService.getFestivalList3(addr);
				
				System.out.println("축제정보의 리스트 사이즈값은 ="+list3.size());
				//만약 지역 축제정보가 5개 이상이라면
				if(list3.size()>=5) {
					System.out.println("축제정보가 5개이상이래");
					List<FestivalVO> finalList = new ArrayList<FestivalVO>();
					// 주소로 가져온 행사의 리스트 사이즈
					int size = list3.size();
					if (size >= 5) {
						int random = (int) (Math.random() * list3.size()); // 리스트 사이즈만큼의 숫자
						ArrayList<Integer> arr = new ArrayList<Integer>();
						arr.add(random);
						//선별된 랜덤값 으로 5번 while문 돌리기.
						while (true) {
							int flag = 0; // 중복인지 아닌지 판별하는 변수

							random = (int) (Math.random() * list3.size()); // 새로 넣을 값
							for (int i = 0; i < arr.size(); i++) {
								if (arr.get(i) == random) {
									flag = 1;
									break; // 새로 넣을 값이 리스트 안에 중복이면 빠져나감
								}
							}

							if (flag == 0) { // 만약에 중복 값이 없을 경우
								arr.add(random); // 리스트에 랜덤값 추가
							}

							if (arr.size() == 5)
								break; // 만약 리스트의 사이즈가 5와 같다면 무한루프 빠져나감
						}
						//랜덤 함수로 인해 선별된 숫자의 리스트 값을 FinalList에 저장
						for (int i = 0; i < arr.size(); i++) {
							finalList.add(i, list3.get(arr.get(i)));				
						}
						request.setAttribute("numlist", finalList.size()-1);
						request.setAttribute("list3", finalList);
						request.setAttribute("check", "Y");
					}
					//축제 정보가 5개 미만이고 0개 이상이라면
				}else if(list3.size()<5 && list3.size()>0){
					System.out.println("축제정보가 5개 이하면서 0이상이래");
					request.setAttribute("list3",list3);
					request.setAttribute("numlist", list3.size()-1);
					request.setAttribute("check", "Y");
				}else if(list3.size()==0){
					System.out.println("축제정보가 없대");
					List<FestivalVO> list4=new ArrayList<FestivalVO>();		
					FestivalVO vo2= new FestivalVO();
					vo2.setFesImg("none");
					vo2.setFesName("none");
					list4.add(0, vo2);				
					request.setAttribute("list3", list4);
					request.setAttribute("numlist", list4.size());
					request.setAttribute("check", "N");
				}
				
				//전체
				List<SellerVO> slist=sellerService.getTodayOrderList(num);
				//통계
				List<SellerVO> clist=sellerService.getTodayPayment(num);
				//배달
				List<SellerVO> dlist=sellerService.getTodayDlvList(num);
				//예약
				List<SellerVO> rlist=sellerService.getTodayRsvList(num);
				System.out.println(slist.size());
				System.out.println(clist.size());
				System.out.println(dlist.size());
				System.out.println(rlist.size());
				model.addAttribute("scount",slist.size());//현금 개수
				model.addAttribute("cdount",clist.size());//카드 개수
				model.addAttribute("dcount",dlist.size());//배달 개수
				model.addAttribute("rcount",rlist.size());//예약 개수
				
				model.addAttribute("licenseNo", num); // 사업자번호 하나
				model.addAttribute("license", list); // 사업자번호 여러개
				
				
				model.addAttribute("todayDlv",dlist);
				model.addAttribute("todayRsv",rlist);
				model.addAttribute("todayOrder", slist);//현금ㅇ
				model.addAttribute("payment", clist);//카드

				return "seller/main";
			}
			
		} else {
			return "sign/login";
		}
	}
	
	// 푸드트럭 등록 
	@RequestMapping("/insertFoodTruckForm")
	public String insertFoodTruckForm() {
		return "seller/insertFoodTruck";
	}
	
	// 푸드트럭 상품 등록
	@RequestMapping("/sellerProduct")
	public String sellerProduct(@RequestParam(value = "licenseNo") String licenseNo, HttpServletRequest request,
								Model model, HttpSession session) throws Exception {
		
		String memId = (String) session.getAttribute("memberId");
		if (memId != null) {
			FoodTruckVO vo=foodtruckService.getFoodTruck2(licenseNo);
			String ftno=vo.getFtruckNo();
			List<SellerVO> list = sellerService.getLicense(memId);
			List<ProductVO> list2 = productService.getProductList(ftno);
			request.setAttribute("list", list);
			request.setAttribute("licenseNo", licenseNo);
			request.setAttribute("list2", list2);
			return "seller/sellerProduct";
			
		} else {
			return "sign/login";
		}
	}

	@RequestMapping("/modal")
	@ResponseBody
	public HashMap<String, Object> modal(@RequestParam("licenseNo") String licenseNo) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("licenseNo", licenseNo);

		return map;
	}

	// 푸드트럭 등록
	@ResponseBody
	@RequestMapping("/insertFoodTruck")
	public int insertFoodTruck(Model model, HttpSession session, HttpServletRequest request, FoodTruckVO fvo) throws Exception, IOException {

		MemberVO mvo = (MemberVO) session.getAttribute("member");
		// License 테이블 insert
		LicenseVO lvo = new LicenseVO();
		lvo.setLicenseNo(fvo.getLicenseNo());
		lvo.setMemId(mvo.getMemberId());
		sellerService.insertLicense(lvo);
		System.out.println(fvo.getFtruckAddr());
		// Foodtruck 테이블 insert
		fvo.setFtruckTel(mvo.getMemberTel());
		fvo.setLicenseNo(lvo.getLicenseNo());
		fvo.setFtruckTel(mvo.getMemberTel());
		int num = sellerService.insertFoodTruck(fvo);

		return num;
	}
	
	// inserFoodTruck.jsp 에서 사업자 번호 중복 체크
	@ResponseBody
	@RequestMapping("/licenseNoCheck")
	public FoodTruckVO licenseNoCheck(HttpServletRequest request) {
		
		String licenseNo = request.getParameter("licenseNo");
		return sellerService.getFoodTruck(licenseNo);
		
	}

	
	@RequestMapping("/productMng")
	public String productMng(HttpSession session, HttpServletRequest request, Model model) {
		
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		if (!sellerService.getLicense(mvo.getMemberId()).isEmpty()) {
			model.addAttribute("license", sellerService.getLicense(mvo.getMemberId()));
			model.addAttribute("product", sellerService.getProductList(request.getParameter("licenseNo")));
			return "seller/productMng";
		} else {
			return "seller/insertFoodTruck";
		}
		
	}
	
	// 판매자 licenseNo로 푸드트럭 정보 가져오기
	@RequestMapping("/asd")
	@ResponseBody
	public HashMap<String, Object> foodtruckInfo(@RequestParam("licenseNo") String licenseNo) {
		
		HashMap<String, Object> map = new HashMap<>();
		FoodTruckVO vo = sellerService.getFoodtruckDtail(licenseNo);
		if (vo.getFtruckAddr() == null) {
			vo.setFtruckAddr(vo.getFtruckAddr2());
		}
		map.put("name", vo.getFtruckName());
		map.put("addr", vo.getFtruckAddr());
		map.put("img", vo.getFtruckImg());
		map.put("intro", vo.getFtruckIntro());
		map.put("tel", vo.getFtruckTel());
		map.put("dliver", vo.getFtruckDlvYn());
		map.put("reserve", vo.getFtruckRsvYn());
		map.put("category", vo.getCategory());
		String com = "";
		com += "<script type=\"text/javascript\">";
		com += "var geocoder = new daum.maps.services.Geocoder();\r\n" + "geocoder.addressSearch('" + vo.getFtruckAddr()
				+ "', function(result, status) {\r\n" + "     if (status === daum.maps.services.Status.OK) {\r\n"
				+ "        var coords = new daum.maps.LatLng(result[0].y, result[0].x);\r\n"
				+ "        var marker = new daum.maps.Marker({\r\n" + "            map: map,\r\n"
				+ "            position: coords\r\n" + "        });\r\n"
				+ "        var infowindow = new daum.maps.InfoWindow({\r\n"
				+ "            content: '<div style=\"width:150px;text-align:center;padding:6px 0;\">"
				+ vo.getFtruckName() + "</div>'\r\n" + "        });\r\n" + "        infowindow.open(map, marker);\r\n"
				+ "        map.setCenter(coords);\r\n" + "    } \r\n" + "});";
		com += "</script>";
		map.put("com", com);
		String info = "";

		return map;
	}
	//푸드트럭 요창 거부후 수정Btn 모달창 띄우기
	@RequestMapping("/fixTruck")
	@ResponseBody
	public HashMap<String, Object> fixTruck(@RequestParam("memId") String memId) throws Exception{
		System.out.println(memId);
		HashMap<String, Object> map = new HashMap<>();
		FoodTruckVO vo =new FoodTruckVO();
		vo=sellerService.getFoodTruckInfo(memId);
		map.put("licenseNo", vo.getLicenseNo());
		map.put("ftruckName", vo.getFtruckName());
		map.put("ftruckAddr", vo.getFtruckAddr2());
		map.put("category", vo.getCategory());
		map.put("ftruckDlvYn", vo.getFtruckDlvYn());
		map.put("ftruckRsvYn", vo.getFtruckRsvYn());
		map.put("memId", memId);
		return map;	
	}

	//푸드트럭 요창 거부후 수정Btn 모달창 띄우기-> 수정하기
	@RequestMapping("updateFoodTruck2")
	@ResponseBody
	public int updateFoodTruck2(Model model, HttpSession session, HttpServletRequest request, FoodTruckVO fvo,@RequestParam("memId") String memId,@RequestParam("pastlicenseno") String pastlicenseno) throws Exception {
		int num=0;	
		System.out.println(fvo.getFtruckName());
		System.out.println(fvo.getCategory());
		System.out.println(fvo.getFtruckDlvYn());
		System.out.println(fvo.getFtruckAddr2());
		System.out.println(fvo.getFtruckImg());
		System.out.println(fvo.getFtruckRsvYn());
		System.out.println(fvo.getLicenseNo());
		LicenseVO lvo = new LicenseVO();
		String stat="I";
		lvo.setLicenseNo(fvo.getLicenseNo());
		lvo.setAppStat(stat);
		lvo.setMemId(memId);
		sellerService.fixUpdate(lvo);
		FoodTruckVO vo= foodtruckService.getFoodTruck2(pastlicenseno);
		fvo.setFtruckNo(vo.getFtruckNo());
		num=sellerService.fixUpdateFoodtruck(fvo);
		
		return num;
	}
}
