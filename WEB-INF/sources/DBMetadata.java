import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.InitialContext;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBMetadata extends HttpServlet
{
  private String getTableMetadata(String tableName)
    throws SQLException, NamingException
  {
    String query = "SELECT * FROM " + tableName;
    Context initCtx = new InitialContext();
    Context envCtx = (Context) initCtx.lookup("java:comp/env");
    DataSource ds = (DataSource) envCtx.lookup("jdbc/movieDB");
    Connection dbcon = ds.getConnection();
    Statement statement = dbcon.createStatement();
    ResultSet rs = statement.executeQuery(query);
    ResultSetMetaData metadata = rs.getMetaData();

    String toReturn = (
      "<table class=\"table table-bordered\">" +
      "  <caption>" + tableName + "</caption>" +
      "  <thead>" +
      "    <tr>" +
      "      <th>Attribute</th>" +
      "      <th>Type</th>" +
      "    </tr>" +
      "  </thead>" +
      "  <tbody>"
    );
    for (int i=1; i <= metadata.getColumnCount(); ++i) {
      String colAttribute = metadata.getColumnName(i);
      String colType = metadata.getColumnTypeName(i);
      toReturn += (
        "<tr>" +
        "  <th>" + colAttribute + "</th>" +
        "  <th>" + colType + "</th>" +
        "</tr>"
      );
    }

    toReturn += (
      "  </tbody>" +
      "</table>"
    );

    rs.close();
    statement.close();
    dbcon.close();
    return toReturn;
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    try {
      String tableData = "";
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/movieDB");
      Connection dbcon = ds.getConnection();

      DatabaseMetaData metadata = dbcon.getMetaData();
      ResultSet rs = metadata.getTables(null, null, "%", null);
      while (rs.next()) {
        tableData += getTableMetadata(rs.getString(3));
      }

      response.setContentType("text/plain");
      response.setCharacterEncoding("utf-8");
      response.setStatus(200);
      response.getWriter().write(tableData);

      rs.close();
      dbcon.close();

    } catch (SQLException ex) {
      response.sendError(400, "No results");
    } catch (java.lang.Exception ex) {
      response.sendError(401, "Not validated");
    }
  }
}