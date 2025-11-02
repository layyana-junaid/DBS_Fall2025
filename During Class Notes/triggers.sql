create table students(
    student_id int primary key,
    student_name varchar(200),
    h_pay int,
    y_pay int
);
select * from students;
insert into students(student_id, student_name) values (1, 'sana');
insert into students(student_id, student_name) values(4, 'hamza');

set serveroutput on;

create or replace trigger insert_data
before insert on students
for each row
begin
IF :NEW.h_pay IS NULL THEN
:NEW.h_pay := 250;
end if;
end;
/

create or replace trigger update_salary
before update on students
for each row
begin
:NEW.y_pay := :NEW.h_pay*1920;
end;
/

update students set h_pay = 200 where student_id = 4;

create or replace trigger prevent_admin
before delete on students
for each row
begin
IF :OLD.student_name = 'admin'
then
RAISE_APPLICATION_ERROR(-20000, 'you cannot delete admin record');
end if;
end;
/
delete from students where student_name = 'admin';

create table student_logs (
student_id int,
student_name varchar(20),
inserted_by varchar(20),
inserted_on date
);

create or replace trigger after_ins
after insert on students for each row
begin
insert into student_logs(student_id, student_name, inserted_by, inserted_on) values
(:NEW.student_id, :NEW.student_name, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
end;
/
insert into students(student_id, student_name, h_pay) values (5, 'aqsa', 300);
select * from student_logs;

create or replace trigger prevent_tables
before drop on database
begin
raise_application_error(
    num => -20000,
    msg => 'cannot drop object'
);
end;
/
drop table students_logs;

create table schema_audit(
    ddl_date date,
    ddl_user varchar(30),
    object_created varchar(30),
    object_name varchar(30),
    ddl_operation varchar(30)
);

create or replace trigger hr_audit_tx
after ddl on schema
begin
insert into schema_audit values (sysdate,;


create table delete_logs(
student_id int,
student_name varchar(20),
h_pay int,
y_pay int,
inserted_by varchar(20),
inserted_on date
);

create or replace trigger after_delete
after insert on students for each row
begin
insert into delete_logs (student_id, student_name, h_pay, y_pay, inserted_by, inserted_on)
values (:OLD.student_id, :OLD.student_name, :OLD.h_pay, :OLD.y_pay, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
end;
/

--create or replace trigger hr_audit_tx
--after ddl on schema
--begin
--insert into schema_audit values (sysdate,;


create table delete_logs(
student_id int,
student_name varchar(20),
h_pay int,
y_pay int,
inserted_by varchar(20),
inserted_on date
);

create or replace trigger after_delete
after delete on students for each row
begin
insert into delete_logs (student_id, student_name, h_pay, y_pay, inserted_by, inserted_on)
values (:OLD.student_id, :OLD.student_name, :OLD.h_pay, :OLD.y_pay, SYS_CONTEXT('USERENV', 'SESSION_USER'), SYSDATE);
end;
/

create or replace trigger prevent_student_table
before drop on database
begin
IF ora_dict_obj_type = 'TABLE' and ora_dict_obj_name = 'students' then
RAISE_APPLICATION_ERROR(-20001, 'Dropping the STUDENTS table is not allowed.');
end if;
end;
/
