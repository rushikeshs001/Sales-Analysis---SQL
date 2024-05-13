-- Join the necessary tables to find the total qunatity of each pizza category ordered.
SELECT pizza_types.category,sum(order_details.quantity) as quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by quantity desc;

-- Determine the distribution of orders by hour of the day.
SELECT hour(order_time),count(order_id) FROM orders
GROUP BY hour(order_time);

-- Join relevant tables to find the category wise distribution of pizzas.
SELECT category,count(name) FROM pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT avg(quantity) FROM
(SELECT orders.order_date,sum(order_details.quantity)
FROM orders JOIN order_details
ON orders.order_id=order_details.order_id
GROUP BY orders.order_date) as order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT pizza_types.name,sum(order_details.quantity*pizzas.price) as revenue
FROM pizza_types JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY  pizza_types.name
ORDER BY revenue desc limit 3;



