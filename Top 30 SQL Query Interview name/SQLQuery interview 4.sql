select * from  EmployeeInfo;
select * from EmployeePosition;

--Q1. Write a query to fetch the EmpFname from the EmployeeInfo table in upper case and use the ALIAS name as EmpName.
select upper(EmpFname) as EmpName from EmployeeInfo;

--Q2. Write a query to fetch the number of employees working in the department ‘HR’.
select count(*) as number_of_employees  from EmployeeInfo
where Department='HR';

---Q3. Write a query to get the current date.
select GETDATE()as current_dates;

---Q4. Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.
select EmpLname,left(EmpLname,4) from EmployeeInfo;
--or 
select SUBSTRING(EmpLname,1,4) from EmployeeInfo;

--Q5. Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

select  SUBSTRING(Address,1,CHARINDEX('(',Address)-1) as address from EmployeeInfo

--Q6. Write a query to create a new table which consists of data and structure copied from the other table.

select * into new_emp_info from EmployeeInfo;

select * from  new_emp_info;
drop table new_emp_info;

---Q7. Write sql query to find all the employees whose salary is between 50000 to 100000.

select EmpFname,EmpLname
from  EmployeeInfo as e1
join EmployeePosition as e2 on e1.EmpID=e2.EmpID
where Salary between 50000  and 100000;


--Q8. Write a query to find the names of employees that begin with ‘S’
select EmpFname 
from EmployeeInfo
where EmpFname  like 's%';

---Q9. Write a query to fetch top N records.

select top 2 * from EmployeeInfo;

--Q10. Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space
select EmpFname,EmpLname,CONCAT(EmpFname,' ',EmpLname)as FullName  from EmployeeInfo;

---Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 and are grouped according to gender

select count(*)as number_of_employees 
from EmployeeInfo
where DOB between cast('1970-05-02' as date) and cast('1975-12-31' as date)
group by gender;

---Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.
select * 
from EmployeeInfo
order by EmpLname desc,Department asc;

--Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.
select *  from EmployeeInfo
where EmpLname like '____a';

--Q14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.

select *  
from EmployeeInfo
where EmpFname not in ('Sanjay' , 'Sonia');

--Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”
select * 
from EmployeeInfo
where Address='DELHI(DEL)';

--Q16. Write a query to fetch all employees who also hold the managerial position.
select  empfname,emplname 
from EmployeeInfo as e1
join EmployeePosition as e2 on e1.empid=e2.empid
where empposition ='manager';


--Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.
select department,count(EmpID)as count_of_employees
from EmployeeInfo
group by department
order by count_of_employees asc;

--Q18. Write a query to calculate the even and odd records from a table.
select * from EmployeeInfo;

--even
select * from EmployeeInfo
where EmpID%2=0;

--odd
select * from EmployeeInfo
where EmpID%2=1;

--Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.

select  distinct e1.*
from EmployeeInfo as e1
join EmployeePosition  as e2 on e1.EmpID=e2.EmpID

--Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.
select * from EmployeePosition

--min
select top 2 Salary from EmployeePosition
order by Salary asc;
--max
select top 2 Salary from EmployeePosition
order by Salary desc;

--
 select top 2 * from (select  * , row_number() over(order by salary desc)as rn from EmployeePosition )as rp;
 
 select top 2 * from ( select * ,row_number() over ( order by salary) as rn from EmployeePosition )as np;

 --Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword
 --n-1=(3-1) 3th highest
select salary from EmployeePosition as e1
where 3=(select count(distinct e2.salary) from EmployeePosition as e2
where e2.salary>e1.salary);
-- 2nd highest
select max(salary)as salary from EmployeePosition
where salary < (select max(salary) from EmployeePosition);
---n th highest
 with cte as(select * , ROW_NUMBER() over (order by Salary desc)as rn from EmployeePosition )
 select salary from cte 
 where rn=2;



 ---Q22. Write a query to retrieve duplicate records from a table.
 select EmpID,EmpFname,EmpLname,Department, count(*)as duplicate_count
 from  EmployeeInfo
 group by  EmpID,EmpFname,EmpLname,Department
 having count(*)>1;

 ---Q23. Write a query to retrieve the list of employees working in the same department.
 select * from EmployeeInfo;

 select distinct e1.EmpFname, e1.Department from EmployeeInfo as e1,EmployeeInfo as e2
 where e1.Department=e2.Department and e1.EmpID!=e2.EmpID;

 ---Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.
 with cte as(select  *, ROW_NUMBER() over (order by empid desc)as rn from EmployeeInfo)
 select * from cte 
 where rn <=3

 ---or
  select top 3 EmpID,EmpFname,EmpLname,Department,Project,Address,DOB,Gender from EmployeeInfo
  order by EmpID desc;

  ---Q25. Write a query to find the third-highest salary from the EmpPosition table.
 
  select top 1 salary from (
  select top 3 salary 
  from EmployeePosition
  order by salary desc) as emp
  order by salary asc;
  ---or 
  select salary from EmployeePosition as e1
  where 2=(select count( distinct e2.salary) as no_of_salary 
  from EmployeePosition as e2
  where e2.Salary>e1.Salary)


  ---Q26. Write a query to display the first and the last record from the EmployeeInfo table.
  select * from  EmployeeInfo;
  select * from EmployeeInfo where empid=(select min(empid)as mininum from EmployeeInfo);
  select * from EmployeeInfo where empid=(select max(empid)as maxnum from EmployeeInfo);

  --or 
  with cte as (select *, ROW_NUMBER() over (order by empid ) as rn from  EmployeeInfo)
  select * from cte 
  where rn=1 or rn=(select count(*) from  EmployeeInfo);

  ---Q27. Write a query to add email validation to your database

 -- Q28. Write a query to retrieve Departments who have less than 2 employees working in it

 select Department, count(*) no_of_emp from EmployeeInfo
 group by  Department
 having count(*)<2;

 ---Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them.

 select EmpPosition,sum(Salary)as total_salary from EmployeePosition
 group by EmpPosition;


 ---Q30. Write a query to fetch 50% records from the EmployeeInfo table.
 with cte as (select * , row_number() over (order by empid) as rn from EmployeeInfo)
 select * from cte
 where rn<=(select count(rn)/2 from cte )
 
 ---or 
 select * from EmployeeInfo 
 where EmpID<=(select count(EmpID)/2 from EmployeeInfo )


