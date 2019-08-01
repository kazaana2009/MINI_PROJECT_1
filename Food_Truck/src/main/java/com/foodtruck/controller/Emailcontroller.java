package com.foodtruck.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodtruck.dao.Mailservice;

@Controller
public class Emailcontroller {
	
	@Autowired
	private Mailservice mailservice;
	@RequestMapping("/check")
	@ResponseBody
	private String sendMail(HttpSession session,HttpServletRequest request) {
		String memberId = request.getParameter("memberId");
		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
        System.out.println(joinCode);
        String subject = "회원가입 인증 코드 발급 안내 입니다.";
        StringBuilder sb = new StringBuilder();
        sb.append("귀하의 인증 코드는 " + joinCode + " 입니다.");
        mailservice.send(subject, sb.toString(), "kazaana2010@gmail.com", memberId);
        
        return joinCode;
	}
}
