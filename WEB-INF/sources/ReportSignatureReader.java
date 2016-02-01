import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ReportSignatureReader extends HttpServlet
{
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    PrintWriter out = response.getWriter();
    out.println(SignatureReader.getSignature("/var/lib/tomcat7/webapps/fabflix/"));
    out.close();
  }
}
