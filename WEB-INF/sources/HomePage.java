import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HomePage extends HttpServlet
{
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession(false);
    PrintWriter out = response.getWriter();

    if (session == null) {
      out.println("not logged in");
    } else {
      String firstName = (String)session.getAttribute("userFirstName");
      out.println("logged in as: " + firstName);
    }

    out.close();
  }
}
