create table empolyeeinfo_table(
	emp_id int,
	f_name varchar(255),
	l_name varchar(255),
	department varchar(255),
	project varchar(255),
	adress varchar(255),
	dob varchar(255),
	gender varchar(255)
	)

insert into empolyeeinfo_table
values(1,'sanjay','mehra','HR','p1','hyderabad(hyd)','01/12/1976','M'),
		(2,'rohan','dare','admin','p2','jalna(jal)','01/5/1986','M'),
		(3,'piya','mehra','acct','p3','hyderabas(hyd)','11/12/1976','f'),
		(4,'sahil','miaal','admin','p1','aurangabad(a.bad)','21/10/1976','M'),
		(5,'anaya','mmena','finace','p2','mumbai(mum)','4/2/1976','f'),
		(6,'vijay','kolhe','it','p5','delhi(dhl)','03/1/1976','M')

drop table empolyeeinfo_table

create table empolyee_position_table(
	emp_id int,
	emp_position varchar(255),
	doj varchar(255),
	salary int
	)

insert into empolyee_position_table
values(1,'manager','05/04/1965',500000),
	(2 ,'Executive' ,'02/05/2024', 75000),
	(3,'Manager','01/05/2024',90000),
	(2,'Lead','02/05/2024',85000),
	(1,'Executive','01/05/2024',300000)


select * from empolyee_position_table




select * from empolyeeinfo_table;

--Q1. Write a query to fetch the EmpFname from the EmployeeInfo table in upper case and use the ALIAS name as EmpName.
 select upper(f_name) from empolyeeinfo_table as empname

 --Q2. Write a query to fetch the number of employees working in the department ‘HR’.
 select count(*) as no_of_emp from empolyeeinfo_table where department='hr'

-- Q3. Write a query to get the current date.
 select getdate()

 --Q4. Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.
 select SUBSTRING(l_name,1,4) as first_four from empolyeeinfo_table

 --Q5. Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.
 select substring(adress,0,charindex('(',adress)) as placename from empolyeeinfo_table

 --Q6. Write a query to create a new table which consists of data and structure copied from the other table.
 select * into empolyeedata from empolyeeinfo_table
  select * from empolyeedata

  --Q7. Write q query to find all the employees whose salary is between 50000 to 100000.
  select * from empolyee_position_table where salary between 50000 and 100000

  --Q8. Write a query to find the names of employees that begin with ‘S’
  select f_name from empolyeeinfo_table where f_name like 's%'

  ---Q9. Write a query to fetch top N records.n=2
  select top 2 * from empolyeeinfo_table 

  --Q10. Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.
  select concat(f_name,' ',l_name) as full_name from empolyeeinfo_table 

  --Q11. Write a query find number of employees whose DOB is between 02/01/1970 to 31/2/1976 and are grouped according to gender
  select count(*) from empolyeeinfo_table where dob between '02/01/1970' and '31/2/1976'

  --Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.
  select * from empolyeeinfo_table order by l_name desc,department asc

  --Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.
  select * from empolyeeinfo_table where l_name like '____a'

  --Q14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.
   select * from empolyeeinfo_table where f_name not in( 'Sanjay' , 'anaya')

   --Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”.
   select * from empolyeeinfo_table where adress like 'delhi(dhl)'

   ---Q16. Write a query to fetch all employees who also hold the managerial position
  
   select * from empolyeeinfo_table e1
   join empolyee_position_table e2
   on e1.emp_id=e2.emp_id
   where emp_position ='manager'

   --Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.
   
  select department ,count(*) as count_emp
  from empolyeeinfo_table
  group by department 
  order by count_emp

  --Q18. Write a query to calculate the even and odd records from a table.
  select * from empolyeeinfo_table
   -- for even 
  select * from empolyeeinfo_table where (emp_id%2) =0 
  -- or
  with cte as(select *, ROW_NUMBER() over(order by emp_id)as rn from empolyeeinfo_table)
  select * from cte where (rn%2)=0

  -- odd
  select * from empolyeeinfo_table where (emp_id%2)=1

  --Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.
  select * from empolyeeinfo_table
  select * from empolyee_position_table

  select * from empolyeeinfo_table e1
  where exists (select * from empolyee_position_table e2 where e1.emp_id=e2.emp_id)

 -- or 
(select e1.emp_id,e1.f_name,e1.l_name ,e1.project ,e1.adress,e1.dob,e1.gender from empolyeeinfo_table e1
 join empolyee_position_table e2 on e1.emp_id=e2.emp_id )

 --Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.
 select * from empolyee_position_table
 --max
 select top 2 * from (select  * , row_number() over(order by salary desc)as rn from empolyee_position_table)as rp
 --min
 select top 2 * from ( select * ,row_number() over ( order by salary) as rn from empolyee_position_table )as np

 --Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword.n=3
 select salary from empolyee_position_table e1
 where 3-1=(select count(salary) from empolyee_position_table e2 where e2.salary>e1.salary)

 --Q22. Write a query to retrieve duplicate records from a table.
 
 select department ,count(*) from empolyeeinfo_table
 group by department
 having count(*) >1

 --Q23. Write a query to retrieve the list of employees working in the same department.

 

 select e1.emp_id,e1.f_name,e1.l_name, e1.department from empolyeeinfo_table e1,empolyeeinfo_table e2
 where e1.department=e2.department and e1.emp_id!=e2.emp_id

 ---Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.
 
 select top 3* from empolyeeinfo_table
 order by emp_id desc
--or
select * empolyeeinfo_table where emp_id>(select count(*) from empolyeeinfo_table)-2;

 --Q25. Write a query to find the third-highest salary from the EmpPosition table.
 
 select top 1 salary from(select top 3 salary from empolyee_position_table order by salary desc) as sal order by salary asc

 --Q26. Write a query to display the first and the last record from the EmployeeInfo table.
 select * from empolyeeinfo_table where emp_id=(select min(emp_id) from empolyeeinfo_table)
 select * from empolyeeinfo_table where emp_id= (select max(emp_id) from empolyeeinfo_table)

 --Q28. Write a query to retrieve Departments who have less than 2 employees working in it
 SELECT department, COUNT(emp_id) as 'EmpNo' FROM empolyeeinfo_table GROUP BY department HAVING COUNT(emp_id)< 2;

 --Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them.
 select * from empolyee_position_table
 select emp_position,sum(salary)as total from empolyee_position_table
 group by emp_position

 --Q30. Write a query to fetch 50% records from the EmployeeInfo table.
 select * from empolyeeinfo_table where emp_id <=(select count(emp_id)/2 from empolyeeinfo_table)

 