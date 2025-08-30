---Layyana Junaid 23k-0056
---Lab 2 Post-Lab Tasks

select employee_id, lpad(first_name, 15, '*') as first_name_padded from employees;

select ltrim(' Oracle') as trimmed from dual;

select employee_id, initcap(first_name) || ' ' || initcap(last_name) as proper_name from employees;

select NEXT_DAY(DATE '2022-08-20', 'MONDAY') as next_monday from dual;

select TO_CHAR(TO_DATE('25-DEC-2023','DD-MON-YYYY'), 'MM-YYYY') as mm_yyyy from dual;

select DISTINCT salary from employees order by salary asc;

select salary, employee_id,ROUND(salary, -2) as salary_rounded_to100 from employees;

select department_id, department_name, num_employees
from (
  select d.department_id,
         d.department_name,
         count(*) as num_employees,
         dense_rank() over (order by count(*) desc) as rk
  from employees e
  join departments d on d.department_id = e.department_id
  group by d.department_id, d.department_name
)
where rk = 1;

select department_id, department_name, total_salary
from (
  select d.department_id,
         d.department_name,
         sum(e.salary) as total_salary,
         dense_rank() over (order by sum(e.salary) desc) as rk
  from employees e
  join departments d on d.department_id = e.department_id
  group by d.department_id, d.department_name
)
where rk <= 3;
