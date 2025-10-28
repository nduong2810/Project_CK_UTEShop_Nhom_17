package com.uteshop.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/customers/appeal")
public class AdminCustomersAppealController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String userId = req.getParameter("userId");
		String message = req.getParameter("message");

		// TODO: Lưu DB / gửi email / push Slack...
		// Ví dụ stub:
		System.out.println("[APPEAL] userId=" + userId + " | message=" + message);

		// Điều hướng về danh sách + thông báo
		resp.sendRedirect(req.getContextPath() + "/admin/customers?msg=appeal_received");
	}
}
