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
      String starIdPath = request.getPathInfo();
      try {
        starIdPath = starIdPath.replace("/", "");
        int starId = Integer.parseInt(starIdPath);
    %>
        <%@ include file="sql/starDetailQuery.jspf" %>
        <%@ include file="sql/starDetailMovies.jspf" %>
    <%
      } catch (Exception ex) {
        out.println(ex);
      }
    %>
    </div>
  </div>

  <%@ include file="common/footer.jspf" %>
  <%@ include file="common/scripts.jspf" %>
  <script src="<% out.println(rootPath); %>/static/js/movieDetail.js"></script>
</body>
</html>
