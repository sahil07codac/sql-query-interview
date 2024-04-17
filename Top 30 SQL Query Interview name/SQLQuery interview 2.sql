CREATE TABLE EmployeeDetailss (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(100),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(100)
);

INSERT INTO EmployeeDetailss (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES 
    (121, 'John Snow', 321, '2019-01-31', 'Toronto'),
    (321, 'Walter White', 986, '2020-01-30', 'California'),
    (421, 'Kuldeep Rana', 876, '2021-11-27', 'New Delhi');


CREATE TABLE EmployeeSalary (
    EmpId INT,
    Project VARCHAR(50),
    Salary INT,
    Variable INT,
    FOREIGN KEY (EmpId) REFERENCES EmployeeDetailss(EmpId)
);

INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES 
    (121, 'P1', 8000, 500),
    (321, 'P2', 10000, 1000),
    (421, 'P1', 12000, 0);

	



	select * from EmployeeDetailss;
	select * from EmployeeSalary;


	--1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.
	select  EmpId,FullName 
	from EmployeeDetailss
	where ManagerId=986;

	--2. Write an SQL query to fetch the different projects available from the EmployeeSalary table.
	select distinct project from EmployeeSalary;

	--3. Write an SQL query to fetch the count of employees working in project ‘P1’
	select count(EmpId) as count_of_employees
	from EmployeeSalary
	where project ='p1';

	--4. Write an SQL query to find the maximum, minimum, and average salary of the employees.
	select max(salary)as maxsalry,min(salary)as minsalary,avg(salary)as avgsalary
	from  EmployeeSalary;

	--5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.
	select EmpId,salary 
	from EmployeeSalary
	where salary between  9000 and 15000;

	--6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.
	select FullName from EmployeeDetailss
	where city='Toronto' and ManagerId='321';
	
	--7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321.
	select FullName, City,ManagerId from EmployeeDetailss
	where city ='California' or ManagerId='321';

	--8. Write an SQL query to fetch all those employees who work on Projects other than P1.
	select * from EmployeeDetailss e1
	join EmployeeSalary e2 on e1.empid=e2.empid
	where project not in ('p1');

	--9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.
	select *,(Salary+Variable ) as total_salary  from EmployeeSalary;

	--10. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.
	select FullName 
	from EmployeeDetailss
	where fullname like '__hn%';

	--11. Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.
	select e1.EmpId 
	from EmployeeDetailss as e1
	full join  EmployeeSalary as e2 on e1.EmpId=e2.EmpId

	--or 
	select empid from EmployeeDetailss
	union
	select empid from EmployeeSalary;

	--12. Write an SQL query to fetch common records between two tables
	select * 
	from EmployeeDetailss as e1
	join EmployeeSalary as e2 on e1.EmpId=e2.EmpId;
---or
	select EmpId from EmployeeDetailss
	intersect
	select EmpId from EmployeeSalary;

	--13. Write an SQL query to fetch records that are present in one table but not in another table
	select * from EmployeeDetailss
	MINUS
	select * from EmployeeSalary;
	--or
	select * from EmployeeSalary
	MINUS
	select * from EmployeeSalary;

	--or

	select * from EmployeeDetailss
	where empid not in (select empid from EmployeeSalary )

	--or 
	select * from EmployeeDetailss as e1
	left join EmployeeSalary as e2 on e1.EmpId=e2.EmpId
	where e1.EmpId!=e2.EmpId or e2.EmpId is null;

	--
--14. Write an SQL query to fetch the EmpIds that are present in both the tables –  ‘EmployeeDetails’ and ‘EmployeeSalary.
--using subquey
select  EmpId 
from  EmployeeDetailss
where EmpId in (select EmpId from EmployeeSalary);

--15. Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary.
select EmpId from EmployeeDetailss
where EmpId not in (select EmpId from EmployeeSalary);

---16. Write an SQL query to fetch the employee’s full names and replace the space with ‘-’.
select replace(fullname,' ','-')as names 
from EmployeeDetailss;

--
--17. Write an SQL query to fetch the position of a given character(s) in a field.
SELECT charindex( 'S', FullName)as position
FROM EmployeeDetailss;

--18. Write an SQL query to display both the EmpId and ManagerId together.
select EmpId,ManagerId from EmployeeDetailss;
--or 
select concat( EmpId,'',ManagerId)as newids from EmployeeDetailss;

--19. Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.
select FullName,SUBSTRING(fullname,1,CHARINDEX(' ',FullName))as fname from EmployeeDetailss;

--20. Write an SQL query to uppercase the name of the employee and lowercase the city values.
select upper(FullName)as name_of_empolyee, lower(city) as city from EmployeeDetailss;

--21. Write an SQL query to find the count of the total occurrences of a particular character – ‘n’ in the FullName field.
select len(fullname)-len(REPLACE(fullname,'n','')) as total_occurrences_of_n
from EmployeeDetailss;

--22. Write an SQL query to update the employee names by removing leading and trailing spaces.
select trim(FullName)as names from EmployeeDetailss;
---or
update EmployeeDetailss set FullName=TRIM(FullName);

--23. Fetch all the employees who are not working on any project.
select * from EmployeeDetailss
where empid not in (select empid from EmployeeSalary )
---or
SELECT EmpId 
FROM EmployeeSalary 
WHERE Project IS NULL;

---24. Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000.
select fullname from EmployeeDetailss as e1
join EmployeeSalary as e2 on e1.EmpId=e2.EmpId
where Salary>=5000  and Salary<=10000;

--26. Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020.
select FullName,year(DateOfJoining) as joinyears from EmployeeDetailss
where year(DateOfJoining)=2020;

--27. Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.
select * from EmployeeDetailss;
select * from EmployeeSalary;

select * from EmployeeDetailss as e1 
left join EmployeeSalary as e2 on e1.EmpId=e2.EmpId
where e1.EmpId=e2.EmpId

---or

SELECT * FROM EmployeeDetailss E
WHERE EXISTS
(SELECT * FROM EmployeeSalary S 
WHERE  E.EmpId = S.EmpId);

--28. Write an SQL query to fetch the project-wise count of employees sorted by project’s count in descending order.
select Project,count(empid)as countsofemp from EmployeeSalary
group by project 
order by countsofemp desc;

---29. Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee.
select e1.FullName,e2.Salary from EmployeeDetailss as e1
left join EmployeeSalary as e2 on e1.EmpId=e2.EmpId


--31. Write an SQL query to fetch all the Employees who are also managers from the EmployeeDetails table.
select e1.fullname from EmployeeDetailss as e1,EmployeeDetailss as e2
where e1.EmpId=e2.ManagerId;

---or 
select e1.fullname from EmployeeDetailss as e1
cross join  EmployeeDetailss as e2 
where e1.EmpId=e2.ManagerId

--32. Write an SQL query to fetch duplicate records from EmployeeDetails (without considering the primary key – EmpId).
select EmpId,FullName,ManagerId,DateOfJoining,City, count(*) 
from EmployeeDetailss
group by EmpId,FullName,ManagerId,DateOfJoining,City
having count(*)>1

--33. Write an SQL query to remove duplicates from a table without using a temporary table.
select * from EmployeeDetailss;
delete from EmployeeDetailss where EmpId  not in (select min(empid) from EmployeeDetailss group by EmpId,FullName,ManagerId,DateOfJoining,City);

---or 
 
delete e1 from EmployeeDetailss as e1 join EmployeeDetailss as e2 on e1.EmpId=e2.EmpId
WHERE E1.EmpId > E2.EmpId 
AND E1.FullName = E2.FullName 
AND E1.ManagerId = E2.ManagerId
AND E1.DateOfJoining = E2.DateOfJoining
AND E1.City = E2.City;

---34. Write an SQL query to fetch only odd rows from the table.
select * from EmployeeDetailss
where EmpId%2=1;


---35. Write an SQL query to fetch only even rows from the table.
select * from EmployeeDetailss
where EmpId%2=0;

--36. Write an SQL query to create a new table with data and structure copied from another table.
--select * into newtable from EmployeeDetailss;


--37. Write an SQL query to create an empty table with the same structure as some other table.
/*CREATE TABLE new_table 
  AS (SELECT * 
      FROM old_table WHERE 1=2); */

	  --38. Write an SQL query to fetch top n records.
	  select top 2 * from EmployeeDetailss;

--39. Write an SQL query to find the nth highest salary from a table.
select top 1  Salary from (
select top 2 Salary
from EmployeeSalary 
order by Salary desc ) as s 
order by salary asc;

--40. Write SQL query to find the 3rd highest salary from a table without using the TOP/limit keyword.
select Salary from EmployeeSalary as e1
where 2=(select count(distinct e2.salary) from EmployeeSalary as e2 where e2.Salary>e1.Salary)
order by Salary desc

/*Removing outliers:
Outliers can significantly affect statistical analysis. You can identify and remove outliers using SQL aggregate functions along with statistical techniques like z-score or percentile.
Example:
SELECT *
FROM table_name
WHERE column_name BETWEEN
(SELECT PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY column_name) FROM table_name)
AND
(SELECT PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY column_name) FROM table_name);/*