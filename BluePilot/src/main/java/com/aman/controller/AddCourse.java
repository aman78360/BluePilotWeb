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

@WebServlet("/AddCourse")
@MultipartConfig
public class AddCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name = request.getParameter("name");
			int fee = Integer.parseInt(request.getParameter("fee"));
			String duration = request.getParameter("duration");
			String content = request.getParameter("content");
			Part part = request.getPart("image");
			InputStream image = part.getInputStream();
			
			DAO database = new DAO();
			String result = database.addCourse(name, fee, duration, content, image);
			database.disconnect();
			HttpSession session = request.getSession();
			
			if(result.equalsIgnoreCase("success")) {
				session.setAttribute("message", "Course Added Successfully");
				
			} else {
				session.setAttribute("message", "Course Already Exist!");
			}
			response.sendRedirect("adminCourses.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
