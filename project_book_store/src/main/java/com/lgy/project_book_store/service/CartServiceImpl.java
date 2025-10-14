package com.lgy.project_book_store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.project_book_store.dao.CartDAO;
import com.lgy.project_book_store.dto.CartDTO;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartDAO cartDAO;

    @Override
    public List<CartDTO> getCartByUserId(String user_id) {
        return cartDAO.selectCartWithBookByUserId(user_id);
    }
}

