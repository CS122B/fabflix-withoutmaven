<%@ include file="../common/variables.jspf" %>
<%@ include file="../common/imports.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../common/navbar.jspf" %>

    <div class="container">
    <%
      String movieIdPath = request.getPathInfo();
      try {
        movieIdPath = movieIdPath.replace("/", "");
        int movieId = Integer.parseInt(movieIdPath);
    %>
        <%@ include file="movieQuery.jspf" %>

        <% if (!"".equals(title)) { %>
          <div class="col-sm-12">
            <%@ include file="detailInfo.jspf" %>
          </div>
        <% } %>
    <%
      } catch (Exception ex) {
        out.println(ex);
      }
    %>
    </div>
  </div>

  <%@ include file="../common/footer.jspf" %>
  <%@ include file="../common/scripts.jspf" %>
  <script src="<% out.println(rootPath); %>/static/js/movieDetail.js"></script>
</body>

