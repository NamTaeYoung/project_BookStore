package com.lgy.project_book_store.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lgy.project_book_store.dto.CartDTO;

public interface CartDAO {
    // 장바구니에 아이템 추가
    int insertCartItem(CartDTO cart);

    // 특정 사용자의 장바구니 아이템 전체 조회
//    List<CartDTO> selectCartByUserId(String user_id);
    List<CartDTO> selectCartByUserId(@Param("user_id") String userId);
    
    // 장바구니 아이템 수량 업데이트
//    void updateCartQuantity(int cart_id, int quantity);
    int updateCartQuantity(@Param("cart_id") int cartId,
            @Param("quantity") int quantity);
    
    // 장바구니 아이템 삭제
//    void deleteCartItem(int cart_id);
    int deleteCartItem(@Param("cart_id") int cartId);
    
    // (선택) 특정 사용자의 장바구니 전체 삭제
//    void deleteCartByUserId(String user_id);
    int deleteCartByUserId(@Param("user_id") String userId);
    
    //현재 로그인한 유저의 장바구니를 조회
//    List<CartDTO> selectCartWithBookByUserId(String user_id);
    List<CartDTO> selectCartWithBookByUserId(@Param("user_id") String userId);

    
//    int deleteCartItemByUserIdAndBookId(@Param("user_id") String user_id, @Param("book_id") int book_id);
    int deleteCartItemByUserIdAndBookId(@Param("user_id") String userId,
            @Param("book_id") int bookId);
    
    void updateCartQuantityByParams(@Param("cart_id") int cart_id,
            @Param("quantity") int quantity);
    
    CartDTO selectCartItemByUserAndBook(@Param("user_id") String userId,
            @Param("book_id") int bookId);
    
    int deleteCartItems(@Param("cartIds") List<Integer> cartIds);
}