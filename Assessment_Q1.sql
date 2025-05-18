-- Find customers with both a savings and investment plan, along with total deposits.

SELECT 
    users.id AS owner_id,
    users.name AS full_name,
    
    COUNT(DISTINCT CASE 
        WHEN plans.is_regular_savings = 1 THEN plans.id 
    END) AS savings_plan_count,
    
    COUNT(DISTINCT CASE 
        WHEN plans.is_a_fund = 1 THEN plans.id 
    END) AS investment_plan_count,
    
    ROUND(SUM(savings.confirmed_amount) / 100.0, 2) AS total_deposit_naira

FROM users_customuser AS users

JOIN plans_plan AS plans 
    ON users.id = plans.owner_id

JOIN savings_savingsaccount AS savings 
    ON plans.id = savings.plan_id

WHERE savings.confirmed_amount > 0

GROUP BY users.id, users.name

HAVING savings_plan_count > 0 AND investment_plan_count > 0

ORDER BY total_deposit_naira DESC;
