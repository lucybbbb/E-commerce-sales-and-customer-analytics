use ecommerce;
-- revenue trend over time?
select 
       date_format(order_time, '%y-%m') as month,
       sum(total_usd) as revenue 
from orders
group by date_format(order_time,'%y-%m')
order by month; 

-- which acquisition sources generate the msot revenue?
select source, 
      count(*) as number_of_orders,
      sum(total_usd) as total_revenue, 
      avg(total_usd) as average_order_value
from orders
group by source
order by total_revenue desc;

-- which acquisition sources have the highest conversion rate from sessions to orders??

with session_counts as (
       select source, 
              count(*) as number_of_sessions
       from sessions
       group by source
), 
order_counts as (
       select source, 
              count(*) as number_of_orders
       from orders
       group by source 
)
select 
        sc.source, sc.number_of_sessions, 
        coalesce(oc.number_of_orders, 0) as number_of_orders,
        coalesce(oc.number_of_orders,0) *100.0/sc.number_of_sessions as conversion_rate
from session_counts as sc
left join order_counts as oc
    on sc.source= oc.source;



