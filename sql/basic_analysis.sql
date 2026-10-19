use ecommerce;
describe orders;


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






 -- which category generate the highets revenue?

select 
        p.category, 
        sum(oi.line_total_usd) as total_revenue
from order_items as oi
join products as p 
     on oi.product_id=p.product_id
group by p.category
order by total_revenue desc
limit 20;
 
 -- whihc product generates the highest revenue?

select 
   p.product_id, 
   p.name, 
   sum(oi.line_total_usd) as total_rev_product
from order_items as oi
join products as p 
   on oi.product_id = p.product_id
group by p.product_id, p.name
order by total_rev_product desc
limit 20;

-- which product have the highest profit: profit/ product? 

select 
   product_id, name,
   (price_usd -cost_usd) as profit
from products
order by profit desc 
limit 100;

-- profit per total/ orders received 

select 
   p.product_id, 
   p.name, 
   sum((oi.quantity) * (oi.unit_price_usd - p.cost_usd)) as total_profit
from order_items as oi
join products as p 
   on oi.product_id = p.product_id
group by p.product_id, p.name
order by total_profit desc
limit 20;

-- which product categories generate the highest total profit?
select 
   p.category, 
   sum((oi.quantity) * (oi.unit_price_usd - p.cost_usd)) as total_profit
from order_items as oi
join products as p 
   on oi.product_id = p.product_id
group by p.category
order by total_profit desc
limit 20;

-- revenue trend over time?
select 
       date_format(order_time, '%y-%m') as month,
       sum(total_usd) as revenue 
from orders
group by date_format(order_time,'%y-%m')
order by month; 

