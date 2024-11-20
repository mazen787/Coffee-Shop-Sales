-- Select all columns from the Coffee_Sales table
SELECT * 
FROM Coffee_Sales;

-- Update transaction_date to convert it to a standard date format (DD/MM/YYYY)
UPDATE Coffee_Sales
SET transaction_date = CONVERT(DATE, transaction_date, 103);

-- Change the data type of transaction_date to DATE
ALTER TABLE Coffee_Sales
ALTER COLUMN transaction_date DATE;

-- Extract only the time part from transaction_time
SELECT LEFT(CAST(transaction_time AS VARCHAR), 8) AS time_only
FROM Coffee_Sales;

-- Add a new column to store only the time portion
ALTER TABLE Coffee_Sales
ADD time_only VARCHAR(8);

-- Populate the new time_only column with the extracted time
UPDATE Coffee_Sales
SET time_only = LEFT(CAST(transaction_time AS VARCHAR), 8);

-- Drop the original transaction_time column
ALTER TABLE Coffee_Sales
DROP COLUMN transaction_time;

-- Rename the time_only column back to transaction_time
EXEC sp_rename 'Coffee_Sales.time_only', 'transaction_time', 'COLUMN';

-- Get metadata information about the Coffee_Sales table
EXEC sp_help Coffee_Sales;

-- Calculate the total sales for May (month = 5)
SELECT ROUND(SUM(transaction_qty * unit_price), 0) AS Total_Sales
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5;

-- Calculate month-over-month (MoM) sales increase percentage for April and May
SELECT 
    MONTH(transaction_date) AS month,
    ROUND(SUM(unit_price * transaction_qty), 0) AS total_sales,
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1) 
     OVER (ORDER BY MONTH(transaction_date))) / NULLIF(LAG(SUM(unit_price * transaction_qty), 1) 
     OVER (ORDER BY MONTH(transaction_date)), 0) * 100 AS mom_increase_percentage
FROM Coffee_Sales
WHERE MONTH(transaction_date) IN (4, 5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

-- Count the total number of orders in May (month = 5)
SELECT COUNT(transaction_id) AS Total_Orders
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5;

-- Calculate MoM percentage change in total orders for April and May
SELECT 
    MONTH(transaction_date) AS month,
    COUNT(transaction_id) AS Total_Orders,
    (COUNT(transaction_id) - LAG(COUNT(transaction_id)) 
     OVER (ORDER BY MONTH(transaction_date))) * 100.0 / NULLIF(LAG(COUNT(transaction_id)) 
     OVER (ORDER BY MONTH(transaction_date)), 0) AS mom_increase_percentage
FROM Coffee_Sales
WHERE MONTH(transaction_date) IN (4, 5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

-- Calculate the total quantity sold in May (month = 5)
SELECT SUM(transaction_qty) AS Total_quantity
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5;

-- Calculate MoM percentage change in total quantity sold for April and May
SELECT 
    MONTH(transaction_date) AS month,
    SUM(transaction_qty) AS total_quantity_sold,
    (SUM(transaction_qty) - LAG(SUM(transaction_qty), 1) 
     OVER (ORDER BY MONTH(transaction_date))) * 100 / NULLIF(LAG(SUM(transaction_qty), 1) 
     OVER (ORDER BY MONTH(transaction_date)), 0) AS mom_increase_percentage
FROM Coffee_Sales
WHERE MONTH(transaction_date) IN (4, 5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

-- Get total sales, quantity sold, and total orders for a specific date
SELECT
    SUM(unit_price * transaction_qty) AS total_sales,
    SUM(transaction_qty) AS total_quantity_sold,
    COUNT(transaction_id) AS total_orders
FROM Coffee_Sales
WHERE transaction_date = '2023-05-18';

-- Format the result in 'K' for thousands for a specific date
SELECT 
    CONCAT(CAST(ROUND(SUM(unit_price * transaction_qty) / 1000.0, 1) AS VARCHAR(10)), 'K') AS total_sales,
    CONCAT(CAST(ROUND(COUNT(transaction_id) / 1000.0, 1) AS VARCHAR(10)), 'K') AS total_orders,
    CONCAT(CAST(ROUND(SUM(transaction_qty) / 1000.0, 1) AS VARCHAR(10)), 'K') AS total_quantity_sold
FROM Coffee_Sales
WHERE transaction_date = '2023-05-18';

-- Calculate the average sales for May
SELECT AVG(total_sales) AS Avg_sales
FROM (
    SELECT SUM(unit_price * transaction_qty) AS total_sales
    FROM Coffee_Sales
    WHERE MONTH(transaction_date) = 5
    GROUP BY transaction_date
) AS nested_query;

-- Calculate daily total sales for May and order by day
SELECT 
    DAY(transaction_date) AS day, 
    ROUND(SUM(transaction_qty * unit_price), 1) AS total_sales
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5
GROUP BY DAY(transaction_date)
ORDER BY DAY(transaction_date);

-- Determine whether daily sales are above, below, or average
SELECT The_day, total_sales,
    CASE
        WHEN total_sales < average_sales THEN 'below average'
        WHEN total_sales > average_sales THEN 'above average'
        ELSE 'average'
    END AS sales_status
FROM (
    SELECT 
        DAY(transaction_date) AS The_day, 
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER() AS average_sales
    FROM Coffee_Sales
    WHERE MONTH(transaction_date) = 5
    GROUP BY DAY(transaction_date)
) AS data_sales
ORDER BY The_day;

-- Calculate total sales for weekdays vs weekends
SELECT 
    CASE
        WHEN DATEPART(WEEKDAY, transaction_date) IN (1, 7) THEN 'weekend'
        ELSE 'weekday'
    END AS day_type, 
    ROUND(SUM(unit_price * transaction_qty), 2) AS total_sales
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5
GROUP BY CASE
    WHEN DATEPART(WEEKDAY, transaction_date) IN (1, 7) THEN 'weekend'
    ELSE 'weekday'
END;

-- Calculate total sales by store location for May
SELECT 
    store_location, 
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_sales
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5
GROUP BY store_location
ORDER BY total_sales;

-- Calculate total sales by product category for May
SELECT 
    product_category, 
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_sales
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_category
ORDER BY total_sales DESC;

-- Top 10 product types by sales for May
SELECT TOP 10 
    product_type,
    ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales 
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC;

-- Analyze sales for a specific weekday and hour in May
SELECT 
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_sales,
    SUM(transaction_qty) AS total_qty,
    COUNT(*) AS total_orders
FROM Coffee_Sales
WHERE DATEPART(WEEKDAY, transaction_date) = 3
AND DATEPART(HOUR, transaction_time) = 8
AND MONTH(transaction_date) = 5;

-- Calculate total sales by day of the week for May
SELECT 
    CASE 
        WHEN DATEPART(WEEKDAY, transaction_date) = 2 THEN 'Monday'
        WHEN DATEPART(WEEKDAY, transaction_date) = 3 THEN 'Tuesday'
        WHEN DATEPART(WEEKDAY, transaction_date) = 4 THEN 'Wednesday'
        WHEN DATEPART(WEEKDAY, transaction_date) = 5 THEN 'Thursday'
        WHEN DATEPART(WEEKDAY, transaction_date) = 6 THEN 'Friday'
        WHEN DATEPART(WEEKDAY, transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty), 0) AS Total_Sales
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5
GROUP BY CASE 
    WHEN DATEPART(WEEKDAY, transaction_date) = 2 THEN 'Monday'
    WHEN DATEPART(WEEKDAY, transaction_date) = 3 THEN 'Tuesday'
    WHEN DATEPART(WEEKDAY, transaction_date) = 4 THEN 'Wednesday'
    WHEN DATEPART(WEEKDAY, transaction_date) = 5 THEN 'Thursday'
    WHEN DATEPART(WEEKDAY, transaction_date) = 6 THEN 'Friday'
    WHEN DATEPART(WEEKDAY, transaction_date) = 7 THEN 'Saturday'
    ELSE 'Sunday'
END;

-- Calculate total sales by hour of the day for May
SELECT 
    DATEPART(HOUR, transaction_time) AS Hour_of_Day,
    ROUND(SUM(unit_price * transaction_qty), 0) AS Total_Sales
FROM Coffee_Sales
WHERE MONTH(transaction_date) = 5
GROUP BY DATEPART(HOUR, transaction_time)
ORDER BY DATEPART(HOUR, transaction_time);
