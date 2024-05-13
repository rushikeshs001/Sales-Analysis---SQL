-- Calculate the percentage contribution of each pizza type to total revenue
SELECT pizza_types.category, (sum(order_details.quantity*pizzas.price)/ (SELECT ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_revenue FROM  order_details JOIN  pizzas ON order_details.pizza_id = pizzas.pizza_id))*100 as revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.category ORDER BY revenue desc;

-- Analyze the cumulative revenue generated over time.
SELECT order_date,sum(revenue) over(order by order_date) as cum_revenue
from
(SELECT orders.order_date,sum(order_details.quantity*pizzas.price) as revenue
FROM order_details JOIN
pizzas ON order_details.pizza_id=pizzas.pizza_id
JOIN orders
ON orders.order_id=order_details.order_id
GROUP BY orders.order_date) as sales;


SELECT category,name,revenue,
rank() over(partition by category order by revenue desc) as ranks
from
(SELECT pizza_types.category,pizza_types.name,
sum((order_details.quantity)*pizzas.price) as revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.category,pizza_types.name) as a;