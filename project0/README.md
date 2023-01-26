# Project 0: Computing Environment

Over the course of the semester, you will work with a variety of software packages, including PostgreSQL, Apache Spark, and others. Installing those packages and getting started can often be a hassle, because of software dependencies. You have three choices.

* (**Preferred Option**) Use Docker (as discussed below). If you have a reasonably modern machine (within last 3-4 years), Docker should generally work fine, but with older laptops, the performance may not be as good. See below for more details on this.
* Install the different software packages on your own machine (most of these packages should have tutorials to install them on different OSs). If you have a Linux box or a Mac, this should be possible; it will be more difficult with Windows. In any case, although TAs would try their best, they would likely not be able to help you with any problems.
* Use a VM in the CS Department's Horvitz Cluster. Last year, only one person chose to use this, so we will likely do this on demand, if anyone is really interested. You can also similarly use a VM in Amazon or Microsoft Azure clusters -- both of them provide free VMs for beginning users. The problem with this approach is that you only have `ssh` access into that machine, so you can't run a web browser, etc., without some work.

---

### Git & Github

Git is one of the most widely used version control management systems today, and invaluable when working in a team. GitHub is a web-based hosting service built around git --
it supports hosting git repositories, user management, etc. There are other similar services, e.g., bitbucket.

We will use GitHub to distribute the assignments, and other class materials. Our use of git/github for the class will be minimal.

#### Just Cloning the Class Repository

You don't need a GitHub account for just cloning the class repository. Just install git (on Windows, http://gitforwindows.org/ is helpful) and then run:

`git clone https://github.com/abadid/cmsc424-spring2019.git`

You can do `git pull` (from within the `cmsc424-spring2019` directory) to fetch the newly added material.

*NOTE*: If you are having trouble installing `git`, you can just download the files instead (as a zipfile), although updating may become tedious.

---

### Docker

[Docker](https://www.docker.com/) is a containerization platform that is used to package your application and all its dependencies together in the form of containers to make sure that your application works seamlessly in any environment which can be developed or tested or in production. We will provide `Dockerfile` for different assignments, that will help you start containers with the requisite packages installed.

- In order to use this option, you have to first install Docker desktop on your machine (called `host` henceforth). See the instructions on the [Docker website](https://www.docker.com/products/docker-desktop). 
- Docker makes things **super-easy**. We will provide you with appropriate setup files -- all you need to do is `docker build` and `docker run` to start the container. Specifically:
   - In the git sub-directory `project0`, run `docker build -t "cmsc424-project0" .` (NOTE: the dot in the end is important). This will build the image of the container you need to run.
   - Run the docker image: `docker run --rm -ti -p 8888:8888 -p 5432:5432 cmsc424-project0:latest`. This will start the container and load data into the postgres instance. 
   - At this point, you will be in the docker container in the `/home/project0` directory. 
- Some other docker commands that you would need to be familiar with:
   - `docker stop`:  Stops the running container. 
   - `docker restart`: Restarts the container.
   - `docker cp`: Copies files between the container and the host. 
   - `docker rm`: Removes the docker container. 

---

### PostgreSQL

PostgreSQL is a full-fledged and powerful relational database system, and will be used for several assignments. 

PostgreSQL is already installed on your container. To get started, start the container using `docker run --rm -ti -p 8888:8888 -p 5432:5432 cmsc424-project0:latest`. 
The current version of PostgreSQL is 15.1. However, the version installed on the containers is 14.6, the one available through `apt-get` right now. You will find the detailed documentation at: https://www.postgresql.org/docs/14/index.html. 

If you are using docker, you can skip the rest of the intrsutctions to create and load the university database. However, its still useful to read the instructions to understand the steps involved in setting up a database instance. 

Following steps will get you started with creating a database and populating it with the `University` dataset provided on the book website: http://www.db-book.com 

* You will be using PostgreSQL in the client-server mode. Recall that the server is a continuously running process that listens on a specific port (the actual port would differ, and you can usually choose it when starting the server). In order to connect to the server, the client will need to know the port. The client and server are often on different machines, but for you, it may be easiest if they are on the same machine (i.e., the virtual machine). 

* Using the **psql** client is the easiest -- it provides a command-line access to the database. But there are other clients too, including a GUI (although that would require starting the VM in a GUI mode, which is a bit more involved). We will assume **psql** here. If you really want to use the graphical interfaces, we recommend trying to install PostgreSQL directly on your machine.

* Important: The server should be already started on your container -- you do not need to start it. However, the following two help pages discuss how to start the
   server: [Creating a database cluster](http://www.postgresql.org/docs/current/static/creating-cluster.html) and [Starting the server](http://www.postgresql.org/docs/current/static/server-start.html)

* PostgreSQL server has a default superuser called **postgres**. You can do everything under that username, or you can create a different username for yourself. If you run a command (say `createdb`) without any options, it uses the same username that you are logged in under (i.e., `root`). However, if you haven't created a PostgreSQL user with that name, the command will fail. You can either create a user (by logging in as the superuser), or run everything as a superuser (typically with the option: **-U postgres**).

* For our purposes, we will create a user with superuser privileges. 
	```
	sudo -u postgres createuser -s root
	```

* After the server has started, the first step is to **create** a database, using the **createdb** command. PostgreSQL automatically creates one database for its own purpose, called **postgres**. It is preferable you create a different database for your data. Here are more details on **createdb**: 
   http://www.postgresql.org/docs/current/static/tutorial-createdb.html

* We will create a database called **university**.
	```
	createdb university
	```
* Once the database is created, you can connect to it. There are many ways to connect to the server. The easiest is to use the commandline tool called **psql**. Start it by:
	```
	psql university
	```
	**psql** takes quite a few other options: you can specify different user, a specific port, another server etc. See documentation: http://www.postgresql.org/docs/current/static/app-psql.html. Make sure your run the above command from the /home/project0/ directory for the commands below to work.

* Note: you don't need a password here because PostgreSQL uses what's called `peer authentication` by default. You would typically need a password for other types of connections to the server (e.g., through JDBC).

Now you can start using the database. 
    
   - The psql program has a number of internal commands that are not SQL commands; such commands are often client and database specific. For psql, they begin with the
   backslash character: `\`. For example, you can get help on the syntax of various PostgreSQL SQL commands by typing: `\h`.

   - `\d`: lists out the tables in the database.

   - All commands like this can be found at:  http://www.postgresql.org/docs/current/static/app-psql.html. `\?` will also list them out.

   - To populate the database using the provided university dataset, use the following: 
     ```
     \i DDL.sql 
     ```
     followed by 
	   ```
	   \i smallRelationsInsertFile.sql
	   ``` 

   - For this to work, the two .sql files must be in the same directory as the one where you started psql. The first command creates the tables, and the
   second one inserts tuples in it. 
	
   - Create a different database ```university_large``` for the larger dataset provided (`largeRelationsInsertFile.sql`). Since the table names
   are identical, we need a separate database. You would need this for the reading homework.

---

### Python and Jupyter/IPython

We will be using Python for most of the assignments; you wouldn't typically use Python for systems development, but it works much better as an instructional tool. Python is easy to pick up, and we will also provide skeleton code for most of the assignments. 

IPython is an enhanced command shell for Python, that offers enhanced introspection, rich media, additional shell syntax, tab completion, and rich history. 

**IPython Notebook** started as a web browser-based interface to IPython, and proved especially popular with Data Scientists. A few years ago, the Notebook functionality was forked off as a separate project, called [Jupyter](http://jupyter.org/). Jupyter provides support for many other languages in addition to Python. 

* Start the docker using `docker run --rm -ti -p 8888:8888 -p 5432:5432 cmsc424-project0:latest`. Python, IPython, and Jupyter are already loaded.

* To use Python, you can just do `python` (or `ipython`), and it will start up the shell.

* To use Jupyter Notebook, do `cd /home/project0` followed by: 
	```
	jupyter-notebook --port=8888 --allow-root --no-browser --ip=0.0.0.0
	``` 
This will start a server on the VM, listening on port 8888. We will access it from the **host** (as discussed above, the Dockerfile maps the 8888 port on the guest container to the 8888 port on the host). To do that, simply start the browser, and point it to: http://127.0.0.1:8888. It will ask you for a password or token. Copy the token from the command line output that was output to your screen when you started jupyter above. (In other words, copy everything after ?token=).

* You should see the Notebooks in the `/home/project0/` directory. Click to open the "IPython Getting Started" Notebook, and follow the instruction therein.

* The second Notebook ("Basics of SQL") covers basics of SQL, by connecting to your local PostgreSQL instance. The Notebook also serves as an alternative mechanism to run queries. However, in order to use that, you must set up a password in `psql` using `\password` (set the password to be `root`).

---