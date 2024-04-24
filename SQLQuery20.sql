CREATE TABLE users (
  id INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
  name VARCHAR(50) NOT NULL,
  active BIT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE()
);



INSERT INTO users (name, active, created_at, updated_at)
VALUES 
('Rohit', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('James', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('David', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Steven', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Ali', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Rahul', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Jacob', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Maryam', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Shwetha', 0, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Sarah', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Alex', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Charles', 0, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Perry', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Emma', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Sophia', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Lucas', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Benjamin', 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
('Hazel', 0, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE()));


CREATE TABLE batches (
  id INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
  name VARCHAR(100) UNIQUE NOT NULL,
  active BIT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE()
);
INSERT INTO batches (name, active, created_at, updated_at) 
VALUES 
('Statistics', 1, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -6, GETDATE())),
('Mathematics', 1, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -6, GETDATE())),
('Physics', 0, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -6, GETDATE()));

CREATE TABLE student_batch_maps (
  id INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
  user_id INTEGER NOT NULL REFERENCES users(id),
  batch_id INTEGER NOT NULL REFERENCES batches(id),
  active BIT NOT NULL DEFAULT 1,
  deactivated_at DATETIME NULL,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO student_batch_maps (user_id, batch_id,active, created_at, updated_at, deactivated_at)
VALUES 
(1, 1,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(2, 1,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(3, 1,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(4, 1,0, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(5, 2,1,GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(6, 2, 1,GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(7, 2,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(8, 2,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(9, 2, 0,GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(10, 3,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(11, 3,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(12, 3,0, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(13, 3,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(14, 3,1, GETDATE(), DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(4, 2,1, GETDATE(), DATEADD(DAY, -4, GETDATE()), DATEADD(DAY, -3, GETDATE())),
(9, 3,0, GETDATE(), DATEADD(DAY, -3, GETDATE()), DATEADD(DAY, -2, GETDATE())),
(9, 1,1, GETDATE(), DATEADD(DAY, -2, GETDATE()), DATEADD(DAY, -1, GETDATE())),
(12, 1,1, GETDATE(), DATEADD(DAY, -4, GETDATE()), DATEADD(DAY, -3, GETDATE()));



CREATE TABLE instructor_batch_maps (
  id INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
  user_id INTEGER REFERENCES users(id),
  batch_id INTEGER REFERENCES batches(id),
  active BIT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE()
);
INSERT INTO instructor_batch_maps (user_id, batch_id, active, created_at, updated_at)
VALUES 
(15, 1, 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(16, 2, 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(17, 3, 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE())),
(18, 2, 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -4, GETDATE()));



CREATE TABLE sessions (
  id INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
  conducted_by INTEGER NOT NULL REFERENCES users(id),
  batch_id INTEGER NOT NULL REFERENCES batches(id),
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE()
);

INSERT INTO sessions (conducted_by, batch_id, start_time, end_time, created_at, updated_at)
VALUES 
(15, 1, DATEADD(MINUTE, -240, CURRENT_TIMESTAMP), DATEADD(MINUTE, -180, CURRENT_TIMESTAMP), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(16, 2, DATEADD(MINUTE, -240, CURRENT_TIMESTAMP), DATEADD(MINUTE, -180, CURRENT_TIMESTAMP), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(17, 3, DATEADD(MINUTE, -240, CURRENT_TIMESTAMP), DATEADD(MINUTE, -180, CURRENT_TIMESTAMP), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(15, 1, DATEADD(MINUTE, -180, CURRENT_TIMESTAMP), DATEADD(MINUTE, -120, CURRENT_TIMESTAMP), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(16, 2, DATEADD(MINUTE, -180, CURRENT_TIMESTAMP), DATEADD(MINUTE, -120, CURRENT_TIMESTAMP), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(18, 2, DATEADD(MINUTE, -120, CURRENT_TIMESTAMP), DATEADD(MINUTE, -60, CURRENT_TIMESTAMP), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);




CREATE TABLE attendances (
  student_id INTEGER NOT NULL REFERENCES users(id),
  session_id INTEGER NOT NULL REFERENCES sessions(id),
  rating FLOAT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE(),
  PRIMARY KEY (student_id, session_id)
);
INSERT INTO attendances (student_id, session_id, rating, created_at, updated_at)
VALUES 
(1, 1, 8.5, GETDATE(), GETDATE()),
(2, 1, 7.5, GETDATE(), GETDATE()),
(3, 1, 6.0, GETDATE(), GETDATE()),
(5, 2, 8.5, GETDATE(), GETDATE()),
(6, 2, 7.5, GETDATE(), GETDATE()),
(7, 2, 6.0, GETDATE(), GETDATE()),
(8, 2, 6.0, GETDATE(), GETDATE()),
(10, 3, 9.5, GETDATE(), GETDATE()),
(11, 3, 7.0, GETDATE(), GETDATE()),
(13, 3, 8.0, GETDATE(), GETDATE()),
(14, 3, 6.0, GETDATE(), GETDATE()),
(1, 4, 7.0, GETDATE(), GETDATE()),
(2, 4, 5.5, GETDATE(), GETDATE()),
(5, 5, 5.0, GETDATE(), GETDATE()),
(5, 6, 6.0, GETDATE(), GETDATE()),
(9, 2, 4.0, GETDATE(), GETDATE()),
(12, 3, 5.0, GETDATE(), GETDATE());

CREATE TABLE tests (
  id INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
  batch_id INTEGER REFERENCES batches(id),
  created_by INTEGER REFERENCES users(id),
  total_mark INTEGER NOT NULL,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE()
);
INSERT INTO tests (batch_id, created_by, total_mark, created_at, updated_at)
VALUES 
(1, 15, 100, GETDATE(), GETDATE()),
(2, 16, 100, GETDATE(), GETDATE()),
(3, 17, 100, GETDATE(), GETDATE()),
(2, 18, 100, GETDATE(), GETDATE()),
(1, 15, 50, GETDATE(), GETDATE()),
(1, 15, 25, GETDATE(), GETDATE()),
(1, 15, 25, GETDATE(), GETDATE()),
(2, 16, 50, GETDATE(), GETDATE()),
(3, 17, 50, GETDATE(), GETDATE());



CREATE TABLE test_scores (
  test_id INTEGER REFERENCES tests(id),
  user_id INTEGER REFERENCES users(id),
  score INTEGER NOT NULL,
  created_at DATETIME NOT NULL DEFAULT GETDATE(),
  updated_at DATETIME NOT NULL DEFAULT GETDATE(),
  PRIMARY KEY(test_id, user_id)
);


INSERT INTO test_scores (test_id, user_id, score, created_at, updated_at)
VALUES 
(1, 1, 80, GETDATE(), GETDATE()),
(1, 2, 60, GETDATE(), GETDATE()),
(1, 3, 30, GETDATE(), GETDATE()),
(2, 5, 80, GETDATE(), GETDATE()),
(2, 6, 35, GETDATE(), GETDATE()),
(2, 7, 38, GETDATE(), GETDATE()),
(2, 8, 90, GETDATE(), GETDATE()),
(3, 10, 65, GETDATE(), GETDATE()),
(3, 11, 85, GETDATE(), GETDATE()),
(3, 13, 95, GETDATE(), GETDATE()),
(3, 14, 100, GETDATE(), GETDATE()),
(5, 1, 40, GETDATE(), GETDATE()),
(5, 2, 35, GETDATE(), GETDATE()),
(5, 3, 45, GETDATE(), GETDATE()),
(6, 1, 22, GETDATE(), GETDATE()),
(6, 2, 12, GETDATE(), GETDATE()),
(7, 1, 16, GETDATE(), GETDATE()),
(7, 3, 10, GETDATE(), GETDATE()),
(8, 5, 15, GETDATE(), GETDATE()),
(8, 6, 20, GETDATE(), GETDATE()),
(9, 13, 25, GETDATE(), GETDATE()),
(9, 14, 35, GETDATE(), GETDATE());


select * from users;
select * from batches;
select * from student_batch_maps;
select * from instructor_batch_maps;
select * from sessions ;
select * from  attendances;
select * from tests;
select * from test_scores;

--1.Calculate the average rating given by students to each teacher for each session created. 
--Also, provide the batch name for which session was conducted.
with cte as(
select a.student_id as student_id,a.session_id as sessionid,a.rating as rainting,i.user_id as instructorid, b.name from attendances as a
join sessions as s on a.session_id=s.id
join batches as b on s.batch_id=b.id
join instructor_batch_maps as i on b.id=i.batch_id)
select name,instructorid,sessionid,avg(rainting)as avgrating from cte
group by sessionid,instructorid, name
order by instructorid;

---or





----
with cte as(
select a.student_id as student_id,a.session_id as sessionid,a.rating as rainting,i.user_id as instructorid ,b.name from attendances as a
join sessions as s on a.session_id=s.id
join batches as b on s.batch_id=b.id
join instructor_batch_maps as i on b.id=i.batch_id)
select  distinct instructorid,name,sessionid ,avg(rainting) over(partition by sessionid)as avgs from cte;

---2.Find the attendance percentage  for each session for each batch. 
--Also mention the batch name and users name who has conduct that session

select * from users;
select * from batches;
select * from sessions ;
select * from  attendances;
select * from student_batch_maps;


with student_per_batch as (
	select batch_id , count(*)as totalbacthcount 
	from student_batch_maps
	where active=1
	group by batch_id), 
multiple_batch as(
	select active.user_id as student_id,active.batch_id as activebatchid,inactive.batch_id as inactivebatch  
	from  student_batch_maps as active
	join  student_batch_maps as inactive on active.user_id=inactive.user_id
	where active.active=1 and inactive.active=0
	),
student_per_section as(
	select session_id,count(*)as attendedsudent from attendances as a
	join sessions as s on a.session_id=s.id
	where a.student_id not in (select student_id from multiple_batch ) 
	or s.id not in (select inactivebatch  from multiple_batch )
	group by session_id),
counttable as(
	select s.batch_id,session_id,totalbacthcount,attendedsudent from  sessions as  s
	join student_per_batch as sb on s.batch_id=sb.batch_id
	join student_per_section as ss on s.id=ss.session_id),
	percentage as(
select batch_id,session_id,totalbacthcount,attendedsudent, cast(100*(cast(attendedsudent as decimal(10,2))/totalbacthcount) as decimal (10,2))as percentage 
from counttable)
select p.session_id,p.percentage,sp.attendedsudent,p.totalbacthcount,b.name,u.name from percentage as p 
join  sessions as s on p.session_id=s.id
join student_per_section as sp on sp.session_id=s.id
join batches b on b.id = s.batch_id
join users u on u.id = s.conducted_by;
;















---

;





---3.What is the average marks scored by each student in all the tests the student had appeared?




select user_id as student_id ,avg(score) avgscore from test_scores
group by user_id;



---4.A student is passed when he scores 40 percent of total marks in a test.
--Find out how many students passed in each test. Also mention the batch name for that test.

select * from tests;
select * from test_scores;
select * from batches;
select * from users;


with cte as(
	select test_id,user_id,score,batch_id,total_mark from test_scores as s
	left join users as u on s.user_id=u.id
	join tests as t on s.test_id=t.id), 
percentagesof as(
	select test_id, batch_id,user_id,score,total_mark,(100*cast(score as decimal(10,2))/total_mark) percentages 
	from cte ),
gradesoff as(
	select *,case when percentages>=40 then 'pass' else 'fail'
	end as grade
	from percentagesof) , g as(
select test_id,batch_id,count(grade)as countofpass from gradesoff 
where grade='pass'
group by  test_id,batch_id)
select test_id,countofpass,name from g 
join batches as b on g.batch_id=b.id
;

--5.A student can be transferred from one batch to another batch. 
---If he is transferred from batch a to batch b. batch b’s active=true and batch a’s active=false in student_batch_maps.
 --At a time, one student can be active in one batch only. One Student can not be transferred more than four times.
 --Calculate each students attendance percentage for all the sessions created for his past batch. 
 --Consider only those sessions for which he was active in that past batch.


select * from users;
select * from batches;
select * from sessions ;
select * from  attendances;
select * from student_batch_maps;

with total_sessions as(
	select sbm.user_id as student_id,s.batch_id,COUNT(sbm.user_id) as total_sessions_per_student from student_batch_maps as sbm
	join sessions as s on sbm.batch_id=s.batch_id
	where sbm.active=0
	group by sbm.user_id,s.batch_id),
multiple_batch_students as
		(select inactive.user_id, inactive.batch_id as inactive_batch, active.batch_id  as active_batch
		from student_batch_maps active
		join student_batch_maps inactive on active.user_id = inactive.user_id
		where active.active = 1
		and inactive.active = 0),
attended_sessions as(
		select student_id, count(1) as sessions_attended_by_student
		from attendances a
		join sessions s on s.id = a.session_id
		where (a.student_id)  in (select user_id from multiple_batch_students) or s.id not in (select inactive_batch  from multiple_batch_students )
		group by student_id)
select u.name as student,(0.1*coalesce(sessions_attended_by_student,0)/ total_sessions_per_student)* 100 as percentage
from total_sessions TS
left join attended_sessions ATTS on ATTS.student_id = TS.student_id
join users u on u.id = TS.student_id
order by 1;

---6. What is the average percentage of marks scored by each student in all the tests the student had appeared?

select * from tests;
select * from test_scores;

select * from users;

 with cte as (
select u.name,ts.test_id,ts.score,t.total_mark,(score*0.1/total_mark)*100 as  percentages from test_scores as ts
join tests as t on ts.test_id=t.id
join users as u on ts.user_id=u.id )
select name,avg( percentages)avgper from cte
group by name ;


---7.A student is passed when he scores 40 percent of total marks in a test.
---Find out how many percentage of students have passed in each test. Also mention the batch name for that test.


select * from tests;
select * from test_scores;
select * from batches;
select * from users;

with totoalpassstudent as(
select ts.test_id, b.name as batch, count(ts.test_id) as students_passed
		from tests t
		join test_scores ts on t.id = ts.test_id
		join users u on u.id = ts.user_id
		join batches b on b.id = t.batch_id
		where ((cast(ts.score as decimal(10,2))/t.total_mark)*100) >= 40
		group by ts.test_id,b.name),
total_student_fortest as (
select test_id, count(user_id)as totalstudent  from test_scores
group by test_id)
select tsft.test_id,tp.batch,cast(tp.students_passed as decimal(10,2))/tsft.totalstudent as percentages from total_student_fortest as tsft
join totoalpassstudent as tp on tsft.test_id=tp.test_id
;


