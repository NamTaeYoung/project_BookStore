package com.lgy.project_book_store.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lgy.project_book_store.dto.CartDTO;
import com.lgy.project_book_store.service.CartService;

@Controller
public class CartController {

    @Autowired
    private CartService cartService;

    @PostMapping("/cartAdd")
    public String addCart(@RequestParam("book_id") int book_id,
                          @RequestParam(value="quantity", defaultValue="1") int quantity,
                          HttpSession session,
                          RedirectAttributes ra) {

        // 로그인 사용자 ID (없으면 임시)
        String user_id = (String) session.getAttribute("LOGIN_USER_ID");
        if (user_id == null || user_id.isEmpty()) {
            user_id = "testuser"; // 개발용. 실제론 로그인 시 세션에 저장
            session.setAttribute("LOGIN_USER_ID", user_id);
        }

        CartDTO cart = new CartDTO();
        cart.setUser_id(user_id);   // DTO가 String이면 그대로 사용
        cart.setBook_id(book_id);
        cart.setQuantity(quantity);

        cartService.addCart(cart);  // 실제 DB 저장

        // 상세 페이지로 되돌아가면서 팝업 트리거
        ra.addAttribute("book_id", book_id);
        ra.addAttribute("added", "1");
        return "redirect:/SearchDetail";
    }
}
