package com.match.web;
import com.match.model.Student;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.*;

//No code to add here
public class GenerateMatch extends SimpleTagSupport {
  Student[] students = null;
  private String id;
  private static final Logger logger = LogManager.getLogger("match");

  public void setId(String id) {
    this.id = id;
  }


  public void doTag() throws JspException, IOException {
    //You write Person.getMatchedPeople in Person class
    if (!id.equals("")) {
      students = Student.getMentorMatches(id);

      for (int i = 0; i < students.length; i++) {
        getJspContext().setAttribute("first", students[i].getFirstName());
        getJspContext().setAttribute("last", students[i].getLastName());
        getJspContext().setAttribute("email", students[i].getEmail());
        getJspBody().invoke(null);
      }
    }
  }
}
