package com.lgy.project_book_store.controller;

import java.util.List;

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

    // /Search?q=검색어&genreId=장르아이디
    @GetMapping("/Search")
    public String bookList(
            @RequestParam(value = "q", required = false) String q,
            @RequestParam(value = "genreId", required = false) Integer genreId,
            Model model) {

        log.info("@# Search(), q={}, genreId={}", q, genreId);

        SearchDAO dao = sqlSession.getMapper(SearchDAO.class);

        // 장르 리스트 모델에 담기
        model.addAttribute("genreList", dao.getGenreList());

        List<SearchDTO> list;

        // 검색어와 장르 조건에 따라 도서 목록 가져오기
        if ((q == null || q.trim().isEmpty()) && genreId == null) {
            list = dao.getBookList();
            model.addAttribute("q", "");
        } else {
            String searchKeyword = (q != null && !q.trim().isEmpty()) ? q.trim() : null;
            list = dao.searchBooksByTitleAndGenre(searchKeyword, genreId);
            model.addAttribute("q", searchKeyword != null ? searchKeyword : "");
        }

        model.addAttribute("bookList", list);
        model.addAttribute("selectedGenreId", genreId);

        return "Book/Search";
    }

    // /SearchDetail?bookId=번호
    @GetMapping("/SearchDetail")
    public String bookDetail(@RequestParam("bookId") int bookId, Model model) {
        SearchDAO dao = sqlSession.getMapper(SearchDAO.class);
        SearchDTO book = dao.getBookById(bookId);

        if (book == null) {
            log.warn("도서를 찾을 수 없습니다. bookId={}", bookId);
            return "redirect:/Search"; // 도서가 없으면 검색 화면으로 리다이렉트
        }

        model.addAttribute("book", book);
        return "Book/SearchDetail";
    }
}
