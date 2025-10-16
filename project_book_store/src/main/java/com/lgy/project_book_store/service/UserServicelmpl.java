package com.lgy.project_book_store.service;

import java.util.Map;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServicelmpl implements UserService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    /** 로그인 검증: users.user_pw를 읽어와 비교 (현 상태 유지) */
    public boolean loginYn(Map<String, String> param) {
        // mapper: loginYn -> 비밀번호만 조회
        String dbPw = (String) sqlSession.selectOne(
            "com.lgy.project_book_store.dao.UserDAO.loginYn", param);
        if (dbPw == null) return false;
        String inputPw = param.get("user_pw");
        return dbPw.equals(inputPw);
    }

    /** 마이페이지 조회 */
    public Map<String, Object> getUser(String userId) {
        Map<String, Object> m = new HashMap<String, Object>();
        m.put("user_id", userId);
        return sqlSession.selectOne(
            "com.lgy.project_book_store.dao.UserDAO.selectUser", m);
    }

    /** 마이페이지 수정 */
    public int updateUser(Map<String, String> param) {
        return sqlSession.update(
            "com.lgy.project_book_store.dao.UserDAO.updateUser", param);
    }
    
    /** 회원가입 로직 */
    public int register(Map<String, String> param) {
        // User.xml 의 <insert id="register"> 문 실행
        return sqlSession.insert(
            "com.lgy.project_book_store.dao.UserDAO.register", param);
    }
    
    public int withdraw(Map<String, String> param) {
        // 비번 일치하면 1, 아니면 0
        return sqlSession.delete(
            "com.lgy.project_book_store.dao.UserDAO.withdraw", param);
    }

    //아이디 중복 체크
    @Override
    public int checkId(String id) {
        return sqlSession.selectOne("com.lgy.project_book_store.dao.UserDAO.checkId", id);
    }

    //아이디로 회원 조회
    @Override
    public UserDTO getUserById(String user_id) {
    	return sqlSession.selectOne(
    			"com.lgy.project_book_store.dao.UserDAO.getUserById", user_id);
    }
    
    //로그인 시도 횟수 체크
	@Override
	public void updateLoginFail(String user_id) {
		sqlSession.update(
				"com.lgy.project_book_store.dao.UserDAO.updateLoginFail", user_id);
	}
	
	//로그인 시도횟수 초기화 
	@Override
	public void resetLoginFail(String user_id) {
		sqlSession.update(
				"com.lgy.project_book_store.dao.UserDAO.resetLoginFail", user_id);
	}
}

