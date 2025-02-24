-- Sales Trends 
-- 1.	What is the total sales revenue per Year?
SELECT 
    SUM(payment_value) AS Total_Revenue,
    YEAR(order_purchase_timestamp) AS Year
FROM
    olist_sales
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY Year DESC
;
SELECT 
    SUM(payment_value) AS Total_Revenue
FROM
    olist_sales
    ;

-- 1b .What is the total sales revenue per month of each  Year?   
SELECT 
    EXTRACT(YEAR FROM order_purchase_timestamp) AS Year,
    MONTHNAME(order_purchase_timestamp) AS Month,
    SUM(payment_value) AS Total_Revenue
FROM
    olist_sales
GROUP BY Year , Month , MONTH(order_purchase_timestamp)
ORDER BY Year DESC , MONTH(order_purchase_timestamp)

; 
-- 2.	Which product categories generate the highest revenue?
SELECT 
    product_category_name AS Product_Category,
    SUM(payment_value) AS Revenue
FROM
    olist_sales
GROUP BY Product_Category
ORDER BY Revenue DESC
LIMIT 1
;

-- 3.	How do sales vary across different states/regions?
#Renaming the states

SELECT distinct
    CASE 
        WHEN customer_state = 'SP' THEN 'São Paulo'
        WHEN customer_state = 'BA' THEN 'Bahia'
        WHEN customer_state = 'GO' THEN 'Goiás'
        WHEN customer_state = 'RN' THEN 'Rio Grande do Norte'
        WHEN customer_state = 'PR' THEN 'Paraná'
        WHEN customer_state = 'RJ' THEN 'Rio de Janeiro'
        WHEN customer_state = 'RS' THEN 'Rio Grande do Sul'
        WHEN customer_state = 'MG' THEN 'Minas Gerais'
        WHEN customer_state = 'SC' THEN 'Santa Catarina'
        WHEN customer_state = 'RR' THEN 'Roraima'
        WHEN customer_state = 'PE' THEN 'Pernambuco'
        WHEN customer_state = 'TO' THEN 'Tocantins'
        WHEN customer_state = 'CE' THEN 'Ceará'
        WHEN customer_state = 'DF' THEN 'Distrito Federal'
        WHEN customer_state = 'SE' THEN 'Sergipe'
        WHEN customer_state = 'MT' THEN 'Mato Grosso'
        WHEN customer_state = 'PB' THEN 'Paraíba'
        WHEN customer_state = 'PA' THEN 'Pará'
        WHEN customer_state = 'RO' THEN 'Rondônia'
        WHEN customer_state = 'ES' THEN 'Espírito Santo'
        WHEN customer_state = 'AP' THEN 'Amapá'
        WHEN customer_state = 'MS' THEN 'Mato Grosso do Sul'
        WHEN customer_state = 'MA' THEN 'Maranhão'
        WHEN customer_state = 'PI' THEN 'Piauí'
        WHEN customer_state = 'AL' THEN 'Alagoas'
        WHEN customer_state = 'AC' THEN 'Acre'
        WHEN customer_state = 'AM' THEN 'Amazonas'
        ELSE customer_state
    END AS customer_state_full,
    SUM(payment_value) AS total_revenue
FROM olist_sales
GROUP BY customer_state
ORDER BY total_revenue DESC;

# 4 a Total of Sales by Payment Type?
SELECT 
    payment_type, SUM(payment_value) AS Total_Sales
FROM
    olist_sales
GROUP BY payment_type
;

# 4️ Distribution of Sales by Payment Type
SELECT 
    payment_type,
    COUNT(*) AS Payment_Count,
    SUM(payment_value) AS Total_sales
FROM
    olist_sales
GROUP BY payment_type
;

# 5 Average  Price Per Product Category 
SELECT 
   product_category_name, avg(price) as Average_Price
FROM
    olist_sales
    group by product_category_name
;

#Customer Behavior
# 1 Most Frequent Buyers
SELECT 
    customer_id, COUNT(customer_id) Count
FROM
    olist_sales
GROUP BY customer_id
ORDER BY Count DESC
;
# Average Number of Orders Per Customer
SELECT 
    AVG(Orders) AS Average_Orders_per_Customer
FROM
    (SELECT 
        customer_id, COUNT(order_id) AS Orders
    FROM
        olist_sales
    GROUP BY customer_id) sub
;


#Average Spend Per Customer
SELECT 
    customer_id, avg(payment_value) AS Avg_Spent
FROM
    olist_sales
GROUP BY customer_id
ORDER BY Avg_Spent DESC
;


#Cities With the Most Active Customers

SELECT 
    customer_city,
    COUNT(DISTINCT customer_id) AS Total_Customers
FROM
    olist_sales
GROUP BY customer_city
ORDER BY Total_Customers DESC
LIMIT 10
;

# Product Performance
# Best-Selling Products
SELECT 
    product_category_name,
    product_id,
    COUNT(order_id) AS Products_Sold
FROM
    olist_sales
GROUP BY product_id,product_category_name
ORDER BY Products_sold DESC
LIMIT 10
;

# Product Categories With the Most Orders
SELECT 
    product_category_name, COUNT(order_id) Orders_Count
FROM
    olist_sales
GROUP BY product_category_name
ORDER BY orders_Count DESC
LIMIT 10;

#  Price Impact on Product Demand
SELECT 
    price, 
    COUNT(order_id) AS total_orders
FROM olist_sales
GROUP BY price
ORDER BY total_orders DESC
LIMIT 10;

# Least-Selling Products

SELECT 
    product_id, COUNT(order_item_id) AS Total_sold
FROM
    olist_sales
GROUP BY product_id
ORDER BY Total_sold ASC

;

# Seller Performance
#Sellers Generating the Highest Revenue
SELECT 
    seller_id, 
    SUM(payment_value) AS total_revenue
FROM olist_sales
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

#Total Average Revenue Per Seller
SELECT 
    AVG(total_revenue) AS avg_revenue_per_seller
FROM (
    SELECT 
        seller_id, 
        SUM(payment_value) AS total_revenue
    FROM olist_sales
  
    GROUP BY seller_id
) sub;

#Sellers With the Highest Order Volume
SELECT 
    seller_id, 
    COUNT(order_id) AS total_orders
FROM olist_sales
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 10;

#Top-selling products for each seller:
SELECT 
    seller_id, 
    product_id, 
    COUNT(order_item_id) AS total_sales
FROM olist_sales
GROUP BY seller_id, product_id
ORDER BY total_sales DESC
LIMIT 10;

 # Impact of seller location on sales:
 SELECT 
    CASE 
        WHEN seller_state = 'SP' THEN 'São Paulo'
        WHEN seller_state = 'BA' THEN 'Bahia'
        WHEN seller_state = 'GO' THEN 'Goiás'
        WHEN seller_state = 'RN' THEN 'Rio Grande do Norte'
        WHEN seller_state = 'PR' THEN 'Paraná'
        WHEN seller_state = 'RJ' THEN 'Rio de Janeiro'
        WHEN seller_state = 'RS' THEN 'Rio Grande do Sul'
        WHEN seller_state = 'MG' THEN 'Minas Gerais'
        WHEN seller_state = 'SC' THEN 'Santa Catarina'
        WHEN seller_state = 'RR' THEN 'Roraima'
        WHEN seller_state = 'PE' THEN 'Pernambuco'
        WHEN seller_state = 'TO' THEN 'Tocantins'
        WHEN seller_state = 'CE' THEN 'Ceará'
        WHEN seller_state = 'DF' THEN 'Distrito Federal'
        WHEN seller_state = 'SE' THEN 'Sergipe'
        WHEN seller_state = 'MT' THEN 'Mato Grosso'
        WHEN seller_state = 'PB' THEN 'Paraíba'
        WHEN seller_state = 'PA' THEN 'Pará'
        WHEN seller_state = 'RO' THEN 'Rondônia'
        WHEN seller_state = 'ES' THEN 'Espírito Santo'
        WHEN seller_state = 'AP' THEN 'Amapá'
        WHEN seller_state = 'MS' THEN 'Mato Grosso do Sul'
        WHEN seller_state = 'MA' THEN 'Maranhão'
        WHEN seller_state = 'PI' THEN 'Piauí'
        WHEN seller_state = 'AL' THEN 'Alagoas'
        WHEN seller_state = 'AC' THEN 'Acre'
        WHEN seller_state = 'AM' THEN 'Amazonas'
        ELSE seller_state
    END AS Seller_State_full,
    SUM(payment_value) AS total_revenue
FROM olist_sales
GROUP BY seller_state
ORDER BY total_revenue DESC;


#Delivery Time Analysis
#Average delivery time
SELECT 
    AVG(order_delivered_customer_date - order_purchase_timestamp) AS avg_delivery_days
FROM olist_sales;


# Customer Satisfaction
#Product categories with most returns/cancellations:
SELECT 
    product_category_name, 
    COUNT(order_id) AS cancellations
FROM olist_sales
WHERE order_status = 'canceled'
GROUP BY product_category_name
ORDER BY cancellations DESC
LIMIT 10;


# Most common payment method:
SELECT 
    payment_type, 
    COUNT(order_id) AS total_orders
FROM olist_sales
GROUP BY payment_type
ORDER BY total_orders DESC;

# installments info
SELECT DISTINCT
    customer_city, customer_id, COUNT(payment_installments) AS installments
FROM
    olist_sales
GROUP BY customer_id,customer_city 
order by installments desc
;