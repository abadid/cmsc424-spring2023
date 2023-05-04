<%@ taglib prefix="tagfiles" tagdir="/WEB-INF/tags" %>

<html>

  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/match.css" rel="stylesheet" />

    <title>Register to find your mentor!</title>
  </head>

  <body>
    <tagfiles:header />

    <div class="container heading">
      <h2>Enter Your Information</h2>
      <form action="add.do" method="post">
        <div class = "row">
            <h3>Personal Information</h3>
            First Name: <br />
            <input type="text" size="18" name="first" required  />
            <br />
            Last Name: <br />
            <input type="text" size="18" name="last" required/>
            <br />
            Email: <br />
            <input type="text" size="18" name="email" />
            <br/>

            Student type: <br />
            <select name="type">
              <option value="Freshman">Freshman</option>
              <option value="Sophomore">Sophomore</option>
              <option value="Junior">Junior</option>
              <option value="Senior">Senior</option>
              <option value="Graduate Student">Graduate Student</option>
            </select>
            <br/>

        </div>

        <div>
          <input type="submit" value="Submit" />
        </div>

      </form>
    </div>
    <div>
      <%
        String id =  request.getParameter("id");
        String advisor = request.getParameter("advisor");
        if(id == null) {
          id = "";
        }
        else {
          if (id.equals("-1")) {
            id = "Unable to add student to the database!";
          } else {
           id = "Your ID is " + id + " - Remember it!";
          }
        }
        if(advisor == null){
            advisor = "";
        }
        else {
          if (advisor.equals("-1")) {
            advisor = "Unable to assign advisor!";
          } else {
            advisor = "Your advisor's id is " + advisor;
          }
        }
      %>
      <p><%= id %> <br> <%= advisor %></p>


    </div>

    <div class="sample">
      <p>You will be assigned a certified Research Trail advisor following your mentor request/offer. </p>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
