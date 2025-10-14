package com.lgy.project_book_store.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.project_book_store.dao.CartDAO;
import com.lgy.project_book_store.dto.CartDTO;
import com.lgy.project_book_store.dto.UserDTO;
import com.lgy.project_book_store.service.UserServicelmpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ProjectController {
	@Autowired
	private UserServicelmpl service;
    
    @Autowired
    private SqlSession sqlSession;
	
	@RequestMapping("/login")
	public String login() {
		log.info("@# login()");
		
		return "login";
	}
	
//	로그인화면->로그인 여부 판단
	@RequestMapping("/login_yn")
	public String login_yn(@RequestParam HashMap<String, String> param) {
		log.info("@# login_yn()");
		ArrayList<UserDTO> dtos = service.loginYn(param);
//		아이디와 비밀번호가 일치
		if (dtos.isEmpty()) {
			return "login";
		}else {
			if (param.get("user_pw").equals(dtos.get(0).getUser_pw())) {
				return "login_ok";
			} else {
				return "login";
			}
		}
	}
	
//	등록 화면 이동
	@RequestMapping("/register")
	public String register() {
		log.info("@# register()");
		
		return "register";
	}

	@RequestMapping("/register_ok")
	public String registerOk(@RequestParam HashMap<String, String> param) {
		log.info("@# register_ok()");
		service.register(param);
		return "login";
	}
    
    @RequestMapping("/cart")
    public String cart(Model model) {
        log.info("@# cart()");
        

        // 로그인 여부 상관없이 하드코딩된 userId 사용
        String userId = "user01";

        CartDAO cartDAO = sqlSession.getMapper(CartDAO.class);
        List<CartDTO> cartList = cartDAO.selectCartWithBookByUserId(userId);

        log.info("장바구니 항목 수: {}", cartList.size());
        
        model.addAttribute("cartList", cartList);
        return "cart";
    }
    
    @RequestMapping("/MyPage/myinfo")
    public String mypage() {
        log.info("@# myinfo()");
        
        return "MyPage/myinfo";
    }
    
    @RequestMapping("/MyPage/withdraw")
    public String withdraw() {
        log.info("@# withdraw()");
        
        return "MyPage/withdraw";
    }
}
