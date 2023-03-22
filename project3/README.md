## Project 3: Matchapp (JDBC Manipulation), CMSC424, Spring 2023

*This project is to be done individually.*

## **Introduction**

This project should help you gain the skills involved in creating parts of a functional web application that interfaces with a database system using JDBC. We will be creating an application that functions as a Craigslist of organ donations. We will be using Java  to make this happen. In a real world, you will also need a webserver such as Apache Tomcat and HTML (along with JavaScript) to create the entire application. You will be a "Backend developer" in this project since you will be dealing with the back-end (logic tier), and the database system components. To simplify the project, you will not need to work on the front-end (presentation tier) of the application.

## **Relevant Project Files**

To begin this project you will have to pull the project 3 folder from our the repository. Below, we give an overview of the important files that you should know about; all of the other files that are included in the code that you pull are just there to make sure that the application works properly:

* **build.sh**: you should run "./build.sh" in order for your project files to build. This will compile all the necessary files for the application. Make sure you run build in the `matchapp` directory to have it generate and copy the war file to the tomcat directory properly. Run this AFTER starting tomcat to see your website instead of the default tomcat site.

Make sure to run this every time you change your code in order to recompile it. You should also run it while the server is running (more on that later).

* **src/**

    * **.jsp**: These are the Java Server Pages. JSP allows Java code to be interleaved with static web markup content (HTML in our case), with the resulting page being compiled and executed on the server to deliver a complete HTML page. Basically Java is being used to dynamically create HTML pages. A good overview/tutorial on JSP can be found at: [https://www.tutorialspoint.com/jsp/jsp_overview.htm](https://www.tutorialspoint.com/jsp/jsp_overview.htm) (however, you can skip the parts of the tutorial on how to set up the enviornment, since we’ve already done that for you). It is a good idea to check out the other jsp files we are providing you, so that you can get a sense of how each page of the app is generated. You DO NOT need to modify any of this code; the jsp files are for your understanding only. **(Front-end Component)**

    * **com/match/**

        * **model/**

            * **Person.java:** This Java file interfaces with the person table in the matchapp database. We provide basic constructors for a person object but there are several functions missing that you must complete. **(Back-end + DB Component)**

        * **web/**

            * **.java:** These are servlet files that deal with porting over information computed by the **model** files. They help bridge the gap between the back-end and the frontend. **(Back-end + Front-end Components)**

## **Getting Started**

Similar to Project0, you will build the container with `docker build -t "cmsc424-project3" .` in the `project3` directory. Next you will need to start the container using `docker run -v "${PWD}:/home/project3" -ti -p 8080:8080 --name project3  cmsc424-project3:latest` (if you're using cmd on Windows, replace `${PWD}` with `%cd%`). 
You can restart the container with the following commands:

   `docker start project3`
   `docker exec -it project3 /bin/bash`


You can quickly start your web application through the following commands:

```bash
cd /opt/tomcat/bin
./startup.sh 
cd /home/project3/matchapp
./build.sh 
```

After executing the commands listed above, Navigate to the page localhost:8080 in your browser. Take some time to view the different pages and examine the format of the website. You may see some error messages until you get the database set up.

More technical details are given in the section below. We will be using tomcat to run our server locally.

* `/opt/tomcat/bin/startup.sh`: Starts your tomcat server

* `/opt/tomcat/bin/shutdown.sh`:  Stops your server

* `./build.sh`:  When executed in the `/home/project3/matchapp` directory, builds all necessary files and copies your **ROOT.war** file to the right tomcat directory.

* ` tail /opt/tomcat/logs/catalina.out`: Checks log file of tomcat server

* `tail /opt/tomcat/logs/localhost.(current-date)`: Checks log file of localhost

You won't be able to debug this web application with print statements like you would for other programs. With Tomcat, you can print values and errors to the log and view the output they produce in the log file. We have set up the log and have included some uses of the logger in the getConnection method but you may want to add your own statements that log information in the methods you write to debug what your program is doing. [Here](https://logging.apache.org/log4j/2.x/manual/messages.html) is a useful link to using the log with examples.

Basically, you can add `logger.info()` and `logger.trace()` statements to print values when your code runs that you can then view the output of in the catalina.out file. If your application isn't behaving as expected or is crashing, add logging statements to your code and view the log to figure out the issue.


Here is which files correspond to which links on the website:
- **404.jsp** - Going to any url that is not set up to be a page on the website  
- **default.jsp** - The home page
- **add.jsp** - The Register link
- **request.jsp** - The Request Organ link
- **offer.jsp** - The Offer Organ link
- **people.jsp** - The People link  
- **generate.jsp** - The Find Matches page  
- **invalid_input.jsp** - Page shown if the user enters invalid input in the Register page  
- **matches.jsp** - The View Matches link  

## **Schema + User**

We already created a database called `matchapp` for you. You should run `\i organs.sql` from the psql interface to insert tuples. Make sure you are in the `/home/projec3` directory when you enter the database (`psql matchapp`).

```bash
$ cd /home/project3
$ psql matchapp
matchapp=# \i organs.sql
matchapp=# \q
```

The schema is as follows:

* **person**:
    * **id:** This is the primary key of the table, to represent a unique person. This will be of type "serial" which we have not seen yet this semester; this data type auto generates a next unique id to assign to a new person in the table.

    * **first_name:** A string less than or equal to 12 characters long.

    * **last_name:** A string less than or equal to 18 characters long.

    * **birthdate:** A date representing birthdate.

    * **blood_type:** A string representing blood type. See the blood_type table for a list of all possible blood types.

    * **doctor_id:** This is an integer type that references the doctor table's id field.

* **doctors**:

    * **id:** **(Primary Key)**  An integer that represents the id of the doctor. This is also of type serial, although you won't be creating any doctors for this project.

    * **name:** String representing the doctor's name.

    * **specialty:** String representing what organ the doctor specializes in.

    * **experience:** int representing how long the doctor has worked for.

* **needs**:

    * **id:** **(Primary Key)**  An integer that represents the id of the person with the need. This references the person table.

    * **organ:** **(Primary Key)** String representing what organ the person needs.

    * **by:** date representing when the person needs the organ by.

* **available**:

    * **id:** **(Primary Key)**  An integer that represents the id of the person with the organ offer. This references the person table.

    * **organ:** **(Primary Key)** String representing what organ the person has available. References the organs table

* **organs**:

    * **organ:** **(Primary Key)**  A string that names an organ.

* **blood_type**:

    * **type:** **(Primary Key)**  A string that names a blood type.

You will also have to create a user with name **"matchmaker"** and password **“kingofthenorth”** and you must grant all permissions to that user to access your database and tables as it will be the one doing the database manipulation. Below are the commands to do this (which you can run in psql or add to a .sql file):

```bash
$ psql matchapp
matchapp=# CREATE USER matchmaker WITH PASSWORD 'kingofthenorth';
matchapp=# GRANT ALL PRIVILEGES ON DATABASE matchapp TO matchmaker;
matchapp=# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO matchmaker;
matchapp=# GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO matchmaker;
matchapp=# \q
```

# Your Tasks

## **Person.java: Back-end + DB (34 points)**

You will need to complete the following methods in the `Person.java` model file that interfaces with the `person table` in the matchapp database. We have already completed a few of these methods, including the constructors as well as functions that interface with your database remotely and locally. You have to complete:

* **getPeople():** Get a list of all the people in the database. (3pts)

* **getPerson(String pid):** Get a specific person given a value for the id attribute. (3pts)

* **getPersonSearch(String substring):** Return people in the Person table that have an attribute that have a substring match with the query. (4pts)

* **addPerson(String first, String last, String birthdate, String blood_type):** Add a person with the specified values in the person table. Should leave doctor_id null.  (4pts)

* **getOrganMatches(id):** Get everyone who can donate an organ to this person. Should use your `computeOrganMatch()` to check the compatibility of each potential match. (4pts)

* **addNeededOrgan(Organ o, int pid, String byDate):** Add a needed organ to the database for the given person and organ. (3pts)

* **addAvailableOrgan(Organ o, int pid):** Add an available organ to the database for given person and organ. (3pts)

* **computeOrganMatch(int id1,int id2):** Check if the two people given are compatible for a donation. (4pts)

* **getDoctorFirst(pid):** Assign a doctor to a newly registered person. See the method comments for more details on how to do that. (3pts)

* **getDoctorUpdate(Organ o,int pid):** Assign a new doctor to someone who registers an organ. See the method comments for more details on how to do that. (3pts)

The `Person.java` file has comments above each method with more details about what each method should do. We will be testing each of these methods individually to ensure that they produce the output as specified by the comments above each method on a database with different people and doctors that we make. The data we test it on will be exactly the same as the form we have given to you in `organs.sql` --- only the actual values will be different.  

You may want to add a main function in `Person.java` to test each function you modified. For example:

```java
public static void main(String [] args) {
  Person[] persons = Person.getPeople();
    for (Person p : persons) {
      System.out.println(p.getFirstName() + " " + p.getLastName());
    }
}
```

To run `Person.java`:

```bash
cd /home/project3/matchapp/src/WEB-INF
cd ../../ && build.sh
cd /home/project3/matchapp/src/WEB-INF
java -classpath "lib/*:classes/.:." com.match.model.Person
```

**The following resources may help you in writing this code:**

[Creating Statements](https://docs.oracle.com/javase/tutorial/jdbc/basics/processingsqlstatements.html#creating_statements)

[Prepared Statements](https://docs.oracle.com/javase/tutorial/jdbc/basics/prepared.html)

## **Connecting Back-end + Front-end (6 points)**

Now that you have successfully finished the majority of the back-end (logic tier) components, you will now have to hook up the back-end with the front-end components. This process will be done via the Java files in the **matchapp/src/com/match/web** directory. You will complete the TODO stubs found in the `doPost()` methods of **AddPerson.java**, **AddOffer.java**, and **AddRequest.java**.


# Testing

**We do not provide you with a testing file like the first two projects, but if you follow the steps below, it should give you a good idea of whether or not your project is working correctly.**

1. To start, ensure that your database is properly created and set up by following the steps in the *Schema + User* section. You should also be running the server and have built the project. Steps for this can be found in the *Getting Started* section. In your vagrant command line, run `psql matchapp`. We will use the psql interface to verify that your queries are working correctly.
2. In a browser, go to `localhost:8080`. The OrganTrail home page should be visible. If not, try refreshing the page a couple times or rebuilding the project. Also make sure the server is running.
3. Click on the `register` tab. Enter any first name, last name, and birthdate (>18 years old). Then select AB+ for the blood type. Click submit. You should see the id and doctor id of your created person. If this is the first person you have registered, it should be id 101 and doctor 2.
4. Now create another person, but this time make the person younger than 18. You should be redirected to an invalid input page.
5. Navigate to the `People` tab. You should see a list of 10 people. Now, enter your registered person's first name into the search bar and press submit. You should see your created person come up. Do the same with last name, and blood type (AB+). For blood type, you may not see your person since there are more than 10 people with AB+. You can verify that all of the people returned have AB+ using the psql command line.
6. Go to the `Find Matches` page. Enter your person's id. It should display nothing (not 'No Matches').
7. Now go to the `Request Organ` tab. Enter your person's id, Liver, and some date that is a couple years into the future. Your doctor's id should be changed. Check that it was also changed in the database. You should also check that this doctor's specialty is liver. If this is the first person you created, you should get doctor 73.
8. Click on the `Find Matches` tab. Enter your person's id and click generate match. You should see at least 7 names, including Viv Bridgwood and Calypso Van Der Hoog. Verify in the database that everyone you see is present in the available table with liver being offered.
9. Now, go to the offer organ tab, and offer your person's heart. Your person's doctor should be changed again. Go back to the find matches tab, and enter id 6. You should see your person's name somewhere in the list.

**This testing is meant to give you a feel of how your project should work. It is not all-encompassing and we encourage you to more vigorously test your site.**


# **Submission**

To submit the project, zip the matchapp folder into a zip file named **matchapp.zip** and submit via Gradescope. The autograder requires the folder to be the root folder of the zip file to execute successfully.
 

