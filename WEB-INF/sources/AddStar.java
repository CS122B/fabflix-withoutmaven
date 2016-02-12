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
    HttpSession session = request.getSession();

    try {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/movieDB");
      Connection dbcon = ds.getConnection();

      String nameRaw = request.getParameter("actorName");
      String[] nameSplit = nameRaw.split(" ");
      String firstName = "";
      String lastName = "";
      String dob = request.getParameter("actorDob");
      String photoUrl = request.getParameter("actorPhotoUrl");

      if (nameRaw.equals("") || dob.equals("")) {
        response.sendError(400, "Missing required fields");
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
      statement.setString(1, firstName);
      statement.setString(2, lastName);
      statement.setString(3, dob);
      statement.setString(4, photoUrl);

      statement.executeUpdate();

      response.setContentType("text/plain");
      response.setCharacterEncoding("utf-8");
      response.setStatus(200);
      response.getWriter().write(nameRaw + " has been added.");

      statement.close();
      dbcon.close();

    } catch (SQLException ex) {
      response.sendError(400, "No results");
    } catch (java.lang.Exception ex) {
      response.sendError(401, "Not validated");
    }
  }
}