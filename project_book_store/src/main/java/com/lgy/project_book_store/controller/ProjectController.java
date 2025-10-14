package com.lgy.project_book_store.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.project_book_store.dto.ProjectDTO;
import com.lgy.project_book_store.service.ProjectServicelmpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ProjectController {
	
	@Autowired
	private ProjectServicelmpl service;
	
	@RequestMapping("/login")
	public String login() {
		log.info("@# login()");
		
		return "login";
	}
	
//	로그인화면->로그인 여부 판단
	@RequestMapping("/login_yn")
	public String login_yn(@RequestParam HashMap<String, String> param) {
		log.info("@# login_yn()");
		ArrayList<ProjectDTO> dtos = service.loginYn(param);
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
}	
