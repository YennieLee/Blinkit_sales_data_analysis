# Blinkit_sales_data_analysis 🛒
> SQL-based data analysis and Power BI dashboard exploring Blinkit’s sales, marketing, and customer insights for data-driven decision-making.<br>


</br>

## 🔍Overview

This project is a sales and marketing data analysis of Blinkit, an online grocery delivery app in India.

I performed exploratory data analysis (EDA) on key areas including sales, products, customers, marketing, and delivery using SQL.
I also created an interactive Power BI dashboard using the same datasets to visualize business insights. <br>



</br>

## 🗃️About the Dataset

The [dataset](https://www.kaggle.com/datasets/akxiit/blinkit-sales-dataset?select=blinkit_inventory.csv) consists of eight tables, structured as follows:

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

- Insight
  - The top 5 products were baby food, mangoes, bread, and vitamins from two different brands.
  - Interestingly, 2 out of the top 5 were vitamins, suggesting that promoting supplements could further increase profit.
  
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

- Insight
  - Since the dataset did not include complete data for March 2023, the growth rate in April appears overstated.
  - The average monthly growth gap was around 10%, which is relatively high.
  - Implementing consistent promotions could help stabilize sales and maintain steady growth. 


### 👥Customer Analysis
- Which **customer segment** generated the highest revenue?
  
  ```
  SELECT c.customer_segment, avg(o.order_total) AS revenue
  FROM orders AS o 
  RIGHT OUTER JOIN customers AS c
  ON o.customer_id = c.customer_id
  GROUP BY c.customer_segment
  ORDER BY revenue DESC;
  ```
- Result :
  
  <img width="524" height="136" alt="image" src="https://github.com/user-attachments/assets/f5ad281b-af63-4bc2-8ee7-9409446ca40a" />


- Insight :
  - Among the four customer segments, newly registered customers showed the highest average order value (AOV).
  - If Blinkit offers discounts or free delivery promotions for new customers who spend above a certain amount, it could further increase both AOV and total sales.


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

- Insight
  - The on-time delivery ratio varied significantly across regions but tended to be higher in coastal areas — the top 5 regions for delivery performance were all located near the coast.


### 📣Marketing & Campaign Insights
- Which **campaign** generated the **highest ROAS**?
  
  ```
  SELECT campaign_name, target_audience, channel, avg(roas) AS roas_avg
  FROM marketing_performance
  GROUP BY campaign_name, target_audience, channel
  ORDER BY campaign_name, roas_avg DESC;
  ```
- Result :
  
  <img width="567" height="62" alt="image" src="https://github.com/user-attachments/assets/ea017833-b63a-4508-9b71-8433deab4bd7" />
  <img width="564" height="30" alt="image" src="https://github.com/user-attachments/assets/bb474b19-4681-424c-b37a-7e82746fc1a1" />

- Insight
  - The Return on Ad Spend (ROAS) analysis highlights the importance of selecting the right target audience and marketing channel.
  - For example, when category promotions were run via Email targeting new users, the average ROAS was around 3.0.
  - However, the same promotion through the App for the same audience resulted in a lower ROAS of about 2.3, showing how channel choice directly impacts marketing efficiency.
 <br>



</br>

## 📊Power BI Dashboard

To visualize sales and marketing performance, I built an interactive [Power BI dashboard](https://app.powerbi.com/view?r=eyJrIjoiOTI3ZGZhYzgtYmU5OS00NmRjLWE1ZDYtNDQxYTllNThjYTY0IiwidCI6ImM2ZmU1ZDQwLTYwNWEtNGE3My05M2FmLTljYmFiZGZlN2UxOSJ9) using the same data.
The dashboard provides a comprehensive view of revenue trends, product performance, customer feedback, and marketing effectiveness.

<img width="4998" height="2851" alt="image" src="https://github.com/user-attachments/assets/26c73051-3b03-4f61-8a08-af8f6cc44aeb" />
<img width="4998" height="2851" alt="image" src="https://github.com/user-attachments/assets/1eaa7d89-1d8c-4804-910b-b8dbaa8ac34d" />
<img width="4998" height="2851" alt="image" src="https://github.com/user-attachments/assets/67010d65-dfa4-486f-8c02-66a00227f35e" />
<img width="4998" height="2851" alt="image" src="https://github.com/user-attachments/assets/e6c3c392-aa54-45ef-9596-84f5ff0899f9" />




