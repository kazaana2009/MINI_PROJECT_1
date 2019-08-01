package com.foodtruck.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.MemberDAO;
import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.MInquiryVO;
import com.foodtruck.vo.MemberVO;
import com.foodtruck.vo.MinquiryReplyVO;

@Service
public class MemberService {
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	// 판매자가 고객문의 답변해주면 문의상태 Y 로 변경
	public int qaSelStatUpdate(int qaSelNo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.qaSelStatUpdate(qaSelNo);
	}
	
	// 고객 문의 답변(판매자)
	public int qaScReplyInsert(MinquiryReplyVO vo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.qaScReplyInsert(vo);
	}
	
	// 판매자에게 온 문의 리스트
	public List<MInquiryVO> getSellerQaSelInfoList(String memberId) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getSellerQaSelInfoList(memberId);
	}
	
	// 사용자 판매자에게 문의내역 리스트
	public List<MInquiryVO> getMemberQaSelInfoList(String memberId) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMemberQaSelInfoList(memberId);
	}
	
	// 사용자 관리자에게 문의내역 리스트
	public List<MInquiryVO> getMemberQaScInfoList(String memberId) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMemberQaScInfoList(memberId);
	}
	
	// 사용자 판매자에게 문의내역 정보
	public MInquiryVO getMemberQaSelInfo(int qaSelNo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMemberQaSelInfo(qaSelNo);
	}
	
	// 사용자 관리자에게 문의내역 정보
	public MInquiryVO getMemberQaScInfo(int qaScNo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMemberQaScInfo(qaScNo);
	}
	
	// 판매자가 사용자에게 문의 답변내용
	public MinquiryReplyVO getMemberQaSelReply(int qaSelNo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMemberQaSelReply(qaSelNo);
	}	
	
	// 관리자가 사용자에게 문의 답변 내용
	public MinquiryReplyVO getMemberQaScReply(int qaScNo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMemberQaScReply(qaScNo);
	}
	
	// 회원 정보
	public MemberVO getMember(String memberId) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMember(memberId);
	}

	// 회원 리스트Ʈ
	public List<MemberVO> getMemberList() {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMemberList();
	}

	// ID 찾기
	public MemberVO getId(String memberTel) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getId(memberTel);
	}
	
	// PW 찾기
	public MemberVO getPw(Map<String,Object> map) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getPw(map);
	}
	
	// 회원 등록
	public int insertMember(MemberVO vo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.insertMember(vo);
	}

	// 회원 수정
	public int updateMember(MemberVO vo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.updateMember(vo);
	}

	// 회원 삭제
	public int deleteMember(String memberId) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.deleteMember(memberId);
	}

	// 판매자 라이센스 번호 
	public List<LicenseVO> getLicenseNo(String selId) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getLicenseNo(selId);
	}
	
	//1:1 insert하기
	public int insertInquiry(MInquiryVO vo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.insertInquiry(vo);
	}
	
	//1:1 문의사항 list가져오기
	public List<MInquiryVO> getMinquiryList(int NpageNo){
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMinquiryList(NpageNo);
	}
	
	//1:1문의사항 count 가져오기
	public int getMinquiryListcount() {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getMinquiryListcount();
	}
	
	//1:1 문의사항 select
	public MInquiryVO getinfo(int qno) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.getinfo(qno);
	}
	
	public int updateMinquiry(int qno) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.updateMinquiry(qno);
	}
	
	//1:1 insert 하기
	public int insertInquiry2(MInquiryVO vo) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		return dao.insertInquiry2(vo);
	}
	
	// 주문 금액 5% 마일리지 적립
	public void updateMileage(Map<String,Object> map) {
		MemberDAO dao = sessionTemplate.getMapper(MemberDAO.class);
		dao.updateMileage(map);
	}

}
