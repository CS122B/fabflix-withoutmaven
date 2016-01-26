<%@ include file="common/header.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
    <%
    String firstName = (String)session.getAttribute("userFirstName");

    out.println("my dawg " + firstName + ", here's your shopping cart: ");
    %>
  </div>
</body>

<%@ include file="common/footer.jspf" %>
