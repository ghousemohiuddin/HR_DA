select * from hr;

set sql_safe_updates = 0;

alter table hr rename column ï»¿id to id;
alter table hr modify id varchar(20);
describe hr;



select birthdate from hr;
update hr set birthdate = case 
								when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
                                when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
                                else null
						  end;
alter table hr modify birthdate date;

alter table hr add column age int;
update hr set age = timestampdiff(YEAR, birthdate, curdate());
select age from hr;
select min(age),max(age) from hr;
select count(*) from hr where age<18;
select count(*) from hr;
delete from hr where age<18;

select hire_date from hr;
update hr set hire_date = case 
								when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
                                when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
                                else null
						  end;
alter table hr modify hire_date date;

select termdate from hr;
update hr set termdate=date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')) where termdate is not null and termdate!='';



































































































