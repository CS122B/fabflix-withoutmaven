import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutPage extends HttpServlet
{
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession(false);

    if (session != null) {
      session.invalidate();
    }

    String loginPage = request.getContextPath() + "/login";
    response.sendRedirect(loginPage);
  }
}
