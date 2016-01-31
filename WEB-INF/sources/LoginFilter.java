import java.io.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginFilter implements Filter {

  @Override
  public void init(FilterConfig config)
    throws ServletException
  {
  }

  @Override
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
    throws IOException, ServletException
  {
    HttpServletRequest request = (HttpServletRequest)req;
    HttpServletResponse response = (HttpServletResponse)res;
    HttpSession session = request.getSession(false);

    String URI = request.getRequestURI();
    String contextPath = request.getContextPath();

    boolean isHomePage = URI.equals(contextPath);
    boolean isLoginPath = (contextPath + "/login").equals(URI);
    boolean isServletPath = URI.startsWith("/servlet/", contextPath.length());
    boolean isStaticDir = URI.startsWith("/static/", contextPath.length());
    boolean isLoggedIn = (session != null && session.getAttribute("userFirstName") != null);

    if (isHomePage || isStaticDir || isServletPath || isLoginPath || isLoggedIn) {
      chain.doFilter(req, res);
    } else {
      String redirectURL = contextPath + "/login?redirect=" + URI;
      response.sendRedirect(redirectURL);
    }
  }

  @Override
  public void destroy() {
  }
}