package com.lgy.project_book_store.service;

import java.util.Map;

public interface UserService {

	/** 로그인 검증 */
    boolean loginYn(Map<String, String> param);

    /** 회원가입 */
    int register(Map<String, String> param);

    /** 마이페이지 조회 */
    Map<String, Object> getUser(String userId);

    /** 마이페이지 수정 */
    int updateUser(Map<String, String> param);

    /** 회원 탈퇴 */
    int withdraw(Map<String, String> param);

    /** 아이디 중복 체크 */
    int checkId(String id);
}
