# E-Commerce Marketing Conversion Analytics Project using SQL, Python and Power BI

## Overview

This project analyzes a multi-table toy store e-commerce dataset using SQL, Python, and Power BI to uncover insights on marketing performance, customer behavior, and sales trends. It focuses on conversion rates, traffic sources, product performance, and refund patterns. The project demonstrates strong skills in data cleaning, joins, aggregations, and business-focused analysis to improve revenue and marketing ROI.


## Dataset Schema

The project includes six main tables:

- website_sessions: User session data (session ID, traffic source, campaign, device type, timestamps).
- website_pageviews: Page level user activity (page URLs, session ID, timestamps).
- orders: Order level data (order ID, session ID, order date, revenue).
- order_items: Product level details within each order (product ID, price, quantity).
- products: Product information (product name, category, price, launch date).
- order_item_refunds: Refund data (refunded items, refund amount, refund date).

## Tools Used

- Python for EDA and data cleaning
- SQL for data analysis
- Power BI for dashboard visualization

## Explore the Data

**Goal:** Conduct an initial data exploration to understand data distribution, check column names, types, and identify potential issues.
**Analysis:** Use functions like .info(), .describe(), and .head() to get a quick overview of the data structure and statistics.

 
## Data Cleaning

Handle Missing Values: Drop rows or columns with missing values if they are insignificant; fill values where essential.
Fix Data Types: Ensure all columns have consistent data types (e.g., dates as datetime.
Date Formatting: Use .datetime() to handle and format date values for analysis.
Validation: Check for any remaining inconsistencies and verify the cleaned data.

##  Load Data into PostgreSQL

Set Up Connection: Connect to PostgreSQL using sqlalchemy and load the cleaned data into each database.
Table Creation: Set up tables in PostgreSQL using Python SQLAlchemy to automate table creation and data insertion.
Verification: Run initial SQL queries to confirm that the data has been loaded accurately.


## SQL Analysis: Complex Queries and Business Problem Solving

Business Problem-Solving: Write and execute complex SQL queries to answer critical business questions, such as:

- Analyzing traffic sources performance (sessions, orders, conversion rates by UTM channels).
- Measuring conversion funnel efficiency (session → pageview → order drop-offs).
- Evaluating revenue trends across products and time periods.
- Identifying best-selling and underperforming products based on sales and revenue.
- Calculating key metrics like conversion rate, average order value (AOV), and revenue per session.
- Analyzing customer behavior patterns across devices (desktop vs mobile).
- Detecting high refund rate products and potential quality issues.
- Performing end-to-end funnel analysis from traffic acquisition to final purchase and refunds.

## Power BI Dashboard



👉 [E-comm Power BI Dashboard](E-Commerce-Marketing-Conversion-Analytics-Project/blob/main/Ecommerce%20marketing%20dashboard.pdf)

Key visuals include:

1. Executive Overview
2. Marketing Performance
3. Customer Behaviour & Product Insights


## Results and Insights

- The website recorded 390K sessions and 40K orders, with an overall conversion rate of 10.27%.
- Total revenue generated was approximately 1.9M, driven primarily by high-traffic marketing channels.
- Google Search (gsearch) contributed the most with 316K sessions, 1,154 orders, and 57K revenue.
- The top product, “The Original Mr. Fuzzy,” generated 1.2M revenue, significantly higher than other products.

