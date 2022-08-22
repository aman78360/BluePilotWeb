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

@WebServlet("/AskQuestion")
@MultipartConfig
public class AskQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String question = request.getParameter("question");
			String pilot_email = request.getParameter("pilot_email");
			
			HttpSession session = request.getSession();
			String user_email = (String) session.getAttribute("emailid");
			
			DAO database = new DAO();
			database.addQuestion(pilot_email, user_email, question);
			database.disconnect();
			session.setAttribute("message", "Question Sent Successfully");
			
			
			response.sendRedirect("userConversation.jsp?pilot_email="+pilot_email);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
