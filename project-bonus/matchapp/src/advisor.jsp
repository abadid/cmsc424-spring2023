<%@ taglib prefix="tagfiles" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="match" uri="match-functions" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/match.css" rel="stylesheet" />

    <title>Get Advisor</title>
  </head>

  <body>
    <tagfiles:header />

    <div class="container heading">
      <h2>Find your advisor's name!</h2>
      <form action="getadvisor" method="get">
        Enter your id to see your advisor: 
         <br />
         <input type="number" name="id" />
         <input type = "submit" value = "Get Advisor!" />
       </form>
       <table align="center">
         <match:listadvisor id="${id}">
           <tr><td>${name}</td><td>${field}</td><td>${experience}</td></tr>
         </match:listadvisor>
       </table>
    </div>

    <div class="sample">
      <p>MatchMaker</p>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
