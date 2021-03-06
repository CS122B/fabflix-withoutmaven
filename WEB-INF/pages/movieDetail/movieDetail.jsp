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
        response.sendError(404);
      }
    %>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
  <script src="<% out.println(rootPath); %>/static/js/movieDetail.js"></script>
</body>

