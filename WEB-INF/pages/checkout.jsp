<%@ include file="common/variables.jspf" %>
<%@ include file="common/imports.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="common/navbar.jspf" %>

    <div class="container">
    <%

      @SuppressWarnings (value="unchecked")
      Map<Integer, Integer> shoppingCart = (Map<Integer, Integer>)session.getAttribute("shoppingCart");

      if (shoppingCart != null) {

      %>
        <div class="form-group">
          <form action="servlet/processOrder" method="POST">
            <div>
              <h4>First Name</h4>
              <input
                class="form-control"
                type="text"
                name="firstName"
              >
            </div>
            <div>
              <h4>Last Name</h4>
              <input
                class="form-control"
                type="text"
                name="lastName"
              >
            </div>
            <div>
              <h4>Expiration Date</h4>
              <input
                class="form-control"
                type="date"
                name="expirationDate"
              >
            </div>
            <div>
              <h4>Credit Card Number</h4>
              <input
                class="form-control"
                type="text"
                name="creditCardNumber"
              >
            </div>
            <button type="submit" class="btn btn-primary">Checkout</button>
          </form>
        </div>

    <%
      }
    %>
    </div>
  </div>

  <%@ include file="common/footer.jspf" %>
  <%@ include file="common/scripts.jspf" %>
</body>
</html>
