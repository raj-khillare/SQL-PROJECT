CREATE DATABASE SQL_ASG;
USE SQL_ASG;


-- *RENAMING TABLES*
RENAME TABLE ECOMMERCE_ORDERS TO ORDERS;
RENAME TABLE CUSTOMERFEEDBACK TO FEEDBACK;

-- 1.	Display the structure of the CustomerFeedback table.
SELECT * FROM FEEDBACK;
DESC feedback;
-- 2.	Show all records from the Ecommerce_Orders table.
SELECT * FROM ORDERS;
-- 3.	Count how many feedback entries are present in the CustomerFeedback table.
SELECT 
    COUNT(*) TOTAL_RECORDS
FROM
    FEEDBACK;

-- 4.	Find the minimum and maximum order amount from the Ecommerce_Orders table.
SELECT 
    MIN(TOTALAMOUNT) MINIMUN_AMOUNT,
    MAX(TOTALAMOUNT) MAXIMUM_AMOUNT
FROM
    ORDERS;
-- MINIMUM_AMOUNT : 216.01 , MAXIMUM_AMOUNT : 49503.85
-- 5.	Show all unique payment methods used in the Ecommerce_Orders table.
SELECT DISTINCT
    (PAYMENTMETHOD)
FROM
    ORDERS;

-- 🔸 II. WHERE Clause & Filtering 
-- 6.	Find all orders where the order amount is greater than 10,000.

SELECT 
    *
FROM
    ORDERS
WHERE
    TOTALAMOUNT > 10000;
-- 403 ORDERS HAS ORDER AMOUNT GREATER THAN 10000.

-- 7.	Show feedback entries with a rating less than 3.
SELECT 
    *
FROM
    FEEDBACK
WHERE
    RATING < 3;
-- 175 FEEDBACK HAS RATING LESS THAN 3.

-- 8.	List all orders where the order status is 'Delivered'.
SELECT 
    *
FROM
    ORDERS
WHERE
    DELIVERYSTATUS = 'DELIVERED';
-- 189 ORDERS ARE DELIVERED .

-- 9.	Retrieve feedback comments that contain the word 'late'.
SELECT 
    *
FROM
    FEEDBACK
WHERE
    FEEDBACKTEXT LIKE '%LATE%';
-- 52 FEEDBACK RECORDS SAYS LATE DELIVERY.

-- 10.	Get orders placed in the year 2024.
SELECT 
    *
FROM
    ORDERS
WHERE
    YEAR(ORDERDATE) = '2024';
-- 400 ORDERS ARE PLACED IN 2024.
-- 2ND APPROACH USING BETWEEN KEY
SELECT 
    *
FROM
    ORDERS
WHERE
    ORDERDATE BETWEEN '2024-01-01' AND '2024-12-31';

-- 11.	Find all records where the payment method is either 'UPI' or 'Credit Card'.
SELECT 
    *
FROM
    ORDERS
WHERE
    PAYMENTMETHOD IN ('UPI' , 'CREDIT CARD');
-- 299 ORDERS PAYMENT DONE BY EITHER UPI OR  CREDIT CARD METHOD.
-- 2ND APPROACH.
SELECT 
    *
FROM
    ORDERS
WHERE
    PAYMENTMETHOD = 'UPI'
        OR PAYMENTMETHOD = 'CREDIT CARD';

-- 12.	Show orders with a delivery date that is NULL.
SELECT 
    *
FROM
    ORDERS
WHERE
    ORDERDATE IS NULL;
-- 0 RECORD

-- 13.	Show customer feedbacks submitted on a weekend (Saturday or Sunday).
SELECT 
    *
FROM
    FEEDBACK
WHERE
    DATE_FORMAT(FEEDBACKDATE, '%W') IN ('SATURDAY' , 'SUNDAY');
-- 105 FEEDBACK GIVEN ON WEEKENDS

-- 14.	Display orders placed between ‘2024-01-01’ and ‘2024-03-31’.
SELECT 
    *
FROM
    ORDERS
WHERE
    ORDERDATE BETWEEN '2024-01-01' AND '2024-03-31';
-- 0 RECORDS FOUND

-- 15.	Show all records where customer name starts with 'A'.
SELECT 
    *
FROM
    ORDERS
WHERE
    CUSTOMERNAME LIKE 'a%';
-- 75 CUSTOMERS WITH STARING NAME A PLACED ORDER.


-- I.	🔸 ORDER BY & LIMIT 
-- 16.	Get the top 5 highest order amounts.
SELECT 
    *
FROM
    ORDERS
ORDER BY TOTALAMOUNT DESC
LIMIT 5;
-- HIGHEST TOTAL AMOUNT IS 49503.85

-- 17.	Show the 10 most recent orders.
SELECT * FROM ORDERS ORDER BY ORDERDATE DESC LIMIT 10;
-- MOST RECENT ORDER ON '2025-06-24'.

-- 18.	List feedback sorted by lowest rating first.
SELECT 
    *
FROM
    FEEDBACK
ORDER BY RATING;


-- 19.	Get the earliest 3 feedback entries by submission date.
SELECT 
    *
FROM
    FEEDBACK
ORDER BY FEEDBACKDATE
LIMIT 3;
-- FIRST MOST FEEDBACK SUBMITED ON '2024-06-24'.

-- 20.	Display the top 5 customers with the highest number of orders (use LIMIT with GROUP BY).
SELECT 
    CUSTOMERID, COUNT(*) TOTAL_ORDERS
FROM
    ORDERS
GROUP BY CUSTOMERID
ORDER BY COUNT(*) DESC
LIMIT 5;


-- IV. Aggregate Functions
-- 21.	Count total number of orders.
SELECT 
    COUNT(*) TOTAL_ORDERS
FROM
    ORDERS;
-- TOTAL ORDERS ARE 750.

-- 22.	 Calculate the total revenue generated from all orders.
SELECT 
    SUM(NETAMOUNT) TOTAL_REVENUE
FROM
    ORDERS;
-- TOTAL REVENUE FROM ORDERS IS 9675467.29 .

-- 23.	Find average order value.
SELECT 
    AVG(TOTALAMOUNT)
FROM
    ORDERS;
-- AVERAGE ORDER VALUE IS 15183.71

-- 24.	Count how many feedbacks have been rated 5.
SELECT 
    COUNT(*)
FROM
    FEEDBACK
WHERE
    RATING = '5';
-- 92 FEEDBACK HAVE BEEN RATED 5.

-- 25.	 Find the maximum delivery time (order to delivery date).
SELECT 
    MAX(datediff(ORDERDATE,DELIVERYDATE))
FROM
    ORDERS;



-- 26.	 Count the number of orders placed via 'Cash on Delivery'.
SELECT 
    COUNT(*)
FROM
    ORDERS
WHERE
    PAYMENTMETHOD = 'CASH ON DELIVERY';
-- 134 ORDER PAYMENT VIA CASH ON DELIVERY.

-- 27.	 Calculate the average rating received.
SELECT 
    AVG(RATING)
FROM
    FEEDBACK;
-- 3 IS THE AVERAGE RATING.

-- 28.	Count how many orders were placed each month.
SELECT 
    MONTH(ORDERDATE) MONTH, COUNT(*) TOTAL_ORDER
FROM
    ORDERS
GROUP BY MONTH(ORDERDATE)
ORDER BY MONTH;

-- 29.	Get the total number of unique customers.
SELECT 
    COUNT(DISTINCT (CUSTOMERID)) UNIQUE_CUSTOMER
FROM
    ORDERS;
-- 750 UNIQUE CUSTOMER ARE THERE

-- 30.	Find how many feedbacks have comments provided (i.e., not NULL or empty).
SELECT 
    COUNT(*)
FROM
    FEEDBACK
WHERE
    FEEDBACKTEXT IS NOT NULL;
-- 444 RECORDS WITH NOT NULL VALUE IN FEEDBACK COMMENTS.


-- 🔸 V. GROUP BY & HAVING 
-- 31.	Count number of orders per payment method.
SELECT 
    PAYMENTMETHOD, COUNT(*) TOTAL_ORDERS
FROM
    ORDERS
GROUP BY PAYMENTMETHOD;
/*
Cash on Delivery	134
Debit Card	169
Net Banking	148
UPI	149
Credit Card	150 */

-- 32.	Show average order amount per delivery city.
SELECT 
    CITY, AVG(TOTALAMOUNT) AVERAGE_ORDER_AMOUNT
FROM
    ORDERS
GROUP BY CITY;
/*
Hyderabad	16297.570559440555
Delhi	16416.32128205128
Chennai	14479.138947368416
Bangalore	13670.029851851854
Mumbai	14939.03798780487
*/

-- 33.	Get number of feedback entries per rating value.
SELECT RATING,COUNT(*) NUMBER_OF_RATING FROM FEEDBACK group by RATING;
/*
1	91
2	84
3	93
4	84
5	92
*/


-- 34.	Display number of orders placed per day.
SELECT 
    ORDERDATE, COUNT(*) NUMBER_OF_ORDERS
FROM
    ORDERS
GROUP BY ORDERDATE;

-- 35.	Find total revenue per customer.
SELECT 
    CUSTOMERID, SUM(NETAMOUNT) TOTAL_REVENUE
FROM
    ORDERS
GROUP BY CUSTOMERID;
-- HIGHEST REVENUE GENERATED PER CUSTOMER IS 43811.8 .


-- 36.	Get cities where the average order value is greater than ₹5000.
SELECT 
    CITY, AVG(TOTALAMOUNT) AVERAGE_ORDER_AMOUNT
FROM
    ORDERS
GROUP BY CITY
HAVING AVG(TOTALAMOUNT) > 5000;
/* 
Bangalore	13670.029851851854
Chennai	14479.138947368416
Mumbai	14939.03798780487
Hyderabad	16297.570559440555
Delhi	16416.32128205128
*/


-- 37.	List payment methods used in more than 100 transactions.
SELECT 
    PAYMENTMETHOD, COUNT(*) NUMBER_OF_ORDERS
FROM
    ORDERS
GROUP BY PAYMENTMETHOD
HAVING COUNT(*) > 100;
/*
Cash on Delivery	134
Debit Card	169
Net Banking	148
UPI	149
Credit Card	150
*/ 


-- 38.	Count feedbacks per customer and filter those who gave more than 2.
SELECT CUSTOMERID, COUNT(*) NUMBER_OF_CUSTOMERS FROM FEEDBACK group by CUSTOMERID HAVING COUNT(*) >2;


-- 39.	Get number of orders per order status.
SELECT 
    DELIVERYSTATUS, COUNT(*)
FROM
    ORDERS
GROUP BY DELIVERYSTATUS;
/*
Cancelled	207
Delivered	189
In Transit	185
Returned	169
*/


-- 40.	Count number of orders per delivery person (if available).
SELECT * FROM ORDERS;

-- 🔸 VI. String Functions
-- 41.	Extract first 3 characters of the order ID.
SELECT 
    ORDERID, LEFT(ORDERID, 3)
FROM
    ORDERS;

SET SQL_SAFE_UPDATES = 0;
-- 42.	Replace all instances of 'delayed' in feedback with 'late'.
UPDATE FEEDBACK
SET FEEDBACKTEXT ='DELAYED' WHERE FEEDBACKTEXT LIKE '%LATE%';
SELECT * FROM feedback;

-- 43.	Create an alias for total amount as TotalOrderValue.
SELECT 
    TOTALAMOUNT AS TotalOrderValue
FROM
    orders;
    
    
-- 🔸 VII. Subqueries
-- 44.	Find the second highest order amount.
SELECT TOTALAMOUNT
FROM (
    SELECT
        TOTALAMOUNT,
        DENSE_RANK() OVER (ORDER BY TOTALAMOUNT DESC) as rnk
    FROM ORDERS
) AS ranked_amount
WHERE rnk = 2;


-- 45.	Get customers who placed the maximum number of orders.
SELECT
    CustomerID,
    CustomerName,
    COUNT(OrderID) AS NumberOfOrders
FROM
    ORDERS
GROUP BY
    CustomerID, CustomerName
ORDER BY
    NumberOfOrders DESC
LIMIT 1;

-- 46.	Find feedbacks submitted after the latest order date.
SELECT 
    *
FROM
    FEEDBACK
WHERE
    FEEDBACKDATE = (SELECT 
            MAX(ORDERDATE)
        FROM
            ORDERS);
/* MOST RECENT FEEDBACKS ARE
738841b3-0b43-4044-8314-32f3c5da161a	3	Product was damaged	2025-06-24
29c69ebb-1591-40d4-b748-e031705d927d	1	Fast shipping	2025-06-24
c2f04a55-8dd1-4ff0-bbfd-053e9c4ed0dd	4	Product was damaged	2025-06-24
*/


-- 47.	Retrieve orders with amounts greater than the average order amount.
SELECT 
    *
FROM
    ORDERS
WHERE
    TOTALAMOUNT > (SELECT 
            AVG(TOTALAMOUNT) AVERAGE
        FROM
            ORDERS);
-- 312 ORDERS HAS ORDER AMOUNT GREATER THAN AVERAGE ORDER AMOUNT.


-- 48.	Find all feedbacks for customers who made at least one order in March 2024.
SELECT 
    *
FROM
    FEEDBACK
WHERE
    CUSTOMERID IN (SELECT 
            CUSTOMERID
        FROM
            ORDERS
        WHERE
            MONTH(ORDERDATE) = 6
                AND YEAR(ORDERDATE) = 2024
        GROUP BY CUSTOMERID);
