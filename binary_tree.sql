select b.n,
case
    when b.p is null then 'Root'
    when b.n in (select distinct p from bst ) then 'Inner'
    else 'Leaf'
end as name
from bst b
order by b.n
;
