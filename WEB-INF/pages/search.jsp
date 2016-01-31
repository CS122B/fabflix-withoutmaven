<%@ include file="_common/variables.jspf" %>
<%@ include file="_common/imports.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="_common/navbar.jspf" %>

    <%
    String searchType = request.getParameter("search");
    String searchInput = request.getParameter("input");
    String searchCriteria = request.getParameter("criteria");
    String searchPage = request.getParameter("pageNum");
    String searchLimit = request.getParameter("numResults");
  	
  	String searchTitle = request.getParameter("title");
  	String searchYear = request.getParameter("year");
  	String searchDirector = request.getParameter("director");
  	String searchStar = request.getParameter("star");
  	String searchOrder = request.getParameter("orderBy");
    String searchGenre = request.getParameter("genre");
    %>

  <div class="container">
    <div class="form-group">
      <form action="search" method="GET">
        <div>
          <h4>Title:</h4>
          <input
            class="form-control"
            type="text"
            name="title"
            placeholder="e.g. Blade Runner"
          >
        </div>
        <div>
          <h4>Release Year:</h4>
          <input
            class="form-control"
            type="text"
            name="year"
            placeholder="e.g. 1982"
          >
        </div>
        <div>
          <h4>Director:</h4>
          <input
            class="form-control"
            type="text"
            name="director"
            placeholder="e.g. Ridley Scott"
          >
        </div>
        <div>
          <h4>Star:</h4>
          <input
            class="form-control"
            type="text"
            name="star"
            placeholder="e.g. Harrison Ford"
          >
        </div>
        <div>
          <h4>Display Options:</h4>
          <h5>Display:</h5>
          <select name="numResults">
            <option>25</option>
            <option>50</option>
			<option>100</option>
          </select>
          <h5>Sorted by:</h5>
          <select name="orderBy">
			  <option value="title asc">Title: A-Z</option>
			  <option value="title desc">Title: Z-A</option>
			  <option value="year asc">Year: Ascending</option>
			  <option value="year desc">Year: ASDFASDF</option>
			</select>
        </div>
        <input name="pageNum" value="1" hidden>
        <button type="submit" class="btn btn-primary">Search</button>
      </form>
    </div>
	
	<%
	if ((searchTitle != null && !"".equals(searchTitle))
		|| (searchYear != null && !"".equals(searchYear))
		|| (searchDirector != null && !"".equals(searchDirector))
		|| (searchStar != null && !"".equals(searchStar))
    || (searchGenre != null && !"".equals(searchGenre))
	) {
	%>
		<%@ include file="sql/advancedSearchQuery.jspf" %>
	<% } %>

    </div>
  </div>

  <%@ include file="_common/footer.jspf" %>
  <%@ include file="_common/scripts.jspf" %>
</body>
</html>
