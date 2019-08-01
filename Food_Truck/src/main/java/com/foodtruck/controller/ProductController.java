package com.foodtruck.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.foodtruck.service.FoodTruckService;
import com.foodtruck.service.ProductService;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.ProductVO;

@Controller
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	MappingJackson2JsonView jsonView;
	@Autowired
	private ProductService productService;
	@Autowired
	private FoodTruckService foodtruckService; 
	
    @RequestMapping("/insertProduct")
    @ResponseBody
    public int insertProduct(ProductVO vo) throws Exception {
        String licenseNo=vo.getLicenseNo();
        FoodTruckVO vo1=foodtruckService.getFoodTruck2(licenseNo);
        System.out.println("sdfsdf");
        vo.setFtruckNo(vo1.getFtruckNo());
        int num = productService.insertProduct(vo);
        return num;

    }

	@RequestMapping("/imggo")
	@ResponseBody
	public HashMap<String ,Object> img(MultipartHttpServletRequest request, HttpServletRequest req) throws IllegalStateException, IOException {

		String user = System.getProperty("user.dir");
		String path1 = "";
		path1 += user;
		System.out.println("이미지경로로로로롤로"+request.getFileNames());
		path1 += "\\food\\Food_Truck\\src\\main\\webapp\\resources\\img\\upload\\";		
		Iterator<String> itr2= request.getFileNames();
		System.out.println(itr2);
		Iterator<String> itr = request.getFileNames();
		System.out.println("진입");
		if (itr2.hasNext()) {
			System.out.println("진입2");
			List<MultipartFile> mpf = request.getFiles(itr.next());
			
			//DB에 저장될 값
			String pname="\\resources\\img\\upload\\"+mpf.get(0).getOriginalFilename();
			System.out.println(pname);
			for (int i = 0; i < mpf.size(); i++) {
				
				File file = new File(path1 + mpf.get(i).getOriginalFilename());				
				System.out.println("******이미지 경로 = " + path1);
				logger.info(file.getCanonicalPath());
				String root = request.getContextPath();
				mpf.get(i).transferTo(file);

			}

			// model.addObject("path", PATH);
			String pa = path1 + mpf.get(0).getOriginalFilename();
            HashMap<String,Object> map = new HashMap<String,Object>();

			map.put("path", pname);
			return map;
			
		} else {
			System.out.println("진입3");
			HashMap<String,Object> map = new HashMap<String,Object>();
		
			map.put("path", "실패");
			return map;
		}
	}
	
	//상품 상세보기
	@RequestMapping("/productInfo")
	@ResponseBody
	public ProductVO productInfo(@RequestParam("prodNo") String prodNo) {

		ProductVO vo = productService.getProduct(prodNo);
		return vo;
	}
	
	//상품 업데이트
	@RequestMapping("/productUpdate")
	@ResponseBody
	public int productUpdate(ProductVO vo) {
		
		int num = productService.updateProduct(vo);
		return num;
	}
	
	//상품 삭제
	@RequestMapping("/productDelete")
	@ResponseBody
	public int productDelete(@RequestParam("prodNo") String prodNo) {
		int num = productService.deleteProduct(prodNo);
		return num;
	}
	
}
