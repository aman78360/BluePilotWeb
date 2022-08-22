package com.aman.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aman.dao.DAO;

@WebServlet("/GetPhoto")
public class GetPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String emailid = request.getParameter("emailid");
			String userType = request.getParameter("userType");
			
			DAO database = new DAO();
			byte []image = database.getPhoto(emailid, userType);
			database.disconnect();
			if(image != null) {
				response.getOutputStream().write(image);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
