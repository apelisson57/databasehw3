
Qihua Hao
Aidan Pelisson
Yuvraj Singh Sidhu



Database Systems HW 3
Fall 2016
Instructor: Samuel Johnson
December 8, 2016


Explanation of our strategy:
Our primary strategy was to use views wherever possible in order to increase performance. We mainly 
used them to replace WHERE clauses. We created a view that took only tuples with the specific columns
we needed, and which satisfied the condition in the where clause. We then performed any aggregate
functions or joins on those tuples.


