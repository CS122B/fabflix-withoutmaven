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
        <input
          class="form-control"
          type="text"
          name="input"
          placeholder="Search for movies"
        >
        <select name="criteria">
          <option value="title">Title</option>
          <option value="director">Director</option>
          <option value="year">Year</option>
        </select>
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
      <%@ include file="common/searchResults.jspf" %>
    <% } %>

  </div>
</body>

<%@ include file="common/footer.jspf" %>
