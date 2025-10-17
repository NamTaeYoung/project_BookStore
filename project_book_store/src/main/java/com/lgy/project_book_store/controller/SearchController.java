package com.lgy.project_book_store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    // /Search?q=검색어&genre_id=장르아이디
    @GetMapping({"/Search","/search"})
    public String search(@RequestParam(value="q", required=false) String q,
                         @RequestParam(value="genre_id", required=false) Integer genre_id,
                         Model model) {

        final String keyword = (q != null && !q.trim().isEmpty()) ? q.trim() : null;
        // 탭의 '전체'는 0으로 오므로 DB 필터에선 null로 변환
        final Integer genreFilter = (genre_id != null && genre_id == 0) ? null : genre_id;

        SearchDAO dao = sqlSession.getMapper(SearchDAO.class);

        // 장르 목록
        model.addAttribute("genreList", dao.getGenreList());

        List<SearchDTO> bookList;

        if (keyword == null && genreFilter == null) {
            bookList = dao.getBookList(); 
        } else {
            // Map으로 파라미터 묶기
        	Map<String, Object> params = new HashMap<>();
        	params.put("keyword", keyword);
        	params.put("genreFilter", genreFilter);

        	bookList = dao.searchBooksByTitleAndGenre(params);
        }


        model.addAttribute("bookList", bookList);
        model.addAttribute("q", keyword == null ? "" : keyword);
        model.addAttribute("selectedGenreId", genre_id == null ? 0 : genre_id);
        System.out.println("genre_id = " + genre_id + ", keyword = " + q);

        return "Book/Search";
    }

    @GetMapping("/SearchDetail")
    public String detail(@RequestParam("book_id") int book_id, Model model) {
        SearchDAO dao = sqlSession.getMapper(SearchDAO.class);
        SearchDTO book = dao.getBookById(book_id);
        if (book == null) return "redirect:/Search";
        model.addAttribute("book", book);
        return "Book/SearchDetail"; 
    }
}
