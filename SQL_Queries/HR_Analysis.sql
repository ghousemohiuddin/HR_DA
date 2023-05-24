select * from hr;

-- gender breakdown of employees in the company
select gender, count(gender) as gender_count from hr group by gender;

-- racial breakdown of employees in the company
select race, count(race) as racial_count from hr group by race order by racial_count desc;

-- age distribution of employees in the company
select age, count(age) as age_employee_count from hr group by age;

select min(age) as youngest, max(age) as eldest from hr;
select (case
			when age>=18 and age<=24 then '18-24'
            when age>=25 and age<=34 then '25-34'
            when age>=35 and age<=44 then '35-44'
            when age>=45 and age<=54 then '45-54'
            when age>=55 and age<=64 then '55-64'
            else '65+'
		end) as age_group, count(*) as age_group_count from hr group by age_group order by age_group;
        
-- distribution of employees in the company on the basis of age and gender
select (case
			when age>=18 and age<=24 then '18-24'
            when age>=25 and age<=34 then '25-34'
            when age>=35 and age<=44 then '35-44'
            when age>=45 and age<=54 then '45-54'
            when age>=55 and age<=64 then '55-64'
            else '65+'
		end) as age_group, gender, count(*) as count from hr group by age_group, gender order by age_group, gender;
        
-- employees work at headquarters versus remote locations
select location, count(*) as location_count from hr group by location order by location_count desc; 

-- average duration of employement for the employees who have been terminated
select floor(avg(datediff(date(termdate),hire_date))/365) as avg_employement_duration from hr where date(termdate)<=curdate() and termdate<>'0000-00-00';

-- variation of gender distribution accross departments
select department,gender,count(*) as dept_gender_count from hr group by department, gender order by department;

-- disribution of job titles accross the company
select jobtitle, count(*) as job_count from hr group by jobtitle order by jobtitle desc;

-- highest termination rate as of department
select department, total_count, termination_count, (termination_count/total_count) as termination_rate
	from (select department, count(*) as total_count, 
			     sum(case 
					      when termdate<>'' and date(termdate)<=curdate() then 1
					      else 0 
				      end) as termination_count from hr group by department) as termination
	order by termination_rate desc;
    
-- distribution of employees acress locations by city and state
select location_state, location_city, count(*) as employee_count from hr group by location_state,location_city order by 3 desc;

-- distribution of employees acress locations by state
select location_state, count(*) as employee_count from hr group by location_state order by 2 desc;

-- change in the employee count over time based on hire and term date
select year, hires, terminations, (hires-terminations) as net_change, round(((hires-terminations)/hires)*100,2) as net_change_percent
	from (select year(hire_date) as year, count(*) as hires, 
				 sum(case
						when termdate<>'' and date(termdate)<=curdate() then 1
						else 0 
					 end) as terminations from hr group by year(hire_date)) as hire_term
	order by year asc;

-- tenure distribution over department
select department, round(avg(datediff(date(termdate),hire_date))/365,0) as avg_tenure from hr 
	where date(termdate)<=curdate() and termdate<>'0000-00-00' 
    group by department order by avg_tenure desc;
	





































































