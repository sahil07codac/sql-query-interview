CREATE table namaste_orders(
order_id int,
city varchar(10),
sales int
)

insert into namaste_orders
values(1, 'Mysore' , 100),
(2, 'Mysore' , 200),
(3, 'Bangalore' , 250),
(4, 'Bangalore' , 150)
,(5, 'Mumbai' , 300),
(6, 'Mumbai' , 500),
(7, 'Mumbai' , 800);

select * from namaste_orders

create table namaste_returns(
order_id int,
return_reason varchar(20)
);

insert into namaste_returns values
(3,'wrong item'),(6,'bad quality'),(7,'wrong item');

select * from namaste_orders;
select * from namaste_returns;

--- 1.Write a SQL to find cities where not even a single order was returned.
select distinct(city) from namaste_orders 
where city not in (select distinct(city) from namaste_orders where order_id in (select order_id from namaste_returns))
---or
select o.city
from namaste_orders o
left join namaste_returns r
on o.order_id=r.order_id
group by o.city
having count(r.order_id)=0

--2.Write a SQL query to calculate the cumulative sales for each order for city except return order.
select * from namaste_orders;
select * from namaste_returns;

select * from (select o1.order_id,o1.city, o1.sales, sum( o2.sales) cum from namaste_orders o1
join namaste_orders o2 on o1.order_id>=o2.order_id
group by o1.order_id,o1.city ,o1.sales)as a
where order_id not in (select order_id from namaste_returns);

--3.Write a SQL query to calculate the cumulative sales for each order within each city except return order.
select o.order_id, o.city, o.sales,sum(o.sales) over(partition by o.city order by o.order_id)as cum from namaste_orders o
left join namaste_returns r on o.order_id=r.order_id
where r.order_id is null
order by o.order_id


---4.Write a SQL query to calculate the cumulative sales for each order within each city
select o.order_id ,o.city ,o.sales, sum(o.sales) over(partition by o.city order by o.order_id)as cum
from namaste_orders o
order by o.order_id

--5.Write a SQL query to find the top 3 cities with the highest total sales.
--(Using Rank function also a very good way to solve this type of problem over using limit)


select top 3 city,sum(sales)as highesttoalsale from namaste_orders 
group by city
order by highesttoalsale

--6.Write a SQL query to find the top 3 cities with the highest sales.
select top 3 city,max(sales)as highestsale from namaste_orders 
group by city


--7.Write a SQL query to find the orders with sales above the overall average sales.

select * from namaste_orders 
where sales>=(select avg(sales)as avgsale from namaste_orders )

--8.Write a SQL query to find the total number of orders and the total number of returns for each city.

select o.city,count(o.order_id)as totalorder,count(r.order_id)as retunorder  from namaste_orders o 
left join namaste_returns r on o.order_id=r.order_id
group by o.city





---question write sql quey for:
--input 1,2,3,5,6,7,9 and output 4,8

create table sp(input int)

insert into sp
values(1),(2),(3),(5),(6),(7),(9)

select * from sp;

WITH AllIDs AS (
    SELECT ROW_NUMBER() OVER (ORDER BY ID) AS ExpectedID
    FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8),(9)) AS AllIDs(ID)
)

SELECT ExpectedID AS ID
FROM AllIDs
WHERE ExpectedID NOT IN (SELECT input FROM sp);


--or
with cte as(select input, lag(input+1,1,1) over(order by input) as op from sp)
select op from cte 
where input!=op;





