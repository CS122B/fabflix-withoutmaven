<%@ include file="common/variables.jspf" %>
<%@ include file="common/header.jspf" %>
<%@ include file="common/imports.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
  <%
    String starIdPath = request.getPathInfo();
    try {
      starIdPath = starIdPath.replace("/", "");
      int starId = Integer.parseInt(starIdPath);
  %>
      <%@ include file="sql/starDetailQuery.jspf" %>
      <%@ include file="sql/starDetailMovies.jspf" %>
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
