package com.coffeebeans.auto.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Provides service end points for login/logout related functionalities
 */
@Controller
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 4685977675148902408L;
    private static final Logger LOGGER = LoggerFactory.getLogger(LoginServlet.class);


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String password = (String) request.getSession().getAttribute("password");
        try {
            String userId = (String) request.getParameter("userId");
            System.out.println("user id is " + userId);
            boolean authorized = true;

            if (authorized) {

                response.sendRedirect("home.htm");
            } else {
                response.sendRedirect("error.htm");
            }
   
        } catch (Exception e) {
            System.out.println("Exception:" + e.getMessage());
            response.sendRedirect("err.htm");
        }
    }

    @RequestMapping("/login")
    public String moveToIndex(ModelMap map, HttpSession ses) {
        return "login";
    }

    @RequestMapping(value = "/closeSession")
    public void killSession(HttpServletRequest request, HttpSession session) {

        if (request.getSession(false) != null) {
            request.getSession(false).invalidate();
            LOGGER.info("Automator Session invalidated");
        }

    }
}
