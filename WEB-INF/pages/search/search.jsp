<%@ include file="../_common/variables.jspf" %>
<%@ include file="../_common/db.jspf" %>
<%@ include file="../_common/imports.jspf" %>
<%@ include file="_functions.jspf" %>
<%@ include file="_classes.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>
    <div class="container">
      <%@ include file="_variables.jspf" %>
      <%@ include file="searchForm.jspf" %>

      <%
      if ((searchTitle != null && !"".equals(searchTitle))
        || (searchYear != null && !"".equals(searchYear))
        || (searchDirector != null && !"".equals(searchDirector))
        || (searchStar != null && !"".equals(searchStar))
        || (searchGenre != null && !"".equals(searchGenre))
      ) {
      %>
        <%@ include file="advancedSearchQuery.jspf" %>
        <%@ include file="movieHoverCard.jspf" %>
        <% out.println(pagination); %>
      <% } %>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
  <script src="<% out.print(rootPath + "/static/js/search.js"); %>"></script>
</body>
</html>
