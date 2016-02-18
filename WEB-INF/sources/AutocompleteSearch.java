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


public class AutocompleteSearch extends HttpServlet {
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
      String titleQuery =
        request
        .getPathInfo()
        .replace("/", "");

      String[] decoded =
        java.net.URLDecoder.decode(titleQuery, "utf-8")
        .split(" ");

      StringBuilder decodedToSQL = new StringBuilder();
      for (String s : decoded) {
        decodedToSQL.append(" +" + s);
      }
      decodedToSQL.append("*");

      Connection dbcon = getConnection();

      try {
        String query = (
          "SELECT id, title, year, banner_url " +
          "FROM movies " +
          "WHERE MATCH(title) " +
          "AGAINST (? IN BOOLEAN MODE) " +
          "LIMIT 5"
        );

        PreparedStatement statement = dbcon.prepareStatement(query);

        try {
          statement.setString(1, decodedToSQL.toString());
          ResultSet rs = statement.executeQuery();

          try {
            JsonObjectBuilder jsonResponseBuilder = Json.createObjectBuilder();
            JsonArrayBuilder titleListBuilder = Json.createArrayBuilder();

            if (rs.isBeforeFirst()) {
              while (rs.next()) {
                JsonObjectBuilder movieBuilder = Json.createObjectBuilder()
                  .add("id", rs.getString("id"))
                  .add("title", rs.getString("title"))
                  .add("year", rs.getString("year"))
                  .add("banner", rs.getString("banner_url"));

                titleListBuilder.add(movieBuilder);
              }
            }

            jsonResponseBuilder.add("suggestions", titleListBuilder);

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