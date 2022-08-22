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

@WebServlet("/AssignPilotCourse")
@MultipartConfig
public class AssignPilotCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// Getting all the inputs from the form
			String pilot_email = request.getParameter("pilot_email");
			String course_name = request.getParameter("course_name");
			
			
			//Database Code
			DAO database = new DAO();
			String result = database.assignPilotCourse(pilot_email, course_name);
			database.disconnect();
			HttpSession session = request.getSession();
			
			if(result.equalsIgnoreCase("success")) {
				session.setAttribute("message", "Pilot Assigned Successfully");
				
			} else {
				session.setAttribute("message", "Pilot Already Assigned!");
			}
			response.sendRedirect("adminCourseDetails.jsp?courseName="+course_name);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
