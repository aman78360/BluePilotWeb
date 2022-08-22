package com.aman.controller;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.aman.dao.DAO;
import com.mysql.cj.Session;

@WebServlet("/Answer")
@MultipartConfig
public class Answer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String answer = request.getParameter("answer");
			String user_email = request.getParameter("user_email");
			int id = Integer.parseInt(request.getParameter("id"));
			
			HttpSession session = request.getSession();
			
			DAO database = new DAO();
			database.reply(id, answer);
			database.disconnect();
			session.setAttribute("message", "Reply Sent Successfully");
			
			
			response.sendRedirect("pilotConversation.jsp?user_email="+user_email);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
