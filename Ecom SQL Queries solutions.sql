SELECT * FROM clean_sessions;
SELECT * FROM clean_pageviews;
SELECT * FROM clean_products;
SELECT * FROM clean_orders;
SELECT * FROM clean_order_items;
SELECT * FROM clean_refunds;

-- query solving data analysis --


-- How much traffic do we get? --

SELECT COUNT(*) AS total_sessions FROM clean_sessions;


-- Is traffic growing over time? --

SELECT DATE_TRUNC('month', created_at) AS month,
COUNT(*) AS sessions FROM clean_sessions
GROUP BY month
ORDER BY month;


-- Which channel brings the most traffic? --

SELECT utm_source AS channel,
COUNT(*) AS sessions FROM clean_sessions
GROUP BY channel
ORDER BY sessions DESC;


-- Which device customers are using the most?--
SELECT device_type AS device,
COUNT(*) AS sessions FROM clean_sessions
GROUP BY device
ORDER BY sessions DESC;


-- MARKETING PERFORMENCE --


-- How many purchases were made? --

SELECT COUNT(*) AS total_orders FROM clean_orders;


-- Which channel drives sales? --

SELECT s.utm_source AS channel,
COUNT(o.order_id) AS total_orders
FROM clean_sessions s
LEFT JOIN clean_orders o
ON s.website_session_id = o.website_session_id
GROUP BY channel
ORDER BY total_orders DESC;



--  Which marketing channel converts best? --

SELECT s.utm_source AS channel,
COUNT(DISTINCT o.order_id) * 100.0 /
COUNT(DISTINCT s.website_session_id) AS conversion_rate
FROM clean_sessions s
LEFT JOIN clean_orders o
ON s.website_session_id = o.website_session_id
GROUP BY channel
ORDER BY conversion_rate DESC;



-- Which channel generates the most revenue? --

SELECT s.utm_source AS channel,
SUM(oi.price_usd) AS total_revenue
FROM clean_sessions s
JOIN clean_orders o
ON s.website_session_id = o.website_session_id
JOIN clean_order_items oi
ON o.order_id = oi.order_id
GROUP BY channel
ORDER BY total_revenue DESC;


-- CUSTOMER BEHAVIOUR ANALYSIS --


-- What is the average number of pageviews per session? --

SELECT 
AVG(pageviews) AS avg_pageviews
FROM (
    SELECT 
    website_session_id,
    COUNT(*) AS pageviews
    FROM clean_pageviews
    GROUP BY website_session_id
) AS session_pageviews;



-- Which pages get the most traffic? --

SELECT 
pageview_url,
COUNT(*) AS total_views
FROM clean_pageviews
GROUP BY pageview_url
ORDER BY total_views DESC;



-- Which page is the most common landing page? --

SELECT pageview_url,
COUNT(*) AS sessions
FROM (
    SELECT 
    website_session_id,
    MIN(website_pageview_id) AS first_pageview
    FROM clean_pageviews
    GROUP BY website_session_id
) first_page
JOIN clean_pageviews wp
ON first_page.first_pageview = wp.website_pageview_id
GROUP BY pageview_url
ORDER BY sessions DESC;



-- How many pages do customers view before buying? --

SELECT 
AVG(pageviews) AS avg_pageviews_before_purchase
FROM (
    SELECT 
    wp.website_session_id,
    COUNT(*) AS pageviews
    FROM clean_pageviews wp
    JOIN clean_orders o
    ON wp.website_session_id = o.website_session_id
    GROUP BY wp.website_session_id
) AS purchase_sessions;


-- SALES & PRODUCT PERFORMANCE --

-- How much money did the company make? --

SELECT 
SUM(price_usd) AS total_revenue
FROM clean_order_items;



-- How much does a customer spend per order? --

SELECT 
AVG(order_total) AS average_order_value
FROM (
    SELECT 
    order_id,
    SUM(price_usd) AS order_total
    FROM clean_order_items
    GROUP BY order_id
) AS order_values;

-- Which product sells the most? --

SELECT p.product_name, oi.product_id,
COUNT(*) AS total_sales
FROM clean_order_items oi
JOIN clean_products p
ON oi.product_id = p. product_id
GROUP BY p. product_name, oi.product_id
ORDER BY total_sales DESC;



-- Which product generates the most revenue? --

SELECT 
p.product_name,
SUM(oi.price_usd) AS revenue
FROM clean_order_items oi
JOIN clean_products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;


-- Which products customers return most? --

SELECT p.product_name, oi.product_id,
COUNT(r.order_item_id) * 100.0 /
COUNT(oi.order_item_id) AS refund_rate
FROM clean_order_items oi
LEFT JOIN clean_refunds r
ON oi.order_item_id = r.order_item_id
LEFT JOIN clean_products p
ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_name
ORDER BY refund_rate DESC;

