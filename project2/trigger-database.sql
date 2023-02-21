create table airports (airportid char(3) primary key, city char(20), name char(100), total2011 int, total2012 int);
insert into airports(name, city, airportid, total2011, total2012) values('Metropolitan Oakland International','Oakland','OAK',10040864,9266570);
insert into airports(name, city, airportid, total2011, total2012) values('Fort Lauderdale Hollywood International','Fort Lauderdale','FLL',23569103,23349835);
insert into airports(name, city, airportid, total2011, total2012) values('General Edward Lawrence Logan International','Boston','BOS',29349759,28932808);
insert into airports(name, city, airportid, total2011, total2012) values('Washington Dulles International','Washington','IAD',22408105,23056291);
insert into airports(name, city, airportid, total2011, total2012) values('Hartsfield Jackson Atlanta International','Atlanta','ATL',95513828,92389023);
insert into airports(name, city, airportid, total2011, total2012) values('Chicago O''Hare International','Chicago','ORD',66633503,66701241);
insert into airports(name, city, airportid, total2011, total2012) values('Los Angeles International','Los Angeles','LAX',63688121,61862052);
insert into airports(name, city, airportid, total2011, total2012) values('Dallas Fort Worth International','Dallas-Fort Worth','DFW',58621369,57832495);
insert into airports(name, city, airportid, total2011, total2012) values('Denver International','Denver','DEN',53156278,52849132);
insert into airports(name, city, airportid, total2011, total2012) values('John F Kennedy International','New York','JFK',49291765,47644060);


create table airlines (airlineid char(2) primary key, name char(20), hub char(3) references airports(airportid));
create table customers (customerid char(10) primary key, name char(30), birthdate date, frequentflieron char(2) references airlines(airlineid));
create table flights (flightid char(6) primary key, source char(3) references airports(airportid), dest char(3) references airports(airportid), airlineid char(2) references airlines(airlineid), local_departing_time time, local_arrival_time time);
create table flewon (flightid char(6) references flights(flightid), customerid char(10) references customers ON DELETE CASCADE, flightdate date);
insert into airlines values ('SW', 'Southwest Airlines', 'OAK');
insert into airlines values ('AA', 'American Airlines', 'DFW');
insert into airlines values ('DL', 'Delta Airlines', 'ATL');
insert into airlines values ('UA', 'United Airlines', 'ORD');

insert into customers values ('cust0', 'Anthony Allen', to_date('1985-05-14', 'yyyy-mm-dd'), 'AA');
insert into customers values ('cust15', 'Betty Gonzalez', to_date('1993-12-28', 'yyyy-mm-dd'), 'SW');
insert into customers values ('cust33', 'Christopher Davis', to_date('1984-05-13', 'yyyy-mm-dd'), 'DL');
insert into customers values ('cust109', 'James Adams', to_date('1994-05-22', 'yyyy-mm-dd'), 'AA');

insert into flights values('UA101', 'BOS', 'FLL', 'UA', time '00:00' + interval '60 minutes', time '00:00' + interval '189 minutes');
insert into flights values('UA180', 'FLL', 'BOS', 'UA', time '00:00' + interval '236 minutes', time '00:00' + interval '365 minutes');
insert into flights values('SW102', 'OAK', 'DFW', 'SW', time '00:00' + interval '484 minutes', time '00:00' + interval '706 minutes');
insert into flights values('SW179', 'DFW', 'OAK', 'SW', time '00:00' + interval '742 minutes', time '00:00' + interval '964 minutes');
insert into flights values('SW103', 'OAK', 'FLL', 'SW', time '00:00' + interval '709 minutes', time '00:00' + interval '983 minutes');
insert into flights values('SW178', 'FLL', 'OAK', 'SW', time '00:00' + interval '996 minutes', time '00:00' + interval '1270 minutes');
insert into flights values('SW104', 'OAK', 'ORD', 'SW', time '00:00' + interval '608 minutes', time '00:00' + interval '843 minutes');
insert into flights values('SW177', 'ORD', 'OAK', 'SW', time '00:00' + interval '864 minutes', time '00:00' + interval '1099 minutes');
insert into flights values('UA105', 'ORD', 'LAX', 'UA', time '00:00' + interval '185 minutes', time '00:00' + interval '449 minutes');
insert into flights values('UA176', 'LAX', 'ORD', 'UA', time '00:00' + interval '465 minutes', time '00:00' + interval '729 minutes');
insert into flights values('SW106', 'ATL', 'FLL', 'SW', time '00:00' + interval '390 minutes', time '00:00' + interval '538 minutes');
insert into flights values('SW175', 'FLL', 'ATL', 'SW', time '00:00' + interval '546 minutes', time '00:00' + interval '694 minutes');
insert into flights values('SW107', 'OAK', 'DFW', 'SW', time '00:00' + interval '285 minutes', time '00:00' + interval '529 minutes');
insert into flights values('SW174', 'DFW', 'OAK', 'SW', time '00:00' + interval '561 minutes', time '00:00' + interval '805 minutes');
insert into flights values('SW108', 'JFK', 'BOS', 'SW', time '00:00' + interval '119 minutes', time '00:00' + interval '211 minutes');
insert into flights values('SW173', 'BOS', 'JFK', 'SW', time '00:00' + interval '271 minutes', time '00:00' + interval '363 minutes');
insert into flights values('AA109', 'DFW', 'JFK', 'AA', time '00:00' + interval '454 minutes', time '00:00' + interval '536 minutes');
insert into flights values('AA172', 'JFK', 'DFW', 'AA', time '00:00' + interval '563 minutes', time '00:00' + interval '645 minutes');
insert into flights values('SW110', 'DFW', 'IAD', 'SW', time '00:00' + interval '363 minutes', time '00:00' + interval '493 minutes');
insert into flights values('SW171', 'IAD', 'DFW', 'SW', time '00:00' + interval '557 minutes', time '00:00' + interval '687 minutes');
insert into flights values('SW111', 'OAK', 'JFK', 'SW', time '00:00' + interval '734 minutes', time '00:00' + interval '1024 minutes');
insert into flights values('SW170', 'JFK', 'OAK', 'SW', time '00:00' + interval '1037 minutes', time '00:00' + interval '1327 minutes');
insert into flights values('SW112', 'OAK', 'DFW', 'SW', time '00:00' + interval '576 minutes', time '00:00' + interval '698 minutes');
insert into flights values('SW169', 'DFW', 'OAK', 'SW', time '00:00' + interval '796 minutes', time '00:00' + interval '918 minutes');
insert into flights values('AA113', 'DFW', 'FLL', 'AA', time '00:00' + interval '560 minutes', time '00:00' + interval '769 minutes');
insert into flights values('AA168', 'FLL', 'DFW', 'AA', time '00:00' + interval '835 minutes', time '00:00' + interval '1044 minutes');
insert into flights values('AA114', 'DFW', 'IAD', 'AA', time '00:00' + interval '423 minutes', time '00:00' + interval '456 minutes');
insert into flights values('AA167', 'IAD', 'DFW', 'AA', time '00:00' + interval '457 minutes', time '00:00' + interval '490 minutes');
insert into flights values('AA115', 'JFK', 'OAK', 'AA', time '00:00' + interval '95 minutes', time '00:00' + interval '233 minutes');
insert into flights values('AA166', 'OAK', 'JFK', 'AA', time '00:00' + interval '329 minutes', time '00:00' + interval '467 minutes');
insert into flights values('SW116', 'ORD', 'OAK', 'SW', time '00:00' + interval '933 minutes', time '00:00' + interval '1111 minutes');
insert into flights values('SW165', 'OAK', 'ORD', 'SW', time '00:00' + interval '1157 minutes', time '00:00' + interval '1335 minutes');
insert into flights values('UA117', 'ATL', 'FLL', 'UA', time '00:00' + interval '499 minutes', time '00:00' + interval '761 minutes');
insert into flights values('UA164', 'FLL', 'ATL', 'UA', time '00:00' + interval '848 minutes', time '00:00' + interval '1110 minutes');
insert into flights values('SW118', 'OAK', 'IAD', 'SW', time '00:00' + interval '210 minutes', time '00:00' + interval '337 minutes');
insert into flights values('SW163', 'IAD', 'OAK', 'SW', time '00:00' + interval '391 minutes', time '00:00' + interval '518 minutes');
insert into flights values('DL119', 'LAX', 'OAK', 'DL', time '00:00' + interval '380 minutes', time '00:00' + interval '642 minutes');
insert into flights values('DL162', 'OAK', 'LAX', 'DL', time '00:00' + interval '728 minutes', time '00:00' + interval '990 minutes');
insert into flights values('SW120', 'OAK', 'JFK', 'SW', time '00:00' + interval '123 minutes', time '00:00' + interval '182 minutes');
insert into flights values('SW161', 'JFK', 'OAK', 'SW', time '00:00' + interval '247 minutes', time '00:00' + interval '306 minutes');
insert into flights values('DL121', 'DFW', 'ORD', 'DL', time '00:00' + interval '690 minutes', time '00:00' + interval '869 minutes');
insert into flights values('DL160', 'ORD', 'DFW', 'DL', time '00:00' + interval '895 minutes', time '00:00' + interval '1074 minutes');
insert into flights values('SW122', 'OAK', 'DEN', 'SW', time '00:00' + interval '177 minutes', time '00:00' + interval '387 minutes');
insert into flights values('SW159', 'DEN', 'OAK', 'SW', time '00:00' + interval '472 minutes', time '00:00' + interval '682 minutes');
insert into flights values('SW123', 'BOS', 'OAK', 'SW', time '00:00' + interval '202 minutes', time '00:00' + interval '322 minutes');
insert into flights values('SW158', 'OAK', 'BOS', 'SW', time '00:00' + interval '398 minutes', time '00:00' + interval '518 minutes');
insert into flights values('SW124', 'FLL', 'IAD', 'SW', time '00:00' + interval '607 minutes', time '00:00' + interval '810 minutes');
insert into flights values('SW157', 'IAD', 'FLL', 'SW', time '00:00' + interval '832 minutes', time '00:00' + interval '1035 minutes');
insert into flights values('SW125', 'DFW', 'JFK', 'SW', time '00:00' + interval '684 minutes', time '00:00' + interval '921 minutes');
insert into flights values('SW156', 'JFK', 'DFW', 'SW', time '00:00' + interval '991 minutes', time '00:00' + interval '1228 minutes');
insert into flights values('SW126', 'ATL', 'DEN', 'SW', time '00:00' + interval '777 minutes', time '00:00' + interval '949 minutes');
insert into flights values('SW155', 'DEN', 'ATL', 'SW', time '00:00' + interval '1029 minutes', time '00:00' + interval '1201 minutes');
insert into flights values('AA127', 'DFW', 'FLL', 'AA', time '00:00' + interval '834 minutes', time '00:00' + interval '893 minutes');
insert into flights values('AA154', 'FLL', 'DFW', 'AA', time '00:00' + interval '930 minutes', time '00:00' + interval '989 minutes');
insert into flights values('UA128', 'IAD', 'FLL', 'UA', time '00:00' + interval '460 minutes', time '00:00' + interval '731 minutes');
insert into flights values('UA153', 'FLL', 'IAD', 'UA', time '00:00' + interval '786 minutes', time '00:00' + interval '1057 minutes');
insert into flights values('SW129', 'OAK', 'DFW', 'SW', time '00:00' + interval '199 minutes', time '00:00' + interval '455 minutes');
insert into flights values('SW152', 'DFW', 'OAK', 'SW', time '00:00' + interval '464 minutes', time '00:00' + interval '720 minutes');
insert into flights values('AA130', 'LAX', 'ATL', 'AA', time '00:00' + interval '566 minutes', time '00:00' + interval '772 minutes');
insert into flights values('AA151', 'ATL', 'LAX', 'AA', time '00:00' + interval '866 minutes', time '00:00' + interval '1072 minutes');
insert into flights values('AA131', 'DFW', 'OAK', 'AA', time '00:00' + interval '24 minutes', time '00:00' + interval '199 minutes');
insert into flights values('AA150', 'OAK', 'DFW', 'AA', time '00:00' + interval '261 minutes', time '00:00' + interval '436 minutes');
insert into flights values('SW132', 'BOS', 'DFW', 'SW', time '00:00' + interval '944 minutes', time '00:00' + interval '1214 minutes');
insert into flights values('SW149', 'DFW', 'BOS', 'SW', time '00:00' + interval '243 minutes', time '00:00' + interval '513 minutes');
insert into flights values('SW133', 'OAK', 'ORD', 'SW', time '00:00' + interval '136 minutes', time '00:00' + interval '336 minutes');
insert into flights values('SW148', 'ORD', 'OAK', 'SW', time '00:00' + interval '453 minutes', time '00:00' + interval '653 minutes');
insert into flights values('DL134', 'ATL', 'DEN', 'DL', time '00:00' + interval '834 minutes', time '00:00' + interval '1033 minutes');
insert into flights values('DL147', 'DEN', 'ATL', 'DL', time '00:00' + interval '1130 minutes', time '00:00' + interval '1329 minutes');
insert into flights values('UA135', 'ORD', 'DEN', 'UA', time '00:00' + interval '749 minutes', time '00:00' + interval '783 minutes');
insert into flights values('UA146', 'DEN', 'ORD', 'UA', time '00:00' + interval '829 minutes', time '00:00' + interval '863 minutes');
insert into flights values('SW136', 'OAK', 'IAD', 'SW', time '00:00' + interval '522 minutes', time '00:00' + interval '753 minutes');
insert into flights values('SW145', 'IAD', 'OAK', 'SW', time '00:00' + interval '787 minutes', time '00:00' + interval '1018 minutes');
insert into flights values('SW137', 'OAK', 'FLL', 'SW', time '00:00' + interval '261 minutes', time '00:00' + interval '409 minutes');
insert into flights values('SW144', 'FLL', 'OAK', 'SW', time '00:00' + interval '453 minutes', time '00:00' + interval '601 minutes');
insert into flights values('UA138', 'BOS', 'IAD', 'UA', time '00:00' + interval '828 minutes', time '00:00' + interval '1071 minutes');
insert into flights values('UA143', 'IAD', 'BOS', 'UA', time '00:00' + interval '1104 minutes', time '00:00' + interval '1347 minutes');
insert into flights values('SW139', 'OAK', 'ATL', 'SW', time '00:00' + interval '738 minutes', time '00:00' + interval '989 minutes');
insert into flights values('SW142', 'ATL', 'OAK', 'SW', time '00:00' + interval '1065 minutes', time '00:00' + interval '1316 minutes');
insert into flights values('DL140', 'ATL', 'DEN', 'DL', time '00:00' + interval '717 minutes', time '00:00' + interval '997 minutes');
insert into flights values('DL141', 'DEN', 'ATL', 'DL', time '00:00' + interval '1059 minutes', time '00:00' + interval '1339 minutes');


insert into flewon values ('UA101', 'cust33', to_date('2016-08-07', 'YYYY-MM-DD'));
insert into flewon values ('UA101', 'cust0', to_date('2016-08-03', 'YYYY-MM-DD'));
insert into flewon values ('UA135', 'cust0', to_date('2016-08-01', 'YYYY-MM-DD'));
insert into flewon values ('UA105', 'cust0', to_date('2016-08-04', 'YYYY-MM-DD'));
insert into flewon values ('SW104', 'cust0', to_date('2016-08-05', 'YYYY-MM-DD'));
insert into flewon values ('SW108', 'cust0', to_date('2016-08-02', 'YYYY-MM-DD'));
insert into flewon values ('SW112', 'cust0', to_date('2016-08-08', 'YYYY-MM-DD'));
insert into flewon values ('UA138', 'cust0', to_date('2016-08-07', 'YYYY-MM-DD'));
insert into flewon values ('AA109', 'cust0', to_date('2016-08-09', 'YYYY-MM-DD'));
insert into flewon values ('UA101', 'cust15', to_date('2016-08-05', 'YYYY-MM-DD'));
insert into flewon values ('SW103', 'cust0', to_date('2016-08-06', 'YYYY-MM-DD'));
insert into flewon values ('SW110', 'cust15', to_date('2016-08-08', 'YYYY-MM-DD'));
insert into flewon values ('DL119', 'cust33', to_date('2016-08-06', 'YYYY-MM-DD'));
insert into flewon values ('UA101', 'cust109', to_date('2016-08-08', 'YYYY-MM-DD'));
insert into flewon values ('AA131', 'cust15', to_date('2016-08-03', 'YYYY-MM-DD'));
insert into flewon values ('AA109', 'cust33', to_date('2016-08-09', 'YYYY-MM-DD'));
insert into flewon values ('SW103', 'cust33', to_date('2016-08-03', 'YYYY-MM-DD'));
insert into flewon values ('SW102', 'cust15', to_date('2016-08-07', 'YYYY-MM-DD'));
insert into flewon values ('UA101', 'cust33', to_date('2016-08-01', 'YYYY-MM-DD'));
insert into flewon values ('SW103', 'cust109', to_date('2016-08-06', 'YYYY-MM-DD'));
insert into flewon values ('UA128', 'cust33', to_date('2016-08-05', 'YYYY-MM-DD'));
insert into flewon values ('AA127', 'cust109', to_date('2016-08-05', 'YYYY-MM-DD'));
insert into flewon values ('SW106', 'cust15', to_date('2016-08-01', 'YYYY-MM-DD'));
insert into flewon values ('UA101', 'cust109', to_date('2016-08-02', 'YYYY-MM-DD'));
insert into flewon values ('UA101', 'cust15', to_date('2016-08-06', 'YYYY-MM-DD'));
insert into flewon values ('SW103', 'cust33', to_date('2016-08-08', 'YYYY-MM-DD'));
insert into flewon values ('SW107', 'cust33', to_date('2016-08-04', 'YYYY-MM-DD'));
insert into flewon values ('SW104', 'cust109', to_date('2016-08-07', 'YYYY-MM-DD'));
insert into flewon values ('UA101', 'cust15', to_date('2016-08-04', 'YYYY-MM-DD'));
insert into flewon values ('SW104', 'cust15', to_date('2016-08-02', 'YYYY-MM-DD'));
insert into flewon values ('SW108', 'cust15', to_date('2016-08-09', 'YYYY-MM-DD'));
insert into flewon values ('DL119', 'cust33', to_date('2016-08-02', 'YYYY-MM-DD'));







create table newcustomers (customerid char(10) primary key, name char(30), birthdate date);
insert into newcustomers (select customerid, name, birthdate from customers);

create table ffairlines (customerid char(10) references newcustomers ON DELETE CASCADE, airlineid char(2) references airlines(airlineid), points int);
insert into ffairlines (with temp as (select customerid, airlineid, SUM(TRUNC(EXTRACT(EPOCH FROM local_arrival_time - local_departing_time)/60)) as points
        from flewon natural join flights group by customerid, airlineid)
    select customers.customerid, frequentflieron, coalesce(points,0) 
    from customers left join temp on (customers.customerid = temp.customerid and customers.frequentflieron = temp.airlineid)
    where frequentflieron is not null);