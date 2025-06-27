-- find companies who have atleast two users speaking in both English and German
-- reference_table: practice_database - company_users

with company_users_cte as (
select company_id, user_id, count(distinct language) as num_lang
from company_users
where language in ('English','German')
group by company_id, user_id
having count(distinct language) = 2)

select company_id 
from company_users_cte
group by company_id 
having count(num_lang) >=2
