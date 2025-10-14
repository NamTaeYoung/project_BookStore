package com.lgy.project_book_store.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.lgy.project_book_store.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Service
public class MailService {
	
	@Autowired
    private JavaMailSender mailSender; // 필드 주입으로 변경

    private static final String senderEmail = "knnn4533@gmail.com"; // 본인 Gmail로 변경
    private static int number;

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
}
