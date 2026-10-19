use ecommerce;
show events;
show tables;
-- sessions by device 
select 
      
      event_type,
      count(*) as number_of_events
from events
group by event_type
order by number_of_events desc; 

-- which product receive the most user engagement?

select 
      e.product_id, 
      count(*) as number_of_events, 
      p.name
from events as e 
left join products as p
on e.product_id = p.product_id
where name is not null 
group by product_id 
order by number_of_events desc
limit 20;


-- sessions by country
select 
      e.event_type,
      count(*) as nr_events, 
      s.country
from events as e
left join sessions as s
on e.session_id = s.session_id
group by e.event_type, s.country
order by nr_events desc
limit 25; 

-- conversion behaviour
-- how many sessions include a product view/ add to cart/ purchase ?

select session_id, 
       count(distinct event_type) as total_events,
       count(*) over() as total_sessions
     
from events
where event_type in ('page_view', 'add_to_cart', 'purchase')
group by session_id
having count(distinct event_type) = 3
order by session_id;

-- show just the toatl number of sessions 
select count(*) as total_sessions
from (
      select session_id
      from events 
      where event_type in ('page_view', 'add_to_cart', 'purchase')
      group by session_id 
      having count(distinct event_type) = 3
)
as qualifying_sessions;

-- what percentage of sessions that contain page_view also contain add_to_cart 
with page_view_sessions AS(
      select session_id
      from events 
where event_type in ('page_view')
group by session_id
order by session_id),

cart_sessions as(
      select session_id
      from events
where event_type in ('page_view', 'add_to_cart')
group by session_id
having count(distinct event_type) = 2)

select 
      (select count(*) from page_view_sessions) as total_1,
      (select count(*) from cart_sessions) as total_2, 
      (select count(*) from cart_sessions) *100 / nullif ((select count(*) from page_view_sessions),0)
      as percentage_view;


-- 120000	81518	67.9317

-- what percentage of sessions contain page_view, add_to_cart, purchase event?

with page_view_sessions AS(
      select session_id
      from events 
where event_type in ('page_view')
group by session_id
),

cart_sessions as(
      select session_id
      from events
where event_type in ('page_view', 'add_to_cart')
group by session_id
having count(distinct event_type) = 2),

purchase_sessions as (
      select session_id
      from events 
where event_type in ('page_view', 'add_to_cart','purchase')
group by session_id
having count(distinct event_type) =3)

select 
      (select count(*) from page_view_sessions) as total_1,
      (select count(*) from cart_sessions) as total_2, 
      (select count(*) from purchase_sessions) as total_3,
      (select count(*) FROM purchase_sessions) *100/
      nullif ((select count(*) from page_view_sessions),0)
      as percentage_view;

-- results: 120000	81518	33580	27.9833

-- what percentage of sessions contain page_view, add_to_cart, purchase event? chronological order

with page_view_sessions AS(
      select session_id
      from events 
where event_type in ('page_view')
group by session_id
),

cart_sessions as(
      select session_id
      from events
where event_type in ('page_view', 'add_to_cart')
group by session_id
having count(distinct event_type) = 2),

purchase_sessions as (
      select session_id,
            min (
                  case 
                    when event_type = 'page_view' then timestamp
                    end) as page_view_time,
            min (
                  case
                   when event_type = 'add_to_cart' then timestamp
                   end) as add_to_cart_time, 
            min (
                  case 
                   when event_type = 'purchase' then timestamp
                  end
            ) as purchase_time

                                   
      from events 
where event_type in ('page_view', 'add_to_cart','purchase')
group by session_id
having (page_view_time < add_to_cart_time) and 
        (add_to_cart_time < purchase_time))

select 
      (select count(*) from page_view_sessions) as total_1,
      (select count(*) from cart_sessions) as total_2, 
      (select count(*) from purchase_sessions) as total_3,
      (select count(*) FROM purchase_sessions) *100.00/
      nullif ((select count(*) from page_view_sessions),0)
      as percentage_view_chronological;

-- 120000	81518	33580	27.983333
-- the number of sessions containing all 3 event types is the same as the number passing the chronological timestamp check 

-- funnel drop-off analysis 



with session_funnel as (
      select session_id,
            min (
                  case 
                    when event_type = 'page_view' then timestamp
                    end) as page_view_time,
            min (
                  case
                   when event_type = 'add_to_cart' then timestamp
                   end) as add_to_cart_time, 
            min (
                  case 
                   when event_type = 'purchase' then timestamp
                  end
            ) as purchase_time

                                   
      from events 
where event_type in ('page_view', 'add_to_cart','purchase')
group by session_id
), 

funnel_counts as (
      select 
          sum(
            case 
              when page_view_time is not null then 1
              else 0

          end) as page_view_sessions,
      sum (
            case 
              when page_view_time < add_to_cart_time then 1 
              else 0
            end) as cart_sessions, 
      sum (
            case 
             when page_view_time < add_to_cart_time
             and 
             add_to_cart_time < purchase_time  then 1
             else 0
     end) as purchase_sessions
from session_funnel

)

select page_view_sessions, cart_sessions, purchase_sessions, 
round (
      cart_sessions *100.00/ nullif(page_view_sessions, 0), 2) as view_to_cart_rate_pct, 
round (
      (page_view_sessions- cart_sessions)*100.00/ nullif (page_view_sessions,0),2
) as view_to_cart_rate_pct, 

round (
        purchase_sessions * 100.0 / nullif(cart_sessions, 0), 2
    ) as cart_to_purchase_rate_pct,

round(
        (cart_sessions - purchase_sessions) * 100.0 / nullif(cart_sessions, 0), 2
    ) as cart_to_purchase_dropoff_pct,

round(
        purchase_sessions * 100.0 / nullif(page_view_sessions, 0), 2
    ) as overall_conversion_pct

FROM funnel_counts;


-- 120000	81518	33580	67.93	32.07	41.19	58.81	27.98

SELECT
    event_type,
    COUNT(*) AS total_events,
    COUNT(DISTINCT session_id) AS unique_sessions
FROM events
GROUP BY event_type;