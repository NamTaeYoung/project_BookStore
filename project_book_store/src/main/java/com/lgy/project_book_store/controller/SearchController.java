package com.lgy.project_book_store.controller;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.project_book_store.dao.SearchDAO;
import com.lgy.project_book_store.dto.SearchDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SearchController {

    @Autowired
    private SqlSession sqlSession;

    // /BookList?q=검색어  (q 없으면 전체)
    @GetMapping("/Search")
    public String bookList(@RequestParam(value = "q", required = false) String q, Model model) {
        log.info("@# Search(), q={}", q);

        SearchDAO dao = sqlSession.getMapper(SearchDAO.class);
        ArrayList<SearchDTO> list;

        if (q == null || q.trim().isEmpty()) {
            list = dao.getBookList();             // 전체 목록
            model.addAttribute("q", "");          // 입력창 유지용
        } else {
            list = dao.searchBooks(q.trim());     // 제목 검색
            model.addAttribute("q", q.trim());
        }

        model.addAttribute("bookList", list);
        return "Book/Search";
    }
    
    @GetMapping("/BookDetail")
    public String bookDetail(@RequestParam("bookId") int bookId, Model model) {
        SearchDAO dao = sqlSession.getMapper(SearchDAO.class);
        SearchDTO book = dao.getBookById(bookId); // DAO에서 단일 도서 조회 메서드 필요
        model.addAttribute("book", book);
        return "Book/BookDetail";  // jsp 파일명
    }
}
