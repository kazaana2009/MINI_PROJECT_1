package com.foodtruck.dao;

import java.util.List;
import java.util.Map;

import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.MInquiryVO;
import com.foodtruck.vo.MemberVO;
import com.foodtruck.vo.MinquiryReplyVO;

public interface MemberDAO {
	
	public int qaSelStatUpdate(int qaSelNo);
	
	// 고객 문의 답변 (판매자)
	public int qaScReplyInsert(MinquiryReplyVO vo);
	
	// 판매자에게 온 문의 리스트
	public List<MInquiryVO> getSellerQaSelInfoList(String memberId);
	
	// 사용자 판매자에게 문의내역 리스트
	public List<MInquiryVO> getMemberQaSelInfoList(String memberId);
	
	// 사용자 관리자에게 문의 내역 리스트
	public List<MInquiryVO> getMemberQaScInfoList(String memberId);
	
	// 사용자 판매자에게 문의 내역 정보
	public MInquiryVO getMemberQaSelInfo(int qaSelNo);
	
	// 사용자 관리자에게 문의 내역 정보
	public MInquiryVO getMemberQaScInfo(int qaScNo);
	
	// 판매자가 사용자에게 답변 내용
	public MinquiryReplyVO getMemberQaSelReply(int qaSelNo);	
	
	// 관리자가 사용자에게 답변 내용
	public MinquiryReplyVO getMemberQaScReply(int qaScNo);
	
	// 회원 정보
	public MemberVO getMember(String memberId);

	// 회원 리스트
	public List<MemberVO> getMemberList();

	//ID 찾기
	public MemberVO getId(String memberTel);
	
	//PW 찾기
	public MemberVO getPw(Map<String,Object> map);
	
	// 회원 등록
	public int insertMember(MemberVO vo);

	// 회원 수정
	public int updateMember(MemberVO vo);

	// 회원 삭제
	public int deleteMember(String memberId);
	
	//판매자의 라이센스번호
	public List<LicenseVO> getLicenseNo(String selId);
	
	//1:1문의 insert하기
	public int insertInquiry(MInquiryVO vo);
	
	//1:1문의 list가져오기
	public List<MInquiryVO> getMinquiryList(int NpageNo);
	
	//1:1문의 total count가져오기
	public int getMinquiryListcount();
	
	//1:1문의 select
	public MInquiryVO getinfo(int qno);
	
	//1:1문의 update
	public int updateMinquiry(int qno);
	
	//1:1문의 insert하기(판매자)
	public int insertInquiry2(MInquiryVO vo);
	
	// 주문 금액 5% 마일리지 적립
	public void updateMileage(Map<String,Object> map);
}
