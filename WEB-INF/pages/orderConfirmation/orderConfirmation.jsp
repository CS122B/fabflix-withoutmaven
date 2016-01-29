<%@ include file="../_common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

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

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
