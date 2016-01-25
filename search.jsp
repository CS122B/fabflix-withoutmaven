<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="java.sql.*,
 javax.sql.*,
 java.io.IOException,
 javax.servlet.http.*,
 javax.servlet.*"
%>
<HTML>
<HEAD>
	<link rel="stylesheet" type="text/css" href="bootstrap.min.css">
  <TITLE>Fabflix Search</TITLE>
</HEAD>

<BODY>
	
<FORM ACTION="search"
      METHOD="GET">
  <INPUT TYPE="TEXT" NAME="input" PLACEHOLDER="SEARCH FOR MOVIES">
  <SELECT NAME="criteria">
	<option>Title</option>
	<option>Director</option>
	<option>Year</option>
  </SELECT>
  <INPUT TYPE="SUBMIT" VALUE="Search">
  <input name="numResults" value="20" hidden>
  <input name="pageNum" value="1" hidden>
  
  <ul class="pagination">
  </ul>
  
</FORM>

<%
	if (request.getParameter("input") != null 
		&& request.getParameter("criteria") != null 
		&& request.getParameter("pageNum") != null 
		&& request.getParameter("numResults") != null ) {
	
		String loginUser = "testuser";
		String loginPasswd = "testpassword";
		String loginUrl = "jdbc:mysql://localhost:3306/moviedb";

		response.setContentType("text/html");    // Response mime type

		out.println("<HTML><HEAD><TITLE>MovieDB</TITLE></HEAD>");
		out.println("<BODY><H2>Search results for: </H2>");


		try
		{
			//Class.forName("org.gjt.mm.mysql.Driver");
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			Connection dbcon = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);
			// Declare our statement
			Statement statement = dbcon.createStatement();

			String searchInput = request.getParameter("input");
			String searchCriteria = request.getParameter("criteria");
			String searchPage = request.getParameter("pageNum");
			String searchLimit = request.getParameter("numResults");
			int searchOffset = (Integer.parseInt(searchPage) - 1) * Integer.parseInt(searchLimit);

			out.println("<b>" + searchInput + "</b>");

			String query = "SELECT * from movies WHERE " + searchCriteria + " LIKE '%" + searchInput + "%'" +
					"LIMIT " + searchLimit + " OFFSET " + searchOffset;

			// Perform the query
			ResultSet rs = statement.executeQuery(query);

			out.println("<TABLE border>");

			// Iterate through each row of rs
			while (rs.next())
			{
				String ID = rs.getString("ID");
				String title = rs.getString("title");
				String year = rs.getString("year");
				String banner = rs.getString("banner_url");
				out.println("<tr>" +
						"<td>" + title + "</td>" +
						"<td>" + year + "</td>" +
						"<td><img src='" + banner + "'></td>" +
						"</tr>");
			}

			out.println("</TABLE>");

			rs.close();
			statement.close();
			dbcon.close();
		}
		catch (SQLException ex) {
			while (ex != null) {
				System.out.println ("SQL Exception:  " + ex.getMessage ());
				ex = ex.getNextException ();
			}  // end while
		}  // end catch SQLException

		catch(java.lang.Exception ex)
		{
			out.println("<HTML>" +
					"<HEAD><TITLE>" +
					"MovieDB: Error" +
					"</TITLE></HEAD>\n<BODY>" +
					"<P>SQL error in doGet: " +
					ex.getMessage() + "</P></BODY></HTML>");
			return;
		}
	}
%>

</BODY>
</HTML>
