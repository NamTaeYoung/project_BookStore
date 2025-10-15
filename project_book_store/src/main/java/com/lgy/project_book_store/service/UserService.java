package com.lgy.project_book_store.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.project_book_store.dto.UserDTO;

public interface UserService {
	public ArrayList<UserDTO> loginYn(HashMap<String, String> param);
	public void register(HashMap<String, String> param);
	public int checkId(String id);
}
