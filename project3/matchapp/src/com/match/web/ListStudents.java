package com.match.web; 
import com.match.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.*;

//No code to add here
public class ListStudents extends SimpleTagSupport {
  Student[] students = null;
  String query = "";

  public void setQuery(String query) {
    this.query = query;
  }

  public void doTag() throws JspException, IOException {
    // If the query is changed, search based on the query
    if (!query.equals(""))
      // You write this method
      students = Student.getStudentSearch(query);
    else
      // Just get all of the students from the database.
      // You write this method
      students = Student.getStudents();
    
    //We will only display first 10 for webpage
    int length = students.length;
    if(length > 10) {
      length = 10;
    }

    for (int i = 0; i < length; i++) {
      getJspContext().setAttribute("first", students[i].getFirstName());
      getJspContext().setAttribute("last", students[i].getLastName());
      getJspContext().setAttribute("email", students[i].getEmail());
      getJspBody().invoke(null);
    }
  }
}
