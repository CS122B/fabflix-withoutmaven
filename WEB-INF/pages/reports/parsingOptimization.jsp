<%@ include file="../_common/imports.jspf" %>
<%@ include file="../_common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

    <div class="container">
      <h2>XML Parsing Optimization</h2>
      <h4>
        A base-case implementation of XML parsing would be to loop through each XML file
        and run SQL queries on them. This may run into slowness due to the overhead of connecting
        to the database for each row. Also, for operations that require multiple queries, each
        query would be another connection to the database. One optimization would be to convert the
        SQL queries to stored procedures. That way, only one connection has to be executed for each
        operation rather than multiple. Another better optimization would be to write all the stored
        procedure executions to a SQL script (.sql), where it could be executed in SQL without having
        to make the roundtrip of sending the data to the database and receiving a response.
      </h4>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
