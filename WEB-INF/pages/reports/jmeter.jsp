<%@ include file="../_common/imports.jspf" %>
<%@ include file="../_common/variables.jspf" %>

<!DOCTYPE html>
<html lang="en">
<%@ include file="../_common/header.jspf" %>
<body>
  <div class="page-wrap">
    <%@ include file="../_common/navbar.jspf" %>

    <div class="container">
      <table style="width:100%">
        <tr style="font-weight:bold; background-color: orange">
          <td width="300px">Case</td>
          <td>Graph Results Screenshot</td>
          <td>Average Query Time Value(ms)</td>
          <td>Throughput</td>
        </tr>
        <tr>
          <td>Case 1: HTTP/1 thread</td>
          <td><img src="<% out.print(rootPath + "/static/images/JMeter_1.png"); %>" alt="Graph Results Screenshot Case 1" style="width:304px;height:228px;"></td>
          <td>44</td>
          <td>786.397/minute</td>
        </tr>
        <tr>
          <td>Case 2: HTTP/10 threads</td>
          <td><img src="<% out.print(rootPath + "/static/images/JMeter_2.png"); %>" alt="Graph Results Screenshot Case 2" style="width:304px;height:228px;"></td>
          <td>51</td>
          <td>10,756.448/minute</td>
        </tr>
        <tr>
          <td>Case 3: HTTPS/10 threads</td>
          <td><img src="<% out.print(rootPath + "/static/images/JMeter_3.png"); %>" alt="Graph Results Screenshot Case 3" style="width:304px;height:228px;"></td>
          <td>34</td>
          <td>13,625.205/minute</td>
        </tr>
        <tr>
          <td>Case 4: HTTP/10 threads/No prepared statements</td>
          <td><img src="<% out.print(rootPath + "/static/images/JMeter_4.png"); %>" alt="Graph Results Screenshot Case 4" style="width:304px;height:228px;"></td>
          <td>49</td>
          <td>11,127.751/minute</td>
        </tr>
      </table>
    </div>
  </div>

  <%@ include file="../_common/footer.jspf" %>
  <%@ include file="../_common/scripts.jspf" %>
</body>
</html>
