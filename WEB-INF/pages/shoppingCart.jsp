<%@ include file="common/variables.jspf" %>
<%@ include file="common/header.jspf" %>
<%@ page import="java.util.*" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
  <%
    String firstName = (String)session.getAttribute("userFirstName");

    @SuppressWarnings (value="unchecked")
    Map<Integer, Integer> shoppingCart = (Map<Integer, Integer>)session.getAttribute("shoppingCart");

    out.println("my dawg " + firstName + ", here's your shopping cart: ");
    if (shoppingCart == null) {
      out.println("its empty dawg");
    } else {
      for (int key : shoppingCart.keySet()) {
        out.println(key + ", " + shoppingCart.get(key));
      }
    }

  %>
  </div>
</body>

<%@ include file="common/footer.jspf" %>
