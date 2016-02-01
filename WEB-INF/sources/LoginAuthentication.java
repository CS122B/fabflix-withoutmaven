
/* A servlet to display the contents of the MySQL movieDB database */

import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.InitialContext;
import javax.naming.Context;
import javax.sql.DataSource;

public class LoginAuthentication extends HttpServlet
{
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession();
    PrintWriter out = response.getWriter();

    try {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/movieDB");
      Connection dbcon = ds.getConnection();

      String email = request.getParameter("email");
      String password = request.getParameter("password");
      String query = (
        "SELECT * " +
        "FROM customers " +
        "WHERE email = ? AND password = ?"
      );

      PreparedStatement statement = dbcon.prepareStatement(query);
      statement.setString(1, email);
      statement.setString(2, password);

      ResultSet rs = statement.executeQuery();
      String firstName;
      String userId;
      session = request.getSession(); 

      while (rs.next()) {
        firstName = rs.getString("first_name");
        userId = rs.getString("id");
        session.setAttribute("userFirstName", firstName);
        session.setAttribute("userId", userId);
      }

      rs.close();
      statement.close();
      dbcon.close();

      String redirectURL = (request.getParameter("redirect") == null)
        ? request.getContextPath() + "/"
        : request.getParameter("redirect");

      response.sendRedirect(redirectURL);
    }
    catch (SQLException ex) {
      response.sendError(400, "No results");
    } catch (java.lang.Exception ex) {
      response.sendError(401, "Not validated");
    }
    out.close();
  }
}