<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="controllers.DataBaseController"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="logic.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Main</title>
</head>
<body>
	<form method="get" action="http://localhost:8080/MyTask/main.jsp">
	Пользователь: <input type="text" name="name"> <input
			type="submit" value="Поиск" name="search">
	<input type="button" value="Добавить нового пользователя" onClick="location.href='http://localhost:8080/MyTask/addUser.jsp'">
	
		<%
			DataBaseController controller = new DataBaseController();
			controller.connectToDataBase();

			ResultSet rs = null;
			String name = request.getParameter("name");
			rs = controller.selectAllQuery();

			if ("".equals(name) || name == null) {
				rs = controller.selectAllQuery();
			} else {
				rs = controller.selectUserByName(name);
			}

			ArrayList<User> users = new ArrayList<>();
			try {
				while (rs.next()) {
					User user = new User(rs.getInt(1), rs.getString(2));
					users.add(user);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			controller.disconnectFromDataBase();
			PrintWriter pw = response.getWriter();
			if (users.size()!=0){
				
				pw.println("<table border = &Prime;1&Prime;");
				pw.println("<tr>");
				pw.println("<td>Id</td>");
				pw.println("<td>Name</td>");
				pw.println("</tr>");

				for (int i = 0; i < users.size(); i++) {
					pw.println("<tr>");
					pw.println("<td>" + users.get(i).getId() + "</td><td>" + users.get(i).getName() + "</td>");
					pw.println("</tr>");
				}
				pw.println("</table>");
			} else {
				pw.println("Пользователь не найден");
			}
			
		%>
	
	</form>

</body>
</html>