package com.lgy.project_book_store.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.lgy.project_book_store.dto.CartDTO;

public interface CartDAO {

    int insertCart(CartDTO cart);

    CartDTO selectCartItemByUserAndBook(@Param("user_id") String userId,
                                        @Param("book_id") int bookId);

    List<CartDTO> selectCartByUserId(@Param("user_id") String userId);

    List<CartDTO> selectCartWithBookByUserId(@Param("user_id") String userId);

    int updateCartQuantity(@Param("cart_id") int cartId,
                           @Param("quantity") int quantity);

    int updateCartQuantityByParams(@Param("cart_id") int cartId,
                                   @Param("quantity") int quantity);

    int deleteCartItem(@Param("cart_id") int cartId);

    int deleteCartByUserId(@Param("user_id") String userId);

    int deleteCartItemByUserIdAndBookId(@Param("user_id") String userId,
                                        @Param("book_id") int bookId);
}
