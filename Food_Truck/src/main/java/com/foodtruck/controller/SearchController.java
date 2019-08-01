package com.foodtruck.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodtruck.service.FoodTruckService;
import com.foodtruck.service.SearchService;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.PageVO;
import com.foodtruck.vo.SearchPageVO;

@Controller
public class SearchController {
	@Autowired
	private SearchService searchService;

	/* geo */
	@RequestMapping(value = "/geo", produces = "application/json;charset=utf8")
	@ResponseBody
	public String geo(@RequestParam("latitude") String latitude, @RequestParam("longitude") String longitude,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("geo");

		String clientId = "hoDp6jNKOTpbBU2DrBpN";// ���ø����̼� Ŭ���̾�Ʈ ���̵�";
		String clientSecret = "m2_K4axumh";// ���ø����̼� Ŭ���̾�Ʈ ��ũ����";
		String location = longitude + "," + latitude;

		try {
			String addr = URLEncoder.encode(location, "utf-8");
			String apiURL = "https://openapi.naver.com/v1/map/reversegeocode?query=" + addr; // json
			// String apiURL = "https://openapi.naver.com/v1/map/reversegeocode.xml?query="
			// + addr; // xml
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;

			if (responseCode == 200) { // ���� ȣ��
				br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			} else { // ���� �߻�
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "utf-8"));
			}
			String inputLine;
			StringBuffer resp = new StringBuffer();

			while ((inputLine = br.readLine()) != null) {
				resp.append(inputLine);
			}
			br.close();

			String respStr = resp.toString();
			URLEncoder.encode(respStr, "UTF-8");

			/* json parsing */
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(respStr);
			JSONObject jObj = (JSONObject) obj;

			jObj = (JSONObject) jObj.get("result");

			JSONArray jarr = (JSONArray) jObj.get("items");
			jObj = (JSONObject) jarr.get(0);
			jObj = (JSONObject) jObj.get("addrdetail");
			String sigugun = (String) jObj.get("sigugun");
			sigugun = "{ \"sigugun\" :\"" + sigugun + "\"}";
			obj = parser.parse(sigugun);
			jObj = (JSONObject) obj;

			/*
			 * JSONObject robj = new JSONObject(); robj.put("sigugun", sigugun);
			 * System.out.println("��:" + robj);
			 */
			return jObj.toJSONString();

		} catch (Exception e) {
			System.out.println(e);
		}
		return null;

	}

	/* search */
	@RequestMapping("/search")
	public String search(@RequestParam("pageNo") int pageNo, @RequestParam("search") String searchStr, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(searchStr != "" && searchStr != null) {
			SearchPageVO vo = new SearchPageVO();
			vo.setSearchStr(searchStr);
			int NpageNo = 1;
			vo.setPageNo(pageNo);
			if (pageNo != 1) {
				NpageNo = (pageNo - 1) * 10 + 1;
				vo.setPageNo(NpageNo);
			}
			
			List<FoodTruckVO> list = searchService.getFoodTruckList(vo);
			for(int i=0;i<list.size();i++) {
				if(list.get(i).getFtruckAddr()==null) {
					String addr=list.get(i).getFtruckAddr2();
					list.get(i).setFtruckAddr(addr);			
				}
			}
			int pagecount = searchService.getCategoryCountTruck(searchStr);
			
			request.setAttribute("pageNo", pageNo);
			request.setAttribute("list", list);
			request.setAttribute("pagecount", pagecount);
			request.setAttribute("search", searchStr);
			
			return "foodtruck/searchBoard";
		}else {
			request.setAttribute("msg", "검색할 단어를 입력해주세요.");
			request.setAttribute("addr", "");
			return "comm/msg";
		}
		
		
		

	}

}
