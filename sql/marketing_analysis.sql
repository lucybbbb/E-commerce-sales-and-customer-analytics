
use ecommerce;
-- revenue by source
select source, 
       sum(total_usd) as revenue 
from orders
group by source 
order by revenue desc; 

--  organic	1501632.60
-- direct	1124754.89
-- paid	561639.48
-- social	536240.79
--  email	395243.16
-- referral	373706.55

-- orders by source
select 
       source , 
       count(order_id) as total_orders_per_source
from orders 
group by source;

    -- AOV by source
select source, 
       AVG (total_usd) as avg_order_val 
from orders 
group by source
order by avg_order_val desc;

-- source performance
select source, 
       sum(total_usd) as revenue, 
       avg(total_usd) as avg_per_order, 
       count(order_id) as total_orders_per_source
from orders 
group by source 
order by revenue desc; 

-- referral	373706.55	137.190363	2724
--  email	395243.16	129.333495	3056
-- social	536240.79	133.260634	4024
-- paid	561639.48	136.287183	4121
-- direct	1124754.89	134.106938	8387
-- organic	1501632.60	133.265229	11268