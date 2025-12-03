--Triggers and Transactions Practise 
--books inventor trigger
--You are asked to create a trigger books_inventory_trg that fires BEFORE INSERT OR UPDATE on BOOKS and enforces these rules:
--Prevent negative or zero values
--PRICE and STOCK must be > 0
--If not, stop the operation and raise:
--RAISE_APPLICATION_ERROR(-21001, 'Price or stock cannot be zero or negative');
--Low stock alert
--If STOCK becomes less than 3, raise:
--'Book stock is critically low'
--Restrict stock reduction during UPDATE
--During UPDATE, if new stock is less than 50% of old stock, raise:
--'Stock reduction more than 50% is not allowed'
--Automatic subtotal
--Always set SUBTOTAL = PRICE * STOCK
--If user tries to manually update SUBTOTAL, raise:
--'Subtotal cannot be updated manually'
--Audit fields
--On INSERT → set CREATED_BY = USER
--On UPDATE → set UPDATED_BY = USER'''
--Update LAST_UPDATED
--On every INSERT or UPDATE, set LAST_UPDATED = SYSDATE

create table books(
book_id NUMBER PRIMARY KEY,
title VARCHAR2(100),
price NUMBER(8, 2),
stock NUMBER,
subtotal number(10, 2),
last_updated DATE,
created_by VARCHAR2(30),
updated_by VARCHAR2(30)
);

Create or replace trigger books_inventory_trg
before insert or update on books
for each row
begin
--1. prevent negative or zero values
     if :new.price <= 0 or :new.stock <= 0 then 
        raise_application_error(-21001, 'price or stock cannot be zero or negative');
     end if;

--2. low stock alert (stock <3)
     if :new.stock < 3 then
        raise_application_error(-21001, 'Book stock is critically low');
     end if;

--3. Restrict stock reduction during update ( > 50% drop)
     if updating then 
        if :old.stock is not null and :old.stock > 0 and :new.stock < (:old.stock * 0.5) then
           raise_application_error(-21003, 'Stock reduction more than 50% is not allowed');
        end if;
     end if;

--4. automatically maintain the subtotal and prevent manual changes
     if updating('subtotal') then 
        raise_application_error(-21004,'Subtotal cannot be updated manually');
     end if;
     
     :new.subtotal := :new.price * :new.stock;
     
--5 created by/updated by
     if inserting then 
        :new.created_by := user;
     elsif updating then
         :new.updated_by := user;
     end if;
     
     :new.last_updated := sysdate;
end;
/

--Question 2 for triggers practise 
create table accounts (
account_id number PRIMARY KEY,
holder_name varchar2(50),
balance number(12, 2),
last_update DATE, 
updated_by varchar2(30)
);

create or replace trigger acct_balance_trg
before update of balance on accounts
for each row
begin
     --1. no negative balance 
     if new.balance < 0 then
        raise_application_error(-22001, 'Insufficient Balance');
     end if;
     
     --2. Max withdrawl 10000 per update
     if (:old.balance - :new.balance) > 10000 then 
         raise_application_error(-22002, 'withdrawl limit exceeded');
     end if;
     
     --3. audit fields 
     :new.last_update := sysdate;
     :new.updated_by := user;
end;
/
