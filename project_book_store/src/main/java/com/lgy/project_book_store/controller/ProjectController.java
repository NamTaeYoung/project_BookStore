package com.lgy.project_book_store.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.project_book_store.dao.BookBuyDAO;
import com.lgy.project_book_store.dao.CartDAO;
import com.lgy.project_book_store.dto.BookBuyDTO;
import com.lgy.project_book_store.dto.CartDTO;
import com.lgy.project_book_store.dto.UserDTO;
import com.lgy.project_book_store.service.UserServicelmpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ProjectController {
	@Autowired
	private UserServicelmpl service;
    
    @Autowired
    private SqlSession sqlSession;
	
	@RequestMapping("/login")
	public String login() {
		log.info("@# login()");
		
		return "login";
	}
	
//	로그인화면->로그인 여부 판단
	@RequestMapping("/login_yn")
	public String login_yn(@RequestParam HashMap<String, String> param, HttpSession session) {
		log.info("@# login_yn()");
		ArrayList<UserDTO> dtos = service.loginYn(param);
//		아이디와 비밀번호가 일치
		if (dtos.isEmpty()) {
			return "login";
		}else {
			if (param.get("user_pw").equals(dtos.get(0).getUser_pw())) {
				session.setAttribute("user", dtos.get(0));
				return "login_ok";
			} else {
				return "login";
			}
		}
	}
	
//	등록 화면 이동
	@RequestMapping("/register")
	public String register() {
		log.info("@# register()");
		
		return "register";
	}

	@RequestMapping("/register_ok")
	public String registerOk(@RequestParam HashMap<String, String> param) {
		log.info("@# register_ok()");
		service.register(param);
		return "login";
	}
    
//	장바구니 화면 이동
    @RequestMapping("/cart")
    public String cart(Model model, HttpSession session) {
        log.info("@# cart()");
        
//        UserDTO user = (UserDTO) session.getAttribute("user");
//
//        if (user == null) {
//            // 로그인 안 되어있으면 로그인 페이지로 리다이렉트
//            return "redirect:/login";
//        }
//
//        String userId = user.getUser_id();

        // 로그인 여부 상관없이 하드코딩된 userId 사용
        String userId = "user01";

        CartDAO cartDAO = sqlSession.getMapper(CartDAO.class);
        List<CartDTO> cartList = cartDAO.selectCartWithBookByUserId(userId);

        log.info("장바구니 항목 수: {}", cartList.size());
        
        model.addAttribute("cartList", cartList);
        return "cart";
    }
    
    @Autowired
    private BookBuyDAO bookBuyDAO;
    @Autowired
    private CartDAO cartDAO;
 // 주문 처리 메서드
    @PostMapping("/orderBooks")
    public String orderBooks( @RequestParam("book_id") List<Integer> bookIds,
    	    				@RequestParam("quantity") List<Integer> quantities, 
    	    				 HttpSession session) {
        log.info("@# orderBooks() - bookIds: {}", bookIds);
        log.info("Received quantities: {}", quantities);

        if(bookIds.contains(0)) {
            log.error("Invalid book_id detected: 0");
            // 예외 던지거나 에러 페이지 리턴
        }
        
        if (bookIds == null || bookIds.isEmpty()) {
            // 선택한 상품 없으면 장바구니로 다시 이동
            return "redirect:/cart";
        }

        // 세션에서 로그인된 사용자 가져오기 (필요 시 주석 해제)
        // UserDTO user = (UserDTO) session.getAttribute("user");
        // if(user == null) {
        //     return "redirect:/login";
        // }
        // String userId = user.getUser_id();

        // 하드코딩 userId (테스트용)
        String userId = "user01";
        
        // 주문내역 insert
        for (int i = 0; i < bookIds.size(); i++) {
            int bookId = bookIds.get(i);
            int qty = quantities.get(i);
            log.info("Processing order item - bookId: {}, quantity: {}", bookId, qty);

            if(bookId == 0) {
                log.error("Invalid bookId detected during processing: 0");
                // 필요 시 예외 던지거나 건너뛰기
                continue; // 또는 break;
            }
            
            BookBuyDTO buyDTO = new BookBuyDTO();
            buyDTO.setBook_id(bookId);
            buyDTO.setUser_id(userId);
            buyDTO.setQuantity(qty); // 만약 quantity 필드가 있다면
            buyDTO.setPurchase_date(new Date());

            bookBuyDAO.insertBookBuy(buyDTO);
            
         // 장바구니에서 구매된 아이템 삭제
            cartDAO.deleteCartItemByUserIdAndBookId(userId, bookId);
        }

        // 주문 완료 후 주문내역 페이지 또는 메인으로 이동
        return "redirect:/MyPage/purchaseList"; 
    }
    
//  마이페이지/내 정보 화면 이동
    @RequestMapping("/MyPage/myinfo")
    public String mypage() {
        log.info("@# myinfo()");
        
        return "MyPage/myinfo";
    }
    
//	마이페이지/회원 탈퇴 화면 이동
    @RequestMapping("/MyPage/withdraw")
    public String withdraw() {
        log.info("@# withdraw()");
        
        return "MyPage/withdraw";
    }
    
//	마이페이지/구매 기록 화면 이동
    @RequestMapping("/MyPage/purchaseList")
    public String purchaseList(Model model, HttpSession session) {
        log.info("@# purchaseList()");
        
        // 세션에서 로그인 사용자 정보 가져오기 (필요하면)
        // UserDTO user = (UserDTO) session.getAttribute("user");
        // if (user == null) {
        //     return "redirect:/login";
        // }
        // String userId = user.getUser_id();

        // 하드코딩 userId (테스트용)
        String userId = "user01";

        // bookBuyDAO에 구매내역 가져오는 메서드 필요
        List<BookBuyDTO> purchaseList = bookBuyDAO.selectPurchaseListByUserId(userId);
        
        log.info("구매내역 수: {}", purchaseList.size());

        model.addAttribute("purchaseList", purchaseList);

        return "MyPage/purchaseList";
    }
}
