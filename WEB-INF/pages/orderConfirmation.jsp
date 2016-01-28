<%@ include file="common/variables.jspf" %>
<%@ include file="common/header.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
  <%
    String orderNumber = request.getParameter("orderNumber");

    if (orderNumber != null) {
      String firstName = (String)session.getAttribute("userFirstName");
      out.println(
        firstName + ", your order number is: " + orderNumber + ". " +
        "Thank you for ordering from Fabflix!"
      );
    }
  %>
  </div>

  <%@ include file="common/scripts.jspf" %>
</body>

<%@ include file="common/footer.jspf" %>
