package com.lgy.project_book_store.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import com.lgy.project_book_store.dto.UserDTO;

public interface UserDAO {
	public ArrayList<UserDTO> loginYn(HashMap<String, String> param);
	public void register(HashMap<String, String> param);
    // 특정 아이디로 사용자 조회 (로그인용 등)
    public List<UserDTO> findByUserId(String user_id);
    // 회원가입 (새 사용자 추가)
    public void insertUser(String user_id, String user_pw, String user_name, String user_email, String user_phone_num);
    // 기타 필요한 메서드 예시
    public void updateUser(UserDTO user);
    public void deleteUser(String user_id);
}
