set serveroutput on;

declare
sec_name varchar(20) := 'Sec-5G';
course_name varchar(20) := 'Data Systems Lab';
Begin
--server on nhi hoga tou output nhi aiga
--server output allow you to use its functions
DBMS_OUTPUT.PUT_LINE('Welcome ' || sec_name || ' to the ' || course_name);
End;

-- || sign of concatination
--3 phases:
--declaration phase, execution(imp), exception.
declare
a int := 10;
b int := 20;
c int;
f real ;
begin
c := a+b ;
DBMS_OUTPUT.put_line('Value of c is '|| c);
f := 70.0/3.0;
DBMS_OUTPUT.PUT_LINE('Value of f is ' || f);
end;

declare
--global variables inside the declare are global vaiables
num1 number := 21 ;
num2 number := 22 ;

Begin 
dbms_output.put_line('Outer Variable Num1 ' || num1);
dbms_output.put_line('Outer Variable Num2 ' || num2);

Declare 
--local variables
n1 int := 45;
n2 int := 12;
begin
dbms_output.put_line('local variables n1 and n2 are ' || n1 || ' ' || n2);
end;
End;
