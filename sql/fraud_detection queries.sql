CREATE TABLE transactions (
    trans_date_trans_time TIMESTAMP,
    merchant VARCHAR(255),
    category VARCHAR(100),
    amt NUMERIC(10, 2),
    gender CHAR(1),
    city VARCHAR(100),
    state CHAR(2),
    zip VARCHAR(10),
    lat NUMERIC(9, 6),
    long NUMERIC(9, 6),
    city_pop INT,
    job VARCHAR(255),
    dob DATE,
    merch_lat NUMERIC(9, 6),
    merch_long NUMERIC(9, 6),
    is_fraud SMALLINT,
    trans_hour INT,
    trans_day VARCHAR(20),
    trans_month VARCHAR(20),
    trans_year INT,
    age INT,
    age_group VARCHAR(10)
);
SELECT COUNT(*) AS total_transactions,
    SUM(is_fraud) AS total_fraud_cases,
    COUNT(*) - SUM(is_fraud) AS total_legit_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_percentage,
    ROUND(SUM(amt), 2) AS total_amount_processed,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount
FROM transactions;
SELECT category,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount,
    ROUND(
        AVG(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS avg_fraud_amount
FROM transactions
GROUP BY category
ORDER BY fraud_rate_pct DESC;
SELECT trans_hour,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount
FROM transactions
GROUP BY trans_hour
ORDER BY trans_hour;
SELECT trans_day,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount
FROM transactions
GROUP BY trans_day
ORDER BY fraud_cases DESC;
SELECT trans_month,
    trans_year,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount
FROM transactions
GROUP BY trans_month,
    trans_year
ORDER BY trans_year,
    fraud_cases DESC;
SELECT state,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount,
    ROUND(
        AVG(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS avg_fraud_amount
FROM transactions
GROUP BY state
ORDER BY fraud_cases DESC
LIMIT 15;
SELECT CASE
        WHEN gender = 'M' THEN 'Male'
        WHEN gender = 'F' THEN 'Female'
    END AS gender,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount,
    ROUND(
        AVG(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS avg_fraud_amount
FROM transactions
GROUP BY gender
ORDER BY fraud_cases DESC;
SELECT age_group,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount,
    ROUND(
        AVG(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS avg_fraud_amount
FROM transactions
GROUP BY age_group
ORDER BY fraud_rate_pct DESC;
SELECT is_fraud,
    CASE
        WHEN is_fraud = 1 THEN 'Fraud'
        ELSE 'Legitimate'
    END AS transaction_type,
    COUNT(*) AS total_transactions,
    ROUND(MIN(amt), 2) AS min_amount,
    ROUND(MAX(amt), 2) AS max_amount,
    ROUND(AVG(amt), 2) AS avg_amount,
    ROUND(
        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY amt
        )::NUMERIC,
        2
    ) AS median_amount,
    ROUND(SUM(amt), 2) AS total_amount
FROM transactions
GROUP BY is_fraud
ORDER BY is_fraud;
SELECT merchant,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount
FROM transactions
GROUP BY merchant
ORDER BY fraud_cases DESC
LIMIT 15;
SELECT category,
    trans_hour,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount
FROM transactions
GROUP BY category,
    trans_hour
HAVING SUM(is_fraud) > 0
ORDER BY fraud_rate_pct DESC
LIMIT 20;
SELECT CASE
        WHEN city_pop < 1000 THEN 'Very Small (<1k)'
        WHEN city_pop < 10000 THEN 'Small (1k-10k)'
        WHEN city_pop < 100000 THEN 'Medium (10k-100k)'
        WHEN city_pop < 500000 THEN 'Large (100k-500k)'
        ELSE 'Very Large (500k+)'
    END AS city_size,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_cases,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(
        SUM(
            CASE
                WHEN is_fraud = 1 THEN amt
            END
        ),
        2
    ) AS total_fraud_amount
FROM transactions
GROUP BY city_size
ORDER BY fraud_rate_pct DESC;