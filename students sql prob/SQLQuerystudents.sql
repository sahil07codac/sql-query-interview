select * from student_list;
select * from correct_answer;
select * from question_paper_code;
select * from student_response;






select sl.roll_number,sl.student_name,sl.class,section,sl.school_name, 
sum(case  when sr.question_paper_code=ca.question_paper_code and sr.question_number=ca.question_number and 
sr.option_marked=ca.correct_option  and sr.option_marked!='e'and qp.subject='math' then  1 else 0 
end) as mathcorrect 
,sum(case  when sr.question_paper_code=ca.question_paper_code and sr.question_number=ca.question_number and 
sr.option_marked!=ca.correct_option  and sr.option_marked!='e'and qp.subject='math' then  1 else 0 
end) as mathwrong,
sum(case  when sr.question_paper_code=ca.question_paper_code and sr.question_number=ca.question_number and 
sr.option_marked!=ca.correct_option  and sr.option_marked='e'and qp.subject='math' then  1 else 0 
end) as mathyettolearn,
sum(case  when sr.question_paper_code=ca.question_paper_code and sr.question_number=ca.question_number and 
sr.option_marked=ca.correct_option  and sr.option_marked!='e'and qp.subject='math' then  1 else 0 
end) as mathscore,
(sum(case when     qp.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) * 100) / sum(case when qp.subject = 'Math' then 1 else 0 end)
 as mathspercentage,
 sum(case  when sr.question_paper_code=ca.question_paper_code and sr.question_number=ca.question_number and 
sr.option_marked=ca.correct_option  and sr.option_marked!='e'and qp.subject='Science' then  1 else 0 
end) as Sciencecorrect 
,sum(case  when sr.question_paper_code=ca.question_paper_code and sr.question_number=ca.question_number and 
sr.option_marked!=ca.correct_option  and sr.option_marked!='e'and qp.subject='Science' then  1 else 0 
end) as Sciencewrong,
sum(case  when sr.question_paper_code=ca.question_paper_code and sr.question_number=ca.question_number and 
sr.option_marked!=ca.correct_option  and sr.option_marked='e'and qp.subject='Science' then  1 else 0 
end) as Scienceyettolearn,
sum(case  when sr.question_paper_code=ca.question_paper_code and sr.question_number=ca.question_number and 
sr.option_marked=ca.correct_option  and sr.option_marked!='e'and qp.subject='Science' then  1 else 0 
end) as Sciencescore,
concat(sum(case when qp.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) * 100 / sum(case when qp.subject = 'Science' then 1 else 0 end), '%') as 'Science_percentage'

from student_response as sr
join student_list as sl on sl.roll_number=sr.roll_number
join question_paper_code as qp on sr.question_paper_code=qp.paper_code
join correct_answer as ca on qp.paper_code=ca.question_paper_code
group by sl.roll_number,sl.student_name,sl.class,section,sl.school_name;





Select sl.roll_number,
sl.student_name,
sl.class,
sl.section,
sl.school_name,
sum(case when pc.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) as 'Math_correct',
sum(case when pc.subject = 'Math' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) as 'Math_Wrong',
sum(case when pc.subject = 'Math' and sr.option_marked = 'e'
then 1 else 0 end) as 'Math_yet_to_learn',
sum(case when pc.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) as 'Math_Score',
concat(sum(case when pc.subject = 'Math' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) * 100 / sum(case when pc.subject = 'Math' then 1 else 0 end), '%') as 'Math_percentage',
sum(case when pc.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) as 'Science_correct',
sum(case when pc.subject = 'Science' and sr.option_marked <> ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) as 'Science_Wrong',
sum(case when pc.subject = 'Science' and sr.option_marked = 'e'
then 1 else 0 end) as 'Science_yet_to_learn',
sum(case when pc.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) as 'Science_Score',
concat(sum(case when pc.subject = 'Science' and sr.option_marked = ca.correct_option and sr.option_marked <> 'e'
then 1 else 0 end) * 100 / sum(case when pc.subject = 'Science' then 1 else 0 end), '%') as 'Science_percentage'
from student_list sl
join student_response sr
on sr.roll_number = sl.roll_number
join correct_answer ca
on ca.question_paper_code = sr.question_paper_code and ca.question_number = sr.question_number
join question_paper_code pc
on pc.paper_code = ca.question_paper_code
group by sl.roll_number, sl.student_name, sl.class, sl.section, sl.school_name
order by sl.class, sl.section, sl.roll_number, sl.student_name;








