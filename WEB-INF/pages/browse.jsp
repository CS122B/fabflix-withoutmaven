<%@ include file="common/variables.jspf" %>
<%@ include file="common/header.jspf" %>
<%@ include file="common/imports.jspf" %>

<body>
  <%@ include file="common/navbar.jspf" %>

  <div class="container">
  BROWSE BY LETTER
	<a href="http://localhost:8080/TomcatForm/search?title=a&numResults=25&orderBy=title+asc&search=browse&pageNum=1">A</a>
	<a href="http://localhost:8080/TomcatForm/search?genre=907000&numResults=25&orderBy=title+asc&search=browse&pageNum=1">Action</a>
  </div>

  <%@ include file="common/scripts.jspf" %>
</body>

<%@ include file="common/footer.jspf" %>
