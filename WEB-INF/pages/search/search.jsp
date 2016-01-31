<%@ include file="../_common/variables.jspf" %>
<%@ include file="../_common/imports.jspf" %>
<%@ include file="_functions.jspf" %>
<%@ include file="_classes.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

<<<<<<< HEAD
    <%
    String searchType = getSearchParam(request, "search");
    String searchInput = getSearchParam(request, "input");
    String searchCriteria = getSearchParam(request, "criteria");
    String searchPage = getSearchParam(request, "pageNum");
    String searchLimit = getSearchParam(request, "numResults");

    String searchTitle = getSearchParam(request, "title");
    String searchYear = getSearchParam(request, "year");
    String searchDirector = getSearchParam(request, "director");
    String searchStar = getSearchParam(request, "star");
    String searchOrder = getSearchParam(request, "orderBy");
    String searchGenre = getSearchParam(request, "genre");
    String browseByTitle = getSearchParam(request, "browseByTitle");
    
    String pagination = "";
    %>

=======
>>>>>>> 9cd1151b6aecc233cbd2cc681c4efb0f810ab061
    <div class="container">
      <%@ include file="_variables.jspf" %>
      <%@ include file="searchForm.jspf" %>
<<<<<<< HEAD

      <%
      if ((searchTitle != null && !"".equals(searchTitle))
        || (searchYear != null && !"".equals(searchYear))
        || (searchDirector != null && !"".equals(searchDirector))
        || (searchStar != null && !"".equals(searchStar))
        || (searchGenre != null && !"".equals(searchGenre))
      ) {
      %>
        <%@ include file="advancedSearchQuery.jspf" %>
        <% out.println(pagination); %>
      <% } %>

=======
      <%@ include file="advancedSearchQuery.jspf" %>
      <% out.println(pagination); %>
>>>>>>> 9cd1151b6aecc233cbd2cc681c4efb0f810ab061
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
  <script src="<% out.println(rootPath); %>/static/js/search.js"></script>
</body>
</html>
