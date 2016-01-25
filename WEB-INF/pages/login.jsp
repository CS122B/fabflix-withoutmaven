<%@page
  import="
    java.sql.*,
    javax.sql.*,
    java.io.IOException,
    javax.servlet.http.*,
    javax.servlet.*"
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="the sickest movie listing ever made. bless up">

  <title>Fabflix - Login</title>
  <link rel="stylesheet" type="text/css" href="static/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="static/css/index.css">
</head>
<body class="login-page">
  <div class="container">
    <form
      class="form-signin"
      method="GET"
      action="servlet/authenticateLogin"
    >
      <h2 class="form-signin-heading">Fabflix Login</h2>
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
</html>
