CREATE DATABASE ecommerce;
use ecommerce; 
    DEFAULT CHARACTER SET = 'utf8mb4';
create table customers (
    customer_id int primary key
);
create table products(
    product_id int primary key,
    category varchar(100) not null, 
    name varchar(300) not null, 
    price_usd decimal(10,2) not null, 
    cost_usd decimal (10,2) not null, 
    margin_usd decimal (10,2) not null
);

create table orders (
    order_id int primary key, 
    customer_id int not null, 
    orer_time datetime not null, 
    payment_method varchar(50), 
    discount_pct decimal(5,2), 
    subtotal_usd decimal (12,2), 
    total_usd decimal (12,2), 
    country varchar(100), 
    device varchar(100),
    source varchar(100),
    constraint fk_orders_customers 
         foreign key (customer_id)
         references customers(customer_id)
);

create table sessions (
    session_id int primary key, 
    customer_id int not null, 
    start_time datetime not null, 
    device varchar(50), 
    source varchar(100), 
    country varchar(100), 
    constraint fk_sessions_customer
           foreign key(customer_id)
           references customers(customer_id)
      
);
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    unit_price_usd DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    line_total_usd DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    rating TINYINT NOT NULL,
    review_text VARCHAR(255) NOT NULL,
    review_time DATETIME NOT NULL,

    CONSTRAINT fk_reviews_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_reviews_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

create table events (
    event_id int primary key, 
    session_id int not null, 
    timestamp datetime not null, 
    event_type varchar(50) not null, 
    product_id int null, 
    qty int null, 
    cart_size int null, 
    payment varchar(50) null, 
    discount_pct decimal(5,2) null, 
    amount_usd decimal(12,2) null, 
    constraint fk_events_session
           foreign key (session_id)
           references sessions(session_id),
    constraint fk_events_product
           foreign key (product_id)
           references products(product_id)
            
);



select DATABASE();

use lisbonairbnb;
show tables;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS
    events,
    reviews,
    order_items,
    sessions,
    orders,
    products,
    customers;

SET FOREIGN_KEY_CHECKS = 1;

show tables;
use ecommerce;
show tables;
SHOW VARIABLES;
SET GLOBAL LOCAL_INFILE =1;
SHOW VARIABLES;

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

-- correct order: order_time instead of orer_time 

alter table orders
rename column orer_time to order_time;
describe orders; 
-- alter table customers 
alter table customers 
add column name varchar (255), 
add column email varchar (255), 
add column country varchar (255), 
add column age int, 
add column signup_date date, 
add column marketing_opt_in boolean;
describe customers;

-- issues with the customers table: created just with customer_id,; despite of trying to be altered
-- the new columns are NULL because adding them with alter table doesn't populate records
-- most propably the laod data tries to insert new rows, not fill the existing one 
-- a temporary table has been created, the cvs imported in, then update the existing rows by matching customer_id 
-- temporary table droped 


LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, name, email, country, age, signup_date, marketing_opt_in);


CREATE TABLE customers_staging (
    customer_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    country VARCHAR(100),
    age INT,
    signup_date DATE,
    marketing_opt_in BOOLEAN
);

LOAD DATA LOCAL INFILE 'E:/projects data/ecommerce/data/customers.csv'
INTO TABLE customers_staging
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, name, email, country, age, signup_date, marketing_opt_in);

SELECT *
FROM customers_staging
LIMIT 5;


UPDATE customers c
JOIN customers_staging s
    ON c.customer_id = s.customer_id
SET
    c.name = s.name,
    c.email = s.email,
    c.country = s.country,
    c.age = s.age,
    c.signup_date = s.signup_date,
    c.marketing_opt_in = s.marketing_opt_in;

SELECT *
FROM customers
LIMIT 10;
SELECT COUNT(*) AS missing_names
FROM customers
WHERE name IS NULL;

DROP TABLE customers_staging;