<%@ include file="common/header.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
    <%
    if (session == null) {
      out.println("not logged in");
    } else {
      String firstName = (String)session.getAttribute("userFirstName");
      out.println("logged in as: " + firstName);
    }
    %>
  </div>
</body>

<%@ include file="common/footer.jspf" %>
