<%@ include file="../_common/imports.jspf" %>
<%@ include file="../_common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body class="login-page">
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

    <div class="container">
    <%
      out.println(session.getAttribute("employeeEmail"));
      if (session == null || session.getAttribute("employeeEmail") == null) { %>
        <%@ include file="loginForm.jspf" %>
      <% } else { %>
        <%@ include file="dashboard.jspf" %>
      <% } %>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
