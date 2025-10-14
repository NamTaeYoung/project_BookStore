package com.lgy.project_book_store.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.lgy.project_book_store.dto.SearchDTO;

public interface SearchDAO {
    ArrayList<SearchDTO> getBookList();
    ArrayList<SearchDTO> searchBooks(@Param("keyword") String keyword);
    SearchDTO getBookById(int bookId);
}
