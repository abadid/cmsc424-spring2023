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
public class GetAdvisor extends SimpleTagSupport {
  Student student;
  private int id;
  private static final Logger logger = LogManager.getLogger("match");

  public void setId(int id) {
    this.id = id;
  }


  public void doTag() throws JspException, IOException {
    //You write Student.getStudentWithAdvisor in Student class
    if (id != 0) {
      student = Student.getStudentWithAdvisor(id);
      getJspContext().setAttribute("name", student.getAdvisorName());
      getJspContext().setAttribute("field", student.getAdvisorField());
      getJspContext().setAttribute("experience", student.getAdvisorExperience());
      getJspBody().invoke(null);
    
    }
  }
}
