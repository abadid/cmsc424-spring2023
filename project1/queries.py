queries = ["" for i in range(0, 11)]
### EXAMPLE
### 0. List all airport codes and their cities. Order by the city name in the increasing order.
### Output column order: airportid, city

queries[0] = """
select airportid, city
from airports
order by city;
"""

### 1. Write a query to find the names of customers who have flights on a friday and first name that has a second letter is not a vowel.
###    Do not include the youngest customer in the results.
### Hint:  - See postgresql date operators that are linked to from the README, and the "like" operator that you saw already in the assigned reading in your textbook. 
###        - Alternately, you can use a regex to match the condition imposed on the name.
###        - See postgresql date operators and string functions
###        - You may want to use a self-join to avoid including the youngest customer.
###        - When testing, write a query that includes all customers, then modify that to exclude the youngest.
### Order: by name
### Output columns: name
queries[1] = """
select 0;
"""


### 2. Write a query to find unqiue customers who are frequent fliers on United Airlines (UA) and have their birthday in the second half of the year.
### Hint: See postgresql date functions and distinct operator. Note that December has 31 days.
### Order: by name
### Output columns: customer id, name, birthdate, frequentflieron
queries[2] = """
select 0;
"""

### 3. Write a query to rank the airlines have the most flights on airports other than their hubs.
### Output the airlineid along with the number of fligths not connecting their hubs. 
### Output: (airlineid, count)
### Order: first by count in descending order, then airline in ascending order
### Note: A flight does not connect a hub if the hub is neither the source nor the destination of the flight. 
queries[3] = """
select 0;
"""

### 4. Write a query to find the names of customers with the least common frequent flier airline.
###    For example, if 10 customers have Delta as their frequent flier airline, and no other airlines have fewer than 10 frequent flier customers, 
###    then the query should return all customers that have Delta as their frequent flier airline. In the case of a tie, return all customers from all tied airlines.
### Hint: use `with clause` and nested queries
### Output: only the names of the customer.
### Order: order by name.
queries[4] = """
select 0;
"""


### 5. Write a query to find all the frequent flyers (customer(s) who have flown on most number of flights),
###    and the count of other frequent flyers they have never flown with.
###    For example if Alice, Bob and Charlie flew on the most number of flighs (3 each). Assuming Alice and Bob never flew together,
###    while Charlie flew with both of them, the expected output would be: [('Alice', 1), ('Bob', 1), ('Charlie', 0)].
### NOTE: A frequent flyer here is purely based on number of occurances in flewon, (not the frequentflieron field).
### Output: name, count
### Order: order by count desc, name.
queries[5] = """
select 0;
"""

### 6. Write a query to find the percentage participation of United Airlines in each airport, relative to the other airlines.
### One instance of participation in an airport is defined as a flight (EX. UA101) having a source or dest of that airport.
### If UA101 leaves BOS and arrives in FLL, that adds 1 to United's count for each airport
### This means that if UA has 1 in BOS, AA has 1 in BOS, DL has 2 in BOS, and SW has 3 in BOS, the query returns:
###     airport 		                              | participation
###     General Edward Lawrence Logan International   | .14
### Output: (airport_name, participation).
### Order: Participation in descending order
### Note: - The airport column must be the full name of the airport
###       - The participation percentage is rounded to 2 decimals, as shown above
###       - You do not need to confirm that the flights actually occur by referencing the flewon table. This query is only concerned with
###         flights that exist in the flights table.
###       - You must not leave out airports that have no UA flights (participation of 0)
queries[6] = """
select 0;
"""

### 7. Write a query to find the customer/customers that taken the highest number of flights but have never flown on their frequentflier airline.
###    If there is a tie, return the names of all such customers. 
### Output: Customer name
### Order: name
queries[7] = """
select 0;
"""

### 8. Write a query to find customers that took flights over four consecutive days, but did not fly any other day.
###    Return the name, start and end date of the customers flights.
### Output: customer_name, start_date, end_date
### Order: by customer_name
queries[8] = """
select 0;
"""

### 9. Write a query to find all flights belonging to the same airline that had a layover in JFK between 1 and 3 hours in length (inclusive)
### Output columns: 1st flight id, 2nd flight id, source city, destination city, layover duration
### Order by: layover duration
queries[9] = """
select 0;
"""

### 10. Provide a top-10 ranking of the most loyal frequent fliers.
### We rank these fliers by the ratio of flights that they take that are with their frequentflieron airline. 
### The customer with the highest ratio of (flights with frequentflieron) / total flights is rank 1, and so on.
### A customer needs more than 7 flights to be considered for the ranking
### Output: (customer_name, rank)
### Order: by the ascending rank
### Note: a) If two customers tie, then they should both get the same rank, and the next rank should be skipped. For example, if the top two customers have the same ratio, then there should be no rank 2, e.g., 1, 1, 3 ...
###       b) This means there may be more than 10 customers in this ranking, so long as their ranks are under 10. This may occur if there are 10 at rank 5, etc.
queries[10] = """
select 0;
"""
