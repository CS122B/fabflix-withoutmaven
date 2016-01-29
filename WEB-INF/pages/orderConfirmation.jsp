<%@ include file="common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="common/header.jspf" %>
<body>
  <div class="page-wrap">
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
  </div>

  <%@ include file="common/footer.jspf" %>
  <%@ include file="common/scripts.jspf" %>
</body>
</html>
