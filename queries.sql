
SELECT* 
FROM olist_orders_dataset
LIMIT 5;


SELECT SUM(payment_value) AS total_revenue
FROM olist_order_payments_dataset;


-- MONTHLY REVENUE--
SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) AS order_month,
    SUM(p.payment_value) AS monthly_revenue
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id
GROUP BY order_month
ORDER BY order_month;

--Top Customers by Spending--

SELECT 
    c.customer_unique_id,
    SUM(p.payment_value) AS total_spent
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;
---How many customers return vs buy once?”
SELECT 
    customer_unique_id,
    COUNT(order_id) AS order_count
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
GROUP BY customer_unique_id;

SELECT
    CASE 
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT 
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
GROUP BY customer_type;
--- Average Order Value---
SELECT 
    SUM(p.payment_value) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id;
