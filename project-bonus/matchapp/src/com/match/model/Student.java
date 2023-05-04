package com.match.model;

import com.match.model.Field;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Arrays;
import java.util.Map;
import java.lang.NullPointerException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;
import java.io.File;
import java.io.IOException;

public class Student {

	static Connection con = null;
	/*
	Fields for a student entry in the students table
	remember to add one of your own choice of fields.
	*/
	private String firstName, lastName, email, studenttype;
	private int advisor, advisorExp;
	private String advisorName, advisorField;

	private String[] needs;
	private String[] available;

	// Used for logging output, see catalina.out for log files.
	private static final Logger logger = LogManager.getLogger("match");
	static JsonFactory factory = new JsonFactory();

	public Student() {

	}

	// Constructor for student if only need to display the name.
	public Student(String firstName, String lastName) {
		this.firstName = firstName;
		this.lastName = lastName;
	}

	// Constructor for student if only need to display the name and email.
	public Student(String firstName, String lastName, String email) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
	}

	// Constructor for student with all inital fields.
	public Student(String firstName, String lastName, String email, String studenttype) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.studenttype = studenttype;
	}

	// Constructor for student with mentor needs and availablity.
	public Student(String firstName, String lastName, String email, String studenttype, int advisor, String[] needs,
			String[] available) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.studenttype = studenttype;
		this.advisor = advisor;
		this.needs = needs;
		this.available = available;
	}
	
	public Student(String advisorName, String advisorField, int advisorExp) {
		this.advisorName = advisorName;
		this.advisorField = advisorField;
		this.advisorExp = advisorExp;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getEmail() {
		return email;
	}

	public String getAdvisorName() {
		return advisorName;
	}

	public String getAdvisorField() {
		return advisorField;
	}

	public int getAdvisorExperience() {
		return advisorExp;
	}

/*
Return an array of all the people in the students table
You will need to make a SQL call via JDBC to the database to get all of the students
Since the webpage only needs to display the student's first name, last name and email,
only those fields of the Student object need to be instantiated.
Order does not matter.
*/
public static Student[] getStudents() {
	con = getConnection();

	if (con == null) {
		logger.warn("Connection Failed!");
		Student failed = new Student("Connection", "Failed", "!");
		return new Student[] { failed };
	}
	return new Student[]{};
}

/* 
For every student record in the database, search each of its character fields to see if input query is a substring of any of them
Return everything that matches with every char/varchar column. This should be case senstive in finding substring matches.

For example if we have 2 students with:
First: Alex, Last: Westave, studenttype: Freshman
First: Dave, Last: Howland, studenttype: Junior

If we query with the string: "ave", the Student array that is returned contains both people
If we query with the string: "West", the Student array that is returned contains just Alex
If we query with the string: "COUNT", the Student array is empty

The order of the people returned does not matter.

Once again you only have to return first name, last name, and email.

If no rows in the database are found with a substring match, you should return an empty array of Student.

You must use a prepared statement.
*/
	public static Student[] getStudentSearch(String query) {

		con = getConnection();

		if (con == null) {
			logger.warn("Connection Failed!");
			Student failed = new Student("Connection", "Failed", "!");
			return new Student[] { failed };
		}

		return new Student[]{};
	}

	/*
	This should return a Student object with all of its fields instantiated
	for the student with the given id in the students table. Note that since id is unique,
	there will only be one student ever returned by this method
	
	Return a student with the first name "No", last name "Matches", and
	email "!", if the student with the id does not exist.
	
	You do not need to use a prepared statement (but you still can!).
	*/
	public static Student getStudent(String sid) {

		con = getConnection();

		if (con == null) {
			logger.warn("Connection Failed!");
			Student failed = new Student("Connection", "Failed", "!");
			return failed;
		}
		return new Student("No", "Matches", "!");
	}

	/*
	Add a student to the database with all of the fields specified.
	
	Do not update the user's advisor_id in this method, simply leave it null in this method. 
	That will be taken care of in AddStudent.java.
	
	If the connection fails or the student was not inserted, return -1, otherwise return the id of the student that you inserted.
	
	You must use a prepared statement to insert the student.
	*/
	public static int addStudent(String first, String last, String email, String studenttype) {

		con = getConnection();

		if (con == null) {
			logger.warn("Connection Failed!");
			return -1;
		}

		return -1;
	}

	/*
	Return a list of all mentors with field matches in the database for the student with the given id based on the
	student type compatibility and field mentor needed. If the student needs a mentor from more than
	one field, return all matches for all fields needed.
	
	A student is not allowed to be matched with herself or himself.
	
	If the student with id does not exist, return a Student array with one student with the first name "No", last name "Matches" and email "!".
	If the student has no matches, return an empty Student array.
	If the student doesn't need a mentor, return an empty Student array.
	
	You must use a prepared statement.
	*/

	public static Student[] getMentorMatches(String id) {

		con = getConnection();
		// If that fails, send dummy entries.
		if (con == null) {
			logger.warn("Connection Failed!");
			Student failed = new Student("Connection", "Failed", "!");
			return new Student[] { failed };
		}

		return new Student[]{};
	}

	/*
	Use this method to add a needed mentor 'm' into the database. The student who needs
	the mentor is given by their id. A student should not be able to submit a request for
	two mentors of the same field.

	Do not update the student's advisor_id in this method. That will be taken care of in AddRequest.java.

	You must use a prepared statement.

	Return 1 on success or -1 otherwise.
	*/
	public static int addMentorNeeded(Field f, int sid) {

		con = getConnection();

		if (con == null) {
			logger.warn("Connection Failed!");
			return -1;
		}

		return -1;
	}

	/*
	Use this method to add an available mentor of field d into the database. The student who 
	can provide mentorship is denoted by their id. A student should not be able to make more than one
	offer in each field.

	Do not update the student's advisor_id in this method. That will be taken care of in AddOffer.java.

	Return 1 on success or -1 otherwise.

	You must use a prepared statement.
	*/
	public static int addMentorAvailable(Field f, int sid) {

		con = getConnection();

		if (con == null) {
			logger.warn("Connection Failed!");
			return -1;
		}

		return -1;
	}

	/*
	Fill in this method to check if student mentorID can satisfy student menteeID's needs for
	a mentor. This means the requested field must match and mentor's student_type must be
	greater than or equal to the mentee's student_type. (Here greater is defined based on the seniority of the student).
	
	You do not need to use prepared statements.
	*/
	public static boolean computeMentorMatch(int menteeID, int mentorID) {

		con = getConnection();

		if (con == null) {
			logger.warn("Connection Failed!");
			return false;
		}

		return false;
	}
	
	/*
	Fill in this method to find the advisor for the student with the given sid.
	Now query the advisors table to find the advisor's name, field and experience.
	Populate the values in the corresponding variables and return the student object.
	
	You do not need to use prepared statements.
	 */
	public static Student getStudentWithAdvisor(int sid) {
		con = getConnection();

		if (con == null) {
			logger.warn("Connection Failed!");
			Student failed = new Student("Connection", "Failed", 0);
			return failed;
		}
		return new Student();
	}

	/* 
	This method will assign an advisor to a student as they sign up for the first time.
	
	You will assign an advisor to a student by updating the students's advisor_id field with
	the advisor with the fewest students. The number of students is defined as the number of
	students assigned to that advisor through their advisor_id field. To break ties, choose
	the advisor with the smallest id.
	
	sid = student id
	
	You must use prepared statements.
	*/
	public static int getAdvisorFirst (int sid) {

	    con = getConnection();

	    if (con == null) {
	        logger.warn("Connection Failed!");
	        return -1;
	    }

	   return -1;
	}


	/*
	Fill in this method to assign an advisor to the given student following a mentor
	request or offer. This function will run each time a student requests or offers mentorship.
	The way to assign a proper advisor is to find the advisor with the
	fewest students, who also has the same field as their requested/offered mentor.
	You should use more experience as a tiebreaker. If two advisors are still tied,
	choose the advisor with the first name alphabetically. Finally, if they are still tied
	choose the one with the smaller id.

	Note: the student will already be assigned an advisor from either signup or a previous
	request/offer. DO NOT include the student you are updating in the count of their advisor's students.

	Make sure you update the correct student entry in the database with the assigned
	advisor id.

	Example: A student request a Theory mentor.

	Name: Abrams, Field: Theory, Experience: 10, # of students: 3
	Name: Scott, Field: Theory, Experience: 5, # of student: 3
	Name, Delagdo, Field: Theory, Experience: 10, # of student: 3

	This should return the id of Abrams, since they have the fewest student, most
	experience, and their name comes before Delgado's aphabetically.

	You must use prepared statements.
	*/
	public static int getAdvisorUpdate(Field f, int sid) {
		con = getConnection();

	    if (con == null) {
	        logger.warn("Connection Failed!");
	        return -1;
	    }

		return -1;
	}

	private static Connection getConnection() {
		// Return existing connection after first call
		if (con != null) {
			return con;
		}
		logger.trace("Getting database connection...");
		// Attempt to connect to a local postgres server
		con = getLocalConnection();
		// If that fails, give up
		if (con == null) {
			logger.warn("Unable to connect to database...");
			return null;
		}
		return con;
	}

	/* Connect to the local database for development purposes
	Your database must be named "matchapp" and you must make a user "matchmaker" with the password "kingofthenorth"
	*/
	private static Connection getLocalConnection() {
		try {
			Class.forName("org.postgresql.Driver");
			logger.info("Getting local connection");
			Connection con = DriverManager.getConnection(
			"jdbc:postgresql://localhost:5432/matchapp",
			"matchmaker",
			"kingofthenorth");
			logger.info("Local connection successful.");
			return con;
		}
		catch (ClassNotFoundException e) { logger.warn(e.toString());}
		catch (SQLException e) { logger.warn(e.toString());}
		return null;
	}

}
