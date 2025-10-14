package com.lgy.project_book_store.service;

import java.util.List;
import com.lgy.project_book_store.dto.CartDTO;

public interface CartService {
	List<CartDTO> getCartByUserId(String user_id);
}
