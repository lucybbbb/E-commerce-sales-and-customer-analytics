use ecommerce;
-- check the count rows 

    select "customers" as table_name, count(*) as row_count from customers
    union all 
    select "products", count(*) from products
    union all 
    select "orders", count(*) from orders
    union all
    select "sessions", count(*) from sessions
    union all
    select "order_items", count(*) from order_items
    union all 
    select "reviews", count(*) from reviews 
    union all 
    select "events", count(*) from events;
    use ecommerce;
    select DATABASE();
    show tables;