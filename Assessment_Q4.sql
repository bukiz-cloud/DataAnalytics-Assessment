-- Estimate customer lifetime value based on tenure and transaction volume.

WITH transaction_data AS (
    SELECT 
        savings.owner_id,
        COUNT(*) AS total_transaction_count,
        SUM(savings.confirmed_amount) AS total_transaction_value_kobo
    FROM savings_savingsaccount AS savings
    GROUP BY savings.owner_id
),

tenure_data AS (
    SELECT 
        users.id AS customer_id,
        users.name AS full_name,
        TIMESTAMPDIFF(MONTH, users.date_joined, CURRENT_DATE()) AS account_tenure_months
    FROM users_customuser AS users
),

combined_metrics AS (
    SELECT 
        tenure_data.customer_id,
        tenure_data.full_name,
        tenure_data.account_tenure_months,
        COALESCE(transaction_data.total_transaction_count, 0) AS total_transactions,
        COALESCE(transaction_data.total_transaction_value_kobo, 0) / 100.0 AS total_transaction_value_naira
    FROM tenure_data
    LEFT JOIN transaction_data 
        ON tenure_data.customer_id = transaction_data.owner_id
)

SELECT 
    customer_id,
    full_name,
    account_tenure_months,
    total_transactions,
    
    ROUND((
        total_transactions / NULLIF(account_tenure_months, 0)
    ) * 12 * (
        total_transaction_value_naira / NULLIF(total_transactions, 0) * 0.001
    ), 2) AS estimated_clv_naira

FROM combined_metrics

WHERE total_transactions > 0

ORDER BY estimated_clv_naira DESC;
