# Blinkit_sales_data_analysis
> SQL-based data analysis and Power BI dashboard exploring Blinkit’s sales, marketing, and customer insights for data-driven decision-making.

## 🔍Overview

This project is a sales and marketing data analysis of Blinkit, an online grocery delivery app in India.

I performed exploratory data analysis (EDA) on key areas including sales, products, customers, marketing, and delivery using SQL.
I also created an interactive Power BI dashboard using the same datasets to visualize business insights. <br>



</br>

## 🗃️About the Dataset

The dataset consists of eight tables, structured as follows:

<img width="1816" height="1012" alt="image" src="https://github.com/user-attachments/assets/34e78c9b-55b7-4a7e-9eec-e7dcd67709dd" />

1. orders – Basic information about each order
2. order_items – Details of items included in each order
3. products – List of products sold on Blinkit
4. customers – Customer information for registered members
5. customer_feedback – Customer feedback on purchased products
6. delivery_performance – Delivery performance for each order
7. marketing_performance – Performance metrics for marketing campaigns
8. inventory – Daily stock information for each product <br>



</br>

## 🛢️SQL Queries

I explored the dataset using MySQL and wrote several queries (5–7) to answer questions related to sales, product performance, customer behavior, delivery efficiency, and marketing campaigns.

This section presents representative example questions for each topic covered in this project.
The full SQL queries and results are available as a separate file in this repository.

### 🛍️Product Analysis
- What are the **top 5 products** by revenue?
  
  ```
  SELECT o.product_id, p.product_name, p.brand, o.revenue
  FROM (
  	SELECT product_id, sum(quantity * unit_price) AS revenue
      FROM order_items
      GROUP BY product_id
  ) AS o
  INNER JOIN products AS p
  ON p.product_id = o.product_id
  ORDER BY o.revenue DESC
  LIMIT 5;
  ```

- Result :
  
  <img width="517" height="164" alt="image" src="https://github.com/user-attachments/assets/b277139d-0757-422c-914a-5d056b54b4fc" />

  
### 💸Sales & Revenue Analysis
- Use SQL window functions to find **monthly revenue growth rate** or **customer retention rate**.
  
  ```
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
  ```
- Result :
  
  <img width="518" height="163" alt="image" src="https://github.com/user-attachments/assets/1b997b8a-4a8d-4ca6-a95a-e669d097c94a" />



### 👥Customer Analysis
- What is the **average number of orders per customer**?
  
  ```
  SELECT avg(order_cnt) AS avg_order
  FROM (
  	SELECT c.customer_id, count(o.order_id) AS order_cnt
  	FROM customers AS c
  	LEFT OUTER JOIN orders AS o
  	ON c.customer_id = o.customer_id
  	GROUP BY c.customer_id
  ) t;
  ```
- Result :
  
  <img width="521" height="59" alt="image" src="https://github.com/user-attachments/assets/df62bfb6-654b-49dc-b0c1-665650dac1bc" />



### 🚚Delivery Performance Analysis
- Which **area** has the **highest on-time delivery rate**?
  
  ```
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
  ORDER BY on_time_rate DESC;
  ```
- Result :
  
  <img width="518" height="162" alt="image" src="https://github.com/user-attachments/assets/d1800420-8e1c-4822-bd83-c124847ae8f2" />


### 📣Marketing & Campaign Insights
- Which **channel** drives the **highest customer engagement (CTR)**?
  
  ```
  SELECT channel, avg(clicks/impressions)*100 AS CTR_avg
  FROM marketing_performance
  GROUP BY channel
  ORDER BY CTR_avg DESC;
  ```
- Result :
  
  <img width="519" height="137" alt="image" src="https://github.com/user-attachments/assets/fcaf730d-b004-49cc-994c-fadda1280a6f" />
 <br>



</br>

## 📊Power BI Dashboard

To visualize sales and marketing performance, I built an interactive Power BI dashboard using the same data.
The dashboard provides a comprehensive view of revenue trends, product performance, customer feedback, and marketing effectiveness.

<img width="3652" height="2112" alt="image" src="https://github.com/user-attachments/assets/64c5c528-99a3-40af-ba1f-c87ecc3534ca" />
<img width="3652" height="2112" alt="image" src="https://github.com/user-attachments/assets/eea16069-aba1-4758-af03-b23f152b5597" />
<img width="3652" height="2112" alt="image" src="https://github.com/user-attachments/assets/b31c9d06-e906-44ac-adf7-29ec668112dd" />
<img width="3652" height="2112" alt="image" src="https://github.com/user-attachments/assets/a282ff10-9965-4a05-a034-d03711e807b7" />



