use Sql_Analytics
Go

--Data ANALYTICS using SQL

--data i am  taking from censusindia.co.in/districts
--import the data from csv

select * from Sheet;

select * from Data;

--1st task count the number  total number of rows in Data1

select count(*) as Total_Number_of_Rows from Data;



-- 2nd task show the data for a particular state

select * from Data where State='Maharashtra';

select * from Data where State in('Maharashtra','Bihar') order by State,District;



--3rd task population of India

select sum(Population) as Total_Population  from Sheet


--4th task average growth of india

select concat(round(avg(Growth)*100,2),'%') as AVG_Growth from Data


-- 5th task Get the Avg Growth rate by state

select State,concat(round(avg(Growth)*100,2),'%') as Avg_Growth from Data group by State




--6th task get the avg sex-ratio

select avg(Sex_ratio) as avg_Sex_ratio from data


--7th task get the avg sex ration by state
select State,round(avg(Sex_ratio),2) as avg_Sex_ratio from Data group by State


--8th state having the highest growth rate

select max(Avg_Growth) as Highest_growth_rate from (select State,round(avg(Growth)*100,2) as Avg_Growth from Data group by State) as t

--or 

select State,round(avg(Growth)*100,2) as Avg_Growth from Data group by State order by Avg_Growth desc



--9th task calculate the avg literacy rate on India

select concat(round(avg(Literacy),2),'%') as Avg_Literacy_Rate from Data 



--10th task calculate the avg literacy rate state wise having more than 85


select State,round(avg(Literacy),2) as Avg_Literacy_Rate from dbo.Data 
group by State 
having round(avg(Literacy),2)>85
order by Avg_Literacy_Rate desc




-- 11th task get the top 3 and bottom 3 avg literacy state
-- for top 3

select top 3 State,round(avg(Literacy),2) as Avg_Literacy_Rate from dbo.Data 
group by State 
order by Avg_Literacy_Rate desc

--for bottom 3

select top 3 State,round(avg(Literacy),2) as Avg_Literacy_Rate from dbo.Data 
group by State 
order by Avg_Literacy_Rate 


-- 12th task get the top 3 and bottom 3 into single result
-- we can perform this task using temp tables

select * into #toptemptable
from (select top 3 State,round(avg(Literacy),2) as Avg_Literacy_Rate from dbo.Data 
group by State 
order by Avg_Literacy_Rate desc) as b

select * into #bottomtemptable
from (select top 3 State,round(avg(Literacy),2) as Avg_Literacy_Rate from dbo.Data 
group by State 
order by Avg_Literacy_Rate) as t

select * from #toptemptable
select * from #bottomtemptable


--union operator for combining the two tables
select * from #toptemptable
union
select * from #bottomtemptable
order by Avg_Literacy_Rate



 

 --13th task count  the states starting with the letter a in a particular state
 
select count(*) as [Count] from ( select * from Sheet where State='Uttar Pradesh') as c 
where (District like 'a%')
 or (District like 'k%')

 --14th task list the states starting with the letter a and ends with the letter d
 select * from (select * from Sheet where State='Uttar Pradesh') as e
 where District like 'k%r'






 --15 task calculate the number of males and number of females into the table

 --formula sex-ratio =total number of females/total number of males
 -- female+males=population

select District,State,Population,floor(population/(Sex_Ratio/1000+1)) as Males,
floor((population*(sex_Ratio/1000))/(1+(sex_Ratio/1000))) as Females 
from (select d.District,d.State,d.Sex_ratio,s.population from Data d
inner join Sheet s
on(s.District=d.District)) as n
order by District



-- calculate total literate people state wise

select State,sum(population) as Population,sum(floor(population*Literacy/100)) as Literate_people 
from 
(select d.District,d.State,d.Literacy,s.population from Data d
inner join Sheet s
on(s.District=d.District)) as n
group by State


--population in previous ce

select d.District,d.State,d.Growth,s.population,floor((s.population*100)/(100+d.Growth)) as Previos_year_population from Data d
inner join Sheet s
on(s.District=d.District)