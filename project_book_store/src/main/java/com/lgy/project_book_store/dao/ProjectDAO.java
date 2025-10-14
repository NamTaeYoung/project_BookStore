package com.lgy.project_book_store.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.project_book_store.dto.ProjectDTO;

public interface ProjectDAO {
	public ArrayList<ProjectDTO> loginYn(HashMap<String, String> param);
	public void register(HashMap<String, String> param);
}
