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

@WebServlet("/UserRegister")
@MultipartConfig
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String emailid = request.getParameter("emailid");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			int age = Integer.parseInt(request.getParameter("age"));
			String phone = request.getParameter("phone");
			String gender = request.getParameter("gender");
			String address = request.getParameter("address");
			Part part = request.getPart("photo");
			InputStream photo = part.getInputStream();
			
			HashMap user = new HashMap();
			
			user.put("emailid", emailid);
			user.put("password", password);
			user.put("name", name);
			user.put("age", age);
			user.put("phone", phone);
			user.put("gender", gender);
			user.put("address", address);
			user.put("photo", photo);
			
			DAO database = new DAO();
			String result = database.addUser(user);
			database.disconnect();
			HttpSession session = request.getSession();
			
			if(result.equalsIgnoreCase("success")) {
				session.setAttribute("message", "User Added Successfully");
				
			} else {
				session.setAttribute("message", "User Already Exist!");
			}
			response.sendRedirect("user.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
