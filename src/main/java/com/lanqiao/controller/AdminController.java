package com.lanqiao.controller;

import com.lanqiao.entity.Admin;
import com.lanqiao.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    IAdminService adminService;

    @RequestMapping("/login")
    public String login(Admin admin, HttpSession session){

        Admin loginAdmin = this.adminService.selectForLogin(admin);

        if (loginAdmin != null) {
            session.setAttribute("loginAdmin",loginAdmin);
            return "redirect:/index.jsp";
        }
        return "redirect:/login_form.jsp";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/login_form.jsp";
    }
}
