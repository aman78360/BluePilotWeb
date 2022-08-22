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

@WebServlet("/UpdateCourse")
@MultipartConfig
public class UpdateCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// Getting all the inputs from the form
			String name = request.getParameter("name");
			String oldName = request.getParameter("oldName");
			int fee = Integer.parseInt(request.getParameter("fee"));
			String duration = request.getParameter("duration");
			String content = request.getParameter("content");
			Part part = request.getPart("image");
			InputStream image;
			//If we get null as image
			if(part.getSize() == 0) image = null;
			else image = part.getInputStream();
			
			//Database Code
			DAO database = new DAO();
			String result = database.updateCourse(name, fee, duration, content, image, oldName);
			database.disconnect();
			HttpSession session = request.getSession();
			
			if(result.equalsIgnoreCase("success")) {
				session.setAttribute("message", "Course Updated Successfully");
				response.sendRedirect("adminCourseDetails.jsp?courseName="+name);
				
			} else {
				session.setAttribute("message", "Course Name Already Exist!");
				response.sendRedirect("adminCourseDetails.jsp?courseName="+oldName);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
