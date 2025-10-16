package com.lgy.project_book_store.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lgy.project_book_store.dao.mapper.BookMapper;
import com.lgy.project_book_store.dto.BookDTO;
import com.lgy.project_book_store.dto.GenreDTO;

@Service
public class BookServicelmpl implements BookService {

    @Autowired
    private BookMapper mapper;

    @Override
    public List<BookDTO> getAllBooks() {
        return mapper.getAllBooks();
    }

    @Override
    public List<GenreDTO> getAllGenres() {
        return mapper.getAllGenres();
    }

    @Override
    public List<BookDTO> getBooksByGenre(int genre_id) {
        return mapper.getBooksByGenre(genre_id);
    }
}
