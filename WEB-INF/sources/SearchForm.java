
/* A servlet to display the contents of the MySQL movieDB database */

import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SearchForm extends HttpServlet
{
    public String getServletInfo()
    {
        return "Servlet connects to MySQL database and displays result of a SELECT";
    }

    // Use http GET

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException
    {
        String loginUser = "testuser";
        String loginPasswd = "testpassword";
        String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

        response.setContentType("text/html");    // Response mime type

        // Output stream to STDOUT
        PrintWriter out = response.getWriter();

        out.println("<HTML><HEAD><TITLE>MovieDB</TITLE></HEAD>");
        out.println("<BODY><H2>Search results for: </H2>");


        try
        {
            //Class.forName("org.gjt.mm.mysql.Driver");
            Class.forName("com.mysql.jdbc.Driver").newInstance();

            Connection dbcon = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
            // Declare our statement
            Statement statement = dbcon.createStatement();

            String searchInput = request.getParameter("input");
            String searchCriteria = request.getParameter("criteria");
            out.println("<b>" + searchInput + "</b>");

            String query = "SELECT * from movies WHERE " + searchCriteria + " LIKE '%" + searchInput + "%'";

            // Perform the query
            ResultSet rs = statement.executeQuery(query);

            out.println("<TABLE border>");

            // Iterate through each row of rs
            while (rs.next())
            {
                String ID = rs.getString("ID");
                String title = rs.getString("title");
                String year = rs.getString("year");
                String banner = rs.getString("banner_url");
                out.println("<tr>" +
                        "<td>" + title + "</td>" +
                        "<td>" + year + "</td>" +
                        "<td><img src='" + banner + "'></td>" +
                        "</tr>");
            }

            out.println("</TABLE>");

            rs.close();
            statement.close();
            dbcon.close();
        }
        catch (SQLException ex) {
            while (ex != null) {
                System.out.println ("SQL Exception:  " + ex.getMessage ());
                ex = ex.getNextException ();
            }  // end while
        }  // end catch SQLException

        catch(java.lang.Exception ex)
        {
            out.println("<HTML>" +
                    "<HEAD><TITLE>" +
                    "MovieDB: Error" +
                    "</TITLE></HEAD>\n<BODY>" +
                    "<P>SQL error in doGet: " +
                    ex.getMessage() + "</P></BODY></HTML>");
            return;
        }
        out.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException
    {
        doGet(request, response);
    }
}