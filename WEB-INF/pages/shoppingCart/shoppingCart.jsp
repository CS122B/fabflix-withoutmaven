<%@ include file="../_common/variables.jspf" %>
<%@ include file="../_common/db.jspf" %>
<%@ include file="../_common/imports.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

    <div class="container">
      <div class="col-sm-12">
        <h3>Shopping Cart</h3>
      <%

        @SuppressWarnings (value="unchecked")
        Map<Integer, Integer> shoppingCart = (Map<Integer, Integer>)session.getAttribute("shoppingCart");

        if (shoppingCart != null && !shoppingCart.isEmpty()) {
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

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
