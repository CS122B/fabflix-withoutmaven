
/* A servlet to display the contents of the MySQL movieDB database */

import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HomePage extends HttpServlet
{
    public String getServletInfo()
    {
       return "Servlet connects to MySQL database and displays result of a SELECT";
    }

    // Use http GET

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException
    {
		HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
		
		if (session == null) {
			out.println("not logged in anyway");
		} else {
			String firstName = (String)session.getAttribute("userFirstName");
			out.println("not logged in anyway");
			session.invalidate();
		}
		
         out.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException
    {
	doGet(request, response);
    }
}