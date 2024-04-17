---##Given us happiness_tbl, we need to display a few specific Rows always at top of the query results.
create table happiness_tbl (ranking int, country varchar(50));

--Insert the records
insert into happiness_tbl values (1,'Finland'),(2,'Denmark'),(3,'Iceland'),
(4,'Israel'),(5,'Netherlands'),(6,'Sweden'),(7,'Norway'),(8,'Switzerland'),
(9,'Luxembourg'),(128,'Srilanka'),(126,'India');

select * from happiness_tbl;

select *,
	case 
		when country='india' then 1 
		when country='srilanka' then 2
		else 3
		end as delivertable
from happiness_tbl
order by  delivertable ,ranking ;

---Given us 2 tables, identify the no of records returned using different type of SQL Joins.

create table table1(id int);
insert into table1 values (1), (1),(2),(null),(null);

create table table2(id int);
insert into table2 values (1),(3),(null);


select * from table1;
select * from table2;

--inner join

select * from table1 as t1
inner join table2 as t2 on t1.id=t2.id

--left join 
select * from table1 as t1
left join table2 as t2 on t1.id=t2.id

--right join 
select * from table1 as t1
right join table2 as t2 on t1.id=t2.id


--fullouter join 
select * from table1 as t1
full outer  join table2 as t2 on t1.id=t2.id


---Given us Student table, find out the total marks of top 2 subjects based on marks.
--sname totalmark
 --a      xxx
 --b      yyy

create table students1(sname varchar(50), sid varchar(50), marks int);

--Insert the records
insert into students1 values('A','X',75),('A','Y',75),('A','Z',80),('B','X',90),('B','Y',91),('B','Z',75);

select * from students1;

select sname,sum(marks) as total_mark from students1
group by sname ;

with cte as (select *,row_number() over (partition by sname order by marks desc)as rn  from students1)
select sname,sum(marks) as totalmark from cte
where rn<=2
group by sname;

---
--Given us Employees table, find out the max ID from Employees excluding duplicates.

--Create Employees1 table
create table employees1 (id int);


insert into employees1 values (2),(5),(6),(6),(7),(8),(8);

select * from Employees1;
--rownumber
with cte as(select *,row_number() over (partition by id order by id)as rn from Employees1)
select max(id) from cte 
where id not in (select id from cte where rn>1)
;
---subquery
select max(id)as maxid from Employees1
where id not in (
select id from (
select id, count(*) as s
from Employees1
group by id
having count(*) >1)as s);
--or
select max(id)as maxid from Employees1
where id not in (
select id
from Employees1
group by id
having count(*) >1);



---
---Given us two tables, find out the result from the combination of 2 input tables.

---empid empname salary
--1      aa    1000
--2      bb    300
--3      cc    100

create table tablea (empid int, empname varchar(50), salary int);
create table tableb (empid int, empname varchar(50), salary int);

--Insert the records
insert into tablea values(1,'AA',1000),(2,'BB',300);
insert into tableb values(2,'BB',400),(3,'CC',100);
 
select * from tablea;
select * from tableb;
---coalesce ,fulljoin
with cte as(
select t1.empid,t1.empname,t1.salary ,t2.empid as t2empid,t2.empname as t2empname,t2.salary as t2salary
from tablea as t1
full join tableb as t2 on t1.empid=t2.empid)
select 
coalesce(null,empid,t2empid)as empid,
coalesce(null,empname, t2empname)as empid,
coalesce(null,salary, t2salary)as empid
from cte ;
---or

with cte as(
select t1.empid,t1.empname,t1.salary ,t2.empid as t2empid,t2.empname as t2empname,t2.salary as t2salary
from tablea as t1
full join tableb as t2 on t1.empid=t2.empid)
select 
coalesce(null,t2empid,empid)as empid,coalesce(null,t2empname,empname)as empname,coalesce(null,t2salary,salary)as salary
from cte ;

---or 
with cte as (
select * from tablea
union 
select * from tableb
)
select empid,empname,min(salary)as salary from cte 
group by empid,empname;


----Given us sales table, find out the periodic sales.

create table sales(month varchar(50), ytd_sales int, monthnum int);

---Insert the records
insert into sales values('jan',15,1),('feb',22,2),('mar',35,3),('apr',45,4),('may',60,5);

select * from sales;

with cte as (
select month,ytd_sales,lag(ytd_sales,1,30) over (order by monthnum  asc)as prev, abs((ytd_sales-lag(ytd_sales,1,30) over (order by monthnum  asc)))periodic_sale from sales)
select month,ytd_sales,periodic_sale from cte ;

---or
with cte as (
select month,ytd_sales,lag(ytd_sales,1,0) over (order by monthnum  asc)as prev from sales)
select month,ytd_sales,(ytd_sales-prev)periodic_sale from cte ;

---
---Given us Students table, we need to create Grades column to the main table.
--Let us first create students table
create table studnts_tbl (sname varchar(50), marks int);

---Insert the records
insert into studnts_tbl values ('A', 75),('B', 30),('C', 55),('A', 60),('D', 91),
('B', 19),('G', 36),('S', 65),('K', 49);

select * from studnts_tbl;


select *,
	case 
		when  marks>=85 then 'Excellent'
		when  marks<85  and marks>=65 then ' very good'
		when marks<65 and marks>=55 then 'good'
		when marks<55 and marks>=40 then  'fair'
		else 'poor'
		end as grade
from studnts_tbl;

---how to Sort the result in alternate order of Gender in SQL ?
Create Table Emp_Tbl
(id int,
EmpName varchar(20),
Gender varchar(20));

Insert into Emp_Tbl values(1,'Allen','MALE');
Insert into Emp_Tbl values(2,'Benjamin','MALE');
Insert into Emp_Tbl values(3,'Charle','MALE');
Insert into Emp_Tbl values(4,'Daisy','FEMALE');
Insert into Emp_Tbl values(5,'Emma','FEMALE');


select * from Emp_Tbl;
with cte as (
select *, ROW_NUMBER() over(partition by gender order by id) as rn from Emp_Tbl)
select * from cte
order by rn ,Gender desc ;
