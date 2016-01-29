<%@ include file="common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="common/navbar.jspf" %>

    <div class="container">
      <div class="home-main-content col-sm-12 col-md-9">
        <%@ include file="common/carousel.jspf" %>
        <%@ include file="common/featuredStars.jspf" %>
      </div>
      <div class="col-sm-12 col-md-3">
        <%@ include file="common/genres.jspf" %>
      </div>
    </div>
  </div>

  <%@ include file="common/footer.jspf" %>
  <%@ include file="common/scripts.jspf" %>
</body>
</html>
