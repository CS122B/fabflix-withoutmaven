<%@ include file="common/header.jspf" %>
<%@ include file="common/imports.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

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
          <option>Title</option>
          <option>Director</option>
          <option>Year</option>
        </select>
        <input name="numResults" value="20" hidden>
        <input name="pageNum" value="1" hidden>
        <button type="submit" class="btn btn-primary">Search</button>
      </form>
    </div>

    <%@ include file="common/searchResults.jspf" %>
  </div>
</body>

<%@ include file="common/footer.jspf" %>
