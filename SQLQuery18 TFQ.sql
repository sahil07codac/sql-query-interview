---1.Write a SQL query to fetch all the duplicate records from a table.

create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

insert into users values
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');

select * from users;
---Record is considered duplicate if a user name is present more than once.
select user_name, count(user_name)as no_of_count from users
group by user_name
having  count(user_name)>1;


---2.Write a SQL query to fetch the second last record from a employee table.

create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;


select * from (
select *, row_number() over(order by emp_id desc)as rn  from employee) as s
where rn=2;


--3. Write a SQL query to display only the details of employees who either earn the highest salary or the lowest salary in each department from the employee table.
with cte as(
select * ,dense_rank() over(partition by dept_name order by salary desc) rn ,
dense_rank() over(partition by dept_name order by salary ) sn 
from employee)
select * from cte
where rn=1 or sn=1 ;
---or
select * from (
select * ,FIRST_VALUE(salary) over( partition by dept_name order by salary desc ) as maxsalary ,
FIRST_VALUE(salary) over( partition by dept_name order by salary  ) as minsalary
from employee) as s
where SALARY=maxsalary or SALARY=minsalary ;


---4. From the doctors table, fetch the details of doctors who work in the same hospital but in different specialty.

create table doctors
(
id int primary key,
name varchar(50) not null,
speciality varchar(100),
hospital varchar(50),
city varchar(50),
consultation_fee int
);

insert into doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

select * from doctors;
---different speciality
select d1.name,d1.speciality,d1.hospital from doctors as d1 ,doctors as d2 
where d1.id!=d2.id and d1.hospital=d2.hospital  and d1.speciality!=d2.speciality;


--- same hospital
select d1.name,d1.speciality,d1.hospital from doctors as d1 ,doctors as d2 
where d1.id!=d2.id and d1.hospital=d2.hospital;


----5.From the login_details table, fetch the users who logged in consecutively 3 or more times.
create table login_details(
login_id int primary key,
user_name varchar(50) not null,
login_date date);

insert into login_details values
(101, 'Michael', GETDATE()),
(102, 'James', GETDATE()),
(103, 'Stewart', GETDATE()+1),
(104, 'Stewart', GETDATE()+1),
(105, 'Stewart', GETDATE()+1),
(106, 'Michael', GETDATE()+2),
(107, 'Michael', GETDATE()+2),
(108, 'Stewart',GETDATE()+3),
(109, 'Stewart', GETDATE()+3),
(110, 'James', GETDATE()+4),
(111, 'James', GETDATE()+4),
(112, 'James', GETDATE()+5),
(113, 'James', GETDATE()+6);

select * from login_details;
--- row no
---loginday-rowno (daydifference)
--row no on daydifference  ,partition by user_name, daydifference
--selct username, count(*), having 

 -----
 with cte as(
	 select * , row_number() over (partition by user_name order by login_date)as rn,
	 dateadd(day,-row_number() over (partition by user_name order by login_date),login_date ) as daydifference 
	 from login_details) ,
day_diffrank as (
 select *,row_number() over(partition by  user_name,daydifference order by login_date) as diifrn 
 from cte)
 select  user_name,diifrn ,count(*)as countof from day_diffrank
 group by  user_name,diifrn 
 having count(*)>=3;
 
 ---using lag function 
 select * from login_details;
 ---lag prev,lagprev2 
 ---where condition, datediff=1 for pre & prev 2  or datediff= 0
 with cte as (
	 select * ,lag(login_date,1) over(partition by user_name order by login_date)as prev,
	 lag(login_date,2) over(partition by user_name order by login_date)as prev_2
	 from login_details
 )
 select * from cte 
 where (DATEDIFF(day,prev,login_date)=1  and DATEDIFF(day,prev_2,prev)=1)
 or (DATEDIFF(day,prev,login_date)=0  and DATEDIFF(day,prev_2,prev)=0 )


  select * from login_details;
  ---lag function prev
  --desnse rank (partition by user, order by date
  --datdifference on rank on pre
  -- count , user name having
  with cte as(
    select *,lag(login_date,1) over(partition by user_name order by login_date) as pre from login_details),
	denseranks as (select * ,DENSE_RANK() over (partition by user_name order by login_date)as rankonpre from cte),
	tg as (
	select *,dateadd(day,-DENSE_RANK() over (partition by user_name order by login_date),login_date)as daydiff from denseranks)
	 select  user_name,daydiff, count(*) as countof from tg
 group by user_name,daydiff
 having count(*)>=3;


---6. From the students table, write a SQL query to interchange the adjacent student names.
create table students
(
id int primary key,
student_name varchar(50) not null
);
insert into students values
(1, 'James'),
(2, 'Michael'),
(3, 'George'),
(4, 'Stewart'),
(5, 'Robin');

--- case statement 
---with id% 2=1 or 0 ,lead, lag function 
select * from students;
select *,
case when id%2=1 then lead(student_name,1,student_name) over(order by id)
 when id%2=0 then lag(student_name,1) over(order by id)
end newnames
from students;


---7. From the following 3 tables (event_category, physician_speciality, patient_treatment),
---write a SQL query to get the histogram of specialties of the unique physicians who have done the procedures but never did prescribe anything.

create table event_category
(
  event_name varchar(50),
  category varchar(100)
);

drop table physician_speciality;
create table physician_speciality
(
  physician_id int,
  speciality varchar(50)
);

drop table patient_treatment;
create table patient_treatment
(
  patient_id int,
  event_name varchar(50),
  physician_id int
);


insert into event_category values ('Chemotherapy','Procedure');
insert into event_category values ('Radiation','Procedure');
insert into event_category values ('Immunosuppressants','Prescription');
insert into event_category values ('BTKI','Prescription');
insert into event_category values ('Biopsy','Test');


insert into physician_speciality values (1000,'Radiologist');
insert into physician_speciality values (2000,'Oncologist');
insert into physician_speciality values (3000,'Hermatologist');
insert into physician_speciality values (4000,'Oncologist');
insert into physician_speciality values (5000,'Pathologist');
insert into physician_speciality values (6000,'Oncologist');


insert into patient_treatment values (1,'Radiation', 1000);
insert into patient_treatment values (2,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 1000);
insert into patient_treatment values (3,'Immunosuppressants', 2000);
insert into patient_treatment values (4,'BTKI', 3000);
insert into patient_treatment values (5,'Radiation', 4000);
insert into patient_treatment values (4,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 5000);
insert into patient_treatment values (6,'Chemotherapy', 6000);

select * from event_category;
select * from patient_treatment;
select * from physician_speciality;


with cte as(
	select p.event_name ,s.speciality,pc.category from patient_treatment as p
	join  physician_speciality as s on p.physician_id=s.physician_id
	join event_category pc on p.event_name=pc.event_name) ,
tp as(
	select distinct event_name,speciality,category from cte 
	where category='Procedure' and  category not in ('Prescription'))
select speciality, count(*)counts from tp
group by speciality ;


------
with cte as (
	select  pt.event_name ,ps.speciality,pc.category  from patient_treatment as pt
	 join physician_speciality as ps on pt.physician_id=ps.physician_id
	 join event_category as pc on pt.event_name=pc.event_name )
 select distinct event_name,speciality,category from cte
 where category='Procedure' and category not in ('Prescription');

 ----8. Find the top 2 accounts with the maximum number of unique patients on a monthly basis.

 create table patient_logs
(
  account_id int,
  date date,
  patient_id int
);

insert into patient_logs values (1, '2020-01-02', 100);
insert into patient_logs values (1, '2020-01-27', 200);
insert into patient_logs values (2, '2020-01-01', 300);
insert into patient_logs values (2, '2020-01-21', 400);
insert into patient_logs values (2, '2020-01-21', 300);
insert into patient_logs values (2, '2020-01-01', 500);
insert into patient_logs values (3, '2020-01-20', 400);
insert into patient_logs values (1, '2020-03-04', 500);
insert into patient_logs values (3, '2020-01-20', 450);


select * from patient_logs;
-- month
--count of  pt
--dense rank on count of  pt
with cte as(
	select account_id, patient_id, month(date)as months from patient_logs) , 
countofptss as(
	select account_id  ,months,COUNT(distinct patient_id)as countofpt from cte
	group by account_id,months), 
d as(
	select *, dense_rank() over (order by account_id) as rn from countofptss)
select months, account_id,countofpt from d
where rn<=2
order by countofpt desc;
----
with cte as(
	select *, month(date)as months from patient_logs),
counts as(
	select account_id,months,count( distinct patient_id)as countofpt 
	from cte
	group by account_id,months),
ranks as(
	select *, dense_rank() over (order by account_id) as rn from counts)
select * from ranks
where rn<=2
order by account_id;


/* Write an SQL query to display the correct message (meaningful message) from the input
comments_and_translation table. */

create table comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);

insert into comments_and_translations values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');

select * from comments_and_translations;


select coalesce( null,translation,comment)as correctcomment from comments_and_translations;

---------
 /* o/p
id		comment
3		newin course
5		new in target
4		mismatch
*/
-----

DROP TABLE source;
CREATE TABLE source
    (
        id      int,
        name    varchar(1)
    );

DROP TABLE target;
CREATE TABLE target
    (
        id      int,
        name    varchar(1)
    );

INSERT INTO source VALUES (1, 'A');
INSERT INTO source VALUES (2, 'B');
INSERT INTO source VALUES (3, 'C');
INSERT INTO source VALUES (4, 'D');

INSERT INTO target VALUES (1, 'A');
INSERT INTO target VALUES (2, 'B');
INSERT INTO target VALUES (4, 'X');
INSERT INTO target VALUES (5, 'F');


select * from source;
select * from target;

-- full join
---where condition
--colleasce



with cte as(
	select s.*,t.id as sd,t.name as n from source  as s
	full join  target as t on s.id=t.id ),
df as(
	select id,name,sd,n from cte 
	where  name!=n or sd is null or id is null)
select coalesce(id,null,sd)as id,
case 
when id=3 then 'newin sourse'
when id=4 then 'mixmatch'
else 'new in target'
end as comments
from df;

----or
select * from source;
select * from target;

select s.id  ,'mismatch' as Comment from source as s
left join  target as t on s.id=t.id
where s.id=t.id and s.name!=t.name
union 
select coalesce(null,t.id) id,'new in target' as Comment from source as s
right join  target as t on s.id=t.id
where s.id is null
union 
select s.id,'new in sourse' as Comment  from source  as s
left join  target as t on s.id=t.id
where s.id!=t.id and s.name!=t.name or t.id is null;

---- IPL Matches
/*There are 10 IPL team. write an sql query such that each team play with every other team just once.

Also write another query such that each team plays with every other team twice.*/

create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');

select * from teams;
--- cross join
---or
---self join 
 ---once
with cte as(
select *, ROW_NUMBER() over (order by team_code)as rn from teams)
select * from cte as c1
cross apply cte as c2
where c1.rn<c2.rn
order by c1.team_code;

---twice
with cte as(
select *, ROW_NUMBER() over (order by team_code)as rn from teams)
select * from cte as c1
cross apply cte as c2
where c1.rn!=c2.rn 
order by c1.team_code;


create table travel_items
(
id              int,
item_name       varchar(50),
total_count     int
);
insert into travel_items values
(1, 'Water Bottle', 2),
(2, 'Tent', 1),
(3, 'Apple', 4);

select * from travel_items;

with recursivecte as(
select id,item_name,total_count from travel_items
union all
select c.id,c.item_name,c.total_count-1 from recursivecte as c
where c.total_count>1
)
select * from recursivecte
order by id;
---ot
with cte as (
select  id,item_name,total_count from travel_items
union all
select c.id,c.item_name,c.total_count-1 from cte as c
join travel_items as ts on c.id=ts.id
where c.total_count>1
) 
select * from cte ;

---Write a query to fetch the record of brand whose amount is increasing every year.
create table brands
(
    Year    int,
    Brand   varchar(20),
    Amount  int
);
insert into brands values (2018, 'Apple', 45000);
insert into brands values (2019, 'Apple', 35000);
insert into brands values (2020, 'Apple', 75000);
insert into brands values (2018, 'Samsung',	15000);
insert into brands values (2019, 'Samsung',	20000);
insert into brands values (2020, 'Samsung',	25000);
insert into brands values (2018, 'Nokia', 21000);
insert into brands values (2019, 'Nokia', 17000);
insert into brands values (2020, 'Nokia', 14000);


select * from brands;
--- lag
with cte as (
select * , amount-lag(amount,1,0) over (partition by  brand order by year) as diff from brands)
select brand,min(diff) from cte 
group by brand 
having min(diff)>0
----
---lead, cte 
with cte  as(
select *,lead(Amount,1,Amount+1) over (partition by  brand order by year)as next
from  brands)
---select * ,next-Amount from cte
select * from cte 
where brand not in (select brand from cte where next-amount<0)

---or 
----rownumber denserank and compare
with cte as (
select * ,ROW_NUMBER() over (partition by brand order by year) as rn ,
DENSE_RANK() over (partition by brand order by amount) as sd
from brands)
select * from cte
where Brand not in (select distinct  brand from cte where rn!=sd);


---or case statement lead function 
with cte as
    (select *
    , (case when amount < lead(amount, 1, amount+1)
                                over(partition by brand order by year)
                then 1
           else 0
      end) as flag
    from brands)
select *
from brands
where brand not in (select brand from cte where flag = 0)

---or self join
with cte as(
select * ,dense_rank() over (order by brand) as rn from brands)
select * from cte as c1 
left join cte as c2 on c1.Brand=c2.Brand
where c1.Brand=c2.Brand and c2.Amount>c1.Amount and c1.Year<c2.Year
and c1.rn=3

/*Suppose you have a car travelling certain distance and the data is presented as follows -
Day 1 - 50 km
Day 2 - 100 km
Day 3 - 200 km

Now the distance is a cumulative sum as in
    row2 = (kms travelled on that day + row1 kms).

How should I get the table in the form of kms travelled by the car on a given day and not the sum of the total distance? */

create table car_travels
(
    cars                    varchar(40),
    days                    varchar(10),
    cumulative_distance     int
);
insert into car_travels values ('Car1', 'Day1', 50);
insert into car_travels values ('Car1', 'Day2', 100);
insert into car_travels values ('Car1', 'Day3', 200);
insert into car_travels values ('Car2', 'Day1', 0);
insert into car_travels values ('Car3', 'Day1', 0);
insert into car_travels values ('Car3', 'Day2', 50);
insert into car_travels values ('Car3', 'Day3', 50);
insert into car_travels values ('Car3', 'Day4', 100);

select * from car_travels;

with cte as(
select *,lag(cumulative_distance,1,0) over (partition by  cars order by days) as prevdaytravveleddistance from car_travels)
select cars,days,prevdaytravveleddistance from cte ;


---Write a SQL query to convert the given input into the expected output as shown below:
/*
-- INPUT:
SRC         DEST        DISTANCE
Bangalore	Hyderbad	400
Hyderbad	Bangalore	400
Mumbai	    Delhi	    400
Delhi	    Mumbai	    400
Chennai	    Pune	    400
Pune        Chennai	    400

-- EXPECTED OUTPUT:
SRC         DEST        DISTANCE
Bangalore	Hyderbad	400
Mumbai	    Delhi	    400
Chennai	    Pune	    400
*/

create table src_dest_distance
(
    source          varchar(20),
    destination     varchar(20),
    distance        int
);
insert into src_dest_distance values ('Bangalore', 'Hyderbad', 400);
insert into src_dest_distance values ('Hyderbad', 'Bangalore', 400);
insert into src_dest_distance values ('Mumbai', 'Delhi', 400);
insert into src_dest_distance values ('Delhi', 'Mumbai', 400);
insert into src_dest_distance values ('Chennai', 'Pune', 400);
insert into src_dest_distance values ('Pune', 'Chennai', 400);

select * from src_dest_distance;

with cte as(
select *, row_number() over(order by distance)as id from src_dest_distance)
select c1.* from cte as c1 
join cte as c2 on  c1.source=c2.destination  
where   c1.id<c2.id;



/*
Write SQL Query to find the average distance between the locations?
-- INPUT:
SRC       DEST    DISTANCE
A	      B	      21
B	      A	      28
A	      B	      19
C	      D	      15
C	      D	      17
D	      C	      16.5
D	      C	      18

-- EXPECTED OUTPUT:
SRC       DEST    DISTANCE
A	      B	      22.66
C	      D	      16.62 
*/

create table src_dest_dist
(
    src         varchar(20),
    dest        varchar(20),
    distance    float
);
insert into src_dest_dist values ('A', 'B', 21);
insert into src_dest_dist values ('B', 'A', 28);
insert into src_dest_dist values ('A', 'B', 19);
insert into src_dest_dist values ('C', 'D', 15);
insert into src_dest_dist  values ('C', 'D', 17);
insert into src_dest_dist values ('D', 'C', 16.5);
insert into src_dest_dist values ('D', 'C', 18);

select * from src_dest_dist;

with cte as(
select * , case when src<dest then src else dest end as src1 ,
case when src>dest then src else dest end as dest1 
from src_dest_dist)
select src1,dest1,avg(distance)avgdistance from cte
group by  src1,dest1;


------
---combine and ang group 12,34,56,
create table emp_input
(
id      int,
name    varchar(40)
);
insert into emp_input values (1, 'Emp1');
insert into emp_input values (2, 'Emp2');
insert into emp_input values (3, 'Emp3');
insert into emp_input values (4, 'Emp4');
insert into emp_input values (5, 'Emp5');
insert into emp_input values (6, 'Emp6');
insert into emp_input values (7, 'Emp7');
insert into emp_input values (8, 'Emp8');

select * from emp_input;

with cte as(
select *, concat(id,' ',name)as combine, NTILE(4)  over (order by id) as grp from emp_input)
select grp, STRING_AGG(combine,',')as result from cte
group by grp;


-----alll join 

create table table_1
(id int);


create table table_2
(id int);

insert into table_1 values (1),(1),(1),(2),(3),(3),(3);
insert into table_2 values (1),(1),(2),(2),(4),(null);

SELECT * FROM table_1;
SELECT * FROM table_2;

---left join
SELECT * FROM table_1 as t
left join table_2 as t2 on t.id=t2.id;

---inner join 
select * from table_1 as t1
join table_2 as t2 on t1.id =t2.id

---right join
select * from table_1 as t1
right join table_2 as t2 on t1.id=t2.id

--full join
select * from  table_1 as t1
full join table_2 as t2 on t1.id=t2.id


--cross join 
select * from  table_1 as t1
cross JOIN   table_2 as t2 

/* > Solution breakup:
1) get the file ext
2) for each day, find how many times each file ext was modified.
3) for each day, get the max modified file ext from #2
4) if there is a tie then concatenate file ext.*/

create table files
(
id              int primary key,
date_modified   date,
file_name       varchar(50)
);
insert into files values (1	,   '2021-06-03', 'thresholds.svg')
insert into files values (2	,   '2021-06-01', 'redrag.py')
insert into files values (3	,   '2021-06-03', 'counter.pdf')
insert into files values (4	,   '2021-06-06', 'reinfusion.py')
insert into files values (5	,   '2021-06-06', 'tonoplast.docx')
insert into files values (6	,   '2021-06-01', 'uranian.pptx')
insert into files values (7	,   '2021-06-03', 'discuss.pdf');
insert into files values (8	,   '2021-06-06', 'nontheologically.pdf')
insert into files values (9	,   '2021-06-01', 'skiagrams.py')
insert into files values (10,   '2021-06-04', 'flavors.py')
insert into files values (11,   '2021-06-05', 'nonv.pptx')
insert into files values (12,   '2021-06-01', 'under.pptx')
insert into files values (13,  '2021-06-02', 'demit.csv')
insert into files values (14,   '2021-06-02', 'trailings.pptx')
insert into files values (15,   '2021-06-04', 'asst.py')
insert into files values (16,   '2021-06-03', 'pseudo.pdf')
insert into files values (17,   '2021-06-03', 'unguarded.jpeg')
insert into files values (18,   '2021-06-06', 'suzy.docx')
insert into files values (19,   '2021-06-06', 'anitsplentic.py')
insert into files values (20,   '2021-06-03', 'tallies.py');


select * from  files;

with cte as(
	select date_modified,file_name ,
	substring(file_name,CHARINDEX('.',file_name),CHARINDEX('.',file_name)-1)as extention
	from files
),
ct as (
	select date_modified,extention , count(extention) as cnt 
	from cte 
	group by date_modified,extention)
select date_modified, STRING_AGG(extention,',' )within group (order  by  extention desc )as extension   ,max(cnt)as countofmost
from ct c1
where cnt = (select max(cnt) from ct c2 where c1.date_modified=c2.date_modified )
group by date_modified
order by 1;
----
with cte as (
	select date_modified, SUBSTRING(file_name,CHARINDEX('.',file_name),CHARINDEX('.',file_name)-1) as extension 
	from files),
ct as(
	select date_modified,extension, count(extension) as cnt from cte
	group by date_modified,extension),
sd as (
select *, DENSE_RANK() over(partition by date_modified order by cnt desc)as s
from ct )
select date_modified,STRING_AGG(extension,',') as extension, cnt from sd
where s=1
group by date_modified,cnt
order by date_modified

/*
write query  acct no and trancastion date when acct balance reache 1000
please include only those record whose balance is >=1000

*/
create table account_balance
(
    account_no          varchar(20),
    transaction_date    date,
    debit_credit        varchar(10),
    transaction_amount  decimal
);

insert into account_balance values ('acc_1', '2022-01-20', 'credit', 100);
insert into account_balance values ('acc_1', '2022-01-21',  'credit', 500);
insert into account_balance values ('acc_1', '2022-01-22',  'credit', 300);
insert into account_balance values ('acc_1', '2022-01-23',  'credit', 200);
insert into account_balance values ('acc_2', '2022-01-20',  'credit', 500);
insert into account_balance values ('acc_2', '2022-01-21', 'credit', 1100);
insert into account_balance values ('acc_2', '2022-01-22', 'debit', 1000);
insert into account_balance values ('acc_3', '2022-01-20',  'credit', 1000);
insert into account_balance values ('acc_4', '2022-01-20',  'credit', 1500);
insert into account_balance values ('acc_4', '2022-01-21',  'debit', 500);
insert into account_balance values ('acc_5', '2022-01-20',  'credit', 900);

select * from account_balance;
--case statement for credit & debit 
--final amount after reduction
--current amount
--condition 

with cte as(
	select account_no,transaction_date,debit_credit, 
	case when debit_credit='credit' then transaction_amount  else - transaction_amount end as transactionamount 
	from account_balance), 
sd as(
	select *,sum(transactionamount) over (partition by account_no order by transaction_date rows between unbounded preceding and unbounded following)as finalamount,
	sum(transactionamount) over (partition by account_no order by transaction_date) as current_v 
	from cte )
select * from sd
where finalamount=current_v and   current_v>=1000


-------
/*o/p
customer_id customer_name Average_AnnualAmt
----------- ------------- ----------------------
1 A 116.666666666667
2 B 200
3 C 183.33333333333
*/

create table billing
(
      customer_id               int
    , customer_name             varchar(1)
    , billing_id                varchar(5)
    , billing_creation_date     date
    , billed_amount             int
);

insert into billing values (1, 'A', 'id1','10-10-2020', 100);
insert into billing values (1, 'A', 'id2', '11-11-2020', 150);
insert into billing values (1, 'A', 'id3', '12-11-2021', 100);
insert into billing values (2, 'B', 'id4', '10-11-2019', 150);
insert into billing values (2, 'B', 'id5', '11-11-2020', 200);
insert into billing values (2, 'B', 'id6', '12-11-2021', 250);
insert into billing values (3, 'C', 'id7', '01-01-2018', 100);
insert into billing values (3, 'C', 'id8', '05-01-2019', 250);
insert into billing values (3, 'C', 'id9', '06-01-2021', 300);

select * from billing;

--  avg=sum/ count 

with cte as(
	select customer_id, customer_name,
	sum(case when year(billing_creation_date)='2019' then billed_amount else 0 end) as yrsumbill_2019,
	sum(case when year(billing_creation_date)='2020' then billed_amount else 0 end) as yrsumbill_2020,
	sum(case when year(billing_creation_date)='2021' then billed_amount else 0 end) as yrsumbill_2021,
	count(case when year(billing_creation_date)='2019' then billed_amount else null end) as noyrsumbill_2019,
	count(case when year(billing_creation_date)='2020' then billed_amount else null end) as noyrsumbill_2020,
	count(case when year(billing_creation_date)='2021' then billed_amount else null end) as noyrsumbill_2021
	from billing
	group by customer_id, customer_name )
select customer_id ,customer_name,
(yrsumbill_2019+yrsumbill_2020+yrsumbill_2021)/
	((case when noyrsumbill_2019=0 then 1 else noyrsumbill_2019 end)+ 
	(case when noyrsumbill_2020=0 then 1 else noyrsumbill_2020 end)+
	(case when noyrsumbill_2021=0 then 1 else noyrsumbill_2021 end)
	)as avgs
from cte ;


/*
Problem Statement: 											
"Imagine a warehouse where the available items are stored as per different batches as indicated in the BATCH table.
Customers can purchase multiple items in a single order as indicated in ORDERS table.

Write an SQL query to determine items for each order are taken from which batch. 
Assume that items are sequencially taken from each batch starting from the first batch."
*/
											
											
											
										

create table batch (batch_id varchar(10), quantity integer);
create table orders (order_number varchar(10), quantity integer);


insert into batch values ('B1', 5);
insert into batch values ('B2', 12);
insert into batch values ('B3', 8);

insert into orders values ('O1', 2);
insert into orders values ('O2', 8);
insert into orders values ('O3', 2);
insert into orders values ('O4', 5);
insert into orders values ('O5', 9);
insert into orders values ('O6', 5);

select * from batch;
select * from orders;


with recursivecte as(
		select batch_id, quantity from batch
		union all
		select c1.batch_id, c1.quantity-1
		from recursivecte as c1
		 join batch as b on b.batch_id=c1.batch_id
		 where c1.quantity>1) 
		 ,sf as (
select batch_id,1 as quantity, ROW_NUMBER() over(order by batch_id)as rn from recursivecte
),
recursiveorder as (
		select order_number,quantity from orders
		union all
		select ro.order_number,ro.quantity-1
		from recursiveorder  as ro
		join orders as o on o.order_number=ro.order_number
		where ro.quantity>1
) 
,df as (
	select order_number,1 as quantity, ROW_NUMBER() over(order by order_number)as sd from recursiveorder)
select d1.order_number,s1.batch_id, sum(s1.quantity)as quantitys from df as d1
left join sf as s1 on d1.sd=s1.rn
group by d1.order_number,s1.batch_id
order by d1.order_number,s1.batch_id;

----


create table job_positions
(
	id			int,
	title 		varchar(100),
	groups 		varchar(10),
	levels		varchar(10),
	payscale	int,
	totalpost	int
);
insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1);
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5);
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);


create table job_employees
(
	id				int,
	name 			varchar(100),
	position_id 	int
);
insert into job_employees values (1, 'John Smith', 1);
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2);
insert into job_employees values (5, 'William Lee', 3);
insert into job_employees values (6, 'Jessica Clark', 3);
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3);

select * from job_positions;
select * from job_employees;


with recursivecte as (
	select id,title,groups,levels,payscale,totalpost from job_positions
	union all
	select c.id,c.title,c.groups,c.levels,c.payscale,c.totalpost-1
	from recursivecte as c
	join job_positions as p on c.id=p.id
	where c.totalpost>1
),
	s as(select *,ROW_NUMBER() over(partition by position_id order by id)as rn  
	from job_employees)
select p.id,p.title,p.groups,p.levels,p.payscale,coalesce(s.name,null,'vacant')as empname from recursivecte as p
left join s on p.totalpost=s.rn and p.id=s.position_id
order by groups,totalpost





