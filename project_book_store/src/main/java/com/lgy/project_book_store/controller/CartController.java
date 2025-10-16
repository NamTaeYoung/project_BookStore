package com.lgy.project_book_store.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lgy.project_book_store.dto.CartDTO;
import com.lgy.project_book_store.service.CartService;

@Controller
public class CartController {

    @Autowired
    private CartService cartService;

    @PostMapping("/cartAdd")
    @ResponseBody
    public String addCart(
            @RequestParam("book_id") int book_id,
            HttpSession session) {

        System.out.println("addCart() 호출됨! book_id = " + book_id);

        // 세션에서 로그인한 유저 ID 가져오기
        String user_id = (String) session.getAttribute("loginId"); // 수정!
        if (user_id == null) {
            return "로그인 후 이용해주세요.";
        }

        try {
            CartDTO cart = new CartDTO();
            cart.setBook_id(book_id);
            cart.setQuantity(1);
            cart.setUser_id(user_id);

            cartService.addCart(cart); // 서비스에서 DB insert + commit 처리
            System.out.println("장바구니에 추가 완료! user_id = " + user_id);

            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "장바구니 담기 실패: " + e.getMessage();
        }
    }
}
