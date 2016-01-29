<%
  String loginUser = "testuser";
  String loginPasswd = "testpassword";
  String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

  try {
	out.println("<h2>Search results for:</h2>");
	if (searchTitle != null && !"".equals(searchTitle))
		out.println("<h2>Title: " + searchTitle + "</h2>");
	if (searchYear != null && !"".equals(searchYear))
		out.println("<h2>Year: " + searchYear + "</h2>");
	if (searchDirector != null && !"".equals(searchDirector))
		out.println("<h2>Director: " + searchDirector + "</h2>");
		

    Class.forName("com.mysql.jdbc.Driver").newInstance();
    Connection dbcon = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);

    int searchOffset = (Integer.parseInt(searchPage) - 1) * Integer.parseInt(searchLimit);
	String orderColumn = searchOrder.split(" ")[0];
	String orderDirection = searchOrder.split(" ")[1];
	
	String countQuery = (
	  "SELECT count(*) " +
      "FROM movies " +
      "WHERE " + 
	  "title LIKE ? AND " +
	  "year LIKE ? AND " +
	  "director LIKE ? " 
    );
	PreparedStatement countStatement = dbcon.prepareStatement(countQuery);
    countStatement.setString(1, "%" + searchTitle + "%");
	countStatement.setString(2, "%" + searchYear + "%");
	countStatement.setString(3, "%" + searchDirector + "%");
	ResultSet count = countStatement.executeQuery();
	int numResults = 0;
	while (count.next()) {
	  numResults = Integer.parseInt(count.getString("count(*)"));
	}
	int numPages = (numResults + Integer.parseInt(searchLimit) - 1) / Integer.parseInt(searchLimit);
	
	out.println("<ul class='pagination'>");
	for (int i = 1;  i <= numPages; i++) {
		String href = "http://localhost:8080/TomcatForm/search";
		href += "?title=" + searchTitle 
			 + "&year=" + searchYear
			 + "&director=" + searchDirector
			 + "&star=" + searchStar
		     + "&numResults=" + searchLimit
			 + "&orderBy=" + searchOrder
		     + "&search=1"
		     + "&pageNum=" + i;
		if (i == Integer.parseInt(searchPage))
			out.println("<li class='active'><a href='" + href + "'>" + i + "</a></li>");
		else
			out.println("<li><a href='" + href + "'>" + i + "</a></li>");
	}
	out.println("</ul>");
	
	count.close();
    countStatement.close();
	
	String starQuery = "";
	String[] starInputs = searchStar.trim().split(" ");
	String starFirstName = "";
	String starLastName = "";
	if (starInputs.length == 1)
	{
	  starQuery = "or stars.last_name like ? ) as b ";
	  starFirstName = starInputs[0];
	}
	else if (starInputs.length == 2)
	{
	  starQuery = "and stars.last_name like ? ) as b ";
	  starFirstName = starInputs[0];
	  starLastName = starInputs[1];
	}
	
    String query = (
	  "SELECT * FROM movies as a " + 
	  "INNER JOIN " + 
	  "(SELECT DISTINCT movie_id from stars_in_movies " + 
	  "inner join stars on stars_in_movies.star_id = stars.id " +
	  "where stars.first_name like ? " +
	  
	  starQuery + 
	  
	  "on a.id = b.movie_id " +
	  "WHERE " + 
	  "a.title LIKE ? AND " +
	  "a.year LIKE ? AND " +
	  "a.director LIKE ? " +
	  "ORDER BY " + searchOrder +
	  " LIMIT ? OFFSET ?"
	);	
	PreparedStatement statement = dbcon.prepareStatement(query);
	statement.setString(1, "%" + starFirstName + "%");
	if (starLastName == "")
		statement.setString(2, "%" + starFirstName + "%");
	else
		statement.setString(2, "%" + starLastName + "%");
    statement.setString(3, "%" + searchTitle + "%");
	statement.setString(4, "%" + searchYear + "%");
	statement.setString(5, "%" + searchDirector + "%");
    statement.setInt(6, Integer.parseInt(searchLimit));
    statement.setInt(7, searchOffset);
	
	ResultSet rs = statement.executeQuery();
	
    out.println("<table border>");
    while (rs.next()) {
		String id = rs.getString("id");
		String title = rs.getString("title");
		String year = rs.getString("year");
		String banner = rs.getString("banner_url");

		out.println(
		"<tr>" +
		"  <td><a href=movies/" + id + ">" + title + "</a></td>" +
		"  <td>" + year + "</td>" +
		"  <td><img src='" + banner + "'></td>" +
		"</tr>"
		);
	}
    out.println("</table>");

    rs.close();
    statement.close();
    dbcon.close();
	

  } catch (SQLException ex) {
    while (ex != null) {
      System.out.println ("SQL Exception: " + ex.getMessage());
      ex = ex.getNextException();
    }
  } catch (java.lang.Exception ex) {
    out.println("<p>SQL error: " +ex.getMessage() + "</p>");
  }
%>