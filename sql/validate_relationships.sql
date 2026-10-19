use ecommerce; 

-- customers - orders
select o.customer_id from orders as o 
left join customers as c 
on o.customer_id = c.customer_id 
where c.customer_id is null;
 -- empty set, every customer referenced  by an order exists;

-- orders - order items 

select oi.order_id from order_items as oi
left join orders as o 
on oi.order_id = o.order_id 
where o.order_id is null; 
-- empty set
-- products to order items 
select oi.product_id from order_items as oi
left join products as p 
on oi.product_id = p.product_id 
where p.product_id is null; 
-- empty set 
-- order - reviews 
select r.order_id from reviews as r
left join orders as o 
on r.order_id = o.order_id 
where o.order_id is null;
-- empty set  

-- products  - reviews 
select r.product_id from reviews as r
left join products as p 
on r.product_id = p.product_id
where p.product_id  is null;
-- empty set

-- customers - sessions 
select s.customer_id from sessions as s
left join customers as c
on s.customer_id = c.customer_id
where c.customer_id is null; 
-- empty set 

-- sessions - events 

select e.session_id from events as e 
left join sessions as s 
on e.session_id  =  s.session_id
where s.session_id is null; 
-- empty set 

-- products - events 

select e.product_id from events as e 
left join products as p 
on e.product_id = p.product_id
where e.product_id is not null 
and p.product_id is null; 