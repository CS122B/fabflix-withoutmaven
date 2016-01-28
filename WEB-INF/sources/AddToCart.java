import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddToCart extends HttpServlet
{

  private Map<Integer, Integer> getShoppingCart(HttpSession session) {
    @SuppressWarnings (value="unchecked")
    Map<Integer, Integer> shoppingCart = (Map<Integer, Integer>)session.getAttribute("shoppingCart");

    if (shoppingCart == null) {
      shoppingCart = new HashMap<Integer, Integer>();
    }

    return shoppingCart;
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession(false);
    PrintWriter out = response.getWriter();

    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");

    try {
      if (session == null || session.getAttribute("userFirstName") == null) {
        throw new Exception();
      }

      String loginUser = "testuser";
      String loginPasswd = "testpassword";
      String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

      Class.forName("com.mysql.jdbc.Driver").newInstance();
      Connection dbcon = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
      String query = (
        "SELECT * " +
        "FROM movies " +
        "WHERE id = ?"
      );

      PreparedStatement statement = dbcon.prepareStatement(query);
      String movieId = request.getParameter("movieId");
      statement.setString(1, movieId);

      ResultSet rs = statement.executeQuery();

      if (!rs.isBeforeFirst()) {
        throw new SQLException();
      }

      Map<Integer, Integer> shoppingCart = getShoppingCart(session);
      int quantity = Integer.parseInt(request.getParameter("quantity"));
      int intMovieId = Integer.parseInt(movieId);

      shoppingCart.put(intMovieId, quantity);
      session.setAttribute("shoppingCart", shoppingCart);

      out.print(quantity);
      rs.close();
      statement.close();
      dbcon.close();
    }
    catch (SQLException ex) {
      response.sendError(400, "No results");
    } catch(java.lang.Exception ex) {
      response.sendError(401, "Not validated");
    }

    out.close();
  }
}
