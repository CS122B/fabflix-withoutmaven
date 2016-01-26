<%@ include file="common/header.jspf" %>
<%@ include file="common/imports.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <%
    String searchInput = request.getParameter("input");
    String searchCriteria = request.getParameter("criteria");
    String searchPage = request.getParameter("pageNum");
    String searchLimit = request.getParameter("numResults");
	
	String searchTitle = request.getParameter("title");
	String searchYear = request.getParameter("year");
	String searchDirector = request.getParameter("director");
	String searchStar = request.getParameter("star");
  %>

  <div class="container">
    <div class="form-group">
      <form action="search" method="GET">
		<div>
			<b>Title:</b><input class="form-control" type="text" name="title" placeholder="e.g. Blade Runner">
		</div>
		<div>
			<b>Release Year:</b><input class="form-control" type="text" name="year" placeholder="e.g. 1982">
		</div>
		<div>
			<b>Director:</b><input class="form-control" type="text" name="director" placeholder="e.g. Ridley Scott">
		</div>
		<div>
			<b>Star:</b><input class="form-control" type="text" name="star" placeholder="e.g. Harrison Ford">
		</div>
		<div>
			<b>Display Options:</b><br>
			Display: <select name="numResults">
				<option>25</option>
				<option>50</option>
			</select>
			sorted by <select></select>
		</div>
        <input name="pageNum" value="1" hidden>
        <button type="submit" class="btn btn-primary">Search</button>
      </form>
    </div>
	

    <%
	if (
        searchInput != null
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
      <%@ include file="sql/searchQuery.jspf" %>
    <% } %>
	
	<%
	if (
		(searchTitle != null && !"".equals(searchTitle))
		|| (searchYear != null && !"".equals(searchYear))
		|| (searchDirector != null && !"".equals(searchDirector))
		|| (searchStar != null && !"".equals(searchStar))
	) {
	%>
		<%@ include file="sql/advancedSearchQuery.jspf" %>
	<% } %>
	
  </div>
</body>

<%@ include file="common/footer.jspf" %>
