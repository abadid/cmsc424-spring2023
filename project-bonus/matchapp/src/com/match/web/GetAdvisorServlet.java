package com.match.web;
import com.match.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

//No code to add here
public class GetAdvisorServlet extends HttpServlet {
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NumberFormatException {
    String id = request.getParameter("id");
    request.setAttribute("id", id);
    RequestDispatcher view = request.getRequestDispatcher("advisor.jsp");
    view.forward(request,response);
  }
}
