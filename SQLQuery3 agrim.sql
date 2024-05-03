select * from sales;



---1.write sql query to  find average daily sales for each region

SELECT [Transaction Date],region, avg(total) average FROM (
SELECT [Transaction Date], region, sum([Item Price]*Quantity-Discount)total FROM sales GROUP BY [Transaction Date], region
)AS A
grouP BY region,[Transaction Date];


-----
with total_sale as(
select  [transaction Date],region,sum([item price]*quantity-discount)as totalsale from sales
group by [transaction Date], region )
select [transaction Date],region,avg(totalsale)  avgsales from total_sale
group by [transaction Date],region;



----2.Write a SQL query which tells the Average Order Value of 3rd most spending customers.
---AVG ORDER VALUE= TOTAL REVENUE/ NO OF ORDER
select * from sales;

WITH CTE AS (SELECT 
 [Customer ID],
 SUM([Item Price]*Quantity-Discount) AS TOTAL_REVENUE
FROM SALES
GROUP BY [Customer ID]
), CTE2 AS (
SELECT  [Customer ID], COUNT([Customer ID])AS COUNT_CU FROM sales
GROUP BY [Customer ID]),
CTE3 AS(
SELECT C1.[Customer ID],C1.TOTAL_REVENUE,C2.COUNT_CU FROM CTE AS C1
JOIN CTE2 AS C2 ON C1.[Customer ID]=C2.[Customer ID]),
CTE4 AS (SELECT [Customer ID],(TOTAL_REVENUE/COUNT_CU ) AS AVG_ORDER_VALUE FROM CTE3),
CTE5 AS(
SELECT *, DENSE_RANK() OVER (ORDER BY AVG_ORDER_VALUE DESC) AS RN FROM CTE4)
SELECT * FROM CTE5
WHERE RN=3

----

with totalsalesbycustomer as(
select [customer id],sum([item price] * quantity - discount)as totalsales from sales
group by [customer id]),
total_order as(
select  [customer id],count( [customer id])as totalorder from sales
group by [customer id]),
total_sales_order as(
select t1.[customer id] ,t1.totalsales,t2.totalorder from totalsalesbycustomer as t1
join  total_order  as t2 on t1.[customer id]=t2.[customer id]), 
avg_ordervalue as (
select [customer id],totalsales/totalorder as  avgordervalue,dense_rank() over(order by totalsales/totalorder desc)as rn  from total_sales_order)
select * from avg_ordervalue
where rn=3





---3.Write a SQL query which tells the customer having lowest Average Order Gap. 
---Hint : Average Order Gap is defined as Gap between two consecutive orders.
select * from sales;
select distinct [Product ID] from sales;


WITH OrderedTransactions AS (
    SELECT 
        [Customer ID],
        [Transaction Date],
        lag([Transaction Date]) OVER (PARTITION BY [Customer ID]  ORDER BY [Transaction Date] ) AS previous_transaction_date,
        DATEDIFF(day,Lag([Transaction Date]) OVER (PARTITION BY [Customer ID]  ORDER BY [Transaction Date] ) , [Transaction Date]) AS order_gap
    FROM sales
)
SELECT top 1
    [Customer ID],
    AVG(order_gap) AS average_order_gap
FROM OrderedTransactions
WHERE previous_transaction_date IS NOT NULL
GROUP BY [Customer ID]
ORDER BY AVG(order_gap) ASC;



--4.To calculate the cumulative purchase of a customer until any transaction date
select * from sales;

with cte as(
select [Transaction Date] , [Customer ID],[Item Price],Quantity,Discount from sales),
total_sale_1 as(
select [Transaction Date], SUM([Item Price] * Quantity - Discount) as totalsales from cte 
group by [Transaction Date])
select *,SUM(totalsales) OVER ( ORDER BY [Transaction Date] Rows Between Unbounded Preceding and Current Row )as cumlsales  from total_sale_1
where [Transaction Date]<='1999-06-09'



----5.Tell best 3 findings and insights from the data.
/*Seasonal Sales Trends: Analyzing the sales data over time might reveal seasonal trends, such as higher sales during certain months or periods. 
/*

/*Customer Segmentation: By analyzing customer purchasing behavior,
we can identify different customer segments based on their spending habits, frequency of purchases, 
and average order value. ./*

/*Product Performance: Analyzing the sales data can help identify top-performing products in terms of revenue generated or units sold.or region/*































