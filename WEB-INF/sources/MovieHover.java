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
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.json.*;


public class MovieHover extends HttpServlet {
  public DataSource datasource;

  public void init(ServletConfig config)
    throws ServletException
  {
    try {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      datasource = (DataSource) envCtx.lookup("jdbc/movieDB");
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private Connection getConnection()
    throws SQLException
  {
    return datasource.getConnection();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    PrintWriter out = response.getWriter();

    response.setContentType("text/plain");
    response.setCharacterEncoding("utf-8");

    try {
      String movieIdPath = request.getPathInfo();
      movieIdPath = movieIdPath.replace("/", "");
      int movieId = Integer.parseInt(movieIdPath);

      Connection dbcon = getConnection();

      try {
        String query = (
          "SELECT m.id, m.title, m.year, m.director, m.banner_url, " +
          "  m.trailer_url, sim.star_id, s.first_name, s.last_name " +
          "FROM movies m " +
          "INNER JOIN stars_in_movies sim " +
          "  ON m.id = sim.movie_id " +
          "INNER JOIN stars s " +
          "  ON sim.star_id = s.id " +
          "WHERE m.id = ?"
        );

        PreparedStatement statement = dbcon.prepareStatement(query);

        try {
          statement.setInt(1, movieId);

          ResultSet rs = statement.executeQuery();

          try {
            if (!rs.isBeforeFirst()) {
              throw new SQLException();
            }

            rs.next();

            JsonObjectBuilder jsonResponseBuilder = Json.createObjectBuilder()
              .add("id", rs.getString("id"))
              .add("title", rs.getString("title"))
              .add("year", rs.getString("year"))
              .add("director", rs.getString("director"))
              .add("banner_url", rs.getString("banner_url"))
              .add("trailer_url", rs.getString("trailer_url"));

            JsonArrayBuilder actorListBuilder = Json.createArrayBuilder();

            do {
              JsonObjectBuilder actorBuilder = Json.createObjectBuilder()
                .add("id", rs.getString("star_id"))
                .add("first_name", rs.getString("first_name"))
                .add("last_name", rs.getString("last_name"));

              actorListBuilder.add(actorBuilder);

            } while (rs.next());

            jsonResponseBuilder.add("actors", actorListBuilder);

            JsonObject jsonResponse = jsonResponseBuilder.build();

            StringWriter stringWriter = new StringWriter();
            JsonWriter writer = Json.createWriter(stringWriter);
            writer.writeObject(jsonResponse);
            writer.close();

            response.setStatus(200);
            out.write(stringWriter.getBuffer().toString());
          } finally {
            rs.close();
          }
        } finally {
          statement.close();
        }
      } finally {
        dbcon.close();
      }
    } catch (java.lang.Exception ex) {
      response.setStatus(400);
      out.write(ex.getMessage());
    } finally {
      out.close();
    }
  }
}