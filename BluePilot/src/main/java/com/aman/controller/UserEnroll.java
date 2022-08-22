package com.aman.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aman.dao.DAO;

@WebServlet("/UserEnroll")
public class UserEnroll extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name = request.getParameter("name");
			HttpSession session = request.getSession();
			String emailid = (String)session.getAttribute("emailid");
			
			if(emailid == null) {
				session.setAttribute("message", "Please Login First!");
				response.sendRedirect("user.jsp");
				
			} else {
				
				DAO database = new DAO();
				String result = database.userEnroll(emailid, name);
				database.disconnect();
				
				if(result.equalsIgnoreCase("success")) {
					session.setAttribute("message", "Succesfully Enrolled!");
					
				} else {
					session.setAttribute("message", "Already Enrolled!");
				}
				response.sendRedirect("courseDetails.jsp?courseName="+name);
				
			}

			
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
		
	}

}
