package com.lgy.project_book_store.dao;

import java.util.List;
import com.lgy.project_book_store.dto.CartDTO;


public interface CartDAO {
    // 장바구니에 아이템 추가
    void insertCartItem(CartDTO cart);

    // 특정 사용자의 장바구니 아이템 전체 조회
    List<CartDTO> selectCartByUserId(String user_id);

    // 장바구니 아이템 수량 업데이트
    void updateCartQuantity(int cart_id, int quantity);

    // 장바구니 아이템 삭제
    void deleteCartItem(int cart_id);

    // (선택) 특정 사용자의 장바구니 전체 삭제
    void deleteCartByUserId(String user_id);
    
    //현재 로그인한 유저의 장바구니를 조회
    List<CartDTO> selectCartWithBookByUserId(String user_id);
}
