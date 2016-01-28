<%@ include file="common/variables.jspf" %>
<%@ include file="common/header.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
  <%
    String firstName = (String)session.getAttribute("userFirstName");
    out.println("logged in as: " + firstName);
  %>
  </div>
</body>

<%@ include file="common/footer.jspf" %>
