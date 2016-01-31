<%@ include file="../_common/imports.jspf" %>
<%@ include file="../_common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

    <div class="container">
      <h2>Connection Pooling</h2>
      <h4>
        Our team used connection pooling wherever we made SQL queries.
        In all files that query the database, we attempt to grab a
        connection from the connection pool.
      </h4>
      <h4>
        If a connection exists,
        we will use that connection to make our query. If it does not
        exist, the server will create a new connection for us to use.
        Using connection pooling will decrease the time spent for the
        client to get his data and decrease the time/processing for the
        server to serve the connection since there is no overhead to
        create a new connection if an available one exists.
      </h4>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
