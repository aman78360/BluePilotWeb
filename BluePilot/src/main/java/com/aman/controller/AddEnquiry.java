package com.aman.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aman.dao.DAO;
import com.mysql.cj.Session;

@WebServlet("/AddEnquiry")
public class AddEnquiry extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			DAO database = new DAO();
			database.addEnquiry(name, phone);
			database.disconnect();
			HttpSession session = request.getSession();
			session.setAttribute("message", "Thanks for Contacting Us...! We Will Contact You Soon.");
			response.sendRedirect("index.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
