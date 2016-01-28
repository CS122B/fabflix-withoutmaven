<%@ include file="common/variables.jspf" %>
<%@ include file="common/header.jspf" %>
<%@ include file="common/imports.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
  <%

    @SuppressWarnings (value="unchecked")
    Map<Integer, Integer> shoppingCart = (Map<Integer, Integer>)session.getAttribute("shoppingCart");

    if (shoppingCart != null) {
    %>
      <table class="table table-bordered">
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Quantity</th>
        </tr>
        <%@ include file="sql/shoppingCartQuery.jspf" %>
      </table>
      <a class="btn btn-primary" href="<% out.println(rootPath); %>/checkout">Checkout</a>
    <%
    } else {
      out.println("Nothing in Cart");
    }

  %>
  </div>

  <%@ include file="common/scripts.jspf" %>
</body>

<%@ include file="common/footer.jspf" %>
