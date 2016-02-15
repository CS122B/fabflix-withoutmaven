<%@ include file="../_common/imports.jspf" %>
<%@ include file="../_common/variables.jspf" %>
<%@ include file="../_common/db.jspf" %>

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
  <script src="<% out.println(rootPath); %>/static/js/employeeDashboard.js"></script>
</body>
</html>
