select s.start_date, e.end_date
from (
select start_date ,
    row_number() over(order by start_date) as num
from projects
where start_date not in (select end_date from projects)
) as s

inner join(
    select end_date,
    row_number() over (order by end_date) as num
    from projects
    where end_date not in (select start_date from projects) 
) e

on e.num = s.num
order by datediff(day, s.start_date, e.end_date), s.start_date asc
;
