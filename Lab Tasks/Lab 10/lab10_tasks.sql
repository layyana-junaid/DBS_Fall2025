```sql
-- create table
create table bank_accounts (
    account_no number primary key,
    holder_name varchar2(50),
    balance number
);

insert into bank_accounts values (101, 'Ali', 25000);
insert into bank_accounts values (102, 'Sara', 18000);
insert into bank_accounts values (103, 'Ahmed', 30000);

update bank_accounts set balance = balance - 5000 where account_no = 101;
update bank_accounts set balance = balance + 5000 where account_no = 102;
update bank_accounts set balance = 0 where account_no = 103;
rollback;

select * from bank_accounts;
```

```sql
create table inventory (
    item_id number primary key,
    item_name varchar2(40),
    quantity number
);
insert into inventory values(1, 'Laptop', 50);
insert into inventory values(2, 'Mouse', 100);
insert into inventory values(3, 'Keyboard', 60);
insert into inventory values(4, 'Charger', 30);

commit;

update inventory set quantity = quantity - 10 where item_id = 1;
savepoint sp1;
update inventory set quantity = quantity - 20 where item_id = 2;

savepoint sp2;
update inventory set quantity = quantity - 5 where item_id = 3;
rollback to sp1;
commit;
select * from inventory;
```

```sql
create table fees (
    student_id number primary key,
    name varchar2(40),
    amount_paid number,
    total_fee number
);

insert into fees values(1, 'Ali', 5000, 20000);
insert into fees values(2, 'Sara', 8000, 20000);
insert into fees values(3, 'Hamza', 12000, 20000);

commit;

update fees set amount_paid = amount_paid + 3000 where student_id = 1;
savepoint halfway;

update fees set amount_paid = amount_paid + 2000 where student_id = 2;
rollback to halfway;
commit;

select * from fees;
```
```sql
-- create tables
create table products (
    product_id number primary key,
    product_name varchar2(50),
    stock number
);

create table orders (
    order_id number primary key,
    product_id number,
    quantity number
);

insert into products values (1, 'Mobile', 30);
insert into products values (2, 'Laptop', 15);
insert into products values (3, 'Tablet', 20);

commit;
update products set stock = stock - 5 where product_id = 1;
insert into orders values (501, 1, 5);
delete from products where product_id = 2;
rollback;

update products set stock = stock - 5 where product_id = 1;
insert into orders values (502, 1, 5);
commit;

select * from products;
select * from orders;
```

```sql
create table employees (
    emp_id number primary key,
    emp_name varchar2(40),
    salary number
);
insert into employees values(1, 'Ali', 50000);
insert into employees values(2, 'Sara', 60000);
insert into employees values(3, 'Hamza', 55000);
insert into employees values(4, 'John', 45000);
insert into employees values(5, 'Hira', 65000);

commit;

update employees set salary = salary + 2000 where emp_id = 1;
savepoint A;

update employees set salary = salary + 3000 where emp_id = 2;
savepoint B;

update employees set salary = salary + 4000 where emp_id = 3;
rollback to A;
commit;

select * from employees;
```

