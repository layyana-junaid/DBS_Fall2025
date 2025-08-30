select count(*) as total_employees from employees;
select count(*) as total_employee , manager_id from employees group by(manager_id);
select distinct manager_id from employees;
select manager_id from employees group by(manager_id);

select sum(salary) from employees;
select sum(salary) as Total_Salary from employees;

select min(salary) as Min_Salary from employees;
select max (salary) as minimu_salary from employees;

select avg(salary) as avg_salary from employees;

--concatenation 
select first_name || salary as first_name_and_salary from employees;
select ALL salary from employees;
select salary from employees;

select salary from employees order by(salary) desc;
select salary from employees order by(salary) asc;

select first_name, hire_date from employees order by(first_name) asc;
select first_name from employees where first_name like 'A__n%';
select FIRST_NAME FROM EMPLOYEES WHERE first_name like '%k';

select * FROM DUAL;

--absolute is a numeric function that automatically return -ve values into +ve 
select abs(-90.5) from dual;
select ceil(-90.3) from dual;
select floor(-90.4) from dual;

select trunc(90.233324, 2) from dual;
select round(90.569) from dual;
select greatest(90, 99, 34) from dual;
select least(90, 33, 100) from dual;

--string func
select lower('Layyana') from dual;
select first_name, lower(first_name) from employees;
select first_name, upper(first_name) from employees;

select INITCAP('the soap') from dual;
select length('Layyana') from dual;
select first_name, length(first_name) from employees;
select ltrim(' Layyana') from dual;

--string kai andar sai dosri strig return kar keh dyta hai 
select substr('Layyana Junaid', 7, 4) from dual;

select lpad('good', 7, '*') from dual;
select rpad('good', 7, '*') from dual;

select ADD_MONTHS('16-sep-2000' ,2) from dual;
select MONTHS_BETWEEN('16-DEC-2024', '16-SEP-2024') FROM DUAL;
select next_day('4-NOV-1999', 'Wednesday') from dual;
select last_day('1-JUN-2008') from dual;
select new_time('1-JUN-2008', 'PST','EST') from dual;

--employing of people on saturday 
select * from employees;
select count(*) from employees where to_char(hire_date,'Day') = 'Saturday';
select count(*) from employees where to_char(hire_date,'Day') = 'Wednesday';
