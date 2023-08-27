/*
   Faasos Food Delivery Data Analysis - Driver and Customer Experience
   Project: Uncovering insights into driver behavior and customer interactions.
   
   This SQL script delves into driver and customer interactions within the Faasos food delivery dataset.
   The aim is to gain insights into driver performance, successful delivery percentages, and challenges
   related to delivery times and cancellations.
   
   By Bhuvaneshwar Reddy J C
*/

-- Introduction
/*
   In this analysis, we'll focus on exploring the driver and customer experience within the Faasos food delivery dataset.
   Our objective is to uncover valuable information about driver behavior, delivery success rates, and common issues
   faced by both drivers and customers. By understanding these aspects, we can identify trends, operational challenges,
   and opportunities for improvement in the delivery process.
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

-- B. Driver and customer experience 

-- 1. What was the average time in minutes it took for each driver to arrive at the Faasos HQ to pickup the order?

-- This was the initial query that I had written which I thought would work.

SELECT driver_id, AVG(TIMESTAMPDIFF(MINUTE, order_date, pickup_time)) AS avg_time_minutes
FROM customer_orders
JOIN driver_order ON customer_orders.order_id = driver_order.order_id
WHERE pickup_time IS NOT NULL
GROUP BY driver_id;

/* This query works when both the order_date and pickup_time are in the same year. 
But in our dataset, we have order_date in one year and the pickup_time in the next year, hence the above query does not work.
TO overcome this, refer the next query.
*/

SELECT driver_id, AVG(diff) AS avg_time
FROM (
    SELECT *
    FROM (
        SELECT *,
            ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY diff) AS `Rank`
        FROM (
            SELECT
                c.order_id,
                c.customer_id,
                c.roll_id,
                c.order_date,
                d.driver_id,
                d.pickup_time,
                d.distance,
                d.duration,
                d.cancellation,
                CASE
                    WHEN MINUTE(d.pickup_time) < MINUTE(c.order_date) THEN (MINUTE(d.pickup_time) + 60 - MINUTE(c.order_date))
                    ELSE (MINUTE(d.pickup_time) - MINUTE(c.order_date))
                END AS diff
            FROM customer_orders c
            INNER JOIN driver_order d ON c.order_id = d.order_id
            WHERE d.pickup_time IS NOT NULL
        ) a
    ) b
    WHERE `Rank` = 1
) n
GROUP BY driver_id;

-- 2. Is there any relationship between the number of rolls and how long the order takes to prepare?

SELECT a.order_id, COUNT(roll_id) AS no_of_rolls, AVG(difference) AS average_time
FROM (
    SELECT c.*, d.pickup_time,
        CASE
            WHEN MINUTE(d.pickup_time) < MINUTE(c.order_date) THEN (MINUTE(d.pickup_time) + 60 - MINUTE(c.order_date))
            ELSE (MINUTE(d.pickup_time) - MINUTE(c.order_date))
        END AS difference
    FROM customer_orders c
    INNER JOIN driver_order d ON c.order_id = d.order_id
    WHERE d.pickup_time IS NOT NULL
) a
GROUP BY a.order_id
ORDER BY average_time;

/* Looking at the results, It is observed that the number of rolls and the time taken to prepare seem to have a 1:10 ratio. 
This suggests that they might be directly related to each other. */

-- 3. What is the average distance travelled for each customer?

SELECT customer_id, AVG(distance) as average_distance
FROM (
SELECT c.order_id, c.customer_id, c.roll_id, c.order_date, d.driver_id, d.pickup_time, d.distance, d.duration, d.cancellation
FROM customer_orders c
INNER JOIN driver_order d on c.order_id = d.order_id
WHERE d.pickup_time is not null
) n
GROUP BY customer_id; 

/* This query works if the data is cleaned. Since it is not cleaned, some values were not taken into consideration.
Therefore, let us clean the data and then perform the query. */

/* To clean the data, we begin by removing 'km' from the distance field and extracting the numerical distance value. 
This extracted value is then converted to a floating-point number using the cast function.
Lastly, we round the floating-point value to two decimal places using the ROUND() function. */

SELECT customer_id, AVG(distance) AS average_distance FROM
(
  SELECT * FROM
  (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY diff) AS `Rank` FROM
    (
      SELECT 
        c.order_id, c.customer_id, c.roll_id, c.order_date, d.driver_id, d.pickup_time,
        ROUND(CAST(TRIM(REPLACE(LOWER(d.distance), 'km', '')) AS FLOAT), 2) AS distance,
        d.duration, d.cancellation,
        CASE
          WHEN MINUTE(d.pickup_time) < MINUTE(c.order_date)
          THEN (MINUTE(d.pickup_time) + 60 - MINUTE(c.order_date))
          ELSE (MINUTE(d.pickup_time) - MINUTE(c.order_date))
        END AS diff
      FROM customer_orders c
      INNER JOIN driver_order d ON c.order_id = d.order_id
      WHERE d.pickup_time IS NOT NULL
    ) a
  ) b WHERE `Rank` = 1
) n
GROUP BY customer_id;

-- 4. What was the difference between the longest and shortest delivery times for all orders?

SELECT MAX(delivery_time) - MIN(delivery_time) AS difference FROM
(
  SELECT LEFT(duration, 2) AS delivery_time FROM driver_order WHERE duration IS NOT NULL ORDER BY delivery_time
) a;

/* This query assumes that the duration values do not exceed two digits.
However, in real-world scenarios, we cannot be certain about this. 
Therefore, an alternative query can be used that accommodates varying duration lengths.*/

SELECT MAX(delivery_time) - MIN(delivery_time) AS difference FROM
(SELECT duration, CASE WHEN duration LIKE '%min%' THEN LEFT(duration, LOCATE('m', duration) - 1) ELSE duration END AS delivery_time
FROM driver_order
WHERE duration IS NOT NULL) a;

-- 5. What was the average speed for each driver for each delivery and do you notice any trend for these values?

SELECT a.*, distance / (duration / 60) AS average_speed, `Count`
FROM driver_order a
INNER JOIN (SELECT order_id, COUNT(roll_id) AS `Count` FROM customer_orders GROUP BY order_id) b ON a.order_id = b.order_id
WHERE distance IS NOT NULL;

/*
This query calculates the average speed in km/hr for each driver during each delivery. 
It ensures the speed is presented in commonly used units and considers data cleaning for accurate results.

The first part of the query performs speed calculation using clean data. 
The second part demonstrates how to clean the data before calculating the speed which is shown below.

*/

SELECT a.driver_id, a.order_id, distance / (time_taken / 60) AS speed, `Count`
FROM (
    SELECT d.order_id, d.driver_id,
           CASE WHEN duration LIKE '%min%' THEN LEFT(duration, LOCATE('m', duration) - 1) ELSE duration END AS time_taken,
           ROUND(CAST(TRIM(REPLACE(LOWER(d.distance), 'km', '')) AS FLOAT), 2) AS distance
    FROM driver_order d
    WHERE distance IS NOT NULL
) a
INNER JOIN (
    SELECT order_id, COUNT(roll_id) AS `Count` FROM customer_orders GROUP BY order_id
) b ON a.order_id = b.order_id;

/*
This query provides insights into driver performance based on the average speed in km/hr for each delivery. 
It takes into account cleaned data to ensure accurate speed calculations.

From the results, an interesting trend emerges: the number of rolls per delivery is inversely proportional to the speed. 
In simpler terms, when more rolls are included in an order, the average speed of delivery tends to decrease.
*/

-- 6. What is the successful delivery percentage for each delivery?

/* The formula to calculate successful delivery percentage is, 
successful delivery percentage = total_orders_successfully_delivered/total_orders_taken */

SELECT
    driver_id,
    (SUM(cancel_status) / COUNT(driver_id)) * 100 AS success_percentage
FROM
    (SELECT
        driver_id,
        CASE WHEN LOWER(cancellation) LIKE "%cancel%" THEN 0 ELSE 1 END AS cancel_status
    FROM
        driver_order
    ) a
GROUP BY
    driver_id;
    
-- Conclusion
/*
   The driver and customer experience analysis shed light on key aspects of the Faasos food delivery process.
   We delved into the average time taken by drivers to arrive for order pickups, identifying potential areas
   for optimizing route planning and driver efficiency. Additionally, we calculated the successful delivery
   percentage for each driver, providing insights into driver performance and reliability.
   Lastly, we examined the average distance traveled by customers, highlighting the distance covered during
   the delivery process.
   
   These insights can aid in enhancing driver training, improving delivery success rates, and refining the
   overall customer experience. By addressing challenges related to delivery times and cancellations,
   Faasos can strengthen customer satisfaction and operational efficiency.
*/