package com.lgy.project_book_store.controller;

import java.util.ArrayList;
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
    public String search(@RequestParam(value="q", required=false) String q,
                         @RequestParam(value="genre_id", required=false) Integer genre_id,
                         Model model) {
        final String keyword = (q != null && !q.trim().isEmpty()) ? q.trim() : null;
        // 탭의 '전체'는 0으로 오므로 DB 필터에선 null로 변환
        final Integer genreFilter = (genre_id != null && genre_id == 0) ? null : genre_id;

        SearchDAO dao = sqlSession.getMapper(SearchDAO.class);

        model.addAttribute("genreList", dao.getGenreList());

        List<SearchDTO> list;
        if (keyword == null && genreFilter == null) {
            // 검색 전 초기 화면: 안내 멘트만 보이게 하려면 빈 리스트 내려줌
            list = java.util.Collections.emptyList();
        } else if (keyword == null && genreFilter == null) {
            list = dao.getBookList(); // (원하면 전체 노출로 바꿔도 됨)
        } else {
            list = dao.searchBooksByTitleAndGenre(keyword, genreFilter);
        }

        model.addAttribute("bookList", list);
        model.addAttribute("q", keyword == null ? "" : keyword);
        model.addAttribute("selectedGenreId", genre_id == null ? 0 : genre_id);
        return "Book/Search";
    }

    @GetMapping("/SearchDetail")
    public String detail(@RequestParam("book_id") int book_id, Model model) {
        SearchDAO dao = sqlSession.getMapper(SearchDAO.class);
        SearchDTO book = dao.getBookById(book_id);
        if (book == null) return "redirect:/Search";
        model.addAttribute("book", book);
        return "Book/SearchDetail"; // 뷰리졸버 prefix/suffix와 합쳐짐
    }
}
