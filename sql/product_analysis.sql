use ecommerce;
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
