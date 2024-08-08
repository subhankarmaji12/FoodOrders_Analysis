/* CREATE TABLE restaurant_orders (
	date DATE,
	vendor_id INT,
	chain_id INT,
	city_id INT,
	spec VARCHAR(255),
	successful_orders FLOAT,
	fail_orders FLOAT
);


-- Check Null Values
SELECT * FROM restaurant_orders
WHERE date is null OR vendor_id is null OR chain_id is null OR city_id is null OR spec is null OR successful_orders is null OR  fail_orders is null;

-- Remove or handle NULL Values
DELETE FROM restaurant_orders
WHERE date is null OR vendor_id is null OR chain_id is null OR city_id is null OR spec is null OR successful_orders is null OR  fail_orders is null;

-- Check for duplicate rows
DELETE FROM restaurant_orders WHERE city_id
NOT IN(
SELECT MIN(city_id)
FROM restaurant_orders GROUP BY date, vendor_id,
chain_id, city_id, spec, successful_orders, fail_orders
);
*/

-- Get The Total Orders Of Successful And Fail Orders
SELECT SUM(successful_orders) AS total_successful,
SUM(fail_orders) AS total_faild
FROM restaurant_orders;

-- Get The Number Of Restaurents Per Specialization
SELECT spec, COUNT(DISTINCT(vendor_id))AS num_restaurents
FROM restaurant_orders
GROUP BY spec;

-- Get The Total Number of Successful Orders and Faild Ordes Per City; 
SELECT city_id, 
SUM(successful_orders) AS total_successful,
SUM (fail_orders) AS total_faild
FROM restaurant_orders
GROUP BY city_id;

-- Get The Average Orders Per Day
SELECT date,
AVG(successful_orders+fail_orders) AS avg_orders
FROM restaurant_orders
GROUP BY date
ORDER BY date;

-- Get The Top 4 Cities By Total Orders

SELECT city_id,
SUM(successful_orders + fail_orders) AS total_orders
FROM restaurant_orders
GROUP BY city_id
ORDER BY total_orders
LIMIT 4;

-- Success Rate by Specilization 
SELECT spec,
SUM(successful_orders) AS total_successful,
SUM(fail_orders) AS total_faild,
(SUM(successful_orders) * 100 / (SUM(successful_orders) + SUM(fail_orders))) as success_rate
from restaurant_orders
GROUP BY spec;


--- Top 5 Chains by Success Rate

SELECT chain_id, 
SUM(successful_orders) AS total_successful, 
SUM(fail_orders) AS total_failed,
CASE 
WHEN SUM(successful_orders) + SUM(fail_orders) = 0 THEN 0
ELSE (SUM(successful_orders) * 100 / (SUM(successful_orders) + SUM(fail_orders)))
END AS success_rate
FROM restaurant_orders
GROUP BY chain_id
ORDER BY success_rate DESC
LIMIT 5;

-- TOP 5 CITIES BY SUCCESS RATE

SELECT city_id,
SUM (successful_orders) AS total_successful,
SUM(fail_orders) AS total_failed,
(SUM(successful_orders) * 100 / (SUM(successful_orders) + SUM(fail_orders))) AS success_rate
FROM restaurant_orders
GROUP BY (city_id)
ORDER BY success_rate
LIMIT 3;

--- DAILY ORDERS TREND FOR A SPECIFIC CHAIN
SELECT date,
SUM( successful_orders+ fail_orders) AS total_rate
FROM restaurant_orders
WHERE chain_id = 7501
GROUP BY date
ORDER BY DATE;
 

-- Monthly Order Trends
SELECT date_trunc ('month', date)
AS month, spec,
SUM (successful_orders) AS total_successful,
SUM(fail_orders) AS total_failed,
(SUM(successful_orders) * 100 / (SUM(successful_orders) + SUM(fail_orders))) AS success_rate
FROM restaurant_orders
GROUP BY month, spec
ORDER BY month, spec;

-- Indentify The Peak Order Days

SELECT date,
SUM( successful_orders+ fail_orders) AS total_orders
FROM restaurant_orders
GROUP BY date
ORDER BY total_orders DESC;

-- Performance Analysis Vendor  Within a City
SELECT vendor_id,
SUM (successful_orders) AS total_successful,
SUM(fail_orders) AS total_failed,
CASE
WHEN SUM(successful_orders) + SUM(fail_orders) = 0 THEN 0
ELSE (SUM(successful_orders) * 100 / (SUM(successful_orders) + SUM(fail_orders)))
END AS success_rate
FROM restaurant_orders
WHERE city_iD = 26
GROUP BY vendor_id;

-- Analyzing Order Failure Patterns:
SELECT date,
SUM(fail_orders) AS total_orders
FROM restaurant_orders
GROUP BY date
ORDER BY total_orders DESC
LIMIT 10;

SELECT * FROM restaurant_orders;