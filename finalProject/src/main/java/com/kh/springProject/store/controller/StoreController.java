package com.kh.springProject.store.controller;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.store.model.service.StoreService;
import com.kh.springProject.store.model.vo.Cart;
import com.kh.springProject.store.model.vo.Store;

@Controller
public class StoreController {

    @Autowired
    private StoreService storeService;

    @GetMapping("list.st")
    public ModelAndView storeList(ModelAndView mv) {
        List<Store> list = storeService.selectAllStores();
        mv.addObject("list", list);
        mv.setViewName("store/storeList");
        return mv;
    }
    @GetMapping("insert.st")
    public String newStoreForm() {
        return "store/storeInsert";
    }

    @PostMapping("insert.st")
    public ModelAndView insertStore(Store store,HttpSession session, ModelAndView mv) {
        int result = storeService.insertStore(store);
        if (result > 0) {
            session.setAttribute("alertMsg", "등록 성공!");
            mv.setViewName("redirect:/list.st");
        } else {
            mv.addObject("errorMsg", "등록 실패");
            mv.setViewName("redirect:/list.st");
        }
        return mv;
    }

    
    @GetMapping("update.st")
    public String updatePage(@RequestParam("storeNo") int storeNo, Model model) {
        Store store = storeService.findByStoreNo(storeNo);
        model.addAttribute("store", store);
        return "store/storeUpdate";
    }
    @PostMapping("update.st")
    public String updateStore(@ModelAttribute Store store, HttpSession session) {
        int result = storeService.updateStore(store);
        if (result > 0) {
            session.setAttribute("alertMsg", "상품이 성공적으로 수정되었습니다.");
            return "redirect:/list.st";
        } else {
            session.setAttribute("alertMsg", "상품 수정에 실패했습니다.");
            return "redirect:/list.st";
        }
    }
    
    @RequestMapping("delete.st")
    public String deleteStore(@RequestParam("storeNo") int storeNo, HttpSession session) {
        int result = storeService.deleteStore(storeNo);

        if (result > 0) {
            session.setAttribute("alertMsg", "상품이 성공적으로 삭제되었습니다.");
            return "redirect:/list.st";
        } else {
            session.setAttribute("alertMsg", "상품 삭제에 실패했습니다.");
            return "redirect:/list.st";
        }
    }
    @GetMapping("addToCart.ct")
    public String addToCart( int storeNo, HttpSession session, Model model) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        
        
        if (loginUser == null) {
            session.setAttribute("alertMsg", "로그인이 필요합니다.");
            return "redirect:/list.st";
        }
        
        
        String memberNo = loginUser.getMemberNo();
        int result = storeService.addToCart(memberNo, storeNo, 1);  // 수량 1로 추가

        if (result > 0) {
            session.setAttribute("alertMsg", "장바구니에 추가되었습니다.");
            return "redirect:/list.st";
        } else {
            session.setAttribute("alertMsg", "장바구니에 추가에 실패했습니다.");
            return "redirect:/list.st";
        }
    }
    
    @GetMapping("list.ct")
    public ModelAndView cartList(HttpSession session, ModelAndView mv) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        
        String memberNo = loginUser.getMemberNo();
        List<Cart> cart = storeService.getCartItems(memberNo);
        mv.addObject("cart", cart);
        mv.setViewName("store/cartList");
        return mv;
    }
    @DeleteMapping("/delete.ct")
    @ResponseBody
    public String deleteCart(@RequestParam("cartId") int cartId) {
        try {
            storeService.deleteCartById(cartId);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    @PostMapping("updateCartAndorderView.ct")
    public String updateCartAndCheckout(HttpServletRequest request, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            session.setAttribute("alertMsg", "로그인이 필요합니다.");
            return "redirect:/list.st";
        }

        String memberNo = loginUser.getMemberNo();

        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("quantity_")) {
                int cartId = Integer.parseInt(paramName.split("_")[1]);
                int quantity = Integer.parseInt(request.getParameter(paramName));
                storeService.updateCartQuantity(cartId, quantity);
            }
        }

        return "redirect:/list.co";
    }
    @GetMapping("list.co")
    public ModelAndView checkOut(HttpSession session, ModelAndView mv) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        
        String memberNo = loginUser.getMemberNo();
        List<Cart> cart = storeService.getCartItems(memberNo);
        mv.addObject("cart", cart);
        mv.setViewName("order/orderView");
        return mv;
    }
    
    
}