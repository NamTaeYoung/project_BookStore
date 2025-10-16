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
import org.springframework.web.bind.annotation.ResponseBody;

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
	    
	    @GetMapping("/main")
	    public String main(HttpSession session) {
	        return "main"; 
	    }
	   
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
	        
	        // 회원 정보 조회 (로그인 시도 및 시간 확인용)
	        UserDTO user = userService.getUserById(userId);

	        if (user == null) {
	            model.addAttribute("login_err", "존재하지 않는 아이디입니다.");
	            return "login";
	        }
	        // 로그인 실패 기록 초기화 조건 확인 (마지막 실패 후 5분 경과 시 자동 초기화)
	        if (user.getLast_fail_time() != null) {
	            long diffMin = (System.currentTimeMillis() - user.getLast_fail_time().getTime()) / 1000 / 60;
	            if (diffMin >= 5 && user.getLogin_fail_count() > 0) {
	                userService.resetLoginFail(userId);
	            }
	        }

	        // 로그인 잠금 상태 체크
	        if (user.getLogin_fail_count() >= 5 && user.getLast_fail_time() != null) {
	            long diffSec = (System.currentTimeMillis() - user.getLast_fail_time().getTime()) / 1000;
	            if (diffSec < 30) {
	                model.addAttribute("login_err", "비밀번호 5회 이상 틀려 30초간 계정이 비활성화 됩니다.<br>잠시 후 다시 시도해주세요.");
	                return "login";
	            } else {
	                userService.resetLoginFail(userId); // 30초 지났으면 초기화
	            }
	        }
	        
	        boolean ok = userService.loginYn(param);
	        
	        if (ok) {
	           // 로그인 성공 시 시도횟수 초기화
	           userService.resetLoginFail(userId);
	           session.setAttribute("loginId", userId);
	            // 로그인 성공 후 main.jsp로 리다이렉트
	            return "redirect:/";
	        } else {
	        	userService.updateLoginFail(userId); // 실패 카운트 증가
	            user = userService.getUserById(userId); // 갱신된 횟수 다시 조회

	            if (user.getLogin_fail_count() >= 5) {
	                model.addAttribute("login_err", "비밀번호를 5회 이상 틀리셨습니다.<br>계정이 30초간 비활성화 됩니다.");
	            } else {
	                model.addAttribute("login_err",
	                    "아이디 또는 비밀번호가 잘못되었습니다. (" + user.getLogin_fail_count() + "/5)");
	            }
	            return "login";
	        }
	    }

	    @RequestMapping(value="/logout", method=RequestMethod.GET)
	    public String logout(HttpSession session) {
	        session.invalidate();
	        return "redirect:/main";
	    }
	
	//아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="/checkId", method=RequestMethod.POST)
	public String checkId(@RequestParam("user_id") String id) {
	    int flag = userService.checkId(id);
	    return (flag == 1) ? "Y" : "N";
	}
	
 // ------------------ 마이페이지 ------------------
    @RequestMapping(value="/mypage", method=RequestMethod.GET)
    public String mypage(Model model, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) return "redirect:/login";

        Map<String, Object> user = userService.getUser(loginId);
        model.addAttribute("user", user);
        return "/MyPage/myinfo"; // /WEB-INF/views/myinfo.jsp
    }

    @RequestMapping(value="/mypage/edit", method=RequestMethod.GET)
    public String mypageEdit(Model model, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) return "redirect:/login";

        Map<String, Object> user = userService.getUser(loginId);
        model.addAttribute("user", user);
        return "/MyPage/myinfo_edit";
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
        return "/MyPage/withdraw"; // /WEB-INF/views/withdraw.jsp
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
        return "/MyPage/withdraw";
    }
    
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
    
    @GetMapping("/board")
    public String board() {
        // /WEB-INF/views/search/search.jsp 로 forward
        return "board";
    }
}
