select sub.submission_date,
(
    select count(distinct hacker_id)
    from submissions s2
    where s2.submission_date = sub.submission_date
    and
    (
        select count(distinct s3.submission_date)
        from submissions s3
        where s3.hacker_id = s2.hacker_id
        and
        s3.submission_date < sub.submission_date
    ) = datediff(day, '2016-03-01', sub.submission_date)
),

(
    select top(1) t.hacker_id
    from 
    (
        select s.hacker_id, s.submission_date, h.name,
        row_number () over(partition by s.submission_date, s.hacker_id
                   order by s.submission_date) as counter
        from submissions s
        inner join hackers h on h.hacker_id = s.hacker_id
    )t
    where t.submission_date = sub.submission_date
    order by t.submission_date, t.counter desc
),

(
    select top(1) t.name
    from 
    (
        select s.hacker_id, s.submission_date, h.name,
        row_number () over(partition by s.submission_date, s.hacker_id
                   order by s.submission_date) as counter
        from submissions s
        inner join hackers h on h.hacker_id = s.hacker_id
    )t
    where t.submission_date = sub.submission_date 
    order by t.submission_date, t.counter desc
)

from
(
    select  distinct submission_date
    from submissions
)as sub
order by sub.submission_date;
