<%@ include file="common/header.jspf" %>

<body class="login-page">
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
    <form
      class="form-signin"
      method="GET"
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
</body>

<%@ include file="common/footer.jspf" %>