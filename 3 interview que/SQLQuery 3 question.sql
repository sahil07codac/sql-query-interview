-- DATASET
---election
create table candidates
(
    id      int,
    gender  varchar(1),
    age     int,
    party   varchar(20)
);
insert into candidates values(1,'M',55,'Democratic');
insert into candidates values(2,'M',51,'Democratic');
insert into candidates values(3,'F',62,'Democratic');
insert into candidates values(4,'M',60,'Republic');
insert into candidates values(5,'F',61,'Republic');
insert into candidates values(6,'F',58,'Republic');

create table results
(
    constituency_id     int,
    candidate_id        int,
    votes               int
);
insert into results values(1,1,847529);
insert into results values(1,4,283409);
insert into results values(2,2,293841);
insert into results values(2,5,394385);
insert into results values(3,3,429084);
insert into results values(3,6,303890);

select * from candidates;
select * from results;


with cte as(
	select party,constituency_id,candidate_id,votes ,
	rank() over (partition by constituency_id order by votes desc)as rn 
	from candidates as c
	join results as r on c.id=r.candidate_id)
	--order by constituency_id,votes desc)
select concat(party,' ',count(*) ) as party_won from cte 
where rn=1
group by party;



 ---#2) Advertising System Deviations report ---

-- DATASET

create table customers
(
    id          int,
    first_name  varchar(50),
    last_name   varchar(50)
);
insert into customers values(1, 'Carolyn', 'O''Lunny');
insert into customers values(2, 'Matteo', 'Husthwaite');
insert into customers values(3, 'Melessa', 'Rowesby');


create table campaigns
(
    id          int,
    customer_id int,
    name        varchar(50)
);
insert into campaigns values(2, 1, 'Overcoming Challenges');
insert into campaigns values(4, 1, 'Business Rules');
insert into campaigns values(3, 2, 'YUI');
insert into campaigns values(1, 3, 'Quantitative Finance');
insert into campaigns values(5, 3, 'MMC');


create table events
(
    campaign_id int,
    status      varchar(50)
);
insert into events values(1, 'success');
insert into events values(1, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(3, 'success');
insert into events values(3, 'success');
insert into events values(3, 'success');
insert into events values(4, 'success');
insert into events values(4, 'success');
insert into events values(4, 'failure');
insert into events values(4, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');

insert into events values(4, 'success');
insert into events values(5, 'success');
insert into events values(5, 'success');
insert into events values(1, 'failure');
insert into events values(1, 'failure');
insert into events values(1, 'failure');
insert into events values(2, 'failure');
insert into events values(3, 'failure');

select * from customers;
select * from campaigns;
select * from events;
	
with cte as(
	select  concat(c.first_name,' ',c.last_name)as customer ,c.id,  cs.name ,e.status,
	count(e.status)as t
	from customers as c
	join campaigns as cs on c.id=cs.customer_id
	join events as e on cs.id=e.campaign_id
	group by concat(c.first_name,' ',c.last_name),e.status,c.id,cs.name),
st as (
	select  status,customer ,STRING_AGG(name,',')as e, sum(t)as s ,row_number() over ( order by sum(t) desc)as rn from cte 
	group by status,customer)
select status,customer,e as campagin,s as total from st
where rn <=2
order by status desc


---or
with cte as(
	select c.id,concat(first_name,' ',last_name)as customer,cs.name, e.status,
	count(e.status)as t
	from customers as c
	join campaigns as cs on c.id=cs.customer_id
	join  events as e on cs.id=e.campaign_id
	group by c.id,concat(first_name,' ',last_name),cs.name, e.status),
cte1 as(
	select customer,STRING_AGG( name,',')as campagins, status, sum(t)as total, 
	ROW_NUMBER() over (partition by status order by sum(t) desc) as rn from cte
	group by customer, status)
select status,customer, campagins,total from cte1
where rn=1
order by status desc ,total desc

---
--- #3) Election Exit Poll by state report ---

-- DATASET

create table candidates_tab
(
    id          int,
    first_name  varchar(50),
    last_name   varchar(50)
);
insert into candidates_tab values(1, 'Davide', 'Kentish');
insert into candidates_tab values(2, 'Thorstein', 'Bridge');


create table results_tab
(
    candidate_id    int,
    state           varchar(50)
);
insert into results_tab values(1, 'Alabama');
insert into results_tab values(1, 'Alabama');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'New York');
insert into results_tab values(2, 'New York');
insert into results_tab values(2, 'Texas');
insert into results_tab values(2, 'Texas');
insert into results_tab values(2, 'Texas');

insert into results_tab values(1, 'New York');
insert into results_tab values(1, 'Texas');
insert into results_tab values(1, 'Texas');
insert into results_tab values(1, 'Texas');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'Alabama');

select * from candidates_tab;
select * from results_tab;


----
with cte as(
	select concat(c.first_name,' ',c.last_name)as candidate_name,
	r.state ,
	count(r.state ) as votes ,
	DENSE_RANK() over(partition by concat(c.first_name,' ',c.last_name) order by count(r.state )desc  ) as rn 
	from candidates_tab as c
	join  results_tab as r on c.id=r.candidate_id
	group by concat(c.first_name,' ',c.last_name),r.state ), 
cte1 as(
select candidate_name,CONCAT(state,'(',votes,')')as statevote, rn, votes from cte)
select candidate_name, 
string_agg(case when rn=1 then statevote end,',') as first_place,
string_agg(case when rn=2 then statevote end ,',')as second_place ,
string_agg(case when rn=3 then statevote end ,',')as third_place 
from cte1
group by candidate_name;



