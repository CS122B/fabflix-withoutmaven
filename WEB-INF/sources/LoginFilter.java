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

    String requestURI = request.getRequestURI();
    String contextPath = request.getContextPath();

    boolean isLoginPath = (contextPath + "/login").equals(requestURI);
    boolean isServletPath = requestURI.startsWith("/servlet/", contextPath.length());
    boolean isStaticDir = requestURI.startsWith("/static/", contextPath.length());
    boolean isLoggedIn = (session != null && session.getAttribute("userFirstName") != null);
    boolean isDashboard = (contextPath + "/_dashboard").equals(requestURI);

    if (isStaticDir || isServletPath || isLoginPath || isLoggedIn || isDashboard) {
      chain.doFilter(req, res);
    } else {
      String redirectURL = contextPath + "/login?redirect=" + requestURI;
      response.sendRedirect(redirectURL);
    }
  }

  @Override
  public void destroy() {
  }
}