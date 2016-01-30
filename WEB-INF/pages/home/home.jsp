<%@ include file="../_common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

    <div class="container home-container">
      <div class="home-main-content col-sm-12 col-md-9">
        <%@ include file="carousel.jspf" %>
        <%@ include file="featuredStars.jspf" %>
      </div>
      <div class="col-sm-12 col-md-3">
        <%@ include file="genres.jspf" %>
      </div>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
