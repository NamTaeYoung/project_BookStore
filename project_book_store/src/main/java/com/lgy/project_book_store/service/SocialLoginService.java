package com.lgy.project_book_store.service;

import com.lgy.project_book_store.dto.SocialUserDTO;

public interface SocialLoginService {
	public String getAccessToken(String code);
	public SocialUserDTO getUserInfo(String accessToken);
}
