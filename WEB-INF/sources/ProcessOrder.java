import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ProcessOrder extends HttpServlet
{

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession(false);
    PrintWriter out = response.getWriter();

    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");


    String contextPath = request.getContextPath();

    try {
      if (session == null || session.getAttribute("userFirstName") == null) {
        throw new Exception("Not logged in.");
      }

      String loginUser = "testuser";
      String loginPasswd = "testpassword";
      String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

      Class.forName("com.mysql.jdbc.Driver").newInstance();

      String firstName = request.getParameter("firstName");
      String lastName = request.getParameter("lastName");
      String creditCardNumber = request.getParameter("creditCardNumber");
      String expirationDate = request.getParameter("expirationDate");
      DateFormat expirationDateFormat = new SimpleDateFormat("yyyy-MM-dd");

      java.util.Date utilExpirationDate = expirationDateFormat.parse(expirationDate);
      java.sql.Date sqlExpirationDate = new java.sql.Date(utilExpirationDate.getTime());
      Connection dbcon = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
      String query = (
        "SELECT * " +
        "FROM creditcards " +
        "WHERE id = ? " + 
        "AND first_name = ? " +
        "AND last_name = ? " + 
        "AND expiration = ?"
      );

      PreparedStatement statement = dbcon.prepareStatement(query);
      statement.setString(1, creditCardNumber);
      statement.setString(2, firstName);
      statement.setString(3, lastName);
      statement.setDate(4, sqlExpirationDate);

      ResultSet rs = statement.executeQuery();


      if (!rs.isBeforeFirst()) {
        throw new Exception("Could not find account with those credentials.");
      }

      String userId = (String)session.getAttribute("userId");
      java.util.Date utilDateToday = new java.util.Date();
      java.sql.Date sqlDateToday = new java.sql.Date(utilDateToday.getTime());

      @SuppressWarnings (value="unchecked")
      Map<Integer, Integer> shoppingCart = (Map<Integer, Integer>)session.getAttribute("shoppingCart");
      if (shoppingCart == null || shoppingCart.isEmpty()) {
        throw new Exception("No movies in shopping cart.");
      }


      String salesQuery = (
        "INSERT INTO sales " +
        "(customer_id, movie_id, sale_date) VALUES " +
        "(?, ?, ?)"
      );

      String mid = "";
      for (Integer movieId : shoppingCart.keySet()) {
        Integer quantity = shoppingCart.get(movieId);

        for (Integer i = 0; i < quantity; ++i) {
          mid += Integer.toString(i);
          PreparedStatement salesStatement = dbcon.prepareStatement(salesQuery);
          salesStatement.setString(1, userId);
          salesStatement.setInt(2, movieId);
          salesStatement.setDate(3, sqlDateToday);

          salesStatement.executeUpdate();
          salesStatement.close();
        }
      }

      shoppingCart.clear();
      session.setAttribute("shoppingCart", shoppingCart);

      rs.close();
      statement.close();
      dbcon.close();

      response.sendRedirect(contextPath + "/confirm?status=success");

    } catch (SQLException ex) {
      response.sendRedirect(contextPath + "/confirm?status=error&message=" + ex.getMessage());
    } catch(Exception ex) {
      response.sendRedirect(contextPath + "/confirm?status=error&message=" + ex.getMessage());
    }

    out.close();
  }
}
