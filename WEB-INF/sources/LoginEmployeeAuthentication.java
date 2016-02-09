
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

public class LoginEmployeeAuthentication extends HttpServlet
{
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession();
    String redirectURL = request.getContextPath() + "/_dashboard";

    try {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/movieDB");
      Connection dbcon = ds.getConnection();

      String email = request.getParameter("email");
      String password = request.getParameter("password");
      String query = (
        "SELECT email, fullname " +
        "FROM employees " +
        "WHERE email = ? AND password = ?"
      );

      PreparedStatement statement = dbcon.prepareStatement(query);
      statement.setString(1, email);
      statement.setString(2, password);

      ResultSet rs = statement.executeQuery();
      String employeeEmail = "";
      String employeeFullName;
      session = request.getSession(); 

      while (rs.next()) {
        employeeEmail = rs.getString("email");
        employeeFullName = rs.getString("fullname");
        session.setAttribute("employeeFullName", employeeFullName);
        session.setAttribute("employeeEmail", employeeEmail);
      }

      rs.close();
      statement.close();
      dbcon.close();

      response.sendRedirect(redirectURL + "?poop=" + employeeEmail);
    }
    catch (SQLException ex) {
      response.sendRedirect(redirectURL + "?error=400");
    } catch (java.lang.Exception ex) {
      response.sendRedirect(redirectURL + "?error=401");
    }
  }
}