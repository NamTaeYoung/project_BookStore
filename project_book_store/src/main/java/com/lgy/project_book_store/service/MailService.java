package com.lgy.project_book_store.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.lgy.project_book_store.dao.UserDAO;
import com.lgy.project_book_store.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Service
public class MailService {
	
	@Autowired
    private JavaMailSender mailSender; // 필드 주입으로 변경
	@Autowired
	private SqlSession sqlSession;

    private static final String senderEmail = "knnn4533@gmail.com"; // 본인 Gmail로 변경
    private static int number;

    // 이메일 중복 여부 확인
    public boolean isEmailRegistered(String email) {
        UserDAO dao = sqlSession.getMapper(UserDAO.class);
        int count = dao.checkEmail(email);
        return count > 0; // 1 이상이면 이미 존재
    }

    // 랜덤 숫자 생성
    public static void createNumber() {
        number = (int)(Math.random() * (90000)) + 100000;
    }

    // 메일 내용 생성
    public MimeMessage createMail(String mail) {
        createNumber();
        MimeMessage message = mailSender.createMimeMessage();
        

        try {
            message.setFrom(senderEmail);
            message.setRecipients(MimeMessage.RecipientType.TO, mail);
            message.setSubject("이메일 인증번호");

            String body = "";
            body += "<h3>요청하신 인증번호입니다.</h3>";
            body += "<h1>" + number + "</h1>";
            body += "<h3>감사합니다.</h3>";

            message.setText(body, "UTF-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        return message;
    }

    // 메일 전송
    public int sendMail(String mail) {
    	MimeMessage message = createMail(mail);
    	mailSender.send(message);
    	return number;
    }
    
    // 아이디 찾기용: 이메일로 user_id 조회 
    public String findUserIdByEmail(String email) {
        UserDAO dao = sqlSession.getMapper(UserDAO.class);
        return dao.findIdByEmail(email);
    }

    // 일반 사용자 지정 메일 보내기
    public void sendCustomMail(String recipient, String subject, String htmlContent) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            message.setFrom(senderEmail);
            message.setRecipients(MimeMessage.RecipientType.TO, recipient);
            message.setSubject(subject);
            message.setText(htmlContent, "UTF-8", "html");
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

}
