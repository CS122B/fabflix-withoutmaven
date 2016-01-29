<%@ include file="common/variables.jspf" %>
<%@ include file="common/imports.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="common/navbar.jspf" %>

    <div class="container">
    <%
      String movieIdPath = request.getPathInfo();
      try {
        movieIdPath = movieIdPath.replace("/", "");
        int movieId = Integer.parseInt(movieIdPath);
    %>
        <%@ include file="sql/movieQuery.jspf" %>

        <% if (!"".equals(title)) { %>
          <h3 id="movie-id"><% out.println(movieId); %></h3> 
          <h3 id="movie-title"><% out.println(title); %></h3>
          <h3 id="movie-year"><% out.println(year); %></h3>
          <h3 id="movie-director"><% out.println(director); %></h3>
          <img id="movie-image" src="<% out.println(banner); %>">
          <a
           id="movie-trailer"
           class="btn btn-primary"
           href="<% out.println(trailer); %>"
           target="_blank"
          >Link to Trailer</a>
          <button
           id="button-add-movie"
           data-movie-id="<% out.println(movieId); %>"
           class="btn btn-primary"
           type="button"
          >
          Add to Cart
          </button>
          <%@ include file="sql/movieDetailGenres.jspf" %>
          <%@ include file="sql/movieDetailStars.jspf" %>
          <%@ include file="common/movieDetailContent.jspf" %>
        <% } %>
    <%
      } catch (Exception ex) {
        out.println(ex);
      }
    %>
    </div>
  </div>

  <%@ include file="common/footer.jspf" %>
  <%@ include file="common/scripts.jspf" %>
  <script src="<% out.println(rootPath); %>/static/js/movieDetail.js"></script>
</body>

