package com.aman.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aman.dao.DAO;

@WebServlet("/PilotStatusUpdate")
public class PilotStatusUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String emailid = (request.getParameter("emailid"));
			String status = (request.getParameter("status"));

			DAO database = new DAO();
			database.updatePilotStatus(emailid, status);
			database.disconnect();
			response.sendRedirect("adminPilots.jsp");
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
		
	}

}
