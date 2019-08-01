package com.foodtruck.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodtruck.service.EventService;
import com.foodtruck.service.FestivalService;
import com.foodtruck.service.FoodTruckService;
import com.foodtruck.service.ProductService;
import com.foodtruck.service.ReviewService;
import com.foodtruck.vo.EventVO;
import com.foodtruck.vo.FestivalVO;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.PageVO;
import com.foodtruck.vo.ProductVO;
import com.foodtruck.vo.ReviewVO;

@Controller
public class FoodTruckController {
	
	@Autowired
	private FoodTruckService foodtruckService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private ProductService productService;
	@Autowired
	private FestivalService festivalService;
	@Autowired
	private EventService eventService;
	
	// FoodTrcuk List - 리스트 형식
	@RequestMapping("/menuBoard")
	public String menuBoarPage(Model model, @RequestParam("pageNo") int pageNo, HttpServletRequest request) throws Exception {
		
		int NpageNo = 1;
		if (pageNo != 1) {
			NpageNo = (pageNo - 1) * 10 + 1;
		}
		
		List<FoodTruckVO> list = foodtruckService.getFoodTruckList(NpageNo);	//rownum된 푸드트럭 리스트
		List<FoodTruckVO> count = foodtruckService.getReviewCountList();
		
		// 푸드트럭에 맞게 리뷰 갯수 뿌려주기 
		for(int i=0; i<count.size(); i++) {
			exit :for(int j=0; j<list.size(); j++) {
				if(count.get(i).getFtruckNo().equals(list.get(j).getFtruckNo())) {
					list.get(j).setCount(count.get(i).getCount());
					break exit;
				}
			}
		}
		
		// 이벤트 작성한 푸드트럭은 리스트 형식에 이벤트반짝반짝 만들기
		List<EventVO> eventList = eventService.progressEvent();
		for(int i = 0; i < eventList.size(); i++) {
			exit :for(int j=0; j<list.size(); j++) {
				if(eventList.get(i).getFtruckNo().equals(list.get(j).getFtruckNo())) {
					list.get(j).setFtruckEvent(eventList.get(i).getEventTitle());
					list.get(j).setEventNo(eventList.get(i).getEventNo());
					list.get(j).setEventReg2(eventList.get(i).getEventReg2());
					break exit;
				}
			}
		}
		
		int pagecount = foodtruckService.getCountTruck();	//총 푸드트럭 개수
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("list", list);
		request.setAttribute("pagecount", pagecount);	//총 페이지 수
		return "foodtruck/menuBoard";
		
	}

	// FoodTruck List2 - 바둑판 형식
	@RequestMapping("/menuBoard2")
	public String menuBoarPage2(Model model, @RequestParam("pageNo") int pageNo, HttpServletRequest request) throws Exception {
		
		int NpageNo = 1;
		if (pageNo != 1) {
			NpageNo = (pageNo - 1) * 10 + 1;
		}
		
		// 푸드트럭에 맞게 리뷰 갯수 뿌려주기 
		List<FoodTruckVO> list = foodtruckService.getFoodTruckList(NpageNo);	//rownum된 푸드트럭 리스트
		List<FoodTruckVO> count = foodtruckService.getReviewCountList();
		for(int i=0; i<count.size(); i++) {
			exit :for(int j=0; j<list.size(); j++) {
				if(count.get(i).getFtruckNo().equals(list.get(j).getFtruckNo())) {
					list.get(j).setCount(count.get(i).getCount());
					break exit;
				}
			}
		}
		
		int pagecount = foodtruckService.getCountTruck();	//총 푸드트럭 개수
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("list", list);
		request.setAttribute("pagecount", pagecount);	//총 페이지 수
		return "foodtruck/menuBoard2";
		
	}

	// CategoryFood
	@RequestMapping("/CategoryFood")
	public String korFoodPage(Model model, @RequestParam("pageNo") int pageNo, HttpServletRequest request, 
							  @RequestParam("category") int category) throws Exception {
		
		PageVO vo = new PageVO();
		vo.setCategory(category);
		
		int NpageNo = 1;
		if(pageNo == 1) {
			pageNo = 1;
			vo.setPageNo(pageNo);	
		} else {
			NpageNo = (pageNo - 1) * 10 + 1;
			vo.setPageNo(NpageNo);	
		}
		
		// 푸드트럭에 맞게 리뷰 갯수 뿌려주기 
		List<FoodTruckVO> list=foodtruckService.getCategoryList(vo);
		List<FoodTruckVO> count = foodtruckService.getReviewCountList();
		for(int i=0; i<count.size(); i++) {
			exit :for(int j=0; j<list.size(); j++) {
				if(count.get(i).getFtruckNo().equals(list.get(j).getFtruckNo())) {
					list.get(j).setCount(count.get(i).getCount());
					break exit;
				}
			}
		}
		
		// 이벤트 작성한 푸드트럭은 리스트 형식에 이벤트반짝반짝 만들기
		List<EventVO> eventList = eventService.progressEvent();
		for(int i = 0; i < eventList.size(); i++) {
			exit :for(int j=0; j<list.size(); j++) {
				if(eventList.get(i).getFtruckNo().equals(list.get(j).getFtruckNo())) {
					list.get(j).setFtruckEvent(eventList.get(i).getEventTitle());
					list.get(j).setEventNo(eventList.get(i).getEventNo());
					list.get(j).setEventReg2(eventList.get(i).getEventReg2());
					break exit;
				}
			}
		}
		
		int pagecount=foodtruckService.getCategoryCountTruck(category);	//총 푸드트럭 개수
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("list",list);
	    request.setAttribute("pagecount", pagecount);
	    request.setAttribute("categoryno", category);
		return "foodtruck/CategoryFood";
		
	}

	// CategoryFood2
	@RequestMapping("/CategoryFood2")
	public String korFoodPage2(Model model, @RequestParam("pageNo") int pageNo, HttpServletRequest request, 
							   @RequestParam("category") int category) throws Exception {
		
		PageVO vo = new PageVO();
		vo.setCategory(category);
		int NpageNo = 1;
		if(pageNo == 1) {
			pageNo=1;
			vo.setPageNo(pageNo);	
		} else {
			NpageNo = (pageNo - 1) * 10 + 1;
			vo.setPageNo(NpageNo);	
		}
		
		// 푸드트럭에 맞게 리뷰 갯수 뿌려주기 
		List<FoodTruckVO> list=foodtruckService.getCategoryList(vo);
		List<FoodTruckVO> count = foodtruckService.getReviewCountList();
		for(int i=0; i<count.size(); i++) {
			exit :for(int j=0; j<list.size(); j++) {
				if(count.get(i).getFtruckNo().equals(list.get(j).getFtruckNo())) {
					list.get(j).setCount(count.get(i).getCount());
					break exit;
				}
			}
		}
		
		int pagecount=foodtruckService.getCategoryCountTruck(category);	//총 푸드트럭 개수
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("list",list);
		request.setAttribute("babo",list);
	    request.setAttribute("pagecount", pagecount);
	    request.setAttribute("categoryno", category);
	     
		return "foodtruck/CategoryFood2";
		
	}	
	
	// 푸드트럭 상세 정보보기
	@RequestMapping("/read")
	public String foodinfo(@RequestParam("ftruckNo") String ftruckNo, HttpServletRequest request) throws Exception {

	    FoodTruckVO vo = foodtruckService.getFoodTruck(ftruckNo);//푸드트럭 정보 호출
	    if(vo.getFtruckIntro() == null) {
	    	vo.setFtruckIntro("없음");
	    }
		
		if(vo.getFtruckAddr() == null) {
			vo.setFtruckAddr(vo.getFtruckAddr2());
		}
		
		List<ReviewVO> Rlist = reviewService.getReviewList(ftruckNo);		// 리뷰 정보 호출
		List<ProductVO> Plist = productService.getProductList(ftruckNo);	// 상품 정보 호출
		String img = vo.getFtruckImg();
		String reimg = img.replaceAll("\\\\", "/");
		vo.setFtruckImg(reimg);
		request.setAttribute("vo", vo);
		request.setAttribute("review", Rlist);
		request.setAttribute("product", Plist);
		return "foodtruck/detail";
		
	}

	// api를 이용하야 행사정보 가져오기
	@RequestMapping("/api")
	public String inputAddr(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 테이블정보를 불러온다
		List<FestivalVO> list2 = festivalService.getFestivalList();
		if (list2.size() != 0) {
			festivalService.deleteFestival();
		}
		
		//축제정보 가져오기 시작
		List<FestivalVO> list = new ArrayList<FestivalVO>();
		int num[] = { 1, 2, 3, 4, 5, 6, 7, 8, 31, 32 };

		for (int q = 0; q < num.length; q++) {
			try {
				Thread.sleep(300);
				int code = num[q];
				System.out.println(code);
				request.setCharacterEncoding("utf-8");
				response.setContentType("text/html; charset=utf-8");

				String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=";
				String serviceKey = "H%2F5lCacGTb8Gu0hK0t%2FZ%2BR04rZ7FtCgprC9i3gXHYFbGvnPOF1UikRkxLw07AXydV%2BN7SBJCExRUanyQ2DRgVQ%3D%3D";

				String parameter = "";
				// serviceKey = URLEncoder.encode(serviceKey,"utf-8");

				PrintWriter out = response.getWriter();
				Date date = new Date();
				SimpleDateFormat sdformat = new SimpleDateFormat("YYYYMMdd");
				String today = sdformat.format(date);
				// PrintWriter out = new PrintWriter(new OutputStream
				// Writer(response.getOutputStream(),"KSC5601"));
				// ServletOutputStream out = response.getOutputStream();
				parameter = parameter + "&" + "areaCode=" + code;
				parameter = parameter + "&" + "cat1=A02";
				parameter = parameter + "&" + "cat2=A0207";
				parameter = parameter + "&" + "eventStartDate=" + today;
				parameter = parameter + "&" + "eventEndDate=20191231";
				parameter = parameter + "&" + "pageNo=1&numOfRows=100";
				parameter = parameter + "&" + "arrange=B";
				parameter = parameter + "&" + "listYN=Y";
				parameter = parameter + "&" + "MobileOS=ETC";
				parameter = parameter + "&" + "MobileApp=aa";
				parameter = parameter + "&" + "_type=json";

				addr = addr + serviceKey + parameter;
				URL url = new URL(addr);

				//System.out.println(addr);

				// BufferedReader in = new BufferedReader(new
				// InputStreamReader(url.openStream(), "UTF-8"));
				InputStream in = url.openStream();
				// CachedOutputStream bos = new CachedOutputStream();
				ByteArrayOutputStream bos1 = new ByteArrayOutputStream();

				IOUtils.copy(in, bos1);
				in.close();
				bos1.close();

				String mbos = bos1.toString("UTF-8");

				byte[] b = mbos.getBytes("UTF-8");
				String s = new String(b, "UTF-8");
				out.println(s);

				/* json parsing */
				System.out.println("s=" + s);
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(s);
				JSONObject json = (JSONObject) obj;

				// json.put("data", data);
				// 지역별 행사정보 가져오기
				JSONObject js = (JSONObject) json.get("response");
				JSONObject jj = (JSONObject) js.get("body");
				JSONObject items = (JSONObject) jj.get("items");
				JSONArray jArray = (JSONArray) items.get("item");

				for (int j = 0; j < jArray.size(); j++) {
					JSONObject a = (JSONObject) jArray.get(j);
					FestivalVO vo = new FestivalVO();
					vo.setFesAddr(a.get("addr1").toString());
					vo.setFesName(a.get("title").toString());
					vo.setFesLatitude(a.get("mapx").toString());
					vo.setFesLongitude(a.get("mapy").toString());
					vo.setFesSdate(a.get("eventstartdate").toString());
					vo.setFesEdate(a.get("eventenddate").toString());
					vo.setFesTel(a.get("tel").toString());
					if ((String) a.get("firstimage") == null) {
						vo.setFesImg("empty");
					} else {
						vo.setFesImg((String) a.get("firstimage"));
					}
					if ((String) a.get("firstimage2") == null) {
						vo.setFesImg2("empty");
					} else {
						vo.setFesImg2((String) a.get("firstimage2"));
					}
					vo.setFesId(a.get("contentid").toString());
					vo.setFesContent("empty");
					list.add(vo);
				}
			} catch (Exception e) {
				System.out.println("");
			}
		}
		
		//상세정보 가져오기 시작
		for (int h = 0; h < list.size(); h++) {
			Thread.sleep(300);
			
            // 테이블이 비어있을때 insert실행
            request.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");

            String addr2 = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=";
            String serviceKey = "H%2F5lCacGTb8Gu0hK0t%2FZ%2BR04rZ7FtCgprC9i3gXHYFbGvnPOF1UikRkxLw07AXydV%2BN7SBJCExRUanyQ2DRgVQ%3D%3D";

            String parameter2 = "";

            PrintWriter out = response.getWriter();

            parameter2 = parameter2 + "&" + "MobileOS=ETC";
            parameter2 = parameter2 + "&" + "defaultYN=N";
            parameter2 = parameter2 + "&" + "addrinfoYN=N";
            parameter2 = parameter2 + "&" + "MobileApp=aa";
            parameter2 = parameter2 + "&" + "overviewYN=Y";
            parameter2 = parameter2 + "&" + "contentId=" + list.get(h).getFesId();
            parameter2 = parameter2 + "&" + "_type=json";
            addr2 = addr2 + serviceKey + parameter2;
            URL url = new URL(addr2);

            System.out.println(addr2);

            // BufferedReader in = new BufferedReader(new
            // InputStreamReader(url.openStream(), "UTF-8"));

            InputStream in2 = url.openStream();
            // CachedOutputStream bos = new CachedOutputStream();
            ByteArrayOutputStream bos2 = new ByteArrayOutputStream();
            IOUtils.copy(in2, bos2);
            //in2.close();
            //bos2.close();

            String mbos2 = bos2.toString("UTF-8");

            byte[] b = mbos2.getBytes("UTF-8");
            String s2 = new String(b, "UTF-8");
            out.println(s2);

            /* json parsing */
            System.out.println("s=" + s2);
            JSONParser parser = new JSONParser();
            Object obj2 = parser.parse(s2);
            JSONObject json2 = (JSONObject) obj2;

            // json.put("data", data);
            // 지역별 행사정보 가져오기
            JSONObject js2 = (JSONObject) json2.get("response");
            JSONObject jj2 = (JSONObject) js2.get("body");
            JSONObject items2 = (JSONObject) jj2.get("items");
            JSONObject items3 = (JSONObject) items2.get("item"); 
            String item4=   (String) items3.get("overview");
            list.get(h).setFesContent(item4);
         
         }     		
		for (int i = 0; i < list.size(); i++) {
			festivalService.IntsertFestival(list.get(i));
		}
		
		System.out.println("***** 축제정보 insert 완료 *****");

		return "nav/recommend";

	}
	
	//푸드트럭 업데이트
	@RequestMapping("updateFoodtruck")
	@ResponseBody
	public int updateFoodtruck(FoodTruckVO vo) throws Exception {
		
		if(vo.getFtruckImg().equals("none")) {
			FoodTruckVO fvo = foodtruckService.getFoodTruck2(vo.getLicenseNo());
			vo.setFtruckImg(fvo.getFtruckImg());
		}
		
		int num = foodtruckService.updateFoodTruck(vo);
		return num;
	}
	
}
