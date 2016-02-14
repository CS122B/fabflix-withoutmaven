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
    if ("DELETE".equals(request.getParameter("method"))) {
      doDelete(request, response);
      return;
    }

    PrintWriter out = response.getWriter();

    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");

    try {
      HttpSession session = request.getSession(false);

      if (session == null || session.getAttribute("userFirstName") == null) {
        throw new Exception();
      }

      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/movieDB");
      Connection dbcon = ds.getConnection();

      try {
        String query = (
          "SELECT * " +
          "FROM movies " +
          "WHERE id = ?"
        );

        PreparedStatement statement = dbcon.prepareStatement(query);

        try {
          String movieId = request.getParameter("movieId");
          statement.setString(1, movieId);

          ResultSet rs = statement.executeQuery();

          try {
            if (!rs.isBeforeFirst()) {
              throw new SQLException();
            }

            Map<Integer, Integer> shoppingCart = getShoppingCart(session);
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int intMovieId = Integer.parseInt(movieId);

            shoppingCart.put(intMovieId, quantity);
            session.setAttribute("shoppingCart", shoppingCart);

            String hasRedirect = request.getParameter("redirect");
            if (hasRedirect != null) {
              response.sendRedirect(request.getContextPath() + "/" + hasRedirect);
            }
          } finally {
            rs.close();
          }
        } finally {
          statement.close();
        }
      } finally {
        dbcon.close();
      }
    }
    catch (SQLException ex) {
      response.setStatus(400);
      out.write(ex.getMessage());
    } catch(java.lang.Exception ex) {
      response.setStatus(401);
      out.write(ex.getMessage());
    } finally {
      out.close();
    }
  }

  public void doDelete(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    HttpSession session = request.getSession(false);

    try {
      if (session == null || session.getAttribute("userFirstName") == null) {
        throw new Exception();
      }

      Integer movieId = Integer.parseInt(request.getParameter("movieId"));
      Map<Integer, Integer> shoppingCart = getShoppingCart(session);

      if (shoppingCart.containsKey(movieId)) {
        shoppingCart.remove(movieId);
      }

      session.setAttribute("shoppingCart", shoppingCart);

      String contextPath = request.getContextPath();
      response.sendRedirect(contextPath + "/cart");

    } catch (SQLException ex) {
      response.sendError(400, "No results");
    } catch(java.lang.Exception ex) {
      response.sendError(401, "Not validated");
    }

    response.setStatus(200);
  }
}
