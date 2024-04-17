select * from student;
select * from program;
select * from Scholarship;

---1. Write a SQL query to fetch “FIRST_NAME” from the Student table in upper case and use ALIAS name as STUDENT_NAME.

select UPPER(FIRST_NAME) AS STUDENT_NAME  from student;


--2. Write a SQL query to fetch unique values of MAJOR Subjects from Student table.
select DISTINCT MAJOR from student;

--3. Write a SQL query to print the first 3 characters of FIRST_NAME from Student table.
select SUBSTRING(FIRST_NAME,1,3) AS  FIRST_NAME from student;

---4. Write a SQL query to find the position of alphabet (‘a’) int the first name column ‘Shivansh’ from Student table

select CHARINDEX('a',first_name)as  position_of_alphabet  from student
where first_name='Shivansh';

--5. Write a SQL query that fetches the unique values of MAJOR Subjects from Student table and print its length
select DISTINCT MAJOR , len(major)as lengths  from student
order by lengths desc ;

--6. Write a SQL query to print FIRST_NAME from the Student table after replacing ‘a’ with ‘A’.
select replace(first_name,'a','A') as replacename from student;

--7. Write a SQL query to print the FIRST_NAME and LAST_NAME from Student table into single column COMPLETE_NAME.
select concat(first_name,'', last_name)as COMPLETE_NAME  from student;

--8. Write a SQL query to print all Student details from Student table order by FIRST_NAME Ascending and MAJOR Subject descending .
select * from student
order by first_name asc, major desc;

---9. Write a SQL query to print details of the Students with the FIRST_NAME as ‘Prem’ and ‘Shivansh’ from Student table.
select * from student
where first_name in ('Prem','Shivansh');

---10. Write a SQL query to print details of the Students excluding FIRST_NAME as ‘Prem’ and ‘Shivansh’ from Student table.
select * from student
where first_name  not in ('Prem','Shivansh');

--11. Write a SQL query to print details of the Students whose FIRST_NAME ends with ‘a’.
select * from student
where first_name like '%a';

--12. Write an SQL query to print details of the Students whose FIRST_NAME ends with ‘a’ and contains six alphabets.
select * from student
where first_name like '%_____a' ;


--13. Write an SQL query to print details of the Students whose GPA lies between 9.00 and 9.99.
select * from student
where gpa  between 9.00 and 9.99;

--14. Write an SQL query to fetch the count of Students having Major Subject ‘Computer Science’.

select major,count(student_id) as count_of_Students from student
where major  ='Computer Science'
group by major;

--15. Write an SQL query to fetch Students full names with GPA >= 8.5 and <= 9.5.
select concat(first_name,'',last_name) as fullnames from student
where  GPA >= 8.5  and gpa<= 9.5;

--16. Write an SQL query to fetch the no. of Students for each MAJOR subject in the descending order.
select major,count(*)as no_of_Students  from student
group by major 
order by no_of_Students  desc;

---17. Display the details of students who have received scholarships, including their names, scholarship amounts, and scholarship dates.
select first_name,last_name,scholarship_amount,scholarship_date from student as s
join Scholarship  as t on s.student_id=t.student_ref_id

---18. Write an SQL query to show only odd rows from Student table.
select * from student
where student_id%2=1;

--19. Write an SQL query to show only even rows from Student table.
select * from student
where student_id%2=0;

--20. List all students and their scholarship amounts if they have received any. If a student has not received a scholarship, display NULL for the scholarship details.
select * from student;
select * from scholarship;

select s.first_name,s.last_name,t.scholarship_amount,t.scholarship_date from student as s
left join scholarship as t on s.student_id=t.student_ref_id;

--21. Write an SQL query to show the top n (say 5) records of Student table order by descending GPA.
select top 5 gpa from student
order by gpa desc;

--22. Write an SQL query to determine the nth (say n=5) highest GPA from a table
 with cte as (select *,dense_rank() over (order by gpa desc) as rn from student)
 select * from cte 
 where rn =5
 --or 
 select top 1 gpa from 
 (select top 5 gpa 
 from student order by gpa desc) as sm
 order by gpa  asc;
 --23. Write an SQL query to determine the 5th highest GPA without using LIMIT/ top keyword.
  with cte as (select *,dense_rank() over (order by gpa desc) as rn from student)
 select * from cte 
 where rn =5

 --or 
 select gpa from student as s
 where 4=(select count( distinct t.gpa)  from student as t
 where t.gpa>s.gpa)


 --24. Write an SQL query to fetch the list of Students with the same GPA.
 select s.first_name,s.last_name from student as s
 join student as t on s.student_id=t.student_id
 where s.gpa=t.gpa and s.student_id!=t.student_id;
  ---or
 select s.* from student as s ,student as t
 where s.gpa=t.gpa and s.student_id!=t.student_id;

 ---25. Write an SQL query to show the second highest GPA from a Student table using sub-query.
 select max(gpa) as gpa from student where  gpa <(select max(gpa) from student);


 --26. Write an SQL query to show one row twice in results from a table.
SELECT * FROM Student 
union all
SELECT * FROM Student 
order by student_id

---27. Write an SQL query to list STUDENT_ID who does not get Scholarship.
select * from student;
select * from scholarship;

select student_id from student 
where student_id not in (select student_ref_id from scholarship);
--or
with cte as (select * from student as s
left join scholarship as t on s.student_id=t.student_ref_id
)
select student_id from cte
where student_id!=student_ref_id or student_ref_id is null

---28. Write an SQL query to fetch the first 50% records from a table
with cte as (select *,row_number() over (order by student_id)as rn from student)
select * from cte 
where rn <=(select count(student_id)/2 from student);


--29. Write an SQL query to fetch the MAJOR subject that have less than 4 people in it.


select major,count(student_id) as no_of_people from student
group by major
having count(student_id)<4;

--30. Write an SQL query to show all MAJOR subject along with the number of people in there
select major,count(student_id)as no_of_people from student
group by  major;

------31. Write an SQL query to show the last record from a table.
select * from student 
where student_id =(select max(student_id) from student);

---32. Write an SQL query to fetch the first row of a table
select * from student
where student_id =(select min(student_id) from student);

---33. Write an SQL query to fetch the last five records from a table
 with cte as(select *,row_number() over(order by student_id desc ) as rn from student)
 select * from cte
 where rn<=5
 order by student_id;

 --34. Write an SQL query to fetch three max GPA from a table using co-related subquery.
 select * from student as s
 where  3>(select count(t.gpa) from student as t where s.gpa<t.gpa)
 order by gpa desc;
 
 --35. Write an SQL query to fetch three min GPA from a table using co-related subquery.
 select * from student as s
 where 3 >(select count(t.gpa) from student as t where s.gpa>t.gpa)
 order by gpa ;
 

 --36. Write an SQL query to fetch nth max GPA from a table
 SELECT DISTINCT GPA FROM Student S1 
WHERE n>= (SELECT COUNT(DISTINCT GPA) FROM Student S2 WHERE S1.GPA <= S2.GPA) ORDER BY S1.GPA DESC;

--37. Write an SQL query to fetch MAJOR subjects along with the max GPA in each of these MAJOR subjects.
select major, max(gpa)as maxgpa from student
group by major;

---38. Write an SQL query to fetch the names of Students who has highest GPA
 select * from (select first_name, gpa,row_number() over(order by gpa desc) as rn from student)as s
 where rn =1;
 ---or 
 select  top 1 first_name, gpa from student 
 order by gpa desc;

 --39. Write an SQL query to show the current date and time.
 select GETDATE()

 ---41. Write an SQL query to update the GPA of all the students in ‘Computer Science’ MAJOR subject to 7.5.
 update student set gpa=7.5 where major='Computer Science';
 
 select * from student;

 ---42. Write an SQL query to find the average GPA for each major.
 select major, avg(gpa) avggpa from student
 group by major;
 
 ---43. Write an SQL query to show the top 3 students with the highest GPA.
 select top 3 * from student 
 order by gpa desc;

 ---44. Write an SQL query to find the number of students in each major who have a GPA greater than 7.5.
 select major ,gpa, count(student_id)as no_of_student 
 from student 
 group by major, gpa
 having gpa >7.5;

 select major, count(student_id) as no_of_student  from student
 where gpa>7.5
 group by major;

 ---45. Write an SQL query to find the students who have the same GPA as ‘Shivansh Mahajan’.
 select s.* from student as s , student as t
 where s.gpa=t.gpa and s.FIRST_NAME = 'Shivansh' 
AND s.LAST_NAME = 'Mahajan';

---or
 SELECT * FROM Student WHERE GPA = (SELECT GPA FROM Student WHERE FIRST_NAME = 'Shivansh' 
AND LAST_NAME = 'Mahajan');


select * from EmpolyeeDetails