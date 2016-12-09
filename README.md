
Qihua Hao
Aidan Pelisson
Yuvraj Singh Sidhu

Database Systems HW 3
Fall 2016
Instructor: Samuel Johnson
December 8, 2016

Directions for Yuvraj:
1.sql, 2.sql and 3.sql are solution files
question1.sql, question2.sql and question3.sql are the original queries for comparison

Question 1

Analysis Before:
PRIMARY	teams	ALL					                            2490	2541	100	    4.21	Using where
PRIMARY	<derived4>	ref	key0	key0	5	stats.teams.yearID	10	    0.28	100	    100	
PRIMARY	<derived3>	ref	key0	key0	5	stats.teams.yearID	10	    28.67	100	    3.49	Using where
DERIVED	teams	ALL					                            2490	2541	100	    100	    Using where; Using temporary; Using filesort
DERIVED	<derived5>	ref	key0	key0	5	stats.teams.yearID	10	    10.05	100	    3.48	Using where
DERIVED	salaries	ALL					                        25881	25575	100	    100	    Using temporary; Using filesort
DERIVED	salaries	ALL					                        25881	25575	100	    100	    Using temporary; Using filesort

Average runtime = 0.393182656 seconds

Analysis After:
1	PRIMARY	teams	    ALL	team_index				                    2490	2541	100	    4.21	Using where
1	PRIMARY	<derived5>	ref	key0	    key0	5	stats.teams.yearID	10	    0.28	100	    100	
1	PRIMARY	<derived4>	ref	key0	    key0	5	stats.teams.yearID	10	    28.67	100	    3.49	Using where
5	DERIVED	teams	    ALL	team_index				                    2490	2541	100	    100	    Using where; Using temporary; Using filesort
5	DERIVED	<derived7>	ref	key0	    key0	5	stats.teams.yearID	10	    10.05	100	    3.48	Using where
7	DERIVED	salaries	ALL					                            25881	25575	100	    100	    Using temporary; Using filesort
4	DERIVED	salaries	ALL					                            25881	25575	100	    100	    Using temporary; Using filesort

Average runtime = 0.386046868 seconds

Question 2

Analysis Before:
1	PRIMARY	master	    ALL					    17724	17725	100	   63.15	Using where
1	PRIMARY	<derived2>	ALL					    155531	17878	100	   0.01	    Using where; Using join buffer (flat, BNL join)
2	DERIVED	fielding	ALL					    155531	156407	100	   70.97	Using where; Using temporary; Using filesort

Average runtime = 1.669924574 seconds

Analysis After:
1	PRIMARY	<derived2>	ALL					                                    155531	17878	100	   100	    Using where
1	PRIMARY	master	ref	player_index	player_index	21	positions.playerID	1	    1.79	100	   33.43	Using where
2	DERIVED	fielding	ALL					                                    155531	156407	100	   70.97	Using where; Using temporary; Using filesort


Average runtime = 1.063896438 seconds

Question 3:

Analysis Before:
1	PRIMARY	master	    ALL	restrictions,birth_year				17724	17725	24.1	15.32	Using where; Using temporary; Using filesort
1	PRIMARY	<derived2>	ALL					                    72314	13705	100	    0	    Using where; Using join buffer (flat, BNL join)
2	DERIVED	batting	    ALL					                    72314	72669	100	    100	    Using temporary; Using filesort


Average runtime = 1.3851219 seconds

Analysis After:
1	PRIMARY	<derived3>	ALL					                                                                    72314	2842	100	   100	Using where; Using temporary; Using filesort
1	PRIMARY	master	ref	restrictions,birth_year,player_index2	player_index2	21	aggregateBatting.playerID	1	    1.82	100	   9.82	Using where
3	DERIVED	batting	ALL					                                                                        72314	72669	100	100	Using temporary; Using filesort


Average runtime = 0.620640808 seconds

Explanation of our strategy:
Our primary strategy was to use views wherever possible in order to increase performance. We mainly used them to replace WHERE clauses. We created a view that took only tuples with the specific columnswe needed, and which satisfied the condition in the where clause. This pushed selection down on the plan tree. We then performed any aggregatefunctions or joins on those tuples. We also used indices on many of the primary keys, in order to reduce the number of unnecessary rows that we were dealing with. Finally, we used views to eliminate any redundancies in our code. For example, in problem 1, we replaced a subquery used multiple times throughout the query with a view that did the same thing.


