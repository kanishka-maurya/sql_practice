-- MEESHO HACKERRANK SQL TEST
-- find how many products fall into customer budget along with list of products
-- in case of clash choose the less costly one
-- products_meesho, customer_budget
-- reference_table: practice_database - products_meesho, customer_budget

with cte_customer_budget as (select *,
sum(cost) over(order by cost) as cum_cost
from products_meesho)

select customer_id, budget, count(product_id), group_concat(product_id) as list_of_product_id from customer_budget 
left join cte_customer_budget on cte_customer_budget.cum_cost <= customer_budget.budget
group by customer_id, budget
