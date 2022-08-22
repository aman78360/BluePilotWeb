package com.aman.dao;

import java.io.InputStream;
import java.io.ObjectInputFilter.Status;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeSet;

import org.apache.catalina.connector.Response;

public class DAO {
	private Connection c;

	public DAO() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		c = DriverManager.getConnection("jdbc:mysql://localhost:3306/bluepilotdb", "root", "7836088006aA");
	}

	public void disconnect() throws SQLException {
		c.close();
	}

	public void addEnquiry(String name, String phone) throws SQLException {

		PreparedStatement p = c
				.prepareStatement("insert into enquiries (name, phone_no, status) values(?, ?, 'pending')");
		p.setString(1, name);
		p.setString(2, phone);
		p.executeUpdate();
	}

	public String adminLogin(String adminid, String password) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from admin where adminid = ? and password = ?");
		p.setString(1, adminid);
		p.setString(2, password);

		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			return rs.getString("name");
		} else {
			return null;
		}
	}

	public String userLogin(String emailid, String password) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from users where emailid = ? and password = ?");

		p.setString(1, emailid);
		p.setString(2, password);
		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			return rs.getString("name");
		} else {
			return null;
		}
	}

	public String pilotLogin(String emailid, String password) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from pilots where emailid = ? and password = ?");

		p.setString(1, emailid);
		p.setString(2, password);
		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			return rs.getString("name");
		} else {
			return null;
		}
	}

	public ArrayList<HashMap> getAllEnquiries() throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from enquiries");
		ArrayList<HashMap> enquiries = new ArrayList<>();
		ResultSet rs = p.executeQuery();

		while (rs.next()) {
			HashMap<String, String> enquiry = new HashMap();
			enquiry.put("enquiry_id", rs.getInt("enquiry_id") + "");
			enquiry.put("name", rs.getString("name"));
			enquiry.put("phone_no", rs.getString("phone_no"));
			enquiry.put("status", rs.getString("status"));

			enquiries.add(enquiry);
		}
		return enquiries;
	}

	public void updateEnquiryStatus(int enquiry_id) throws SQLException {

		PreparedStatement p = c.prepareStatement("update enquiries set status = 'Done' where enquiry_id = ?");
		p.setInt(1, enquiry_id);
		p.executeUpdate();
	}

	public void updatePilotStatus(String emailid, String status) throws SQLException {

		PreparedStatement p = c.prepareStatement("update pilots set status = ? where emailid = ?");
		p.setString(1, status);
		p.setString(2, emailid);
		p.executeUpdate();
	}

	public String addCourse(String name, int fee, String duration, String content, InputStream image)
			throws SQLException {

		PreparedStatement p = c
				.prepareStatement("insert into courses (name, fee, duration, content, image) values(?, ?, ?, ?, ?)");
		p.setString(1, name);
		p.setInt(2, fee);
		p.setString(3, duration);
		p.setString(4, content);
		p.setBinaryStream(5, image);

		try {
			p.executeUpdate();
			return "success";

		} catch (SQLIntegrityConstraintViolationException e) {
			return "already exists";
		}
	}

	public void addQuestion(String pilot_email, String user_email, String question) throws SQLException {

		PreparedStatement p = c
				.prepareStatement("insert into conversation (pilot_email, user_email, question, question_date) values(?, ?, ?, CURRENT_DATE)");
		p.setString(1, pilot_email);
		p.setString(2, user_email);
		p.setString(3, question);
		
		p.executeUpdate();
	}
	
	public void reply(int id, String answer) throws SQLException {

		PreparedStatement p = c
				.prepareStatement("update conversation set answer = ? where id = ?");
		
		p.setString(1, answer);
		p.setInt(2, id);
		
		p.executeUpdate();
	}

	public String assignPilotCourse(String pilot_email, String course_name) throws SQLException {

		PreparedStatement p = c
				.prepareStatement("select * from pilotcourses where pilot_email = ? and course_name = ?");
		p.setString(1, pilot_email);
		p.setString(2, course_name);

		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			return "failed";

		} else {
			p = c.prepareStatement("insert into pilotcourses (pilot_email, course_name) values (?, ?)");
			p.setString(1, pilot_email);
			p.setString(2, course_name);
			p.executeUpdate();
			return "Success";
		}

	}

	public String userEnroll(String user_email, String course_name) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from userenroll where user_email = ? and course_name = ?");
		p.setString(1, user_email);
		p.setString(2, course_name);

		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			return "failed";

		} else {
			p = c.prepareStatement("insert into userenroll (user_email, course_name) values (?, ?)");
			p.setString(1, user_email);
			p.setString(2, course_name);
			p.executeUpdate();
			return "Success";
		}

	}

	public String addUser(HashMap user) throws SQLException {

		PreparedStatement p = c.prepareStatement(
				"insert into users (emailid, password, name, age, phone, gender, address, photo) values(?, ?, ?, ?, ?, ?, ?, ?)");

		p.setString(1, (String) user.get("emailid"));
		p.setString(2, (String) user.get("password"));
		p.setString(3, (String) user.get("name"));
		p.setInt(4, (int) user.get("age"));
		p.setString(5, (String) user.get("phone"));
		p.setString(6, (String) user.get("gender"));
		p.setString(7, (String) user.get("address"));
		p.setBinaryStream(8, (InputStream) user.get("photo"));

		try {
			p.executeUpdate();
			return "success";

		} catch (SQLIntegrityConstraintViolationException e) {
			return "already exists";
		}
	}

	public String addPilot(HashMap pilot) throws SQLException {

		PreparedStatement p = c.prepareStatement(
				"insert into pilots (emailid, password, name, experience, phone, gender, address, photo, status) values(?, ?, ?, ?, ?, ?, ?, ?, 'pending')");

		p.setString(1, (String) pilot.get("emailid"));
		p.setString(2, (String) pilot.get("password"));
		p.setString(3, (String) pilot.get("name"));
		p.setInt(4, (int) pilot.get("experience"));
		p.setString(5, (String) pilot.get("phone"));
		p.setString(6, (String) pilot.get("gender"));
		p.setString(7, (String) pilot.get("address"));
		p.setBinaryStream(8, (InputStream) pilot.get("photo"));

		try {
			p.executeUpdate();
			return "success";

		} catch (SQLIntegrityConstraintViolationException e) {
			return "already exists";
		}
	}

	public String updateCourse(String name, int fee, String duration, String content, InputStream image, String oldName)
			throws SQLException {

		PreparedStatement p;

		if (image != null) {

			p = c.prepareStatement(
					"update courses set name = ?, fee = ?, duration = ?, content = ?, image = ? where name = ?");
			p.setString(1, name);
			p.setInt(2, fee);
			p.setString(3, duration);
			p.setString(4, content);
			p.setBinaryStream(5, image);
			p.setString(6, oldName);

		} else {
			p = c.prepareStatement("update courses set name = ?, fee = ?, duration = ?, content = ? where name = ?");
			p.setString(1, name);
			p.setInt(2, fee);
			p.setString(3, duration);
			p.setString(4, content);
			p.setString(5, oldName);
		}

		try {
			p.executeUpdate();
			return "success";

		} catch (SQLIntegrityConstraintViolationException e) {
			return "already exists";
		}
	}

	public ArrayList<HashMap> getAllCourses() throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from courses");
		ResultSet rs = p.executeQuery();

		ArrayList<HashMap> courses = new ArrayList<>();

		while (rs.next()) {
			HashMap course = new HashMap<>();

			course.put("name", rs.getString("name"));
			course.put("fee", rs.getInt("fee"));
			course.put("duration", rs.getString("duration"));
			course.put("content", rs.getString("content"));

			courses.add(course);
		}
		return courses;
	}
	
	public ArrayList<HashMap> getConversation(String pilot_email, String user_email) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from conversation where pilot_email = ? and user_email = ? order by question_date DESC");
		
		p.setString(1, pilot_email);
		p.setString(2, user_email);
		
		ResultSet rs = p.executeQuery();

		ArrayList<HashMap> conversations = new ArrayList<>();

		while (rs.next()) {
			HashMap conversation = new HashMap<>();

			conversation.put("question", rs.getString("question"));
			conversation.put("answer", rs.getString("answer"));
			conversation.put("question_date", rs.getString("question_date"));
			conversation.put("id", rs.getInt("id"));


			conversations.add(conversation);
		}
		return conversations;
	}

	public TreeSet<String> getAllCoursesByUser(String emailid) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from userenroll where user_email = ?");
		p.setString(1, emailid);
		ResultSet rs = p.executeQuery();

		TreeSet<String> courseNames = new TreeSet<>();

		while (rs.next()) {

			courseNames.add(rs.getString("course_name"));

		}
		return courseNames;
	}

	public TreeSet<String> getAllCoursesByPilot(String emailid) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from pilotcourses where pilot_email = ?");
		p.setString(1, emailid);
		ResultSet rs = p.executeQuery();

		TreeSet<String> courseNames = new TreeSet<>();

		while (rs.next()) {

			courseNames.add(rs.getString("course_name"));

		}
		return courseNames;
	}

	public TreeSet<String> getAllUserByCourse(String courseName) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from userenroll where course_name = ?");
		p.setString(1, courseName);
		ResultSet rs = p.executeQuery();

		TreeSet<String> userNames = new TreeSet<>();

		while (rs.next()) {

			userNames.add(rs.getString("user_email"));

		}
		return userNames;
	}

	public boolean checkCoursesByUser(String emailid, String courseName) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from userenroll where user_email = ? and course_name = ?");
		p.setString(1, emailid);
		p.setString(2, courseName);
		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			return true;
		}
		return false;
	}

	public ArrayList<HashMap> getAllPilots() throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from pilots");
		ResultSet rs = p.executeQuery();

		ArrayList<HashMap> pilots = new ArrayList<>();

		while (rs.next()) {
			HashMap pilot = new HashMap<>();

			pilot.put("emailid", rs.getString("emailid"));
			pilot.put("name", rs.getString("name"));
			pilot.put("phone", rs.getString("phone"));
			pilot.put("experience", rs.getInt("experience"));
			pilot.put("gender", rs.getString("gender"));
			pilot.put("address", rs.getString("address"));
			pilot.put("status", rs.getString("status"));

			pilots.add(pilot);
		}
		return pilots;
	}

	public TreeSet<String> getAllPilotsEmail() throws SQLException {

		PreparedStatement p = c.prepareStatement("select emailid from pilots where status = 'accepted'");
		ResultSet rs = p.executeQuery();

		TreeSet<String> emailids = new TreeSet<>();

		while (rs.next()) {

			emailids.add(rs.getString("emailid"));
		}
		return emailids;
	}

	public TreeSet<String> getAllPilotsEmailByCourse(String course_name) throws SQLException {

		PreparedStatement p = c.prepareStatement("select pilot_email from pilotcourses where course_name = ?");
		p.setString(1, course_name);
		ResultSet rs = p.executeQuery();

		TreeSet<String> emailids = new TreeSet<>();

		while (rs.next()) {

			emailids.add(rs.getString("pilot_email"));
		}
		return emailids;
	}

	public byte[] getImage(String courseName) throws SQLException {

		PreparedStatement p = c.prepareStatement("select image from courses where name = ?");
		p.setString(1, courseName);
		ResultSet rs = p.executeQuery();
		rs.next();
		byte[] image = rs.getBytes("image");
		return image;

	}

	public byte[] getPhoto(String emailid, String userType) throws SQLException {

		PreparedStatement p;

		if (userType.equalsIgnoreCase("user")) {

			p = c.prepareStatement("select photo from users where emailid = ?");

		} else {
			p = c.prepareStatement("select photo from pilots where emailid = ?");
		}

		p.setString(1, emailid);
		ResultSet rs = p.executeQuery();
		rs.next();
		byte[] image = rs.getBytes("photo");
		return image;
	}

	public HashMap getCourseByName(String courseName) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from courses where name = ?");
		p.setString(1, courseName);
		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			HashMap course = new HashMap<>();

			course.put("name", rs.getString("name"));
			course.put("fee", rs.getInt("fee"));
			course.put("duration", rs.getString("duration"));
			course.put("content", rs.getString("content"));
			return course;

		} else {
			return null;
		}
	}

	public HashMap getUserByEmailid(String emailid) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from users where emailid = ?");
		p.setString(1, emailid);
		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			HashMap user = new HashMap<>();

			user.put("name", rs.getString("name"));
			user.put("age", rs.getInt("age"));
			user.put("phone", rs.getString("phone"));
			user.put("gender", rs.getString("gender"));
			user.put("address", rs.getString("address"));
			return user;

		} else {
			return null;
		}
	}

	public HashMap getPilotByEmailid(String emailid) throws SQLException {

		PreparedStatement p = c.prepareStatement("select * from pilots where emailid = ?");
		p.setString(1, emailid);
		ResultSet rs = p.executeQuery();

		if (rs.next()) {
			HashMap pilot = new HashMap<>();

			pilot.put("name", rs.getString("name"));
			pilot.put("experience", rs.getInt("experience"));
			pilot.put("phone", rs.getString("phone"));
			pilot.put("gender", rs.getString("gender"));
			pilot.put("address", rs.getString("address"));
			return pilot;

		} else {
			return null;
		}
	}

	public String getPilotStatus(String emailid) throws SQLException {

		PreparedStatement p = c.prepareStatement("select status from pilots where emailid = ?");
		p.setString(1, emailid);

		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			return rs.getString("status");

		} else {
			return null;
		}
	}
}
