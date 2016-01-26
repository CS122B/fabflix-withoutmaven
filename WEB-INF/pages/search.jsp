<%@ include file="common/header.jspf" %>
<%@ include file="common/imports.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <%
    String searchInput = request.getParameter("input");
    String searchCriteria = request.getParameter("criteria");
    String searchPage = request.getParameter("pageNum");
    String searchLimit = request.getParameter("numResults");
  %>

  <div class="container">
    <div class="form-group">
      <form action="search" method="GET">
		<div>
			Title:<input class="form-control" type="text" name="title" placeholder="e.g. Blade Runner">
		</div>
		<div>
			Release Year:<input class="form-control" type="text" name="year" placeholder="e.g. 1982">
		</div>
		<div>
			Director:<input class="form-control" type="text" name="director" placeholder="e.g. Ridley Scott">
		</div>
		<div>
			Star:<input class="form-control" type="text" name="star" placeholder="e.g. Harrison Ford">
		</div>
        <input name="numResults" value="20" hidden>
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
        && searchLimit != null) {
    %>
      <%@ include file="sql/searchQuery.jspf" %>
    <% } %>

  </div>
</body>

<%@ include file="common/footer.jspf" %>
