## Project 2: Advanced SQL Assignment, CMSC424, Spring 2023

*The assignment is to be done by yourself.*

Please do a `git pull` to download the directory `project2`. The files are:

1. README.md: This file
1. small.sql: SQL script for populating `flights` database.
1. queries.py: The file where to enter your answers for Q1 and Q2; this file has to be submitted.
1. answers.py: The expected answers to query Q1 and Q2.
1. SQLTesting.py: File to be used for testing your SQL submission -- see below.
1. trigger-database.sql: SQL script for setting up the `flighttrigger` database.
1. trigger.sql: The file where you will add the code for the trigger; this file has to be submitted.
1. trigger-test.py: Python script for testing the trigger -- see below.
1. Dockerfile: A dockerfile that creates a container with the required databases and populates some of them.

### Getting started
Similar to Project0, you will build the container with `docker build -t "cmsc424-project2" .` in the `project2` directory. Next you will need to start the container using `docker run -v "${PWD}:/home/project2" -ti -p 8888:8888 -p 5432:5432 --name project2  cmsc424-project2:latest` (if you're using cmd on Windows, replace `${PWD}` with `%cd%`). We have already created and loaded the `flights` and `flighttrigger` database in the docker container.

You can restart the container with the following commands:

    docker start project2
    docker exec -it project2 /bin/bash

Alternately, if you are using your host machine to start the PostgreSQL server, follow the instructions mentioned in the [Project0 README](https://github.com/abadid/cmsc424-spring2023/tree/main/project0). If you are using a native installation of postgres, will need to create and load the `flights` database using the `small.sql` file. Additionally, you will also need to create the `flighttrigger` database (you don't need to populate this database).


If you run into any issues while creating, loading or accessing the database, please seek help from a TA.

### Testing and submitting using SQLTesting.py
- Your answers (i.e., SQL queries) should be added to the `queries.py` file similar to Project 1. You are also provided with a Python file `SQLTesting.py` for testing your answers.

- We recommend that you use `psql` to design your queries, and then paste the queries to the `queries.py` file, and confirm it works.

- SQLTesting takes quite a few options: use `python SQLTesting.py -h` to see the options.

- If you want to test your answer to Question 1, use: `python SQLTesting.py -q 1`. The program compares the result of running your query against the provided answer (in the `answers.py` file).

- The -v flag will print out more information, including the correct and submitted answers etc.

### Submission Instructions
- Submit your answers to Q1, Q2, and Q3 in `queries.py`
- Submit your answer to Q4 in `trigger.sql`

</br>

**Q1 (5pt)**. A flight has flown on a certain day if the `flewon` table contains at least one entry with the same `flightid` on
the given date. Write a query that uses an outer join to list all the flights that did not fly on August 5, 2016. 
Output Column: `flightid`. Order By: `flightid`.

**Q2 (5pt)**. Let's revisit query 6 from Project 1. Recall that query 6 asked you to write a query to find the percentage participation of United Airlines in each airport, relative to the other airlines.
One instance of participation in an airport is defined as a flight (EX. UA101) having a source or dest of that airport.
If UA101 leaves BOS and arrives in FLL, that adds 1 to United's count for each airport.
This means that if UA has 1 in BOS, AA has 1 in BOS, DL has 2 in BOS, and SW has 3 in BOS, the query returns:

	| airport 		                                  | participation
	| General Edward Lawrence Logan International   	  | .14

Output: (airport_name, participation).
Order: Participation in descending order, airport name.

Note: 

1. The airport column must be the full name of the airport <br />
1. The participation percentage is rounded to 2 decimals, as shown above <br />
1. You do not need to confirm that the flights actually occur by referencing the flewon table. This query is only concerned with flights that exist in the flights table. 

In project 1, you were allowed to write this query any way that you wanted to. For this project, we want to give you some practice using correlated subqueries, so we are going to write the same query, but this time using correlated subqueries. In class, we saw an example of using correlated subqueries in the **WHERE** clause. However, for this query, we're going to use a correlated subquery in the **SELECT** clause. 

Start with the following query:
```
SELECT name, count(*)
FROM (SELECT source as airportid FROM flights union all SELECT dest as airportid FROM flights) as airportidunion
	natural join airports
GROUP BY name;
```

Your query **must** keep the same FROM clause as the above query. However, you need to modify the SELECT clause to add the correlated subquery to make sure you have United's participation in each airport (the query we gave you only has the total participation of each airport). You will likely find that you have to modifiy the GROUP BY clause as well --- this is fine. You will also need to add the ORDER BY clause. But you should not do anything else besides modify the SELECT and GROUP BY clauses of this query and adding the ORDER BY clause. 

**Q3 (8pt)**. We will try to write a query using outer joins to find all the customers who satisfy all the following conditions  
  1. are born in or before 1970, and  
  1. have taken a flight at least once and at most five times, 
  1. have never taken a flight in or out of `IAD`.

You're given the following views. You don't need to include them in the `queries.py` file, but you need to create them manually if you want to test your query in `psql`. 

```
create view customer_flight as
select distinct c.customerid as cid, flightid
from customers c, flewon f
where c.customerid = f.customerid and extract(year from birthdate) <= 1970
order by cid, flightid;
	
create view flight_IAD as
select flightid from flights
where source = 'IAD' or dest = 'IAD'
order by flightid;
```

**Q3.1 (3 pt)**. The `customer_flight` view lists all the customers who are born in or before 1970 and the flightid of the flights that the customer has taken. The `flight_IAD` view lists all the flights that fly in or out of IAD.

Explain why the following query does not work? Include your explanation as a comment in the `queries.py` file.

```
select cid 
from customer_flight c left join flight_IAD i 
  on c.flightid = i.flightid 
where i.flightid is null 
group by cid 
having count(*) <= 5;
```

**Q3.2 (5 pt)**. Modify the above query to produce the correct output. You can only use additional predicates and subqueries; however, you may not use any other tables. Order of the output does not matter.

**Q4 (22pt)**.[Trigger]

For this problem you are a database administrator who needs to deal with an issue with the current schema in the flights database.  Today's customers have multiple frequent flier airline memberships. However, the flights schema only allows one frequent flier airline per customer.  To fix the issue, we're going to evolve the database to a new schema.  We decide to delete the frequentflieron column from the `customers` table and instead store customer frequent flier information in a new table: `ffairlines (customerid, airlineid, points)`. By storing this information in a seperate table, if a customer has more than one frequent flier airline, this information can be represented as multiple rows in this new ffairlines table. 

The `points` columns of the `ffairlines` table is calculated as follows. A customer gets one point for each minute they spend on a flight with the given airline. The time spent on the airline is the difference of the local_arrival_time and  local_departing_time. (For simplicity, we ignore the time zones and simply calculate the difference in minutes). 

Unfortunately there are several apps that are using this schema, and some of them need some time before they can update their code to move to the new schema. In the meantime, they want to use the old schema. On the other hand, other apps need to use the new schema right away. We can't use views to solve this problem since both the apps that want to use the old schema and the apps that want to use the new schema want to insert new records into their respective schemas (see the discussion in the textbook about inserting data into views). 


We can solve this using triggers!  We'll keep the old customers table around. And we'll give the new customers table a different name `newcustomers`. Originally it is populated with data from the original customers table (without the `frequentflieron` column which instead will be populated in the new ffairline table). 

You need to write triggers that do the following:
1. **(9 pt)** Whenever an app inserts/updates/deletes data into the `customers` table, a trigger is fired that does the same corresponding action for the copy of the data in the `newcustomers` and `ffairline` tables.  On inserts into the `customers` table, the value for `frequentflieron` should result in an insertion into `ffairlines` of (customerid, frequentflieron, points).  If `frequentflieron` is NULL you should NOT add (customerid, NULL, NULL) to the `ffairlines` table.  Similarly, on updates to `frequentflieron` in the old customers table, a tuple should be inserted into `ffairlines` of (customerid, updated value of frequentflieron, points) --- but you wouldn't delete/change any other rows in `ffairlines` for that customer.  However, if `frequentflieron` is updated to NULL, then you should delete all entries in `ffairlines` for that customer.
1. **(3 pt)** Whenever an app inserts/updates/deletes data into the `newcustomers` table, a trigger is fired that does the same corresponding action for the copy of the data in the `customers` table. The value of the `frequentflieron` column in the `customers` table is the airline frequently travelled airline for that customer (based on the values of the `points` column in the `ffairline` table). If there are no frequent flier airlines for that customer, then the `frequentflieron` column must be set to NULL. In the case of a tie, the one that is smallest lexicographically is chosen. 
1. **(5 pt)** We also need a trigger on the new `ffairline` table to update the value of the `frequentflieron` column of the old customers table if the value should change as a result of the insert/delete/update to the ffairline table.
1. **(5 pt)** Since the `flewon` table can affect the choice of which airline should be listed as the `frequentflieron` value in the old customers table, we also need a trigger on the `flewon` table if as as result of the insert/update/delete to the table, the `frequentflieron` value needs to be changed in the old customers table. 

Here's an example (`flewon` table not shown):

Initially our database looks like this

`customers`

	 customerid |              name              | birthdate  | frequentflieron 
	------------+--------------------------------+------------+-----------------
	 cust0      | Anthony Allen                  | 1985-05-14 | AA
	 cust109    | James Adams                    | 1994-05-22 | AA
	 cust15     | Betty Gonzalez                 | 1993-12-28 | SW
	 cust33     | Christopher Davis              | 1984-05-13 | DL

`newcustomers`

	 customerid |              name              | birthdate  
	------------+--------------------------------+------------
	 cust0      | Anthony Allen                  | 1985-05-14
	 cust109    | James Adams                    | 1994-05-22
	 cust15     | Betty Gonzalez                 | 1993-12-28
	 cust33     | Christopher Davis              | 1984-05-13

`ffairlines`

	 customerid | airlineid | points 
	------------+-----------+--------
	 cust0      | AA        |     82
	 cust109    | AA        |     59
	 cust15     | SW        |    827
	 cust33     | DL        |    524


First, let's delete `(cust109, James Adams, 1994-05-22, AA )` from `customers`, we then have:

`customers`

	 customerid |              name              | birthdate  | frequentflieron 
	------------+--------------------------------+------------+-----------------
	 cust0      | Anthony Allen                  | 1985-05-14 | AA
	 cust15     | Betty Gonzalez                 | 1993-12-28 | SW
	 cust33     | Christopher Davis              | 1984-05-13 | DL

`newcustomers`

	 customerid |              name              | birthdate  
	------------+--------------------------------+------------
	 cust0      | Anthony Allen                  | 1985-05-14
	 cust15     | Betty Gonzalez                 | 1993-12-28
	 cust33     | Christopher Davis              | 1984-05-13

`ffairlines`

	 customerid | airlineid | points 
	------------+-----------+--------
	 cust0      | AA        |     82
	 cust15     | SW        |    827
	 cust33     | DL        |    524


Next let's insert `(cust102, George Gonzalez, 1996-01-30)` into `newcustomers`, we then have:

`customers`

	 customerid |              name              | birthdate  | frequentflieron 
	------------+--------------------------------+------------+-----------------
	 cust0      | Anthony Allen                  | 1985-05-14 | AA
	 cust15     | Betty Gonzalez                 | 1993-12-28 | SW
	 cust33     | Christopher Davis              | 1984-05-13 | DL
	 cust102    | George Gonzalez                | 1996-01-30 | 

`newcustomers`

	 customerid |              name              | birthdate  
	------------+--------------------------------+------------
	 cust0      | Anthony Allen                  | 1985-05-14
	 cust15     | Betty Gonzalez                 | 1993-12-28
	 cust33     | Christopher Davis              | 1984-05-13
	 cust102    | George Gonzalez                | 1996-01-30

`ffairlines`

	 customerid | airlineid | points 
	------------+-----------+--------
	 cust0      | AA        |     82
	 cust15     | SW        |    827
	 cust33     | DL        |    524


Note: George's frequentflieron column is null in `customers` because we inserted his info into the `newcustomers` table but didn't add any entries in `ffairlines`.

Next let's assume that George plans to take a lot of flights on Delta so he decides to become a `DL` frequent flier. So we add (cust102, DL) to `ffairlines`. Our table looks like:

`customers`

	 customerid |              name              | birthdate  | frequentflieron 
	------------+--------------------------------+------------+-----------------
	 cust0      | Anthony Allen                  | 1985-05-14 | AA
	 cust15     | Betty Gonzalez                 | 1993-12-28 | SW
	 cust33     | Christopher Davis              | 1984-05-13 | DL
	 cust102    | George Gonzalez                | 1996-01-30 | DL


`newcustomers`

	 customerid |              name              | birthdate  
	------------+--------------------------------+------------
	 cust0      | Anthony Allen                  | 1985-05-14
	 cust15     | Betty Gonzalez                 | 1993-12-28
	 cust33     | Christopher Davis              | 1984-05-13
	 cust102    | George Gonzalez                | 1996-01-30

`ffairlines`

	 customerid | airlineid | points 
	------------+-----------+--------
	 cust0      | AA        |     82
	 cust15     | SW        |    827
	 cust33     | DL        |    524
	 cust102    | DL        |      0


Note: We added DL as George's frequent flier airline because it is his only frequent flier airline.

Lastly let's say  Anthony Allen becomes a South West frequent flier in addition to her American Airlines frequent flier membership.  So we insert (cust12, SW, 723) into `ffairlines`. Our tables look like:

`customers`

	 customerid |              name              | birthdate  | frequentflieron 
	------------+--------------------------------+------------+-----------------
	 cust0      | Anthony Allen                  | 1985-05-14 | SW
	 cust15     | Betty Gonzalez                 | 1993-12-28 | SW
	 cust33     | Christopher Davis              | 1984-05-13 | DL
	 cust102    | George Gonzalez                | 1996-01-30 | DL

`newcustomers`

	 customerid |              name              | birthdate  
	------------+--------------------------------+------------
	 cust0      | Anthony Allen                  | 1985-05-14
	 cust15     | Betty Gonzalez                 | 1993-12-28
	 cust33     | Christopher Davis              | 1984-05-13
	 cust102    | George Gonzalez                | 1996-01-30

`ffairlines`

	 customerid | airlineid | points 
	------------+-----------+--------
	 cust0      | AA        |     82
	 cust15     | SW        |    827
	 cust33     | DL        |    524
	 cust102    | DL        |      0
	 cust0      | SW        |    723


Note: We updated Anthony's `frequentflieron` airline.  This may not always happen.  By looking at the `flewon` table (not shown here) we saw that Anthony flew on more SW flights than AA flights so we updated her `frequentflieron`.  If we had found that he had flown on more AA flights than SW flights then there would be no changes in the `customers` table.

Switch to the `flighttrigger` database (i.e. exit out of the flights database and run `psql flighttrigger`). Execute `\i trigger-database.sql` The trigger code should be submitted in `trigger.sql` file. Running `psql -f trigger.sql flighttrigger` should generate the trigger without errors.

You may also use `trigger-test.py`, in which case you do not need to execute `psql -f trigger.sql flighttrigger` (it is included in the script). You can run the test script as `python trigger-test.py`. A few transactions to the `newcustomers` and `ffairlines` table are also provided. You are free to add more transactions for purposes of testing your trigger code.
The simplest way to reset the database is to
```
dropdb flighttrigger
createdb flighttrigger
psql -f trigger-database.sql flighttrigger
psql -f trigger.sql flighttrigger
```
All of those commands are executed for you in the script.

We will be grading this assignment using the same `trigger-test.py` file but with different data.

Some useful trigger examples:
+ https://www.postgresql.org/docs/14/plpgsql-trigger.html 
+ https://stackoverflow.com/questions/708562/prevent-recursive-trigger-in-postgresql


### Submission
Add `queries.py` and `trigger.sql` to a zip file and submit it on gradescope. 
