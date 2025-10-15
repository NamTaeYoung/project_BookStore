package com.lgy.project_book_store.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lgy.project_book_store.service.MailService;

@Controller
@RequestMapping("/mail")
public class MailController {
	
	@Autowired
    private MailService mailService;

    private int savedCode; // 서버에 최근 발송된 인증번호 저장

    // 인증번호 이메일 전송
    @PostMapping("/send")
    @ResponseBody
    public String sendAuthMail(@RequestParam("email") String email,HttpSession session) {
    	
    	// 중복 이메일 검사
        if (mailService.isEmailRegistered(email)) {
            return "duplicate"; // 이미 등록된 이메일이면 인증번호 전송 X
        }
        
    	int code = mailService.sendMail(email);
        session.setAttribute("authCode", code); //세션에 저장
        return String.valueOf(code); // (테스트용으로 클라이언트에 반환, 실제 사용시 제거해야 함)
//        return "success";
    }

    // 인증번호 검증
    @PostMapping("/verify")
    @ResponseBody
    public String verifyAuthCode(@RequestParam("code") int code, HttpSession session) {
        Integer savedCode = (Integer) session.getAttribute("authCode");
        if (savedCode != null && savedCode == code) {
            session.setAttribute("emailVerified", true); // 인증 완료 플래그 세션 저장
            return "success";
        } else {
            return "fail";
        }
    }
    
    //아이디 찾기
    @PostMapping("/find_id")
    @ResponseBody
    public String sendUserId(@RequestParam("email") String email) {
        String userId = mailService.findUserIdByEmail(email);

        if (userId != null) {
            mailService.sendCustomMail(email, "아이디 찾기 안내", 
                "<h3>회원님의 아이디는 다음과 같습니다:</h3><h2>" + userId + "</h2>");
            return "success";
        } else {
            return "fail";
        }
    }
}
