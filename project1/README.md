## Project 1: SQL Assignment, CMSC424, Spring 2019

*The assignment is to be done by yourself.*

The following assumes you have gone through PostgreSQL instructions from Project 0 and have ran some queries on the `university` database. It also assumes you have cloned the git repository, and have done a `git pull` to download the directory `project1`. The files are:

1. README.md: This file.
1. small.sql: The SQL script for creating the data.
1. queries.py: The file where to enter your answer; this is the file to be submitted.
1. answers.py: The answers to the queries on the small dataset.
1. SQLTesting.py: File to be used for testing your submission -- see below.
1. Dockerfile: A Dockerfile that creates a container and starts the PostgreSQL server. 

**Note:** We will test your queries on a different, larger dataset.

### Getting started
Similar to Project0, you will build the container with `docker build -t "cmsc424-project1" .` in the `project1` directory. Next you will need to start the container using `docker run -v $PWD:/home/project1 -ti -p 8888:8888 -p 5432:5432 --name project1  cmsc424-project1:latest`. We have already created and loaded the flights database in the docker container. If you are using a native installation of postgres, will need to create and load the `flights` database using the `small.sql` file.  You can restart the container with the following commands: 
    ```
    docker start project1
    docker exec -it project1 /bin/bash
    ```

Alternately, if you are using your host machine to start the PostgreSQL server, follow the instructions mentioned in the [Project0 README](https://github.com/abadid/cmsc424-spring2023/tree/main/project0).


If you run into any issues while creating, loading or accessing the database, please seek help from a TA.

### Schema
The dataset contains synthetic air flight data. Specifically it contains the following tables:

1. airports: airportid, city, name, total2011, total2012
1. customers: customerid, name, birthdate, frequentflieron
1. airlines: airlineid, name, hub
1. flights: flightid, source, dest, airlineid, local_departing_time, local_arrival_time
1. flewon: flightid, customerid, flightdate

See the provided SQL file for the table definitions.

The dataset was generated synthetically: the airport ids and the cities were chosen from the biggest airports in the US, but the rest of the data is populated randomly. The data will not make sense. For example, two different flights between the same cities may have very different flight durations. The flight times between the cities may not correspond to geographical distances that you know. Some other information about the data:
- Each customer may at most take one flight every day.
- The flight times were chosen between 30 minutes to 5 hours randomly.
- All flights are daily (start and end on a single day), and none are overnight.
- For every flight from city A to city B, there is corresponding return flight from B to A.
- The "flewon" table only contains the flight date -- the flight times must be extracted from the flights table.

This assignment invovles writing SQL queries over this dataset.  In many cases (especially for complex queries or queries involving `max` or `min`), you may find it helpful to use the `with` construct in order to break down your solution into less complex parts. This also will make debugging easier.

Some of the queries require you to use string or date functions that were not in the assigned reading from your textbook. This will enable you to get some experience using DB documentation to help you to write queries. Some helpful links:

- PostgreSQL date functions: https://www.postgresql.org/docs/current/functions-datetime.html
- PostgreSQL string functions: https://www.postgresql.org/docs/current/functions-string.html
- How to cast data types in PostgreSQL: http://www.postgresqltutorial.com/postgresql-cast/

You don't have to use the "hints" if you don't want to; there might
be simpler ways to solve the questions.

### Testing and submitting using SQLTesting.py
The queries that we want you to write can be found as comments in the `queries.py` file. Your answers (i.e., SQL queries) should be added to this same `queries.py` file. A simple query is provided for the first answer to show you how it works.
You are also provided with a Python file `SQLTesting.py` for printing your answers. The `SQLTesting.py` file essentially compares the answers of your queries with the correct answers present in `answers.py`.

- We recommend that you use `psql` to design your queries, and then paste the queries to the `queries.py` file, and confirm it works.

- SQLTesting takes quite a few options: use `python SQLTesting.py -h` to see the options.

- To get started with SQLTesting, do: `python SQLTesting.py -v -i` -- that will run each of the queries and show you the result returned.

- If you want to test your answer to Question 1, use: `python SQLTesting.py -q 1`.

- The `-v` flag will print out more information, including the correct and submitted answers etc.

- If you want to test your answers to all questions (this is what we will do), use: `python SQLTesting.py` and look at the final total score.

- `-i` flag to SQLTesting will run all the queries, one at a time (waiting for you to press Enter after each query).

- **Note that**: We will basically run this same program on your submitted `queries.py` file, but with a larger dataset; your score on the assignment will be the score output by the program. The program tries to give partial credit (as you can see in the code). In general, it is unlikely that your score on the larger, hidden dataset will be higher than your score on the dataset that we provided you.

### Submission Instructions
Submit the `queries.py` file using the Assignments link on Gradescope.

### Assignment Questions
See `queries.py` file.
