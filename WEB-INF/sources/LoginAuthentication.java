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

public class LoginAuthentication extends HttpServlet {
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

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    PrintWriter out = response.getWriter();
    String isRedirect = request.getParameter("redirect");
    String redirectURL;

    response.setContentType("text/plain");
    response.setCharacterEncoding("utf-8");

    try {
      String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
      boolean isValidRecaptcha = VerifyUtils.verify(gRecaptchaResponse);

      if (!isValidRecaptcha) {
        redirectURL =
          request.getContextPath() + "/login?error=recaptcha" +
          (isRedirect == null ? "" : "&redirect=" + isRedirect);

        response.sendRedirect(redirectURL);
        return;
      }

      Connection dbcon = getConnection();

      try {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String query = (
          "SELECT * " +
          "FROM customers " +
          "WHERE email = ? AND password = ?"
        );

        PreparedStatement statement = dbcon.prepareStatement(query);

        try {
          statement.setString(1, email);
          statement.setString(2, password);

          ResultSet rs = statement.executeQuery();

          try {
            String firstName;
            String userId;
            HttpSession session = request.getSession();

            if (!rs.isBeforeFirst()) {
              throw new SQLException();
            }

            rs.next();

            firstName = rs.getString("first_name");
            userId = rs.getString("id");
            session.setAttribute("userFirstName", firstName);
            session.setAttribute("userId", userId);

            redirectURL = isRedirect == null
              ? request.getContextPath() + "/"
              : isRedirect;
            response.sendRedirect(redirectURL);
          } finally {
            rs.close();
          }
        } finally {
          statement.close();
        }
      } finally {
        dbcon.close();
      }
    } catch (SQLException ex) {
      redirectURL =
        request.getContextPath() + "/login?error=noUser" +
        (isRedirect == null ? "" : "&redirect=" + isRedirect);
      response.sendRedirect(redirectURL);
    } catch (java.lang.Exception ex) {
      response.sendError(401, "Not validated");
    } finally {
      out.close();
    }
  }
}