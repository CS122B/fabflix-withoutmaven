<%@ include file="common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="common/header.jspf" %>
<body class="login-page">
  <div class="page-wrap">
    <%@ include file="common/navbar.jspf" %>

    <div class="container">
      <form
        class="form-signin"
        method="POST"
        action="servlet/authenticateLogin"
      >
        <h2 class="form-signin-heading">Login</h2>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input
          id="inputEmail"
          class="form-control"
          type="email"
          name="email"
          placeholder="Email address"
          required
          autofocus
        >
        <label for="inputPassword" class="sr-only">Password</label>
        <input
          id="inputPassword"
          class="form-control"
          type="password"
          name="password"
          placeholder="Password"
          required
        >
        <%
        String redirectURL = request.getParameter("redirect");

        if (redirectURL != null) {
          out.println(
            "<input" +
            "  type=\"hidden\"" +
            "  name=\"redirect\"" +
            "  value=\"" + redirectURL + "\"" +
            ">"
          );
        }
        %>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>
    </div>
  </div>

  <%@ include file="common/footer.jspf" %>
  <%@ include file="common/scripts.jspf" %>
</body>
</html>
