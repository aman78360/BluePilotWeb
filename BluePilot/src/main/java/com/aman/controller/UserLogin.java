package com.aman.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

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

@WebServlet("/UserLogin")
@MultipartConfig
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String emailid = request.getParameter("emailid");
			String password = request.getParameter("password");
			
			DAO database = new DAO();
			String name = database.userLogin(emailid, password);
			database.disconnect();
			HttpSession session = request.getSession();
			
			if(name != null) {
				session.setAttribute("name", name);
				session.setAttribute("emailid", emailid);
				response.sendRedirect("userHome.jsp");
				
			} else {
				session.setAttribute("message", "Incorrect ID or Password!");
				response.sendRedirect("user.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
