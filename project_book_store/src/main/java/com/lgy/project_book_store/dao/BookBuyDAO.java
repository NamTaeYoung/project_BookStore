package com.lgy.project_book_store.dao;

import java.util.List;

import com.lgy.project_book_store.dto.BookBuyDTO;

public interface BookBuyDAO {
    void insertBookBuy(BookBuyDTO bookBuy);
    List<BookBuyDTO> selectPurchaseListByUserId(String userId);
}
