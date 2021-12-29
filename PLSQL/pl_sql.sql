set serveroutput on
Declare
a number := 10;
Begin
While (a>1)
loop
Dbms_output.put_line(to_char(a));
a :=a-1 ;
END LOOP;
End;
/

select * from users;

set serveroutput on
DECLARE
uname users.user_name%type:='&user_name';
umail users.user_email%type;
BEGIN
select user_email into umail from users
where user_name=uname;
dbms_output.put_line('Emploeyee email for ' || umail);
END;
/


------------------16/12/21---------------------------------------
CREATE OR REPLACE PROCEDURE print_contact(
    in_customer_id NUMBER 
)
IS
  r_contact contacts%ROWTYPE;
BEGIN
  -- get contact based on customer id
  SELECT *
  INTO r_contact
  FROM contacts
  WHERE customer_id = p_customer_id;

  -- print out contact's information
  dbms_output.put_line( r_contact.first_name || ' ' ||
  r_contact.last_name || '<' || r_contact.email ||'>' );

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line( SQLERRM );
END;
Call the procedure
EXEC print_contact(100);
select * from employees;

DROP PROCEDURE print_contact;



set serveroutput on
DECLARE
--emp_fname employees.first_name%type;
emp_mid employees.manager_id%type;
emp_mail employees.email%type;

cursor emp_cursor is
select email,manager_id from employees;
--where first_name=emp_fname;
BEGIN
--  emp_fname :=&fname;
  open emp_cursor;
  LOOP
    fetch emp_cursor into emp_mail,emp_mid;
    exit when emp_cursor%ROWCOUNT>5 OR emp_cursor%NOTFOUND;
    dbms_output.put_line( emp_mid ||'  '|| emp_mail);
  end loop;
  close emp_cursor;
END;
/

------------------------------------------------------------------------------

select * from employee;

set serveroutput on
exec PROCEDURE emp_procedure(2);
/

CREATE OR REPLACE PROCEDURE emp_procedure
 (emp_id IN employee.id%type,
  emp_fname OUT employee.first_name%type,
  emp_sal OUT employee.salary%type,
  dep_id OUT employee.department_id%type)
IS
BEGIN
  select first_name,salary,department_id
  into emp_fname,emp_sal,dep_id
  from employee
  where id=emp_id;
END emp_procedure;
/


-----------------------------------------------------------------------------------------------------------------
set serveroutput on
create or replace PACKAGE insert_op as
 procedure insert_product (pro_id in number,pro_name in varchar2,pro_desc in varchar2,pro_prize in number,status out varchar2,i_error out varchar2);
 procedure delete_product (pro_id in number,status out varchar2,i_error out varchar2);
END;
/
CREATE or replace PACKAGE body insert_op  AS
 procedure insert_product(pro_id number,pro_name varchar2,pro_desc varchar2,pro_prize number,status out varchar2,i_error out varchar2)
is 
begin
insert into product (product_id,product_name,product_desc,prize1) values (pro_id,pro_name,pro_desc,pro_prize);
if sql%rowcount>0 then
status:='insert success';
end if;
commit;

Exception when others then 
status:='insert failed';
i_error:=sqlcode||sqlerrm;
end insert_product;

procedure delete_product (pro_id in number,status out varchar2,i_error out varchar2)
is 
begin 
delete  from product where product_id =pro_id;
if sql%rowcount>0 then
status:='Product Deleted';
end if;
if sql%rowcount=0 then
status:='No IDs There';
end if;
exception when others then
status:='Not Deleted';
i_error:=sqlcode||sqlerrm;
end delete_product ;
 
end insert_op  ;
/



Declare
status varchar2(100);
error varchar2(500);
begin
--insert_op.insert_product  (18,'sample','sample desc',106,status,error);
insert_op.delete_product(234,status,error); 
dbms_output.put_line('status='||status);
dbms_output.put_line('error='||error);
end;
/

--------------------------------------------------------------------------


select * from product;

desc product;

execute insert_op.insert_emp (13,'sample','sample desc',100);

select * from product;

set serveroutput on
create or replace package admin_info as
procedure insert_admin (ad_name in varchar2,ad_contact in int,ad_email in varchar2,ad_password in varchar2, status out varchar2,error out varchar2);
procedure delete_admin (ad_id in int ,status out varchar2 ,error out varchar2 );
procedure update_booking(b_id in int,b_status in varchar2,pay_status in varchar2,status out varchar2 ,error out varchar2 );
end;
/

create or replace package body admin_info as
procedure insert_admin (ad_name in varchar2,ad_contact in int,ad_email in varchar2,ad_password in varchar2, status out varchar2,error out varchar2)
is 
begin
insert into admin_details(admin_name,admin_contact,admin_password,admin_email) values (ad_name,ad_contact,ad_password,ad_email);
if sql%rowcount>0 then
status:='inserted successfully';
end if;
commit;

Exception when others then
status:='not inserted';
error:=sqlcode||sqlerrm;
end insert_admin;


procedure delete_admin (ad_id in int,status out varchar2,error out varchar2)
is 
begin
delete from admin_details where admin_id=ad_id;
if sql%rowcount>0 then 
status:='deleted successfully';
end if;

Exception when others then 
status:='not deleted';
error:=sqlcode||sqlerrm;
end delete_admin;

procedure update_booking (b_id in int,b_status in varchar2,pay_status in varchar2,status out varchar2,error out varchar2)
is
begin
update booked_tickets set booking_status=b_status ,payment_status=pay_status where booking_id=b_id;
if sql%rowcount>0 then
status:='updated success';
end if;

Exception when others then
status:='not updated';
error:=sqlcode||sqlerrm;
end update_booking;

end admin_info;
/


declare
status varchar2(100);
error varchar2(100);
begin
--admin_info.insert_admin('berbin',9872838934,'berbin','berbin@gmail.com',status,error);
--admin_info.delete_admin(21,status,error);
admin_info.update_booking(10009,'canceled','refund',status,error);

--update booking_tickets set booking_status='canceled',payment_status='refund' where booking_id=;
dbms_output.put_line('status : '||status);
dbms_output.put_line('error : '||error);
end;
/

--declare
--status varchar2(100);
--error varchar2(100);
--begins
--update booking_tickets set booking_status=b_status,payment_status=pay_status;
--dbms_output.put_line('status : '||status);
--dbms_output.put_line('error : '||error);
--end;
--/

----------------------------------------------------------------------------------------------------------------

create or replace package booking_info as

end;
/

create or replace


















































---------------------------------------------------------------------------------------------------------------


