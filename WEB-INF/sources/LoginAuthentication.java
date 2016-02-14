
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
    PrintWriter out = response.getWriter();

    response.setContentType("text/plain");
    response.setCharacterEncoding("utf-8");

    try {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/movieDB");
      Connection dbcon = ds.getConnection();

      try {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String query = (
          "SELECT * " +
          "FROM customers " +
          "WHERE email = ? AND password = ?"
        );

        PreparedStatement statement = dbcon.prepareStatement(query);

        try {
          statement.setString(1, email);
          statement.setString(2, password);

          ResultSet rs = statement.executeQuery();

          try {
            String firstName;
            String userId;
            HttpSession session = request.getSession();

            while (rs.next()) {
              firstName = rs.getString("first_name");
              userId = rs.getString("id");
              session.setAttribute("userFirstName", firstName);
              session.setAttribute("userId", userId);
            }

            String isRedirect = request.getParameter("redirect");
            String redirectURL = isRedirect == null
              ? request.getContextPath() + "/"
              : isRedirect;

            response.sendRedirect(redirectURL);
          } finally {
            rs.close();
          }
        } finally {
          statement.close();
        }
      } finally {
        dbcon.close();
      }
    } catch (SQLException ex) {
      response.sendError(400, "No results");
    } catch (java.lang.Exception ex) {
      response.sendError(401, "Not validated");
    } finally {
      out.close();
    }
  }
}