use ecommerce;

-- load customers
LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- load products
LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- load orders 
LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/clean/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- load sessions 
LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/clean/sessions.csv'
INTO TABLE sessions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/clean/order_items.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, product_id, unit_price_usd, quantity, line_total_usd);

-- load reviews 
LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/clean/reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- load events
LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/clean/events.csv'
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    event_id,
    session_id,
    timestamp,
    event_type,
    @product_id,
    @qty,
    @cart_size,
    @payment,
    @discount_pct,
    @amount_usd
)
SET
    product_id = NULLIF(@product_id, ''),
    qty = NULLIF(@qty, ''),
    cart_size = NULLIF(@cart_size, ''),
    payment = NULLIF(@payment, ''),
    discount_pct = NULLIF(@discount_pct, ''),
    amount_usd = NULLIF(@amount_usd, '');

   
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