package controllers;

import java.sql.*;

public class DataBaseController {

	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost:3306/test";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "root";

	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs;
	
	public void connectToDataBase(){
		try {
			Class.forName(JDBC_DRIVER);
			con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			stmt = con.createStatement();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void disconnectFromDataBase(){
		try {
			rs.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void insertRow(String name){
		try {
			PreparedStatement pstmt = con.prepareStatement("INSERT INTO test.mytable(name) VALUE (?)");
			pstmt.setString(1, name);
			pstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
	
	public ResultSet selectAllQuery(){
		try {
			rs = stmt.executeQuery("SELECT * FROM test.myTable");
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}

	public ResultSet selectUserByName(String name){
		try {
			rs = stmt.executeQuery("SELECT * FROM test.myTable WHERE name=\"" + name + "\"");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

}
