<%@ include file="common/header.jspf" %>
<%@ include file="common/imports.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
  <%
    String movieIdPath = request.getPathInfo();
    try {
      movieIdPath = movieIdPath.replace("/", "");
      int movieId = Integer.parseInt(movieIdPath);
  %>
      <%@ include file="sql/movieQuery.jspf" %>
  <%
    } catch (Exception ex) {
      out.println(ex);
    }
  %>
  </div>
</body>

<%@ include file="common/footer.jspf" %>
