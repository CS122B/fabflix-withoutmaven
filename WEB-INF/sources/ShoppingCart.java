
/* A servlet to display the contents of the MySQL movieDB database */

import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ShoppingCart extends HttpServlet
{
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException
    {
		HttpSession session = request.getSession(false);
        PrintWriter out = response.getWriter();
		
		if (session == null) {
			String redirectURL = "?redirect=" + request.getRequestURI();
			response.sendRedirect("/TomcatForm/login" + redirectURL);
		} else {
			String firstName = (String)session.getAttribute("userFirstName");
			out.println(firstName + ", here is your shopping cart");
		}
		
         out.close();
    }
}