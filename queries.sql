DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date TEXT,
    transaction_amount REAL,
    merchant_category TEXT,
    transaction_type TEXT,
    city TEXT,
    state TEXT,
    device_type TEXT,
    payment_method TEXT,
    fraud_flag INT
);

INSERT INTO transactions VALUES
(1001,201,'2025-01-01',1500.00,'Electronics','Online','Mumbai','Maharashtra','Mobile','Credit Card',0),
(1002,202,'2025-01-01',25000.00,'Jewelry','POS','Delhi','Delhi','Desktop','Debit Card',1),
(1003,201,'2025-01-02',3000.00,'Travel','Online','Mumbai','Maharashtra','Mobile','UPI',0),
(1004,203,'2025-01-02',45000.00,'Luxury','Online','Bangalore','Karnataka','Tablet','Credit Card',1),
(1005,204,'2025-01-03',200.00,'Food','POS','Lucknow','UP','Mobile','UPI',0);

SELECT * FROM transactions;
-- =========================================
-- TOTAL TRANSACTIONS
-- =========================================

SELECT COUNT(*) AS total_transactions
FROM transactions;

-- =========================================
-- TOTAL FRAUDULENT TRANSACTIONS
-- =========================================

SELECT COUNT(*) AS fraudulent_transactions
FROM transactions
WHERE fraud_flag = 1;

-- =========================================
-- FRAUD PERCENTAGE
-- =========================================

SELECT ROUND(
    (SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
    2
) AS fraud_percentage
FROM transactions;

-- =========================================
-- TOP HIGH-RISK CITIES
-- =========================================

SELECT city,
       COUNT(*) AS fraud_cases
FROM transactions
WHERE fraud_flag = 1
GROUP BY city
ORDER BY fraud_cases DESC;

-- =========================================
-- HIGH VALUE TRANSACTIONS
-- =========================================

SELECT transaction_id,
       customer_id,
       transaction_amount
FROM transactions
WHERE transaction_amount > 20000
ORDER BY transaction_amount DESC;

-- =========================================
-- FRAUD BY PAYMENT METHOD
-- =========================================

SELECT payment_method,
       COUNT(*) AS fraud_cases
FROM transactions
WHERE fraud_flag = 1
GROUP BY payment_method
ORDER BY fraud_cases DESC;

-- =========================================
-- FRAUD BY DEVICE TYPE
-- =========================================

SELECT device_type,
       COUNT(*) AS fraud_cases
FROM transactions
WHERE fraud_flag = 1
GROUP BY device_type;

-- =========================================
-- MONTHLY FRAUD TREND
-- =========================================

SELECT strftime('%m', transaction_date) AS month,
       COUNT(*) AS fraud_cases
FROM transactions
WHERE fraud_flag = 1
GROUP BY strftime('%m', transaction_date)
ORDER BY month;

-- =========================================
-- TOP MERCHANT CATEGORIES WITH FRAUD
-- =========================================

SELECT merchant_category,
       COUNT(*) AS fraud_cases
FROM transactions
WHERE fraud_flag = 1
GROUP BY merchant_category
ORDER BY fraud_cases DESC;

-- =========================================
-- HIGHEST FRAUD TRANSACTION
-- =========================================

SELECT *
FROM transactions
WHERE fraud_flag = 1
ORDER BY transaction_amount DESC
LIMIT 1;