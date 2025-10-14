package com.lgy.project_book_store.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	private UserServicelmpl userService;
    
    @Autowired
    private SqlSession sqlSession;
	
 // ------------------ 기존 회원가입 ------------------
    @RequestMapping(value="/register", method=RequestMethod.GET)
    public String register() {
        return "register";
    }

    @RequestMapping(value="/register_ok", method=RequestMethod.POST)
    public String registerOk(@RequestParam Map<String, String> param, Model model) {
        if (param.get("user_email_chk") == null || param.get("user_email_chk").equals("")) {
            param.put("user_email_chk", "N");
        }

        int result = userService.register(param);
        if (result == 1) {
            return "redirect:/login";
        } else {
            model.addAttribute("msg", "회원가입 실패. 다시 시도하세요.");
            return "register";
        }
    }

    // ------------------ 로그인 ------------------
    @RequestMapping(value="/login", method=RequestMethod.GET)
    public String login() {
        return "login"; // /WEB-INF/views/login.jsp
    }

    @RequestMapping(value="/login_yn", method=RequestMethod.POST)
    public String loginYn(@RequestParam Map<String, String> param, HttpSession session, Model model) {
        String userId = param.get("user_id");
        boolean ok = userService.loginYn(param);

        if (ok) {
            // 로그인 성공 → 세션에 아이디 저장
            session.setAttribute("loginId", userId);
            return "login_ok"; // 로그인 성공 후 마이페이지 버튼이 있는 화면
        } else {
            model.addAttribute("login_err", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login";
        }
    }

    @RequestMapping(value="/logout", method=RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
    
 // ------------------ 마이페이지 ------------------
    @RequestMapping(value="/mypage", method=RequestMethod.GET)
    public String mypage(Model model, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) return "redirect:/login";

        Map<String, Object> user = userService.getUser(loginId);
        model.addAttribute("user", user);
        return "myinfo"; // /WEB-INF/views/myinfo.jsp
    }

    @RequestMapping(value="/mypage/edit", method=RequestMethod.GET)
    public String mypageEdit(Model model, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) return "redirect:/login";

        Map<String, Object> user = userService.getUser(loginId);
        model.addAttribute("user", user);
        return "myinfo_edit";
    }

    @RequestMapping(value="/mypage/update", method=RequestMethod.POST)
    public String mypageUpdate(@RequestParam Map<String, String> param, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) return "redirect:/login";

        param.put("user_id", loginId);
        userService.updateUser(param);
        return "redirect:/mypage";
    }
    
 // 탈퇴 화면
    @RequestMapping(value="/withdraw", method=RequestMethod.GET)
    public String withdraw(HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) return "redirect:/login";
        return "withdraw"; // /WEB-INF/views/withdraw.jsp
    }

    // 탈퇴 처리
    @RequestMapping(value="/withdraw_ok", method=RequestMethod.POST)
    public String withdrawOk(@RequestParam Map<String,String> param,
                             HttpSession session, Model model) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) return "redirect:/login";

        // 세션 아이디 강제 주입 (폼 조작 방지)
        param.put("user_id", loginId);

        int res = userService.withdraw(param); // 비번 일치 시 삭제(1), 불일치 0
        if (res == 1) {
            session.invalidate(); // 세션 종료
        }
        model.addAttribute("result", res); // JSP에서 alert 처리
        return "withdraw";
    }
    
 // 컨트롤러 내부에 추가 (예: 클래스 맨 아래)
    private String getLoginId(HttpSession session) {
        return (String) session.getAttribute("loginId");
    }
    
//	장바구니 화면 이동
    @RequestMapping("/cart")
    public String cart(Model model, HttpSession session) {
        log.info("@# cart()");

        String userId = getLoginId(session);
        if (userId == null) return "redirect:/login";

        List<CartDTO> cartList = cartDAO.selectCartWithBookByUserId(userId);
        model.addAttribute("cartList", cartList);
        return "cart";
    }
    
    @Autowired
    private BookBuyDAO bookBuyDAO;
    @Autowired
    private CartDAO cartDAO;
    
 // 주문 처리 메서드
    @PostMapping("/orderBooks")
    public String orderBooks(@RequestParam("book_id") List<Integer> bookIds,
                             @RequestParam("quantity") List<Integer> quantities, 
                             HttpSession session) {

        String userId = getLoginId(session);
        if (userId == null) return "redirect:/login";

        if (bookIds == null || bookIds.isEmpty()) return "redirect:/cart";

        for (int i = 0; i < bookIds.size(); i++) {
            int bookId = bookIds.get(i);
            int qty = quantities.get(i);

            BookBuyDTO buyDTO = new BookBuyDTO();
            buyDTO.setBook_id(bookId);
            buyDTO.setUser_id(userId);
            buyDTO.setQuantity(qty);
            buyDTO.setPurchase_date(new Date());

            bookBuyDAO.insertBookBuy(buyDTO);
            cartDAO.deleteCartItemByUserIdAndBookId(userId, bookId);
        }

        return "redirect:/MyPage/purchaseList";
    }
    
//	마이페이지/구매 기록 화면 이동
    @RequestMapping("/MyPage/purchaseList")
    public String purchaseList(Model model, HttpSession session) {
        log.info("@# purchaseList()");

        String userId = getLoginId(session);
        if (userId == null) return "redirect:/login";

        List<BookBuyDTO> purchaseList = bookBuyDAO.selectPurchaseListByUserId(userId);
        model.addAttribute("purchaseList", purchaseList);

        return "MyPage/purchaseList";
    }
}
