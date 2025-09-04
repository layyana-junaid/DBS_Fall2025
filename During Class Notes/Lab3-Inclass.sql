--DDL Operations 
---Data Definition Language --> DDL
--create, alter, drop 
--In alter we have: add, rename, modify, drop

--create user layyana IDENTIFIED by layyana;
create table students(
id int primary key,
std_name varchar(30),
age int,
check(age>=18)
);

select * from students;

--alter functions
alter table students add salary int;
alter table students add (city VARCHAR(20) default 'Karachi', dept_id int);
alter table students add CONSTRAINT unique_email unique(email);
alter table students modify(std_name VARCHAR(20) not null, email varchar(20) not null);

alter table students add(CONSTRAINT
check_age check(age between 18 AND 30),
CONSTRAINT unique_email unique(email)
);

create table departments(
id int primary key,
dept_name varchar(20) not null
);

select * from departments;
insert into DEPARTMENTS(id, dept_name) values(4, 'AI');
insert into DEPARTMENTS(id, dept_name) values(5, 'CS');
insert into DEPARTMENTS(id, dept_name) values(6, 'CYB');
insert into DEPARTMENTS(id, dept_name) values(7, 'DS');


select * from students;
ALTER table students drop column dept_id;

alter table studnets add( dept_id int, foreign key(dept_id) references departments(id));
insert into STUDENTS(id , std_name , email , age , city , salary , dept_id) values (4, 'Layyana', 'lj1234@gmail.com', 21, 'Karachi', 40000, 6);





