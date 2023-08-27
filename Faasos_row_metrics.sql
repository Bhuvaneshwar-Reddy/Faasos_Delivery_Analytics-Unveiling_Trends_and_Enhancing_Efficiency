/*
   Faasos Food Delivery Data Analysis - Roll Metrics
   Project: Gaining insights into roll-related data and identifying operational challenges.
   
   This SQL script focuses on analyzing roll metrics within the Faasos food delivery dataset.
   The objective is to unveil valuable information about roll orders, customer preferences,
   and operational challenges.
   
   By Bhuvaneshwar Reddy J C
*/

-- Introduction
/*
   In this analysis, we'll dive into the roll-related metrics present in the Faasos food delivery dataset.
   Our goal is to gain insights into various aspects related to rolls, including the total number of rolls ordered,
   customer preferences for Veg and Non-Veg rolls, the distribution of orders across different hours of the day,
   and the number of orders on each day of the week. By understanding these metrics, we can identify patterns,
   preferences, and potential operational challenges related to roll orders and delivery times.
*/

-- Create a table named 'driver' to store information about delivery drivers.

CREATE TABLE driver(
    driver_id INTEGER,    -- Unique ID for each driver.
    reg_date date         -- Registration date of the driver.
);

-- Insert values into the driver table

INSERT INTO driver(driver_id,reg_date)
VALUES(1,'2021-01-01'),
(2,'2021-01-03'),
(3,'2021-01-08'),
(4,'2021-01-15');

SELECT * FROM driver;

-- Create a table named 'ingredients' to store information about food ingredients.

CREATE TABLE ingredients(
    ingredient_id INTEGER,        -- Unique ID for each ingredient.
    ingredient_name varchar(50)    -- Name of the ingredient (up to 50 characters).
);

-- Insert values into ingredients table.

INSERT INTO ingredients(ingredient_id,ingredient_name)
VALUES (1,'BBQ Chicken'),
(2,'Chilli Sauce'),
(3,'Chicken'),
(4,'Cheese'),
(5,'Kebab'),
(6,'Mushrooms'),
(7,'Onions'),
(8,'Egg'),
(9,'Peppers'),
(10,'schezwan sauce'),
(11,'Tomatoes'),
(12,'Tomato Sauce');

SELECT * FROM ingredients;

-- Set up a table named 'rolls' to keep track of types of food rolls.

CREATE TABLE rolls(
    roll_id INTEGER,          -- Unique ID for each type of roll.
    roll_name varchar(30)     -- Name of the roll type (up to 30 characters).
);

-- Insert values into rolls table.

INSERT INTO rolls(roll_id ,roll_name) 
 VALUES (1	,'Non Veg Roll'),
(2	,'Veg Roll');

SELECT * FROM rolls;

-- Create a table 'rolls_recipes' to manage roll ingredients for each roll type.

CREATE TABLE rolls_recipes(
    roll_id INTEGER,         -- Unique ID for each roll type.
    ingredients varchar(30)  -- Ingredients used in the roll (up to 30 characters).
);

-- Insert values into the rolls_recipes table.

INSERT INTO rolls_recipes(roll_id ,ingredients) 
 VALUES (1,'1,2,3,4,5,6,8,10'),
(2,'4,6,7,9,11,12');

SELECT * FROM rolls_recipes;

-- Create a table 'driver_order' to track order details and driver information.

CREATE TABLE driver_order(
    order_id integer,        -- Unique ID for each order.
    driver_id integer,       -- ID of the driver handling the order.
    pickup_time datetime,    -- Time when the order was picked up.
    distance VARCHAR(10),    -- Distance of the delivery (up to 10 characters).
    duration VARCHAR(10),    -- Duration of the delivery (up to 10 characters).
    cancellation VARCHAR(30) -- Reason for order cancellation (up to 30 characters).
);

-- Insert values into the driver_order table.

INSERT INTO driver_order(order_id,driver_id,pickup_time,distance,duration,cancellation) 
 VALUES(1,1,'2021-01-01 18:15:34','20km','32 minutes',''),
(2,1,'2021-01-01 19:10:54','20km','27 minutes',''),
(3,1,'2021-01-03 00:12:37','13.4km','20 mins','NaN'),
(4,2,'2021-01-04 13:53:03','23.4','40','NaN'),
(5,3,'2021-01-08 21:10:57','10','15','NaN'),
(6,3,null,null,null,'Cancellation'),
(7,2,'2020-01-08 21:30:45','25km','25mins',null),
(8,2,'2020-01-10 00:15:02','23.4 km','15 minute',null),
(9,2,null,null,null,'Customer Cancellation'),
(10,1,'2020-01-11 18:50:20','10km','10minutes',null);

SELECT * from driver_order;

-- Create a table 'customer_orders' to store information about customer orders.

CREATE TABLE customer_orders(
    order_id integer,                -- Unique ID for each order.
    customer_id integer,             -- ID of the customer placing the order.
    roll_id integer,                 -- ID of the roll ordered.
    not_include_items VARCHAR(4),    -- Indicator for items not included (up to 4 characters).
    extra_items_included VARCHAR(4), -- Indicator for extra items included (up to 4 characters).
    order_date datetime              -- Date and time of the order.
);

-- Insert values into customer_orders table.

INSERT INTO customer_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included,order_date)
values (1,101,1,'','','2021-01-01  18:05:02'),
(2,101,1,'','','2021-01-01 19:00:52'),
(3,102,1,'','','2021-01-02 23:51:23'),
(3,102,2,'','NaN','2021-01-02 23:51:23'),
(4,103,1,'4','','2021-01-04 13:23:46'),
(4,103,1,'4','','2021-01-04 13:23:46'),
(4,103,2,'4','','2021-01-04 13:23:46'),
(5,104,1,null,'1','2021-01-08 21:00:29'),
(6,101,2,null,null,'2021-01-08 21:03:13'),
(7,105,2,null,'1','2021-01-08 21:20:29'),
(8,102,1,null,null,'2021-01-09 23:54:33'),
(9,103,1,'4','1,5','2021-01-10 11:22:59'),
(10,104,1,null,null,'2021-01-11 18:34:49'),
(10,104,1,'2,6','1,4','2021-01-11 18:34:49');

select * from customer_orders;

select * from customer_orders;
select * from driver_order;
select * from ingredients;
select * from driver;
select * from rolls;
select * from rolls_recipes;


/* 
I have purposefully introduced NULL values and empty spaces in the data to mirror common real-world data scenarios, where many attributes may lack complete information. 
As data analysts, our task involves refining these raw tables by resolving discrepancies, paving the way for robust data analysis.
This practice empowers us to derive valuable insights from the data, even in the presence of initial imperfections.
*/

-- A. Roll metrics

-- 1. Calculate the total number of rolls ordered.

SELECT COUNT(roll_id) AS Total_Rolls_Ordered
FROM customer_orders;

-- 2. Count the number of unique customer orders made.

SELECT COUNT(DISTINCT customer_id) AS Unique_Customer_Orders
FROM customer_orders;

-- 3. Count the number of successful orders delivered by each driver.

SELECT driver_id, COUNT(order_id) AS Successful_Orders
FROM driver_order
WHERE distance IS NOT NULL
GROUP BY driver_id;

-- Alternative Solution

SELECT a.driver_id, COUNT(order_id) AS Completed_Deliveries
FROM (
SELECT *, CASE WHEN cancellation IN ('Cancellation', 'Customer Cancellation') THEN 'Cancel' ELSE 'Not_Cancel' END AS cancellation_status
FROM driver_order
) a
WHERE cancellation_status = 'Not_Cancel'
GROUP BY a.driver_id;

-- 4. Calculate the count of each roll type that was successfully delivered.

SELECT roll_id, COUNT(roll_id) AS Roll_Count
FROM customer_orders
WHERE order_id IN (
SELECT order_id FROM (
SELECT *, CASE WHEN cancellation IN ('Cancellation', 'Customer Cancellation') THEN 'Cancel' ELSE 'Not_Cancel' END AS cancellation_status
FROM driver_order
) a
WHERE cancellation_status = 'Not_Cancel'
)
GROUP BY roll_id;

-- Alternate Solution using JOINS.

SELECT a.roll_id, COUNT(*) AS Roll_Count
FROM customer_orders a
JOIN driver_order b ON a.order_id = b.order_id
WHERE b.cancellation NOT LIKE '%Cancellation%' OR b.cancellation IS NULL
GROUP BY a.roll_id;

-- 5. How many Veg and non-veg Rolls were ordered by each customer?

SELECT c.customer_id,
SUM(CASE WHEN r.roll_name = 'Veg Roll' THEN 1 ELSE 0 END) AS Veg_Rolls_Count,
SUM(CASE WHEN r.roll_name = 'Non Veg Roll' THEN 1 ELSE 0 END) AS NonVeg_Rolls_Count
FROM customer_orders c
JOIN rolls r ON c.roll_id = r.roll_id
GROUP BY c.customer_id;

-- 6. What was the maximum number of rolls delivered in a single order?

-- If we only want the maximum number of rolls delivered

SELECT MAX(`Count`) AS Maximum_Rolls_Delivered
FROM (
SELECT COUNT(roll_id) AS `Count`
FROM customer_orders c
JOIN driver_order d ON c.order_id = d.order_id
WHERE d.cancellation NOT IN ('Cancellation','Customer Cancellation')
GROUP BY c.order_id
) a;

-- Alternative: If we want both the order_id as well as the maximu number of rolls delivered

SELECT order_id, `Count` AS Maximum_Rolls_Delivered
FROM (
SELECT order_id, count(roll_id) as `Count`
FROM customer_orders
WHERE order_id IN (
SELECT order_id
FROM (
SELECT *, CASE WHEN cancellation IN ('Cancellation','Customer Cancellation') THEN 'Cancel' ELSE 'Not_Cancel' END AS cancellation_status
FROM driver_order
) a
WHERE cancellation_status = 'Not_Cancel'
)
GROUP BY order_id
) max_rolls
ORDER BY `Count` DESC
LIMIT 1;

-- 7. For each customer, how many delivered rolls had atleast 1 change and how many had no changes?

SELECT customer_id,
SUM(CASE WHEN extra_items_included IS NOT NULL OR not_include_items IS NOT NULL THEN 1 ELSE 0 END) AS rolls_with_changes,
SUM(CASE WHEN extra_items_included IS NULL AND not_include_items IS NULL THEN 1 ELSE 0 END) AS rolls_without_changes
FROM customer_orders
WHERE order_id IN (
SELECT order_id
FROM driver_order
WHERE cancellation NOT LIKE '%Cancellation%' OR cancellation IS NULL
)
GROUP BY customer_id;

/* Now the above queries were performed without any data cleaning.
Since there are lots of NULL and Blank spaces in the tables, we may miss those records by accident during analysis.
Let us clean the data from both customer_orders table and driver_order table by creating a temporary table. */

/* Data Cleaning for Analysis */

-- Create Temporary Table for Cleaned Customer Orders Data

DROP temporary TABLE IF EXISTS temp_customer_orders;

CREATE TEMPORARY TABLE temp_customer_orders AS
SELECT order_id, customer_id,roll_id,
CASE WHEN not_include_items IS NULL OR not_include_items='' THEN 0 ELSE not_include_items END AS new_not_include_items,
CASE WHEN extra_items_included IS NULL OR extra_items_included='' OR extra_items_included = 'NaN' THEN 0 ELSE extra_items_included END new_extra_items_included, 
order_date FROM customer_orders;

SELECT * FROM temp_customer_orders;

-- Create Temporary Table for Cleaned Driver Order Data

DROP TEMPORARY TABLE IF EXISTS temp_driver_order;

CREATE TEMPORARY TABLE temp_driver_order AS
SELECT order_id, driver_id, pickup_time, distance, duration,
CASE WHEN cancellation IS NULL OR cancellation = 'NaN' OR cancellation = '' THEN 1 ELSE 0 END AS new_cancellation
FROM driver_order;

SELECT * FROM temp_driver_order;

-- Here 0 indicates delivery was cancelled and 1 indicates delivery was not cancelled.

/* In the above code, we are performing data cleaning on the customer_orders and driver_order tables
by creating temporary tables temp_customer_orders and temp_driver_order. We are handling NULL values and
cleaning up the 'not_include_items', 'extra_items_included', and 'cancellation' columns. The new_cleaned
columns ensure that the data is more consistent and ready for analysis. */

-- 7. For each customer, how many delivered rolls had atleast 1 change and how many had no changes?

SELECT customer_id,
SUM(CASE WHEN new_not_include_items = 0 AND new_extra_items_included = 0 THEN 0 ELSE 1 END) AS changes_made,
SUM(CASE WHEN new_not_include_items = 0 AND new_extra_items_included = 0 THEN 1 ELSE 0 END) AS no_changes
FROM temp_customer_orders
WHERE order_id IN (
SELECT order_id
FROM temp_driver_order
WHERE new_cancellation != 0
)
GROUP BY customer_id;

/* In the provided query, we are analyzing the customer orders to determine how many delivered rolls
had at least 1 change and how many had no changes. We are using the cleaned data from the
temp_customer_orders table and considering only orders with no cancellations. The results are grouped
by customer and the type of changes made ("no_change" or "changes_are_made"). The query provides
insight into how many customers modified their orders. */

-- 8 How many rolls were delivered that had both exclusions and extras?

SELECT customer_id,COUNT(roll_id) AS rolls_with_exclusions_and_extras
FROM (
SELECT *,CASE WHEN new_not_include_items AND new_extra_items_included THEN 1 ELSE 0 END AS rolls_with_exclusions_and_extras 
FROM temp_customer_orders 
WHERE order_id IN
(select order_id FROM temp_driver_order WHERE new_cancellation!=0))a
WHERE rolls_with_exclusions_and_extras=1
GROUP BY customer_id;

-- Alternative method

SELECT customer_id, COUNT(roll_id) AS rolls_with_exclusions_and_extras
FROM temp_customer_orders
WHERE order_id IN (
SELECT order_id
FROM temp_driver_order
WHERE new_cancellation != 0
)
AND new_not_include_items > 0 AND new_extra_items_included > 0
GROUP BY customer_id;

-- 9. What was the total number of rolls ordered for each hour of the day?

SELECT hours_range, COUNT(hours_range) AS Total_Rolls_Ordered
FROM (
SELECT *, CONCAT(CAST(HOUR(order_date) AS CHAR), ' ', CAST(HOUR(order_date) + 1 AS CHAR)) AS hours_range
FROM customer_orders
) a
GROUP BY hours_range
ORDER BY Total_Rolls_Ordered DESC;

/* This query adds up how many rolls were ordered during each hour of the day. 
It looks at the order_date in the customer_orders table and groups the orders by the hour range they belong to. 
The outcome gives us a sense of when roll orders are most popular throughout the day.
*/

-- 10. What was the number of orders for each day of the week?

SELECT day_of_week, COUNT(DISTINCT order_id) AS COUNT
FROM (
SELECT *, DAYNAME(order_date) AS day_of_week
FROM customer_orders
) a
GROUP BY day_of_week;

-- Conclusion
/*
   The roll-related metrics analysis provided valuable insights into the Faasos food delivery dataset.
   We explored the total number of rolls ordered, identified unique customer orders, and examined the
   distribution of Veg and Non-Veg rolls ordered by each customer. Additionally, we investigated the demand
   for rolls during different hours of the day and across different days of the week.
   
   These insights can be used to make informed decisions about inventory management, staffing, and operational
   scheduling to meet customer demands effectively. By understanding when and what types of rolls are most popular,
   Faasos can optimize their offerings and enhance the overall customer experience.
*/