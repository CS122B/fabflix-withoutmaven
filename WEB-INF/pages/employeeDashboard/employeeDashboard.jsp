<%@ include file="../_common/imports.jspf" %>
<%@ include file="../_common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>

<% if (session == null || session.getAttribute("employeeEmail") == null) { %>
  <%@ include file="loginForm.jspf" %>
<% } else { %>
  <%@ include file="dashboard.jspf" %>
<% } %>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
