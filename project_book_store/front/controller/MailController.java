package com.lgy.project_book_store.controller;

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

    private int savedCode; // ✅ 서버에 최근 발송된 인증번호 저장

    // 인증번호 이메일 전송
    @PostMapping("/send")
    @ResponseBody
    public String sendAuthMail(@RequestParam("email") String email) {
        savedCode = mailService.sendMail(email);
        return String.valueOf(savedCode); // (테스트용으로 클라이언트에 반환)
    }

    // 인증번호 검증
    @PostMapping("/verify")
    @ResponseBody
    public String verifyAuthCode(@RequestParam("code") int code) {
        if (code == savedCode) {
            return "success"; // ✅ 인증 성공
        } else {
            return "fail"; // ❌ 인증 실패
        }
    }
}