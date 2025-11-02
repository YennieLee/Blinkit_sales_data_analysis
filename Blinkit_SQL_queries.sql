# -------------------------
# 1. Product Analysis
# -------------------------
# (1) How many distinct product categories are there?
SELECT count(DISTINCT category)
FROM products;

SELECT DISTINCT category
FROM products;

# (2) Which product category generated the highest total revenue?
SELECT p.category, sum(oi.quantity*oi.unit_price) as revenue
FROM products AS p 
LEFT OUTER JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 10;

# (3) Which product sold the most units overall?
SELECT p.product_name, sum(oi.quantity) AS total_units_sold
FROM products AS p INNER JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 1;

# (4) What are the top 10 products by revenue?
SELECT o.product_id, p.product_name, p.brand, o.revenue
FROM (
	SELECT product_id, sum(quantity * unit_price) AS revenue
    FROM order_items
    GROUP BY product_id
) AS o
INNER JOIN products AS p
ON p.product_id = o.product_id
ORDER BY o.revenue DESC
LIMIT 10;

# (5) Which brand contributes the highest share of total sales?
SELECT p.brand, sum(oi.quantity*oi.unit_price) AS revenue
FROM products AS p INNER JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.brand
ORDER BY revenue DESC
LIMIT 1;


# -------------------------
# 2. Sales & Revenue Analysis
# -------------------------
# (1) What is the daily average number of orders?
SELECT avg(total_orders) AS order_avg
FROM (
	SELECT date(order_date) AS 'date', count(order_id) AS total_orders
	FROM orders
	GROUP BY date(order_date)
) t;

# (2) What is the average order amount?
SELECT avg(order_total) AS amount_avg
FROM orders;

# (3) What is the total revenue by month?
SELECT 
	date_format(order_date, '%Y-%m') AS 'year_month',
	sum(order_total) AS 'revenue'
FROM orders
GROUP BY date_format(order_date, '%Y-%m')
ORDER BY date_format(order_date, '%Y-%m');

# (4) Which month recorded the highest total sales?
SELECT 
	date_format(order_date, '%Y-%m') AS 'year_month',
	sum(order_total) AS 'revenue'
FROM orders
GROUP BY date_format(order_date, '%Y-%m')
ORDER BY revenue DESC
LIMIT 1;

# (5) Which payment method was used most often for high-value orders?
WITH order_rev AS (
  SELECT
    o.order_id,
    sum(order_total) AS order_revenue
  FROM orders AS o
  GROUP BY o.order_id
),
ranked AS (
  SELECT
    order_id,
    order_revenue,
    CUME_DIST() OVER (ORDER BY order_revenue DESC) AS cd
  FROM order_rev
)
SELECT order_id, order_revenue
FROM ranked
WHERE cd <= 0.30
ORDER BY order_revenue;

# by revenue
SELECT payment_method, sum(order_total) AS revenue
FROM orders AS o
WHERE order_total >= 2925
GROUP BY payment_method
ORDER BY revenue DESC;

# by orders
SELECT payment_method, count(order_id) AS order_cnt
FROM orders AS o
WHERE order_total >= 2925
GROUP BY payment_method
ORDER BY order_cnt DESC;

# (6) Which area has the highest total revenue?
SELECT c.area, sum(o.order_total) AS revenue
FROM orders AS o 
RIGHT OUTER JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.area
ORDER BY revenue DESC;

# (7) Use SQL window functions to find monthly revenue growth rate.
SELECT 
	date_format(order_date, '%Y-%m') AS 'year_month',
	sum(order_total) AS 'revenue'
FROM orders
GROUP BY date_format(order_date, '%Y-%m')
ORDER BY date_format(order_date, '%Y-%m');

SELECT *,
    (revenue/(lag(revenue, 1) OVER (PARTITION BY 'month')) - 1)*100 AS growth_rate
FROM (
	SELECT 
	date_format(order_date, '%Y-%m') AS 'month',
	sum(order_total) AS 'revenue'
	FROM orders
	GROUP BY date_format(order_date, '%Y-%m')
	ORDER BY date_format(order_date, '%Y-%m')
) t;


# -------------------------
# 3. Customer Analysis
# -------------------------
# (1) What is the average number of orders per customer?
SELECT avg(order_cnt) AS avg_order
FROM (
	SELECT c.customer_id, count(o.order_id) AS order_cnt
	FROM customers AS c
	LEFT OUTER JOIN orders AS o
	ON c.customer_id = o.customer_id
	GROUP BY c.customer_id
) t;

# (2) List all customer segments and how many customers belong to each.
SELECT customer_segment, count(customer_id)
FROM customers
GROUP BY customer_segment;

# (3) Which customer segment generated the highest total revenue?
SELECT c.customer_segment, avg(o.order_total) AS revenue
FROM orders AS o 
RIGHT OUTER JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY revenue DESC;

# (4) How many new customers joined per month?
SELECT 
	date_format(registration_date, '%Y-%m') AS reg_month, 
    count(customer_id)
FROM customers
GROUP BY date_format(registration_date, '%Y-%m')
ORDER BY reg_month;

# (5) Which area has the most frequent repeat buyers?
SELECT area, avg(total_orders) AS order_cnt
FROM customers
GROUP BY area
ORDER BY order_cnt DESC;


# (6) Which day of the week gets the most customer ratings?
SELECT 
	dayname(feedback_date) AS day_of_week, 
    count(rating) AS rating_cnt
FROM customer_feedback
GROUP BY dayname(feedback_date)
ORDER BY rating_cnt DESC;

# (7) Which area or region has the lowest rating?
SELECT c.area, avg(cf.rating) AS rating_avg, count(rating) AS rating_cnt
FROM customer_feedback AS cf
INNER JOIN customers AS c
ON cf.customer_id = c.customer_id
GROUP BY c.area
ORDER BY rating_avg;


# -------------------------
# 4. Delivery & Performance Analysis
# -------------------------
# (1) How many orders were delivered late vs. on time?
SELECT delivery_status, count(order_id) AS order_cnt
FROM delivery_performance
GROUP BY delivery_status;

# (2) What is the average delivery time (in minutes)?
SELECT avg(delivery_time) AS time_avg
FROM (
	SELECT 
		timestampdiff(minute, order_date, actual_delivery_time) AS delivery_time
	FROM orders
) t;

# (3) Compare average rating between on-time and delayed deliveries.
SELECT d.delivery_status, avg(cf.rating) AS rating_avg
FROM delivery_performance AS d
LEFT OUTER JOIN customer_feedback AS cf
ON d.order_id = cf.order_id
GROUP BY d.delivery_status
ORDER BY 2 DESC;


# (4) Which area has the highest on-time delivery rate?
SELECT
	c.area,
    count(if(d.delivery_status='On Time', 1, NULL)) / count(d.delivery_status) AS on_time_rate,
    count(o.order_id) AS order_cnt
FROM delivery_performance AS d
INNER JOIN orders AS o
ON d.order_id = o.order_id
RIGHT OUTER JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.area
HAVING order_cnt >= 20
ORDER BY on_time_rate;

# (5) Does distance significantly affect delivery time?
SELECT
	round(d.distance_km) AS km_rnd, 
    avg(o.delivery_time) AS time_avg
FROM (
	SELECT
		order_id,
		timestampdiff(minute, order_date, actual_delivery_time) AS delivery_time
	FROM orders
) AS o
INNER JOIN delivery_performance AS d
ON o.order_id = d.order_id
GROUP BY round(d.distance_km)
ORDER BY km_rnd;


# -------------------------
# 5. Marketing & Campaign Insights
# -------------------------
# (1) Which campaign generated the highest ROAS?
SELECT campaign_name, avg(roas) AS roas_avg
FROM marketing_performance
GROUP BY campaign_name
ORDER BY roas_avg DESC;

# considering target audience and channel
SELECT campaign_name, target_audience, channel, avg(roas) AS roas_avg
FROM marketing_performance
GROUP BY campaign_name, target_audience, channel
ORDER BY campaign_name, roas_avg DESC;

# (2) Which channel drives the highest customer engagement (CTR)?
SELECT channel, avg(clicks/impressions)*100 AS CTR_avg
FROM marketing_performance
GROUP BY channel
ORDER BY CTR_avg DESC;

SELECT DISTINCT channel
FROM marketing_performance;


# (3) What is the conversion rate for each marketing channel?
SELECT channel, avg(conversions/clicks)*100 AS cv_rate_avg
FROM marketing_performance
GROUP BY channel;

# (4) Which target audience performed best in terms of conversions?
SELECT target_audience, avg(conversions/clicks)*100 AS cv_rate_avg
FROM marketing_performance
GROUP BY target_audience
ORDER BY cv_rate_avg DESC;

# (5) Which campaign generated the most impressions but lowest conversions?
SELECT 
	campaign_name, 
    avg(conversions/impressions) AS cv_efficiency
FROM marketing_performance
GROUP BY campaign_name
ORDER BY 2;


