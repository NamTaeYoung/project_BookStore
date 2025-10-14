package com.lgy.project_book_store.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProjectDTO {
	private String user_id;
	private String user_pw;
	private String user_email;
	private String user_phone_num;
	private String user_post_num;
	private String user_address;
	private String user_detail_address;
	private String user_name;
	private String user_nickname;
}
