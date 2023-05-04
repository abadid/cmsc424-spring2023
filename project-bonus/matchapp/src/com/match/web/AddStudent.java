package com.match.web;
import com.match.model.Student;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class AddStudent extends HttpServlet {
  private static final Logger logger = LogManager.getLogger("match");
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NumberFormatException {

    //Gets the string data of all of the fields in the form
    String first = request.getParameter("first");
    String last = request.getParameter("last");
    String email = request.getParameter("email");
    String studenttype = request.getParameter("type");

    /*
    TODO: Call the addStudent and getAdvisorFirst methods, given the parameters passed
    to the post request. Only call getAdvisorFirst if the first function is successful.
    Redirect to the invalid input page if any constraint defined in
    the Schema + User section of the readme is violated:

    You must check that first name is less or equal to 12 chars, last name less
    than or equal to 18 chars, and that their email is valid.

    Then, send the student and advisor's id in the url parameters.
    */

    // Replace 'true' below and check for input constraints
    if (true) {
        response.sendRedirect("invalidinput");
    } else {

        //Here we make the call to the addStudent method in Student.java that connects to the database and inserts the student with the given values
        // If that's successful, update their advisor with getAdvisorFirst, which is also in person.java.
        // id should be the id returned from addStudent, and advisor should be the advisor's id returned from getAdvisorFirst.

        int id = -1;
        int advisor = -1;
        
        //Sends the response to the add page so that another person can be added. ID is passed as a parameter to display the id
        //for the new user to refer to get and view matches
        response.sendRedirect("add?id=" + id + "&advisor=" + advisor);
    }


  }
}
