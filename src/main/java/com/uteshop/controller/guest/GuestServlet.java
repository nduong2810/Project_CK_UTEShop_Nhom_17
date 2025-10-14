package com.uteshop.controller.guest;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/guest/*")
public class GuestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        System.out.println("GuestServlet - PathInfo received: " + path);

        String view;
        switch (path == null ? "" : path) {
            case "/login":
                view = "/WEB-INF/views/guest/login.jsp";
                break;
            case "/register":
                view = "/WEB-INF/views/guest/register.jsp";
                break;
            case "/verify-otp":
                view = "/WEB-INF/views/guest/verify-otp.jsp";
                break;
            case "/home":
            default:
                view = "/WEB-INF/views/guest/home.jsp";
                break;
        }

        System.out.println("GuestServlet - Forwarding to view: " + view);
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }
}
