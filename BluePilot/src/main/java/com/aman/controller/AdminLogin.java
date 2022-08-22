package com.aman.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aman.dao.DAO;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String adminid = request.getParameter("adminid");
			String password = request.getParameter("password");
			DAO database = new DAO();
			
			String name = database.adminLogin(adminid, password);
			database.disconnect();
			HttpSession session = request.getSession();
			
			if(name != null) {
				session.setAttribute("name", name);
				response.sendRedirect("adminHome.jsp");
			} else {
				session.setAttribute("message", "Incorrect ID or Password!");
				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
