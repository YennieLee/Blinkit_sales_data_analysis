# Blinkit_sales_data_analysis 🛒
> SQL-based data analysis and Power BI dashboard exploring Blinkit’s sales, marketing, and customer insights for data-driven decision-making.

<br><br><br>

## 🔍Overview

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e853935b-e46e-46aa-9ba5-fe6ea4d7df28" />

Blinkit is an online grocery delivery service in India, founded in 2013 and currently operating in over 153 cities (as of 2025).

This project focuses on **sales and marketing data analysis** for Blinkit, with the goal of identifying actionable business insights across **sales, product, customer, delivery, and marketing performance**.

The project consists of two main parts:

1. Explored the data to drive business insights and develop recommendations in product, sales, customer, delivery, and marketing aspect. 
2. Created an interactive Power BI dashboard using the same datasets to visualize business insights.

<br><br>

---

<br>

## 🗃️ About the Dataset

- **[Blinkit Sales Dataset](https://www.kaggle.com/datasets/akxiit/blinkit-sales-dataset?select=blinkit_inventory.csv)**
- Covers sales data from **March 2023 to November 2024**
- The dataset consists of eight tables, structured as follows:
  
  <img width="3320" height="1656" alt="image" src="https://github.com/user-attachments/assets/fe75a443-c202-484a-9913-6fac6c55c204" />
  
  1. orders – Basic information about each order
  2. order_items – Details of items included in each order
  3. products – List of products sold on Blinkit
  4. customers – Customer information for registered members
  5. customer_feedback – Customer feedback on purchased products
  6. delivery_performance – Delivery performance for each order
  7. marketing_performance – Performance metrics for marketing campaigns
  8. inventory – Daily stock information for each product

<br><br>

---

<br>

## 📈 Sales Insights

<img width="1531" height="640" alt="image" src="https://github.com/user-attachments/assets/36d4a154-311f-4351-9140-98c2dc6012c9" />

- The **average monthly sales revenue** from April 2023 to October 2024 is **INR 561.49K**. (March 2023 and November 2024 were excluded due to incomplete records.)
- Blinkit recorded the **highest sales in August 2023** and the **lowest in June 2023**.

<br>

<img width="2540" height="1067" alt="image" src="https://github.com/user-attachments/assets/09b06db9-6e1c-48eb-ac39-90964602592b" />

- **Order volume closely follows revenue trends**, indicating that revenue growth is primarily driven by order frequency rather than price changes.

<br>

<img width="2522" height="1066" alt="image" src="https://github.com/user-attachments/assets/7da44199-307b-4b0f-95fc-d8f4d3208ef0" />

- Monthly revenue growth shows **high volatility**, with repeated ups and downs over time.
- 💡 **Business implication:** Implementing more consistent promotional strategies may help stabilize revenue and support sustained growth.

<br><br>

---

<br>

## 🧴 Product Insights

<img width="1582" height="638" alt="image" src="https://github.com/user-attachments/assets/0f0f5392-0b2b-47c2-acb0-54d77d645737" />

- Among 11 categories, **Dairy & Breakfast, Pharmacy, and Fruits & Vegetables** are the **top three revenue contributors**.
- The **top five products by revenue** include baby food, mangoes, bread, and vitamins across two brands.
- 💡 **Recommendation:** “Buy 2 Get 1 Free” promotions for **supplements and breakfast products** could increase basket size and overall profitability.

<br><br>

---

<br>

## 👤 Customer Insights

<img width="1511" height="544" alt="image" src="https://github.com/user-attachments/assets/7a940632-f3a7-4af6-be1f-57b6008454eb" />

- Customers are segmented into four groups: **New, Regular, Premium, and Inactive**.
- Each segment represents a similar share of the customer base (**24–25.5%**).
- **Average Order Value (AOV)** is slightly higher among **new customers**.
- 💡 **Recommendation:** Offering discounts or free delivery for new customers who exceed a spending threshold could further increase AOV and total revenue.

<br><br>

---

<br>

## 🚚 Delivery Insights

<img width="1578" height="595" alt="image" src="https://github.com/user-attachments/assets/46669359-4c8c-49ca-8abd-9593b9b32019" />

- The **average delivery time** is **19 minutes**.
- **70% of orders** are delivered on time, **20% slightly late**, and **10% late**.
- Delivery time is **not strongly affected by distance**, suggesting operational rather than geographic constraints.

<br>

<img width="1456" height="443" alt="image" src="https://github.com/user-attachments/assets/5e8c295b-b80a-482e-80de-fb58fa5b9eb3" />

- Cities with the **highest on-time delivery rates** include Visakhapatnam, Thiruvananthapuram, Gandhidham, Berhampur, and Jamnagar. These cities benefit from **strong infrastructure and logistics accessibility**.
- Cities with the **lowest on-time delivery rates** include Sonipat, Thoothukudi, Bijapur, Anantapur, Bulandshahr, and Agra. These are mostly **tier-2 and tier-3 cities**, where rider availability and navigation accuracy may be limited.
- 💡 **Recommendation:** Increasing delivery partner availability in underperforming cities could improve on-time delivery rates.

<br><br>

---

<br>

## 📢 Marketing Insights

<p align="center">
  <img src="https://github.com/user-attachments/assets/7368a2c0-b3ae-4e4e-b4a4-03d2f5d3c3df" alt="image1" width="850">
</p>

- Blinkit runs multiple marketing campaigns, including **email campaigns referral program and weekend sales**.
- Among nine campaign types, **email campaigns show the highest ROAS**, while **category promotions show the lowest overall ROAS**.

<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/8bb841cb-64c0-43cb-ac50-eb45d90dcebd" alt="image1" width="800">
</p>

- Campaign performance varies significantly by **channel and customer target audience**.
- For example, category promotions achieve a **ROAS of 3.0** when targeting new users via email, but only **2.3** when delivered through the app.
- 💡 **Recommendation:** Optimizing campaign-channel combinations can significantly improve marketing efficiency.

<br><br>

---

<br>

## 📊Power BI Dashboard

To visualize sales and marketing performance, I built an interactive [Power BI dashboard](https://app.powerbi.com/view?r=eyJrIjoiOTI3ZGZhYzgtYmU5OS00NmRjLWE1ZDYtNDQxYTllNThjYTY0IiwidCI6ImM2ZmU1ZDQwLTYwNWEtNGE3My05M2FmLTljYmFiZGZlN2UxOSJ9) using the same data.
The dashboard provides a comprehensive view of revenue trends, product performance, customer feedback, and marketing effectiveness.

<img width="4998" height="2851" alt="image" src="https://github.com/user-attachments/assets/26c73051-3b03-4f61-8a08-af8f6cc44aeb" />
<img width="4998" height="2851" alt="image" src="https://github.com/user-attachments/assets/1eaa7d89-1d8c-4804-910b-b8dbaa8ac34d" />
<img width="4998" height="2851" alt="image" src="https://github.com/user-attachments/assets/67010d65-dfa4-486f-8c02-66a00227f35e" />
<img width="4998" height="2851" alt="image" src="https://github.com/user-attachments/assets/e6c3c392-aa54-45ef-9596-84f5ff0899f9" />




