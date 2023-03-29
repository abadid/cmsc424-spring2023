package com.match.web;
import com.match.model.Student;
import com.match.model.Field;
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
public class AddOffer extends HttpServlet {
  private static final Logger logger = LogManager.getLogger("match");
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NumberFormatException {

    //Gets the string data of all of the fields in the form
    String id = request.getParameter("id");
    String field = request.getParameter("field");

    /*
    TODO: Call the addMentorAvailable and getAdvisorUpdate methods given the parameters passed
    to the post request. Only call getAdvisorUpdate if the first function is successful.
    Then, send the status and new advisor as URL parameters in the redirect
    */

    // status should be the code returned from addMentorAvailable and advisor should be the advisor's id returned from getAdvisorUpdate.
    // There is no need to update advisor if addMentorAvailable fails.

    int status = -1;
    int advisor = -1;

    response.sendRedirect("offer?status=" + status + "&advisor=" + advisor);
  }
}
