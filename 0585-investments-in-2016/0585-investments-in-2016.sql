# Write your MySQL query statement below
with num_tiv_2015 as (
    select 
        tiv_2015
        , count(distinct pid) as num_pid
    from Insurance
    
    group by 1
), num_cities as (
    select
        concat(concat(lat, ","), lon) as city
        , count(distinct pid) as num_pid
    from Insurance
    group by 1
)

select 
    round(sum(tiv_2016), 2) as tiv_2016
from
    Insurance
where 
    concat(concat(lat, ","), lon) in 
        (select city from num_cities where num_pid = 1)
    and 
    tiv_2015 in
        (select tiv_2015 from num_tiv_2015 where num_pid > 1)