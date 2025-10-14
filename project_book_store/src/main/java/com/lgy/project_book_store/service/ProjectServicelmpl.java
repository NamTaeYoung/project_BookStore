package com.lgy.project_book_store.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.project_book_store.dao.ProjectDAO;
import com.lgy.project_book_store.dto.ProjectDTO;

@Service
public class ProjectServicelmpl implements ProjectService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ProjectDTO> loginYn(HashMap<String, String> param) {
		ProjectDAO dao = sqlSession.getMapper(ProjectDAO.class);	
		ArrayList<ProjectDTO> list = dao.loginYn(param);
		return list;
	}

	@Override
	public void register(HashMap<String, String> param) {
		ProjectDAO dao = sqlSession.getMapper(ProjectDAO.class);
		dao.register(param);
	}

}
