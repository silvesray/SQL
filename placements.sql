/*
Write a query to output the names of those students 
whose best friends got offered a higher salary than them. 
Names must be ordered by the salary amount offered to the best friends. 
It is guaranteed that no two students got same salary offer.

------------------------                DATABASE            -------------------------------------
Students(id, name)
Friends(id, friend_id)
Packages(id, salary)

*/ 


select  s.name
from students s, friends f, packages p1, packages p2
where
(
    (s.id = f.id) and (s.id = p1.id) and (f.friend_id) = p2.id and (p1.salary < p2.salary)
)
order by p2.salary;
