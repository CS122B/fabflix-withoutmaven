<%@ include file="../_common/variables.jspf" %>
<%@ include file="../_common/imports.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

    <div class="container">
    <%
      String starIdPath = request.getPathInfo();
      try {
        starIdPath = starIdPath.replace("/", "");
        int starId = Integer.parseInt(starIdPath);
    %>
        <%@ include file="starDetailQuery.jspf" %>

        <% if (!"".equals(starDOBString)) { %>
          <%@ include file="detailInfo.jspf" %>
        <% } %>
    <%
      } catch (Exception ex) {
        response.sendError(404);
      }
    %>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
  <script src="<% out.println(rootPath); %>/static/js/movieDetail.js"></script>
</body>
</html>
