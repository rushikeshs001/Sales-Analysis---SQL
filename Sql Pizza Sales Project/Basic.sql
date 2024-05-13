-- 1)Retrieve the total number of orders placed.
SELECT COUNT(order_id) as total_orders FROM pizzahut.orders;

-- 2)Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;


-- 3)Identify the highest priced pizza
SELECT pizza_id,price FROM pizzahut.pizzas order by price desc limit 1;   
-- OR
SELECT pizza_types.name,pizzas.price
FROM pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by price desc limit 1;

-- 4) Identify the most common pizza size ordered
SELECT pizzas.size,COUNT(order_details.order_details_id) as order_count
FROM pizzas join order_details
ON pizzas.pizza_id=order_details.pizza_id
group by pizzas.size order by order_count desc;


-- 5) List the top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name,sum(order_details.quantity) as quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.name ORDER BY quantity desc limit 5;



“Pizza Sales Analysis: Uncovering Insights for Optimization” Description: “In this project, I analyzed sales data from a fictional pizza restaurant chain using SQL. By examining customer preferences, top-selling flavors, and sales trends, I provided actionable recommendations to enhance business performance.”

