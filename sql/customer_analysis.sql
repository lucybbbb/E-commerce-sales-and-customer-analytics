use ecommerce;

select 
     count(*) as total_orders, 
     count(distinct customer_id) as customer_with_orders, 
     sum(total_usd) as total_revenue,
     avg(total_usd) as average_order_value
from orders; 

-- customer purchase frequency 
select customer_id,
       count(*) as number_of_orders
from orders
group by customer_id
order by number_of_orders desc;

select customer_id, sum(total_usd) as total_revenue
from orders
group by customer_id
order by total_revenue desc;

-- one-time customers and multi buyers 
select customer_id,
  case 
     when count(customer_id) = 1 then "one time buyer"
     when count(customer_id)>1 then  "multi buyer"
  
   end as customer_type
from orders
group by customer_id;


WITH customer_types AS (
    SELECT
        customer_id,
        CASE
            WHEN COUNT(*) = 1 THEN 'one time buyer'
            WHEN COUNT(*) > 1 THEN 'multi buyer'
        END AS customer_type
    FROM orders
    GROUP BY customer_id
)

SELECT
    customer_type,
    COUNT(*) AS number_of_customers
FROM customer_types
GROUP BY customer_type;


-- Repeat Buyer	10045
-- One-time Buyer	6223