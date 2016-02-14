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

public class AddStar extends HttpServlet
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
        String nameRaw = request.getParameter("actorName");
        String[] nameSplit = nameRaw.split(" ");
        String firstName = "";
        String lastName = "";
        String dob = request.getParameter("actorDob");
        String photoUrl = request.getParameter("actorPhotoUrl");

        if (nameRaw.equals("")) {
          response.setStatus(400);
          out.write("Missing required fields.");
          return;
        }

        // add actor only with last name
        if (nameSplit.length == 1) {
          lastName = nameSplit[0];
        } else {
          firstName = nameSplit[0];
          lastName = nameSplit[1];
        }

        String query = (
          "INSERT INTO stars " +
          "(" +
          "  first_name, " +
          "  last_name, " +
          "  dob, " +
          "  photo_url" +
          ") " +
          "VALUES (?,?,?,?)"
        );

        PreparedStatement statement = dbcon.prepareStatement(query);

        try {
          statement.setString(1, firstName);
          statement.setString(2, lastName);
          statement.setString(3, dob);
          statement.setString(4, photoUrl);

          statement.executeUpdate();

          response.setStatus(200);
          out.write(nameRaw + " has been added.");
        } finally {
          statement.close();
        }
      } finally {
        dbcon.close();
      }
    } catch (SQLException ex) {
      response.setStatus(400);
      out.write(ex.getMessage());
    } catch (java.lang.Exception ex) {
      response.setStatus(401);
      out.write(ex.getMessage());
    } finally {
      out.close();
    }
  }
}