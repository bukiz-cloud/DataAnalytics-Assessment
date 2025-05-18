# DataAnalytics-Assessment
This repository contains SQL queries developed to solve real-world business problems based on customer behavior, account activity, and financial performance insights. The challenges simulate analytical tasks in a fintech or banking environment, utilizing structured data from relational database tables.

Problem Statements & Business Context
1️ High-Value Customers with Multiple Products
Business Goal:
Identify customers who have both a funded savings plan and a funded investment plan to unlock cross-selling opportunities.

Query Objectives:

Filter users with at least one funded savings and one funded investment plan.

Calculate the total deposits per customer.

Sort results by highest total deposits.

Output Fields:
owner_id, name, savings_count, investment_count, total_deposits

2️Transaction Frequency Analysis
Business Goal:
Segment customers by how frequently they transact to drive engagement and personalization strategies.

Query Objectives:

Calculate average transactions per customer per month.

Categorize users into:

High Frequency (≥10 transactions/month)

Medium Frequency (3–9 transactions/month)

Low Frequency (≤2 transactions/month)

Output Fields:
frequency_category, customer_count, avg_transactions_per_month

3️ Account Inactivity Alert
Business Goal:
Identify active financial accounts that haven’t received inflow transactions in over a year to prompt retention or reactivation efforts.

Query Objectives:

Filter both savings and investment accounts with no inflow activity in the last 365 days.

Report last transaction date and number of inactive days.

Output Fields:
plan_id, owner_id, type, last_transaction_date, inactivity_days

4️ Customer Lifetime Value (CLV) Estimation
Business Goal:
Estimate the potential lifetime value of customers based on tenure and transaction history for better marketing ROI and retention decisions.

Query Objectives:

Calculate account tenure (in months) since signup.

Aggregate total transactions per customer.

Estimate CLV using the formula:

CLV = (Total Transactions ÷ Tenure) × 12 × Average Profit per Transaction

Where:

Average profit per transaction = 0.1% of transaction value.

Output Fields:
customer_id, name, tenure_months, total_transactions, estimated_clv


Tech Stack
SQL (MySQL)

Relational database schema with customer, savings, and plan tables

Best Practices Followed
Clear and readable SQL queries with meaningful aliases

Use of window functions, filtering, grouping, and subqueries where appropriate

Scalable and modular query design
