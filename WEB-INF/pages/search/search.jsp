<%@ include file="../_common/variables.jspf" %>
<%@ include file="../_common/imports.jspf" %>
<%@ include file="_functions.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

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
    %>

    <div class="container">
      <%@ include file="searchForm.jspf" %>

      <%
      if (searchType != null && searchType.equals("basic")
        && searchInput != null
        && !"".equals(searchInput)
        && searchCriteria != null
        && (
          "title".equals(searchCriteria)
          || "director".equals(searchCriteria)
          || "year".equals(searchCriteria)
        )
        && searchPage != null
        && searchLimit != null
      ) {
      %>
        <%@ include file="searchQuery.jspf" %>
      <% } %>

      <%
      if (searchType != null && searchType.equals("advanced")
        && ((searchTitle != null && !"".equals(searchTitle))
        || (searchYear != null && !"".equals(searchYear))
        || (searchDirector != null && !"".equals(searchDirector))
        || (searchStar != null && !"".equals(searchStar)))
      ) {
      %>
        <%@ include file="advancedSearchQuery.jspf" %>
      <% } %>

      <%
      if (searchType != null && searchType.equals("browse")
        && ((searchTitle != null && !"".equals(searchTitle))
        || (searchGenre != null && !"".equals(searchGenre)))
      ) {
      %>
        <%@ include file="browseSearchQuery.jspf" %>
      <% } %>

    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
