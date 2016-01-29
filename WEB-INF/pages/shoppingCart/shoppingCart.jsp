<%@ include file="../common/variables.jspf" %>
<%@ include file="../common/imports.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../common/navbar.jspf" %>

    <div class="container">
      <div class="col-sm-12">
        <h3>Shopping Cart</h3>
      <%

        @SuppressWarnings (value="unchecked")
        Map<Integer, Integer> shoppingCart = (Map<Integer, Integer>)session.getAttribute("shoppingCart");

        if (shoppingCart != null) {
        %>
          <table class="table table-striped shopping-cart-table">
            <tr>
              <th>Banner</th>
              <th>Title</th>
              <th>Quantity</th>
              <th></th>
            </tr>
            <%@ include file="shoppingCartQuery.jspf" %>
          </table>
          <a class="btn btn-primary btn-lg btn-block" href="<% out.println(rootPath); %>/checkout">Checkout</a>
        <%
        } else {
          out.println("Nothing in Cart");
        }

      %>
      </div>
    </div>
  </div>

  <%@ include file="../common/footer.jspf" %>
  <%@ include file="../common/scripts.jspf" %>
</body>
</html>
