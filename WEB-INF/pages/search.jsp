<%@ include file="common/variables.jspf" %>
<%@ include file="common/header.jspf" %>
<%@ include file="common/imports.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

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
	String searchGenre = request.getParameter("genre");
	String searchOrder = request.getParameter("orderBy");

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
          </select>
          <h5>Sorted by:</h5>
          <select name="orderBy">
			  <option value="title asc">Title: A-Z</option>
			  <option value="title desc">Title: Z-A</option>
			  <option value="year asc">Year: Ascending</option>
			  <option value="year desc">Year: Descending</option>
			</select>
        </div>
        <input name="search" value="advanced" hidden>
        <input name="pageNum" value="1" hidden>
        <button type="submit" class="btn btn-primary">Search</button>
      </form>
    </div>
	<%
	out.println("<h4>" + searchType + "</h4>");
	if (searchType.equals("basic")
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
      <%@ include file="sql/searchQuery.jspf" %>

    <% } %>
	
	<%
	if ( searchType.equals("advanced") && 
		((searchTitle != null && !"".equals(searchTitle))
		|| (searchYear != null && !"".equals(searchYear))
		|| (searchDirector != null && !"".equals(searchDirector))
		|| (searchStar != null && !"".equals(searchStar)))
	) {
	%>
		<%@ include file="sql/advancedSearchQuery.jspf" %>
	<% } %>
	
	<%
	if ( searchType.equals("browse") && 
		((searchTitle != null && !"".equals(searchTitle))
		|| (searchGenre != null && !"".equals(searchGenre)))
	) {
	%>
		<%@ include file="sql/browseSearchQuery.jspf" %>
	<% } %>
	

  </div>

  <%@ include file="common/scripts.jspf" %>
</body>

<%@ include file="common/footer.jspf" %>
