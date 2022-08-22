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

@WebServlet("/PilotRegister")
@MultipartConfig
public class PilotRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String emailid = request.getParameter("emailid");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			int experience = Integer.parseInt(request.getParameter("experience"));
			String phone = request.getParameter("phone");
			String gender = request.getParameter("gender");
			String address = request.getParameter("address");
			Part part = request.getPart("photo");
			InputStream photo = part.getInputStream();
			
			HashMap pilot = new HashMap();
			
			pilot.put("emailid", emailid);
			pilot.put("password", password);
			pilot.put("name", name);
			pilot.put("experience", experience);
			pilot.put("phone", phone);
			pilot.put("gender", gender);
			pilot.put("address", address);
			pilot.put("photo", photo);
			
			DAO database = new DAO();
			String result = database.addPilot(pilot);
			database.disconnect();
			HttpSession session = request.getSession();
			
			if(result.equalsIgnoreCase("success")) {
				session.setAttribute("message", "Pilot Added Successfully");
				
			} else {
				session.setAttribute("message", "Pilot Already Exist!");
			}
			response.sendRedirect("pilot.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
