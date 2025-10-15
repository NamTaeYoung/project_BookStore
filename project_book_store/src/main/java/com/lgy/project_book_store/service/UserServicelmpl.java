package com.lgy.project_book_store.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.project_book_store.dao.UserDAO;
import com.lgy.project_book_store.dto.UserDTO;

@Service
public class UserServicelmpl implements UserService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<UserDTO> loginYn(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);	
		ArrayList<UserDTO> list = dao.loginYn(param);
		return list;
	}

	@Override
	public void register(HashMap<String, String> param) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
		dao.register(param);
	}

	@Override
	public int checkId(String id) {
		UserDAO dao = sqlSession.getMapper(UserDAO.class);
        return dao.checkId(id);
	}
}
