package com.lgy.project_book_store.dao;

import java.util.List;
import com.lgy.project_book_store.dto.BookDTO;

public interface BookDAO {
    public void insertBook(BookDTO book);
    public List<BookDTO> selectAllBooks();
    public BookDTO selectBookById(int book_id);
    public void updateBook(BookDTO book);
    public void deleteBook(int book_id);
}
