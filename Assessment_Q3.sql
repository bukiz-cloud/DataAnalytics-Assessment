-- Identify active plans with no transactions in the last 365 days.

SELECT 
    plans.id AS plan_id,
    plans.owner_id,
    
    CASE 
        WHEN plans.is_regular_savings = 1 THEN 'Savings'
        WHEN plans.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS plan_type,
    
    MAX(savings.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE(), MAX(savings.transaction_date)) AS days_since_last_transaction

FROM plans_plan AS plans

LEFT JOIN savings_savingsaccount AS savings 
    ON plans.id = savings.plan_id

WHERE plans.is_deleted = 0 AND plans.is_archived = 0

GROUP BY plans.id, plans.owner_id, plan_type

HAVING last_transaction_date IS NOT NULL AND days_since_last_transaction > 365;
