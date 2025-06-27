-- find cities where covid cases are increasing continuosly
-- reference table: practice_database-covid

with cte_covid_cases as (
select *,
rank() over(partition by city order by days) as rank_days,
rank() over(partition by city order by cases) as rank_cases,
cast(rank() over(partition by city order by days) as signed) - cast(rank() over(partition by city order by cases) as signed) as rank_diff
from covid)

select city 
from cte_covid_cases
group by city 
having count(distinct rank_diff) = 1 and max(rank_diff) = 0 
