create database bank360;

DROP TABLE IF EXISTS bank_churn;

CREATE TABLE bank_churn (
    id INT PRIMARY KEY,              -- Unique ID for every row
    CustomerId INT,                  -- The Bank's internal ID
    Surname VARCHAR(100),            -- Variable text length
    CreditScore INT,                 -- Numerical Score
    Geography VARCHAR(50),           -- Country Name
    Gender VARCHAR(20),              -- Male/Female
    Age DECIMAL(5,2),                -- Handles ages like 36.44
    Tenure INT,                      -- How many years as customer
    Balance DECIMAL(15,2),           -- Precision money storage
    NumOfProducts INT,               -- Count of products
    HasCrCard INT,                   -- 1 = Yes, 0 = No
    IsActiveMember INT,              -- 1 = Yes, 0 = No
    EstimatedSalary DECIMAL(15,2),   -- Precision money storage
    Exited INT                       -- 1 = Churned, 0 = Stayed
);

ALTER TABLE bank_churn
ALTER COLUMN hascrcard TYPE NUMERIC;

ALTER TABLE bank_churn
ALTER COLUMN IsActiveMember TYPE NUMERIC;


COPY bank_churn
FROM 'C:/Program Files/PostgreSQL/18/data/train.csv'
DELIMITER ','
CSV HEADER;

select * from bank_churn limit 5;

SELECT COUNT(*) FROM bank_churn;


/* Level: Easy
   Goal: Compare churn rates between genders
*/
SELECT 
    Gender,
    COUNT(CustomerId) as Total_Customers,
    SUM(Exited) as Churned_Count,
    -- Calculate Percentage
    ROUND(SUM(Exited) * 100.0 / COUNT(CustomerId), 2) as Churn_Rate_Percent
FROM bank_churn
GROUP BY Gender;

/* Level: Intermediate
   Goal: Group Credit Scores into logical "Buckets" (Binning)
*/
SELECT 
    CASE 
        WHEN CreditScore < 500 THEN 'Very Low (<500)'
        WHEN CreditScore BETWEEN 500 AND 599 THEN 'Low (500-600)'
        WHEN CreditScore BETWEEN 600 AND 699 THEN 'Fair (600-700)'
        WHEN CreditScore BETWEEN 700 AND 799 THEN 'Good (700-800)'
        ELSE 'Excellent (>800)'
    END AS Credit_Bucket,
    COUNT(CustomerId) as Total_Customers,
    ROUND(AVG(Exited) * 100, 2) as Churn_Rate_Percent
FROM bank_churn
GROUP BY 
    CASE 
        WHEN CreditScore < 500 THEN 'Very Low (<500)'
        WHEN CreditScore BETWEEN 500 AND 599 THEN 'Low (500-600)'
        WHEN CreditScore BETWEEN 600 AND 699 THEN 'Fair (600-700)'
        WHEN CreditScore BETWEEN 700 AND 799 THEN 'Good (700-800)'
        ELSE 'Excellent (>800)'
    END
ORDER BY Churn_Rate_Percent DESC;


/* Level: Advanced
   Goal: Calculate "Contribution to Total Churn" using Window Functions
*/
WITH Geo_Stats AS (
    SELECT 
        Geography,
        SUM(Exited) as Country_Churned_Count
    FROM bank_churn
    GROUP BY Geography
)
SELECT 
    Geography,
    Country_Churned_Count,
    -- Advanced: Sum of ALL churned counts across the whole table
    SUM(Country_Churned_Count) OVER () as Global_Total_Churn,
    -- Calculation: Country / Global
    ROUND(
        Country_Churned_Count * 100.0 / SUM(Country_Churned_Count) OVER (), 
        2
    ) as Percent_Contribution_To_Global_Churn
FROM Geo_Stats
ORDER BY Percent_Contribution_To_Global_Churn DESC;



/* Problem: Analyze churn risk based on account balance segments.
   Technique: CTE (Common Table Expression) + Conditional Logic
*/
WITH Balance_Segments AS (
    SELECT 
        CASE 
            WHEN Balance = 0 THEN 'Zero Balance'
            WHEN Balance < 100000 THEN 'Low Balance'
            ELSE 'High Balance' -- > 100k
        END AS Balance_Category,
        Exited
    FROM bank_churn
)
SELECT 
    Balance_Category,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(CAST(SUM(Exited) AS NUMERIC) / COUNT(*) * 100, 2) AS Churn_Rate_Percent
FROM Balance_Segments
GROUP BY Balance_Category
ORDER BY Churn_Rate_Percent DESC;

/* Problem: Find the top 3 loyal active customers per country.
   Technique: Window Functions (ROW_NUMBER) with PARTITION
*/
WITH Ranked_Customers AS (
    SELECT 
        Surname,
        Geography,
        Tenure,
        Balance,
        CreditScore,
        -- Restart rank for each country, order by Tenure then Money
        ROW_NUMBER() OVER (
            PARTITION BY Geography 
            ORDER BY Tenure DESC, Balance DESC
        ) as Rank_In_Country
    FROM bank_churn
    WHERE IsActiveMember = 1 AND Exited = 0 -- Only active, non-churned
)
SELECT * FROM Ranked_Customers
WHERE Rank_In_Country <= 3;

/* Problem: Evaluate churn rate by number of products held.
   Technique: Aggregation & Calculated Rates
*/
SELECT 
    NumOfProducts,
    COUNT(*) as Total_Customers,
    SUM(Exited) as Churned,
    ROUND(CAST(SUM(Exited) AS NUMERIC) / COUNT(*) * 100, 2) as Churn_Rate
FROM bank_churn
GROUP BY NumOfProducts
ORDER BY NumOfProducts ASC;