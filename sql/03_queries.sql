-- =====================================================================
-- PIZZA SALES DATABASE - ORACLE SQL ANALYSIS QUERIES
-- Database Engineering Lab Project
-- =====================================================================

-- =====================================================================
-- BASIC
-- =====================================================================

-- 1. Retrieve the total number of orders placed.
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p ON p.pizza_id = od.pizza_id;

-- 3. Identify the highest-priced pizza.
SELECT pt.name, p.size, p.price
FROM pizzas p
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
FETCH FIRST 1 ROWS ONLY;

-- 4. Identify the most common pizza size ordered.
SELECT p.size, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
FETCH FIRST 1 ROWS ONLY;

-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p  ON p.pizza_id = od.pizza_id
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
FETCH FIRST 5 ROWS ONLY;


-- =====================================================================
-- INTERMEDIATE
-- =====================================================================

-- 6. Join the necessary tables to find the total quantity
--    of each pizza category ordered.
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p  ON p.pizza_id = od.pizza_id
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- 7. Determine the distribution of orders by hour of the day.
SELECT TO_CHAR(o.order_time, 'HH24') AS order_hour,
       COUNT(o.order_id) AS total_orders
FROM orders o
GROUP BY TO_CHAR(o.order_time, 'HH24')
ORDER BY order_hour;

-- 8. Join relevant tables to find the category-wise distribution of pizzas.
SELECT pt.category, COUNT(p.pizza_id) AS total_pizzas
FROM pizzas p
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
ORDER BY total_pizzas DESC;

-- 9. Group the orders by date and calculate the average number
--    of pizzas ordered per day.
SELECT ROUND(AVG(daily_qty), 2) AS avg_pizzas_per_day
FROM (
    SELECT o.order_date, SUM(od.quantity) AS daily_qty
    FROM orders o
    JOIN order_details od ON od.order_id = o.order_id
    GROUP BY o.order_date
);

-- 10. Determine the top 3 most ordered pizza types based on revenue.
SELECT pt.name, ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN pizzas p  ON p.pizza_id = od.pizza_id
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
FETCH FIRST 3 ROWS ONLY;


-- =====================================================================
-- ADVANCED
-- =====================================================================

-- 11. Calculate the percentage contribution of each pizza type
--     (by category) to total revenue.
SELECT pt.category,
       ROUND(SUM(od.quantity * p.price), 2) AS category_revenue,
       ROUND(
           SUM(od.quantity * p.price) * 100 /
           SUM(SUM(od.quantity * p.price)) OVER (),
       2) AS pct_of_total_revenue
FROM order_details od
JOIN pizzas p  ON p.pizza_id = od.pizza_id
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
ORDER BY pct_of_total_revenue DESC;

-- 12. Analyze the cumulative revenue generated over time.
SELECT order_date,
       daily_revenue,
       ROUND(SUM(daily_revenue) OVER (ORDER BY order_date), 2) AS cumulative_revenue
FROM (
    SELECT o.order_date,
           SUM(od.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN order_details od ON od.order_id = o.order_id
    JOIN pizzas p ON p.pizza_id = od.pizza_id
    GROUP BY o.order_date
)
ORDER BY order_date;

-- 13. Determine the top 3 most ordered pizza types based on revenue
--     for EACH pizza category.
SELECT category, name, revenue, rn AS rank_in_category
FROM (
    SELECT pt.category,
           pt.name,
           ROUND(SUM(od.quantity * p.price), 2) AS revenue,
           RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS rn
    FROM order_details od
    JOIN pizzas p  ON p.pizza_id = od.pizza_id
    JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
    GROUP BY pt.category, pt.name
)
WHERE rn <= 3
ORDER BY category, rn;
