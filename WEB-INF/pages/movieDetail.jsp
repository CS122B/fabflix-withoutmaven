<%@ include file="common/variables.jspf" %>
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
      <%@ include file="sql/movieDetailGenres.jspf" %>
      <%@ include file="sql/movieDetailStars.jspf" %>
      <%@ include file="common/movieDetailContent.jspf" %>
  <%
    } catch (Exception ex) {
      out.println(ex);
    }
  %>
  </div>

  <%@ include file="common/scripts.jspf" %>
  <script src="<% out.println(rootPath); %>/static/js/movieDetail.js"></script>
</body>

<%@ include file="common/footer.jspf" %>
