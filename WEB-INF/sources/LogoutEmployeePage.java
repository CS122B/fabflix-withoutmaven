import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutEmployeePage extends HttpServlet
{
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession(false);

    if (session != null) {
      session.removeAttribute("employeeFullName");
      session.removeAttribute("employeeEmail");
    }

    String loginPage = request.getContextPath() + "/_dashboard";
    response.sendRedirect(loginPage);
  }
}
