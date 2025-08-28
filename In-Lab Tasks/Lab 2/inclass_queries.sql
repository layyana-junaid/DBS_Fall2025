select count(*) as total_employees from employees;
select count(*) as total_employee , manager_id from employees group by(manager_id);
select distinct manager_id from employees;
select manager_id from employees group by(manager_id);

select sum(salary) from employees;
select sum(salary) as Total_Salary from employees;

select min(salary) as Min_Salary from employees;
select max (salary) as minimu_salary from employees;

select avg(salary) as avg_salary from employees;