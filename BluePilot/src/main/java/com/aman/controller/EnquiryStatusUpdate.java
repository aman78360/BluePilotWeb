package com.aman.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aman.dao.DAO;

@WebServlet("/EnquiryStatusUpdate")
public class EnquiryStatusUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int enquiry_id = Integer.parseInt(request.getParameter("enquiry_id"));
			DAO database = new DAO();
			database.updateEnquiryStatus(enquiry_id);
			database.disconnect();
			response.sendRedirect("adminHome.jsp");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
		
	}

}
