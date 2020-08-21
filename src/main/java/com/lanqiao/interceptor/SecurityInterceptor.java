package com.lanqiao.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SecurityInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();

        Object loginAdmin = session.getAttribute("loginAdmin");
        if (loginAdmin == null) {
            response.sendRedirect(request.getContextPath());
            return false;
        }

        return true;
    }
}
