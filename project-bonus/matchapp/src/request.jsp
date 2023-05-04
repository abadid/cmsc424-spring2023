<%@ taglib prefix="tagfiles" tagdir="/WEB-INF/tags" %>

<html>

  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/match.css" rel="stylesheet" />

    <title>Register to find your match!</title>
  </head>

  <body>
    <tagfiles:header />

    <div class="container heading">
      <h2>Request a Mentor!</h2>
      <form action="request.do" method="post">
        <div class = "row">
            Student ID: <br />
            <input type="number" size="18" name="id" required  />
            <br />
            Field: <br />
            <select name="field">
              <option value="Theory">Theory</option>
              <option value="Artificial Intelligence">Artificial Intelligence</option>
              <option value="Networks">Networks</option>
              <option value="Databases">Databases</option>
              <option value="Security">Security</option>
            </select>
            <br />
            <!-- ADD YOUR INPUT FIELD FOR THE FIELD YOU ADDED TO THE PERSON DATABASE RIGHT HERE-->

        </div>

        <div>
          <input type="submit" value="Submit" />
        </div>

      </form>
    </div>

    <div>
      <%
        String status =  request.getParameter("status");
        String advisor = request.getParameter("advisor");
        String message = null;
        if(status == null) {
          message = "";
        }
        else if(status.compareTo("-1") == 0){
          message = "Request failed";
        }
        else if(status.compareTo("1") == 0){
            message = "Request Successful";
        }
        else{
            message = "Request status unknown";
        }

        if(advisor == null || advisor.compareTo("-1") == 0){
          advisor = "";
        }
        else{
          advisor = "Your advisor's id is " + advisor;
        }
      %>
      <p><%= message %> <br> <%= advisor %></p>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
