package com.lgy.project_book_store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Override
    @Transactional
    public void addCart(CartDTO cart) {
        System.out.println("CartServiceImpl.addCart() 호출됨, user_id=" + cart.getUser_id() 
                            + ", book_id=" + cart.getBook_id());

        // 수량 기본값 1 처리
        if (cart.getQuantity() <= 0) {
            cart.setQuantity(1);
        }

        // 현재 유저 장바구니 조회
        List<CartDTO> cartList = cartDAO.selectCartByUserId(cart.getUser_id());

        // 같은 book_id 확인
        CartDTO existing = null;
        for (CartDTO c : cartList) {
            if (c.getBook_id() == cart.getBook_id()) {
                existing = c;
                break;
            }
        }

        if (existing != null) {
            int newQty = existing.getQuantity() + cart.getQuantity();
            cartDAO.updateCartQuantityByParams(existing.getCart_id(), newQty);

            System.out.println("장바구니 수량 업데이트 완료! cart_id=" + existing.getCart_id() + ", newQty=" + newQty);
        } else {
            // 새로운 항목이면 insert
            cartDAO.insertCart(cart);
            System.out.println("🆕 새로운 책 장바구니 추가 완료! user_id=" 
                                + cart.getUser_id() + ", book_id=" + cart.getBook_id());
        }
    }
}
