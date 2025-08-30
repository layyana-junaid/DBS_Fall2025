---Layyana Junaid 23k-0056
---Lab 2 In-Lab Tasks

select sum(salary) as Total_Salary from EMPLOYEES;
select avg(salary) as Avg_Salary from EMPLOYEES;

select count(*) as total_employee , manager_id from employees group by(manager_id);

select min(salary) as Min_Salary from EMPLOYEES;

select sysdate from dual;

select TO_CHAR(SYSDATE, 'DAY MONTH YYYY') as full_date from dual;

select count(*) from employees where to_char(hire_date,'Day') = 'Wednesday';

select MONTHS_BETWEEN('01-JAN-2025', '01-OCT-2024') from dual;

select employee_id, first_name, last_name, floor(MONTHS_BETWEEN(SYSDATE, hire_date)) as months_worked from employees order by months_worked desc;

select employee_id, last_name, SUBSTR(last_name, 1, 5) as last5 from employees;

