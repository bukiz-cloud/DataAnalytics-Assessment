-- Categorize customers by average number of monthly transactions.

WITH transaction_summary AS (
    SELECT 
        savings.owner_id,
        COUNT(*) AS total_transaction_count,
        DATEDIFF(MAX(savings.transaction_date), MIN(savings.transaction_date)) / 30.0 AS active_months
    FROM savings_savingsaccount AS savings
    GROUP BY savings.owner_id
),

transaction_frequency AS (
    SELECT 
        transaction_summary.owner_id,
        ROUND(transaction_summary.total_transaction_count / NULLIF(transaction_summary.active_months, 0), 2) AS average_transactions_per_month
    FROM transaction_summary
),

categorized_customers AS (
    SELECT 
        CASE 
            WHEN average_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN average_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        average_transactions_per_month
    FROM transaction_frequency
)

SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(average_transactions_per_month), 1) AS average_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category;
