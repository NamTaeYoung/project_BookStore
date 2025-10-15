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
    // 아이디 중복 체크
    public int checkId(String user_id);
    // 이메일 중복 체크
    public int checkEmail(String user_email);
    // 이메일로 아이디를 찾음
    public String findIdByEmail(String user_email);
//    // 아이디, 이메일로 비밀번호를 찾음
//    public String findPwByIdEmail(HashMap<String, String> param);
//    //사용자의 아이디와 생성된 토큰을 받아, 데이터베이스 토큰을 저장(사용자가 재설정할 권한이 있음을 증명)
//    public void saveResetToken(HashMap<String, String> param);
//    //토큰으로 비밀번호 업데이트
//    public boolean updatePasswordByToken(HashMap<String, String> param);
}
