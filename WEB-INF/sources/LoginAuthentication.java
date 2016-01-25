
/* A servlet to display the contents of the MySQL movieDB database */

import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginAuthentication extends HttpServlet
{
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession();
    PrintWriter out = response.getWriter();

    // if (session != null) {
    //   out.println("you're already logged in, log out first");
    //   out.close();
    //   return;
    // }

    String loginUser = "testuser";
    String loginPasswd = "testpassword";
    String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

    try {
      Class.forName("com.mysql.jdbc.Driver").newInstance();
      Connection dbcon = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
      String email = request.getParameter("email");
      String password = request.getParameter("password");
      String query = (
        "SELECT first_name " +
        "FROM customers " +
        "WHERE email = ? AND password = ?"
      );

      PreparedStatement statement = dbcon.prepareStatement(query);
      statement.setString(1, email);
      statement.setString(2, password);

      ResultSet rs = statement.executeQuery();
      String firstName;
      session = request.getSession(); 

      while (rs.next()) {
        firstName = rs.getString("first_name");
        out.println(firstName);
        session.setAttribute("userFirstName", firstName);
      }

      rs.close();
      statement.close();
      dbcon.close();

      String redirectURL = request.getParameter("redirect") == null
      ? "/TomcatForm"
      : request.getParameter("redirect");

      response.sendRedirect(redirectURL);
    }
    catch (SQLException ex) {
      while (ex != null) {
        System.out.println ("SQL Exception:  " + ex.getMessage ());
        ex = ex.getNextException();
      }
    } catch(java.lang.Exception ex) {
      out.println(
        "<HTML>" +
        "<HEAD><TITLE>" +
        "MovieDB: Error" +
        "</TITLE></HEAD>\n<BODY>" +
        "<P>SQL error in doGet: " +
        ex.getMessage() + "</P></BODY></HTML>");
      return;
    }
    out.close();
  }
}