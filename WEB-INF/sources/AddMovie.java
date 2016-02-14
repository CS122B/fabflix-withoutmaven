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

public class AddMovie extends HttpServlet
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
        String title = request.getParameter("movieTitle");
        String year = request.getParameter("movieYear");
        String director = request.getParameter("movieDirector");
        String bannerURL = request.getParameter("movieBanner");
        String trailerURL = request.getParameter("movieTrailer");
        String star = request.getParameter("star");
        String[] starSplit = star.split(" ");
        String starFirstName = "";
        String starLastName = "";
        String genre = request.getParameter("genre");

        if (title.equals("") || year.equals("") || director.equals("")
            || star.equals("") || genre.equals("")) {
          response.setStatus(400);
          out.write("Missing required fields.");
          return;
        }

        // add actor only with last name
        if (starSplit.length == 1) {
          starLastName = starSplit[0];
        } else {
          starFirstName = starSplit[0];
          starLastName = starSplit[1];
        }

        String statement = "{call add_movie(?,?,?,?,?,?,?,?,?)}";
        CallableStatement callable = dbcon.prepareCall(statement);

        try {
          callable.setString(1, title);
          callable.setString(2, year);
          callable.setString(3, director);
          callable.setString(4, bannerURL);
          callable.setString(5, trailerURL);
          callable.setString(6, starFirstName);
          callable.setString(7, starLastName);
          callable.setString(8, genre);
          callable.registerOutParameter(9, Types.INTEGER);

          callable.execute();

          int queryStatusId = callable.getInt(9);
          String queryStatus = "";
          switch (queryStatusId) {
          case 0:
            queryStatus = "rollback";
            break;
          case 1:
            queryStatus = "inserted";
            break;
          case 2:
            queryStatus = "updated";
            break;
          }

          String responseText = queryStatusId == 0
            ? "Something went wrong with this submission! Try again."
            : "`" + title + "` has been " + queryStatus + ".";

          response.setStatus(200);
          out.write(responseText);
        } finally {
          callable.close();
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