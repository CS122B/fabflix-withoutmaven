<%@ include file="../_common/variables.jspf" %>
<%@ include file="../_common/imports.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

    <div class="container">
    <%

      @SuppressWarnings (value="unchecked")
      Map<Integer, Integer> shoppingCart = (Map<Integer, Integer>)session.getAttribute("shoppingCart");

      if (shoppingCart != null) {
      %>
        <%@ include file="checkoutForm.jspf" %>
      <%
      }
    %>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
