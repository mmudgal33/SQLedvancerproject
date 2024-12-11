create database Batch_17020

use Batch_17020

create table Student_Bio_Data (STDID INT, STD_NAME VARCHAR(50), ROLL_NO INT, CLASS VARCHAR(50));

SELECT * FROM Student_Bio_Data;

INSERT INTO Student_Bio_Data VALUES(1,'ALI FAIZAL',12,'5TH');
INSERT INTO Student_Bio_Data VALUES(1,'mohit mudgal',12,'5TH');
INSERT INTO Student_Bio_Data VALUES(1,'triveni kaul',12,'5TH');
INSERT INTO Student_Bio_Data VALUES(1,'tamanna selwal',12,'5TH');

insert into Student_Bio_Data(STDID,STD_NAME) values(5,'mini manu');

create table employee (empid int not null, empname varchar(50) not null, empopt varchar(50) not null, salary varchar(50));
select * from employee;

insert into employee values(1,'amir','admin','55000');
insert into employee values(3,'surbhi','finance','35000');
insert into employee values(2,'shakshi','manager','38000');

delete from employee where empid = 3;
delete from employee where empname = 'amir';

truncate table employee;
update employee set salary = 50000 where empid = 2;
update employee set empname = 'disha' where empid = 2;
update employee set empopt = 'analyst' where empid = 2;

create table voter_list (voter_id int primary key, voter_name varchar(50) not null, voter_age int not null);
create table voter_list (voter_id int primary key, voter_name varchar(50) not null, voter_age int not null check(voter_age>=18));
select * from voter_list;

insert into voter_list(voter_name,voter_age) values('mohit',21); --id can't be null
insert into voter_list(voter_id,voter_name,voter_age) values(1,'mohit',21);

insert into voter_list values(1,'rohit',19);
insert into voter_list values(2,'ritika',19);
insert into voter_list values(3,'reshma',18);
insert into voter_list values(4,'ruhi',17);
insert into voter_list values(5,'renu',20);
insert into voter_list values(6,'monika',21);

select * from voter_list where voter_id = 4 or voter_id = 6;
drop table voter_list;

create table customer_tbl
(
c_id int primary key,
c_name varchar(50),
c_address varchar(max),
city varchar(50)
);

select * from customer_tbl;
insert into customer_tbl values(1, 'mohit','house no 191','delhi');
insert into customer_tbl values(2, 'triveni','house no 2','gurgaon');
insert into customer_tbl values(3, 'mohini','house no 234','rohtak');
insert into customer_tbl values(4, 'tamanna','house no 777','delhi');
insert into customer_tbl values(5, 'manu','house no 7717','sonipat');

select * from customer_tbl;

create table [order]
(
order_id int primary key,
item varchar(50),
quantity int,
pricce_of_1 int,
c_id int foreign key references customer_tbl(c_id)
);

select * from [order];

insert into [order] values(111,'hard disk',2,500,3);
insert into [order] values(222,'ram',1,300,1);
insert into [order] values(333,'keyboard',3,400,4);
insert into [order] values(444,'mouse',2,300,2);
insert into [order] values(555,'speaker',1,3000,2);
insert into [order] values(666,'usb',2,1000,5);

select * from customer_tbl;
select * from [order];

delete from customer_tbl where c_id =3;

alter table [order] drop constraint [FK__order__c_id__60A75C0F];
alter database [Batch_17020] modify name = [New_Batch_17020];

execute sp_renamedb 'New_Batch_17020', 'Batch_17020'; --database rename
execute sp_rename 'New_Batch_17020', 'Batch_17020'; --table rename

alter table voter_list add voter_city varchar(50) not null;
alter table voter_list add voter_city varchar(50);

select * from voter_list;
update voter_list set voter_city = 'hyderabad' where voter_id = 1;

alter table voter_list drop column voter_city;
alter table voter_list alter column voter_name nvarchar(50);

create table voter_table
(
voter_id int,
voter_name varchar(50),
voter_age int
);

select * from voter_table;
alter table voter_table alter column voter_name varchar(50) not null;
alter table voter_table alter column voter_name varchar(50) null;

insert into voter_table (voter_id,voter_age) values (1,20);
alter table voter_table add unique(voter_id);

insert into voter_table (voter_id,voter_age) values (1,'mohit',20);
insert into voter_table (voter_id,voter_age) values (1,'rohit',22);

alter table voter_table drop constraint [UQ__voter_ta__B79503120039180E];
alter table voter_table add primary key (voter_id);
alter table voter_table alter column voter_id int not null;
alter table voter_table drop constraint [PK__voter_ta__B795031306CE23B1];

create table voter_city
(
c_id int,
c_name varchar(50),
voter_id int
);

select * from voter_table;
select * from voter_city;

alter table voter_city add foreign key (voter_id) references voter_table(voter_id);
alter table voter_city drop constraint [FK__voter_cit__voter__6C190EBB];

alter table voter_table add check (voter_age>=16);
insert into voter_table values(2,'aakash',17);
insert into voter_table values(3 ,'ankit',18);

alter table voter_table drop constraint [CK__voter_tab__voter__6E01572D];
alter table voter_table add default 18 for voter_age;
select * from voter_table;
insert into voter_table (voter_id,voter_name) values(3,'rakesh');


create table employee_tbl (emp_id int unique not null, emp_name varchar(50) not null,emp_email varchar(50), designation varchar(50) not null);
select * from employee_tbl;

insert into employee_tbl values(11,'aakash','aakash123@gmail.com','manager');
insert into employee_tbl values(12,'mohini','mohini123@gmail.com','a manager');
insert into employee_tbl values(13,'triveni','triveni123@gmail.com','it incharge');
insert into employee_tbl values(14,'tamanna','tamanna123@gmail.com','computer operator');
insert into employee_tbl values(15,'akansha','akansha123@gmail.com','d manager');

truncate table employee_tbl;

create table department (dep_id int unique not null, dpt_name varchar(50) not null, dpt_salary varchar(50) not null, emp_id int unique not null);
drop table department;
insert into department values (111,'administration','5000',13);
insert into department values (222,'accounts','6000',12);
insert into department values (333,'IT','40000',11);
insert into department values (444,'academic','45000',14);
insert into department values (555,'sports','45000',17);

--inner join
select * from employee_tbl as a
inner join department as b
on a.emp_id = b.emp_id;

select a.emp_name,a.designation,b.dpt_name,b.dpt_salary from employee_tbl as a
inner join department as b
on a.emp_id = b.emp_id;

select * from employee_tbl;
select * from  department;

select a.emp_name,a.designation,b.dpt_name,b.dpt_salary from employee_tbl as a
left join department as b
on a.emp_id = b.emp_id;

select a.emp_name,a.designation,b.dpt_name,b.dpt_salary from employee_tbl as a
right join department as b
on a.emp_id = b.emp_id;

select a.emp_name,a.designation,b.dpt_name,b.dpt_salary from employee_tbl as a
full outer join department as b
on a.emp_id = b.emp_id;

--self join

create table employee_manager (emp_id int primary key,emp_name varchar(50) not null, manager_id int);

insert into employee_manager values(1,'sushant',4);
insert into employee_manager values(2,'prashant',4);
insert into employee_manager values(3,'saurav',5);
insert into employee_manager values(4,'mohan',6);
insert into employee_manager values(5,'rohan',1);
insert into employee_manager values(6,'amir',1);

select a.emp_name as manager, b.emp_name as employee 
from employee_manager as a
inner join employee_manager as b
on a.manager_id = b.emp_id;

create table teacher_tbl (t_id int primary key identity(100,2), t_name char(50) not null,t_qualification char(50) not null, t_salary varchar(50) not null);
--SET IDENTITY_INSERT teacher_tbl ON
insert into teacher_tbl values('aman','bsc','20000');
insert into teacher_tbl values('aanshik','masters','24000');
insert into teacher_tbl values('manish','bcs','27000');
insert into teacher_tbl values('ziya','bba','30000');
select * from teacher_tbl;
drop table teacher_tbl;

create table footballparticipants (p_id int ,p_name varchar(50), p_email varchar(50));
create table hockeyparticipants (p_id int ,p_name varchar(50), p_email varchar(50));

insert into footballparticipants values(1,'aashish','aashish123@gmail.com');
insert into footballparticipants values(2,'aman','aman123@gmail.com');
insert into footballparticipants values(3,'aakash','aakash123@gmail.com');
insert into footballparticipants values(4,'arun','arun123@gmail.com');

insert into hockeyparticipants values(1,'varun','varum123@gmail.com');
insert into hockeyparticipants values(2,'anamika','anamika123@gmail.com');
insert into hockeyparticipants values(3,'sudhir','sudhir123@gmail.com');
insert into hockeyparticipants values(4,'arun','arun123@gmail.com');

select * from hockeyparticipants;
select * from footballparticipants;

select * from hockeyparticipants
union
select * from footballparticipants;

select * from hockeyparticipants
union all
select * from footballparticipants;

select * from hockeyparticipants
intersect
select * from footballparticipants;

select * from hockeyparticipants
except
select * from footballparticipants;

--aggregate sum,min,max,avg,count calculation on set of values return singlevalue.
select sum(cast(salary as int)) as total_salary from employee_details;
select max(cast(salary as int)) as total_salary from employee_details;
select min(cast(salary as int)) as total_salary from employee_details;
select avg(cast(salary as int)) as total_salary from employee_details;
select count(cast(salary as int)) as total_salary from employee_details;

create table employee_details (id int primary key identity, name varchar(50) not null, gender varchar(50) not null,
salary varchar(50) not null, city varchar(50) not null);

insert into employee_details values('aashish','male','10000','delhi');
insert into employee_details values('anshika','female','14000','chennai');
insert into employee_details values('aakansha','female','15000','mumbai');
insert into employee_details values('rakesh','male','18000','mumbai');
insert into employee_details values('suresh','male','22000','kolkata');
insert into employee_details values('mukesh','male','19000','mumbai');
insert into employee_details values('saurav','male','16000','kolkata');
insert into employee_details values('monika','female','15000','chennai');
insert into employee_details values('triveni','female','25000','delhi');

drop table employee_details;
select * from employee_details;

create table my_employees(emp_id int primary key identity,emp_name varchar(50) not null,gender varchar(50) not null,
salary varchar(50) not null,city varchar(50) not null, dept_id int not null);

INSERT INTO my_employees
VALUES
('aashish','male','10000','delhi',2),
('anshika','female','14000','mumbai',1),
('aakansha','female','15000','chennai',3),
('rakesh','male','18000','mumbai',4),
('suresh','male','22000','delhi',2),
('mukesh','male','19000','mumbai',1),
('saurav','male','16000','kolkata',3),
('monika','female','15000','kolkata',2),
('triveni','female','25000','delhi',1);

truncate table my_employees;
select * from my_employees;

--group by
select  gender,sum(cast(salary as int)) as [total salaries according to cities] from my_employees group by gender;
select gender,city, sum(cast(salary as int)) as [total salaries according to cities] from my_employees group by gender,city;

select class, sum(fees) as total_fees from school_table group by class;

select * from employee;

--use AdventureWorks2014;
select * from product_sales;

select city, sum(cast(salary as int)) as total_salary from employee_details
group by city having city in ('gurgaon');

select city, sum(cast(salary as int)) as total_salary from employee_details
group by city where city in ('gurgaon'); ---error where after group by

select city, sum(cast(salary as int)) as total_salary from employee_details
where city in ('gurgaon') group by city ;

select gender, sum(cast(salary as int)) as total_salary from employee_details
group by gender having sum(cast(salary as int)) >=70000;

/*where must be used before group by, but not after
where filter rows, having filter groups
where doesn't work with aggregate functions sum, avg, min, max, count etc
use having for aggregate functions.
where and having can be use in single query
having is slower than where avoid if possible*/

select city, sum(cast(salary as int)) as total_salary
from employee_details
where city in ('delhi','mumbai')
group by city
having sum(cast(salary as int))>=50000;

select product_name, sum(cast(sales_amount as int)) as total_sales
from product_sales
where sum(cast(sales_amount as int))>1000
group by product_name;

--An aggregate may not appear in the WHERE clause unless it is in a subquery contained in a HAVING clause or a select list,
--and the column being aggregated is an outer reference.


create table [product_sales]
(
product_name varchar(50),
sales_amount int,
);

drop table [dbo].[product_sales];
select * from [product_sales];

insert into [product_sales] values('hard disk',500);
insert into [product_sales] values('ram',300);
insert into [product_sales] values('keyboard',400);
insert into [product_sales] values('mouse',300);
insert into [product_sales] values('speaker',3000);
insert into [product_sales] values('usb',1000);

-- press alt and select vertically
--order by sort ascending by default, use asc, desc

select * from employee_details
order by name asc, gender desc;

--view is saved sql query, it's virtual table.
--used as mechanism to implement row and column level security.
--insert, update,delete with views

select * from department;
select * from employee;

create view vw_foremployees
as
select * from employee as a
inner join department as b
on a.empid=b.dep_id;

select * from vw_foremployees;

create view select * from vw_foremployees;
as
select a.*,b.dpt_name from employee as a
inner join department as b
on a.empid=b.dep_id;

select * from vw_foremployees;
sp_helptext vw_foremployees;

alter view vw_foremployees3
as
select a.*,b.dpt_name
from employees as a
inner join department as b
on b.id=a.dept_id
where dept_name='hr' or dept_name='accounts';

drop view vw_foremployees;

create view vw_foremployees
as
select * from my_employees;

insert into vw_foremployees values('areeb','male','35000','hyderabad',3);
update vw_foremployees set emp_name='sufyan' where emp_id=10;
delete from vw_foremployees where emp_id=10;

create view vw_employee
as
select emp_id,emp_name,gender from my_employees;

select * from vw_employee1

create view vw_employee1
as
select * from my_employees where dept_id = 1;

--like operator used with where clause for getting specified pattern in column
-- '%a','a%','%or%','_r%','a___'
--_ means sigle character, % means one or more characters
--'_r%' first character anything second r else anything.

select * from my_employees where emp_name like 'a%';
select * from my_employees where emp_name like '%a';
select * from my_employees where emp_name like '%sh%';
select * from my_employees where emp_name like 'a___i%';
select * from my_employees where emp_name like '______a';
select * from my_employees where emp_name like '[a,m,t]%';
select * from my_employees where emp_name like '[a-m]%';
select * from my_employees where emp_name like '_u%';
select * from my_employees where emp_name like 't%i';

--sub query/nested query query in query or embedded within where clause.
--sub query return data that will be used in main query as condition to 
--further restrict the data to be recieved.
--subquery rules embedded in parenthesis, 
--subquery have only one column in the select clause, unless main query have more than one column for subquery to compare its selected columns.
--order by cannot be used in subquery, main query can use order by.
--subqueries that return more than one row can only be used with multiple value operators sush as in operator


select * from my_employees
where emp_id in
(select emp_id from my_employees where salary>15000);

select * from my_employees
where emp_id in
(select emp_id from my_employees where city='delhi');

update my_employees set salary=salary+2000
where emp_id in
(select emp_id from my_employees where city='noida')

delete from my_employees
where emp_id in
(select emp_id from my_employees where city='noida')

create table my_department (dept_id int primary key identity, dept_name varchar(50));
insert into my_department values('acounts');
insert into my_department values('hr');
insert into my_department values('administration');
insert into my_department values('counseling');
select * from my_department;

select * from my_employees
where dept_id in
(select dept_id from my_department where dept_name='acounts');

select * from my_employees
where dept_id in
(select emp_id from my_employees where salary>12000 order by emp_id);

select * from my_employees
where salary in
(select salary from my_employees where emp_name='anshika' or emp_name='triveni');

select * from my_employees
where salary in
(select salary from my_employees where emp_name in ('anshika','triveni')
or salary between '15000' and '17000');

select * from my_employees
where salary < any
(select salary from my_employees where emp_name='monika' or emp_name='aakansha');

select * from my_employees
where salary < all
(select salary from my_employees where emp_name='monika' or emp_name='aakansha');

select * from my_employees as e
where e.dept_id in
(select d.dept_id from my_department as d where e.gender='male');

select * from my_employees as e
where e.dept_id in
(select d.dept_id from my_department as d where e.gender='female');

select * from my_employees as e
where e.dept_id in
(select d.dept_id from my_department as d where e.salary>15000);

--emp_id dept_id both are in result

select * from my_employees
where salary in
(select min(salary) from my_employees);

select * from my_employees
where salary = min(salary); --where with aggregate not work

select * from [dbo].[employee_details];
select top 5 * from [dbo].[employee_details];

select top 40 percent * from [dbo].[employee_details];

select distinct [name] from [dbo].[employee_details];
insert into employee_details values('usman','male','34000','karachi');
select * from employee_details where city in ('hyderabad','karachi');

select * from employee_details where salary between 10000 and 18000;

--select into-- select the data from onetable and insert it into a new table.
--we can copy all the rows/columns, selected rows/columns from existing table to new table.
--use join on two or more table and insert into new table.
--drom one database table to another database table.

select * into employee_backup from my_employees;
select * from employee_backup;

select * from my_employees;
select * from my_department;

select emp_id,emp_name,salary 
into employee_backup from my_employees;

select * from employee_backup;

select * into employee_backup from my_employees
where city = 'delhi';

select * into employee_backup from my_employees as a
inner join my_department as b
on b.id=a.dept_id;

select a.*, b.dept_name into employee_backup from my_employees as a
inner join my_department as b
on b.id=a.dept_id;

USE [Batch_17020];  

EXEC sp_rename 'dbo.my_department.dept_id','id','COLUMN';  

select * into practicedb from my_employees;

select * into employee_backup from my_employees where 1<>1; --get only format of table

select * into customer_backup from customer_tbl;
insert into customer_backup select * from customer_tbl;
select * from customer_backup;
drop table customer_backup;

select * into customer_backup from customer_tbl where 1<>1;


insert into customer_backup (c_name,c_address)
select c_name,c_address from customer_tbl; --not null type create error only

--stored procedure
--example, single parameter,multiple parameter(change order of them), alter sp, seeing code,drop sp
--sp_ prefix for system sp, sp_help
--encryption of sp code

sp_rename 'customer_backup', 'customer_backup';
sp_renamedb 'Batch_17021', 'Batch_17020';

select * from employee_details;

create procedure spgetemployees as
begin
select name,gender from employee_details;
end

spgetemployees;

create procedure spgetemployeesbyid @id int as
begin
select * from employee_details where id=@id;
end

execute spgetemployeesbyid 3;

create procedure spgetemployeebyidandname @id int, @name varchar(50) as
begin
select [name],salary,city from employee_details where id=@id and name=@name;
end

execute spgetemployeebyidandname 9,'triveni';

sp_helptext spgetemployeebyidandname;

alter procedure spgetemployeebyidandname @id int, @name varchar(50)
with encryption as
begin
select [name],salary,city from employee_details where id=@id and name=@name;
end

alter procedure spgetemployeebyidandname @city varchar(50), @name varchar(50)
as
begin
select * from employee_details where city=@city and name=@name;
end

execute spgetemployeebyidandname 'delhi','triveni';
sp_helptext spgetemployeebyidandname;

--The text for object 'spgetemployeebyidandname' is encrypted.
--programmability--stored procedure

drop procedure spgetemployeebyidandname;

create proc spgetemployeeidbygender
@gender varchar(50),
@employeecount int output
as
begin
select @employeecount = count(emp_id) from my_employees
where gender=@gender;
end

declare @totalemployee int
execute spgetemployeeidbygender 'male',@totalemployee output
select @totalemployee as male_employees;

declare @totalemployee int
execute spgetemployeeidbygender 'female',@totalemployee output
select @totalemployee as female_employees;

--functions--do repetative task on data given, return something.
--call function, it accepts input in parameter form, returns a value.
--sql have builtin functions for various tasks.
--sp have group of statements, sp can't be called within sql statements.
--functions apply on large data sets have performance issue.
--in t-sql functions considered an object, some rules when creating functions.
---function have name, which can never be start with special character such as @,$,# etc.
-----------only work with select statements.
-----------used anywhere in sql, like count, sum, min, date etc with select statement.
-----------functions compile everytime.
-----------functions must return something as result.
-----------functions only work with input parameters.
-----------try and catch statements are not used in functions.
--sql server supports two types of functions--user defined--system(built in database functions)
---user defined functions types--scalar functions--inline table valued functions--multi-statement table valued functions.
---scalar functions take one or more parameter and returns single(scalar) value.
--------------------return any data type except text, ntext, image, cursor and timestamp.
--programmability--functions--three user defined types and list of inbuilt functions.

--key take aways scalar functions
---used almost anywhere in T-sql statements.
---accept one or more parameters but return only one value, therefore return statement present always.
---they use logic such as if blocks or while loops.
---can't update data, they can access but don't do it, use procedure.
---scalar functions can call other functions.

--create function without,sigle,multiple parameter. alter them
create function showmessage()
returns varchar(100)
as
begin
	return 'welcome to functions';
end

select dbo.showmessage();

create function takeanumber(@num as int)
returns int
as
begin
	return (@num*@num);
end

select dbo.takeanumber(3);

create function addition(@num1 as int,@num2 as int)
returns int
as
begin
	return(@num1+@num2);
end

select dbo.addition(2,5);
select dbo.addition(22,15);

alter function addition(@num1 as int,@num2 as int)
returns int
as
begin
	return(@num1*@num2);
end

drop function dbo.takeanumber;

create function checkvoterage(@age as int)
returns varchar(100)
as
begin
	declare @str varchar(100)
	if @age >= 18
	begin
		set @str = 'you are eligible to vote'
	end
	else
	begin
		set @str = 'you are not eligible to vote'
	end	
	return @str
end

select dbo.checkvoterage(20);
select dbo.checkvoterage(18);

create function getmydate()
returns datetime
as
begin
	return getdate()
end

select dbo.getmydate();

--inline table valued functions--user defined functions
---contains single tsql statement and returns a table set.
---scalar function return scalar value
---inline table valued functions returns table
---steps--specify return type as table--no begin/end bllocks--returned table use select command within the function.

select * from teacher_tbl;

create function fn_getstudents()
returns table
as
return (select * from [dbo].[Student_Bio_Data])

select * from fn_getstudents();

create function fn_getstudentswithage(@age int)
returns table
as
return (select * from tbl_student where s_age>=@age)

select * from fn_getstudentswithage(17);

create table teacher_tbl(t_id int primary key ,t_name varchar(50) not null,
t_qualification varchar(50) not null,t_age int not null);

create table tbl_student(s_id int primary key ,s_name varchar(50) not null,
s_gender varchar(50),s_age int not null,s_standard varchar(50) not null, teacher_id int foreign key references teacher_tbl(t_id)); 

insert into teacher_tbl values(10,'ashok','mphil',28);
insert into teacher_tbl values(15,'krish','mba',30);
insert into teacher_tbl values(20,'azad','mphil',28);
insert into teacher_tbl values(25,'akshay','mphil',26);
insert into teacher_tbl values(30,'saurav','masters',25);
insert into teacher_tbl values(40,'sumit','masters',25);
insert into teacher_tbl values(50,'surbhi','mba',25);

insert into tbl_student values(1,'ajay','male',18,'11',10);
insert into tbl_student values(2,'sudhir','male',17,'10',20);
insert into tbl_student values(3,'anamika','female',20,'12',30);
insert into tbl_student values(4,'ankit','male',16,'9',15);
insert into tbl_student values(5,'sanjay','male',17,'18',25);
insert into tbl_student values(6,'ashok','male',15,'7',10);
insert into tbl_student values(7,'surbhi','female',18,'11',20);
insert into tbl_student values(8,'triveni','female',19,'12',40);
insert into tbl_student values(9,'anjum','female',17,'10',50);

select * from tbl_student;
select * from teacher_tbl;

drop table teacher_tbl;
drop table tbl_student;

select * from fn_getstudentswithage(18) as a
inner join teacher_tbl as b
on a.teacher_id = b.t_id;

--multi statement table valued functions (user defined functions)
---table valued functions that return result of multiple statements.

create function fn_getstudentsbygender(@gender varchar(20))
returns @mytable table (std_id int,std_name varchar(50), gender varchar(50))
as
begin
	insert into @mytable
	select s_id,s_name,s_gender from tbl_student where s_gender = @gender
	return
end

select * from [dbo].[fn_getstudentsbygender]('male')
select * from [dbo].[fn_getstudentsbygender]('female')

--difference between functions and stored procedure
create function fn_addition_of_number(@int1 as int,@int2 as int)
returns int
as
begin
return (@int1+@int2)
end

create procedure spgetaddition
as
begin
	select [dbo].[fn_addition_of_number](14,9)
end

execute spgetaddition; --function call inside procedure is working

create proc spgetdata
as
begin
	select * from student_tbl;
end

--procedure cannot be called inside function
create function fn_executesp()
returns int
as
begin
execute spgetdata
end

select b.[name],b.class,b.fees,a.[name],
a.qualification,a.salary,c.city
from teacher as a
inner join student as b
on a.t_id = b.t_id
inner join branch as c
on b.s_id = c.std_id;

--coalesce() function---return first non-null value in a list.
--coalesce() function vs isnull function---isnull only for two values.
--if null then alternative value manually input using it.
--cast() convert datatype from one to another.
--convert() function--use,similarities and difference between cast and convert, how to choose between them
----------------------change datatype, various formats of date

select coalesce(null,null,'adil',null,'learning never ends');

create table fullnametbl(id int,first_name varchar(50),middle_name varchar(50),last_name varchar(50));
insert into fullnametbl values(1,null,'ali',null);
insert into fullnametbl values(2,null,null,'khan');
insert into fullnametbl values(3,'zain',null,null);
insert into fullnametbl values(4,null,'anas','quraishi');
insert into fullnametbl values(5,'ebad',null,'ansari');

select * from fullnametbl;

select id,coalesce(first_name,middle_name,last_name) from fullnametbl;

select id,isnull(first_name,middle_name,last_name) from fullnametbl;

-----------The isnull function requires 2 argument(s).
select id,isnull(first_name,middle_name) from fullnametbl;
select id,isnull(first_name,'empty') from fullnametbl;

select cast(23.45 as int) as value;
select cast('2021-05-03' as datetime);
select [emp_name]+'-'+cast(emp_id as varchar) from employee_tbl;
select * from employee_tbl;
insert into employee_tbl values(16,'umair'+cast(26 as varchar),'umair123@gmail.com','it');

create table employee_cast(
id int primary key identity,
[name] varchar(50),
joining_date datetime);

insert into employee_cast values('ali',getdate());
insert into employee_cast values('amir',cast('2014-04-11' as datetime));
insert into employee_cast values('amir',cast('2014-04-11 04:11:56' as datetime));
insert into employee_cast values('amar',cast('2014-07-11 04:13:56' as datetime));
insert into employee_cast values('amar',cast('2014-07-11 03:15:56' as datetime));


select * from employee_cast;
select * from employee_cast where joining_date = '2014-04-11 04:11:56';
select * from employee_cast where joining_date = '2014-07-11';
select * from employee_cast where joining_date = cast('2014-07-11' as date);

select * from employee_cast where cast(joining_date as date)='2014-04-11';
select * from employee_cast where joining_date = cast('2014-04-11 04:11:56' as datetime);

select id,name,cast(joining_date as date) from employee_cast where cast(joining_date as date)='2014-07-11';

select cast(joining_date as date), count(id) from employee_cast
group by cast(joining_date as date);

declare @num1 decimal = 24.54;
select cast(@num1 as int);
select @num1;

declare @num2 decimal = 24.54;
select convert(int,@num2);
select @num2;

select cast('2021-05-05' as datetime);
select convert(datetime,'2021-05-05');

--convert(data_type([length]),expression,[style])--[] means optional parameters of function.
select convert(varchar,getdate(),0);
select convert(varchar,getdate()) as today_date;
select convert(varchar,getdate(),1);
select convert(varchar,getdate(),2);
select convert(varchar,getdate(),101);
select convert(varchar,getdate(),102);
select convert(varchar,getdate(),3);
select convert(varchar,getdate(),103);

select * from employee_cast;
select convert(varchar, joining_date,103) as today_date from employee_cast;
select [name], convert(varchar, joining_date,103) as today_date from employee_cast;
select [name], convert(varchar, joining_date,130) as today_date from employee_cast;

--cursor--temporary memory or temporary work station
----------database object that is used to retrieve data from a result set one row at a time.
----------used to store database tables
----------allows process individual row returned by a query
----------two types--implicit--default cursors allocated by sql server when user perform dml operations
---------------------explicit--created by user, used for fetching data from table in row-by-row manner.
----------methods of cursor--next--prior--first--last--absolute n--relative n
-----------------------------------------------------------------------------------------
--steps involved in sql cursor life cycle--declare--opening--fetching--closing--deallocating
--declare using statement
--opened for storing data retrieved from the result set
--rows fetched one by one or in a block to do data manipulations.
--after data manipulation cursor must be closed.
--cursors deallocated to delete cursor defination and release all the system resources associated with cursor
----------------------------------------------------------------------------------------------------------------
--cursors can be used in 2 ways--with cursor variables--without cursor variables
--

select * from employee_cast;

declare mycursor cursor scroll for select * from employee_cast
open mycursor
fetch first from mycursor
fetch next from mycursor
fetch last from mycursor
fetch prior from mycursor
fetch absolute 3 from mycursor
fetch relative 2 from mycursor
fetch relative -2 from mycursor
close mycursor
deallocate mycursor

--with cursor variables
declare mycursor cursor scroll for select id, [name] from employee_cast
declare @emp_id int,@emp_name varchar(50)
open mycursor
fetch first from mycursor into @emp_id, @emp_name
print 'employee is: '+cast(@emp_id as varchar(50))+' '+@emp_name
fetch next from mycursor into @emp_id, @emp_name
print 'employee is: '+cast(@emp_id as varchar(50))+' '+@emp_name
fetch last from mycursor into @emp_id, @emp_name
print 'employee is: '+cast(@emp_id as varchar(50))+' '+@emp_name
fetch prior from mycursor into @emp_id, @emp_name
print 'employee is: '+cast(@emp_id as varchar(50))+' '+@emp_name
fetch absolute 3 from mycursor into @emp_id, @emp_name
print 'employee is: '+cast(@emp_id as varchar(50))+' '+@emp_name
fetch relative 2 from mycursor into @emp_id, @emp_name
print 'employee is: '+cast(@emp_id as varchar(50))+' '+@emp_name
fetch relative -2 from mycursor into @emp_id, @emp_name
print 'employee is: '+cast(@emp_id as varchar(50))+' '+@emp_name

close mycursor
deallocate mycursor

--over clause with partition by in sql server
select * from [dbo].[tbl_student];

select s_gender,count(*) as gender_total from tbl_student
group by s_gender;

select s_name,s_gender,count(*) as gender_total from tbl_student
group by s_gender;
--Column 'tbl_student.s_name' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

select * from [dbo].[tbl_student];

--use of over(partition by) and its alternate
--over clause with partition by is used to split data into partitions. specified function operates for each partition.
--use any function sum(), avg(), min(), max(), count(), row_number(), rank(), dense_rank() etc
--partitioned data based upon some column known as window, windowing of data----window functions--apply on set of rows to rank/aggregate values in that window. 
--windowing--create window of records for every record. window is then used for making computations.
--group by--columns used which either used for grouping or in aggregate functions
--order by--retrieve aggregated and non aggregated values/columns.

select s_name,s_gender,s_age,
count(s_gender) over (partition by s_gender) as gender_total,
max(s_age) over (partition by s_gender) as max_age,
min(s_age) over (partition by s_gender) as min_age,
avg(s_age) over (partition by s_gender) as avg_age
from tbl_student;

select s_name, s_age, tbl_student.s_gender, genders.gender_total from tbl_student
inner join
(select s_gender,count(*) as gender_total from tbl_student group by s_gender) as genders
on tbl_student.s_gender = genders.s_gender;

select s_name,s_age,s_gender,count(s_gender) over (partition by s_gender) as gender_total
from tbl_student;

select s_name,s_age,tbl_student.s_gender,genders.gender_total,
genders.max_age,genders.min_age,genders.avg_age
from tbl_student
inner join
(select s_gender, count(s_gender) as gender_total,max(s_age) as max_age,min(s_age) as min_age,avg(s_age) as avg_age
from tbl_student group by s_gender) as genders
on tbl_student.s_gender=genders.s_gender;

select s_name,s_gender,s_age,
count(s_gender) over (partition by s_gender) as gender_total,
max(s_age) over (partition by s_gender) as max_age,
min(s_age) over (partition by s_gender) as min_age,
avg(s_age) over (partition by s_gender) as avg_age
from tbl_student;


--retrieving last generated identity value

--3 functions for get last generated identity value
--Scope_Identity() function-------returns last generated identity in same session, same scope
----@@Identity --global variable------last generated identity same session any scope
--Ident_Current() function-----last generated identity, for specific table or view in any session.

create table customer_identity (id int identity,name varchar(50));
select * from customer_identity;

insert into customer_identity values('ali');
insert into customer_identity values('ali');
select Scope_Identity();
select @@Identity;

create table cust_identity(id int identity, date_time datetime);
select * from cust_identity;

insert into cust_identity values(getdate());
insert into cust_identity values('ali');

create trigger tr_cust_identity
on cust_identity
after insert 
as
begin
	insert into cust_identity values(getdate());
end


--row_number() over (order by column_name)---in partition, all partition have separate numbering 1-n
--rank()---dense_rank()
select * ,row_number() over (order by e_name desc) as numbering from employee_tbl;

drop table [dbo].[employee];
create table employee([name] varchar(50) not null,gender varchar(50) not null,age int not null,salary int not null,city varchar(50) not null);

insert into employee values('aman','m',23,13000,'delhi');
insert into employee values('ankur','m',25,19000,'delhi');
insert into employee values('triveni','f',24,17000,'mumbai');
insert into employee values('mohit','m',27,16000,'delhi');
insert into employee values('tanuj','m',22,12000,'mumbai');
insert into employee values('tamanna','f',22,19000,'delhi');
insert into employee values('surbhi','f',27,22000,'mumbai');
insert into employee values('gaurav','m',28,18000,'mumbai');
insert into employee values('yogita','f',26,15000,'delhi');
insert into employee values('sakshi','f',24,15000,'mumbai');
insert into employee values('saurav','m',26,14000,'mumbai');

select * from employee;
select * ,row_number() over (order by name desc) as [rank] from employee;
select * ,row_number() over (partition by gender order by [name] desc) as numbering from employee;
select * ,row_number() over (partition by city order by age desc) as numbering from employee;

select * ,rank() over (order by age desc) as ranking from employee;
--rank()--same age same rank--1,2,2,4,4,6,7,7,9,10,10
select * ,rank() over (partition by city order by age desc) as [rank] from employee;

select * ,dense_rank() over (order by age desc) as [demse_rank] from employee;
--dense_rank()--same age same rank but---1,2,2,3,3,4,5,5,6,7,7

select [name],gender,age,salary,rank() over (order by salary desc) as [rank],
dense_rank() over (order by salary desc) as [dense_rank] from employee;

--apply operator types---cross apply---outer apply


select * from [dbo].[teacher_tbl];
select * from [dbo].[tbl_student];

select * from teacher_tbl
inner join tbl_student
on teacher_tbl.t_id=tbl_student.teacher_id;

select t.t_name,t.t_qualification, s.s_name, s.s_age from teacher_tbl as t
inner join tbl_student as s
on t.t_id=s.teacher_id;



create function fn_getstudentbyteacherid(@teacher_id int)
returns table
as
return
(select * from [dbo].[tbl_student]
where teacher_id=@teacher_id);

select * from fn_getstudentbyteacherid(30);

select t.t_name,t.t_qualification, s.s_name, s.s_age from teacher_tbl as t
left join fn_getstudentbyteacherid(t.t_id) as s
on t.t_id=s.teacher_id;

select t.t_name,t.t_qualification, s.s_name, s.s_age from teacher_tbl as t
outer apply fn_getstudentbyteacherid(t.t_id) as s;
--cross/outer apply must have right table expression and should be table valued function.

select t.t_name,t.t_qualification, s.s_name, s.s_age from teacher_tbl as t
cross apply fn_getstudentbyteacherid(t.t_id) as s;

--left table used first then evaluate with right table valued function.
--cross apply(inner join)--returns only matching rows.
--outer apply(left join)--returns both matching and unmatching rows.
--------------------------unmatched columns of table valued function becomes null.

--trigger--special kind of stored procedure that automatically executes when an event accurs in the database server
-----------trigger run before(instead of) or after. apply during insert, update, delete
---three types--DML(FIRED automatically in response to DML events like insert, update, delete)
---DML triggers can be of two types---after triggers(triggers)
---instead of triggers--instead of insert/update/delete
---DDL---LOGON TRIGGERS
--special kind of stored procedure that automatically executes when an event accurs in the database server

select * from [dbo].[tbl_student];

create trigger tr_student_forinsert
on tbl_student
after insert
as
begin
	print 'something happened to the student table'
end

insert into tbl_student values(10,'ankita','f',19,11,50);
insert into tbl_student values(12,'ankit','m',19,11,50);

alter trigger tr_student_forinsert
on tbl_student
after insert
as
begin
	select * from inserted
end

create trigger tr_student_fordelete
on tbl_student
after delete
as
begin
	select * from deleted
end


delete from tbl_student where s_id =10;
insert into tbl_student values(11,'sumit','m',19,10,30);
delete from tbl_student where s_id =12;

select * from [dbo].[tbl_student];

create table tbl_student_audit
(audit_id int primary key identity, audit_info varchar(max));

select * from tbl_student_audit;

create trigger tr_student_audit_forinsert
on tbl_student
after insert
as
begin
	declare @id int
	select @id = s_id from inserted

	insert into tbl_student_audit values('student with id '+cast(@id as varchar(50))+ 'is added at '+cast(getdate() as varchar(50)));
end

insert into tbl_student values(13,'gaurav','m',16,9,20);
select * from tbl_student_audit;

alter trigger tr_student_audit_fordelete
on tbl_student
after delete
as
begin
	declare @id int
	select @id = s_id from deleted

	insert into tbl_student_audit values('existing student with id '+cast(@id as varchar(50))+ ' is deleted at '+cast(getdate() as varchar(50)));
end

delete from tbl_student where s_id =13;
insert into tbl_student values(13,'gaurav','m',16,9,20);
select * from tbl_student_audit;
select * from tbl_student;
--tables--select table--triggers

create trigger tr_student_audit_forupdate
on tbl_student
after update
as
begin
	select * from inserted
	select * from deleted
end

update 	tbl_student set s_name='mohit', s_gender='female' where s_id=9;

sp_helptext [tr_student_audit_forinsert];

select * from [dbo].[customer_tbl];

drop table [dbo].[tbl_customer];

create table tbl_customer(
id int primary key identity, 
[name] varchar(50) not null, 
gender varchar(50) not null,
city varchar(50) not null, 
contact_num varchar(50) not null);

insert into tbl_customer values('aman','m','delhi',9968983079);
insert into tbl_customer values('ankur','m','delhi',9968983079);
insert into tbl_customer values('triveni','f','mumbai',9968983079);
insert into tbl_customer values('mohit','m','delhi',9968983079);
insert into tbl_customer values('tanuj','m','mumbai',9968983079);
insert into tbl_customer values('tamanna','f','delhi',9968983079);
insert into tbl_customer values('surbhi','f','mumbai',9968983079);
insert into tbl_customer values('gaurav','m','mumbai',9968983079);
insert into tbl_customer values('yogita','f','delhi',9968983079);
insert into tbl_customer values('sakshi','f','mumbai',9968983079);
insert into tbl_customer values('saurav','m','mumbai',9968983079);

create trigger  tr_customer_insteadof_insert
on tbl_customer
instead of insert
as
begin
	print 'you are not allowed to insert data in this table'
end

insert into tbl_customer values('saurabh','m','delhi',9968983079);
select * from tbl_customer;

create trigger  tr_customer_insteadof_update
on tbl_customer
instead of update
as
begin
	print 'you are not allowed to update data in this table'
end

update tbl_customer set gender='f' where id=4;
select * from tbl_customer;

create trigger  tr_customer_insteadof_delete
on tbl_customer
instead of delete
as
begin
	print 'you are not allowed to delete data in this table'
end

delete from tbl_customer where id =11;
select * from tbl_customer;


create table tbl_customer_audit
(audit_id int primary key identity, audit_info varchar(max));

select * from tbl_customer_audit;

create trigger tr_customer_insteadofinsertaudit
on tbl_customer
instead of insert
as
begin
	insert into tbl_customer_audit values(' someone has tried to insert data in customer table at:  '+cast(getdate() as varchar(50)));
end

--Cannot create trigger 'tr_customer_insteadofinsertaudit' on table 'tbl_customer' because an INSTEAD OF INSERT trigger already exists on this object.
drop trigger tr_customer_insteadof_insert;

insert into tbl_customer values('mohini','f','delhi',9968983079);--2 rows affected--

select * from tbl_customer;
select * from tbl_customer_audit;

create trigger tr_customer_insteadofupdateaudit
on tbl_customer
instead of update
as
begin
	insert into tbl_customer_audit values(' someone has tried to update data in customer table at:  '+cast(getdate() as varchar(50)));
end

drop trigger tr_customer_insteadof_update;
update tbl_customer set name = 'rohit' where id=1;


alter trigger tr_customer_insteadofdeleteaudit
on tbl_customer
with encryption
instead of delete
as
begin
	insert into tbl_customer_audit values(' someone has tried to delete data in customer table at:  '+cast(getdate() as varchar(50)));
end

drop trigger tr_customer_insteadof_delete;
delete from tbl_customer where id=6;

select * from tbl_customer;
select * from tbl_customer_audit;

sp_helptext tr_customer_insteadofdeleteaudit;

--after trigger--could be many
--instead of trigger--only one--drop/alter old according to requirement.
--with encryption--The text for object 'tr_customer_insteadofdeleteaudit' is encrypted.
--instead of trigger with view on 

select * from [dbo].[employee_details];
select * from [dbo].[employee_manager];
select * from vw_employees;

alter view vw_employees
as
select a.id,a.[name],a.salary,b.emp_name as manager from [dbo].[employee_details] as a
inner join [dbo].[employee_manager] as b
on a.id=b.manager_id;

select * from vw_employees;

create trigger tr_insteadof_employeedetails
on vw_employees
instead of delete
as
begin
delete from employee_details where id in
(select id from deleted)
delete from employee_manager where emp_id in
(select id from deleted)
end

select * from vw_employees;
delete from vw_employees where id=6;

select * from [dbo].[employee_details];
select * from [dbo].[employee_manager];

create database trigger_db;

create trigger tr_ddl_table_create
on database
for create_table
as
begin
	print 'new table created |:';
end

create table test_tbl(id int);

create trigger tr_ddl_table_alter
on database
for alter_table
as
begin
	print 'table altered |:';
end

alter table test_tbl add city varchar(50);

create trigger tr_ddl_table_drop
on database
for drop_table
as
begin
	print 'table droped |:';
end

drop table test_tbl;
drop trigger tr_ddl_table_drop;

create trigger tr_ddl_table_table
on database
for drop_table,create_table,alter_table
as
begin
	print 'table create,alter or droped |:';
end

create table test_tbl(id int);
alter table test_tbl add city varchar(50);
drop table test_tbl;

create trigger tr_ddl_sp_create
on database
for create_procedure
with encryption
as
begin
	rollback
	print 'you are not allowed to create a stored procedure |:';
end

create procedure sp_myprocedure
as
begin
	print 'this is my stored procedure';
end

sp_helptext tr_ddl_sp_create

-----------------------------------ROLLBACK

create trigger tr_ddl_sp_create_alter_drop
on database
with encryption
for create_table,drop_table,alter_table
as
begin
	rollback
	print 'you are not allowed to create,alter,drop a stored procedure |:';
end

create table test_tbl(id int);
alter table test_tbl add city varchar(50);
drop table test_tbl;

-------------------------The transaction ended in the trigger. The batch has been aborted.
disable trigger [tr_ddl_sp_create_alter_drop] on database;
enable trigger [tr_ddl_sp_create_alter_drop] on database;


create trigger tr_ddl_rename
on database
--with encryption
for rename
as
begin
	--rollback
	print 'you have just renamed a table or table column |:';
end

sp_rename 'test_tbl','test_table1';

drop trigger tr_ddl_rename; 

create trigger tr_serverscopedtrigger_view
on all server
--with encryption
for create_view
as
begin
	rollback
	print 'you are not allowed to create a view |:';
end

drop trigger tr_ddl_rename on database; 
drop trigger tr_ddl_rename on all server; 


create table test_tbl(id int,age varchar(50));
alter table test_tbl add [name] varchar(50);
select * from test_tbl;
insert into test_tbl values(1,'15','rohit'),(2,'18','mohit'),(3,'17','radha');
drop table test_tbl;

 create trigger tr_student_1
 on test_tbl
 after insert
 as
 begin
 print '1st trigger is fired';
 end

 create trigger tr_student_2
 on test_tbl
 after insert
 as
 begin
 print '2nd trigger is fired';
 end

 create trigger tr_student_3
 on test_tbl
 after insert
 as
 begin
 print '3rd trigger is fired';
 end

 execute sp_settriggerorder
 @triggername='tr_student_1',
 @order='first',
 @stmttype='insert';

 execute sp_settriggerorder
 @triggername='tr_student_1',
 @order='last',
 @stmttype='insert';

insert into test_tbl values(1,'15','rohit'),(2,'18','mohit'),(3,'17','radha');


------------------------------GUID---------------------------------------------------------

select newid();--------------globally unique identifier

create table cust_hyd(id uniqueidentifier primary key default newid(),[name] varchar(50));
create table cust_dl(id uniqueidentifier primary key default newid(),[name] varchar(50));

insert into cust_hyd values(default,'mohit'),(default,'rohit'),(default,'radha');
insert into cust_dl values(default,'rohit'),(default,'mohit'),(default,'radha');

select * from cust_hyd;
select * from cust_dl;
select * from customer;
alter table test_tbl add [name] varchar(50);

drop table cust_hyd;
drop table cust_dl;
drop table customer;

create table customer(id uniqueidentifier primary key default newid(),[name] varchar(50));

insert into customer
select * from cust_hyd
union all
select * from cust_dl;


------------------------composite key in sql
create table employee_composite_key
(
emp_id int not null,
dept_id int not null,
emp_name varchar(50),
emp_gender varchar(50),
emp_salary int,
dept_name varchar(50),
dept_head varchar(50),
dept_location varchar(50),
primary key (emp_id,dept_id)
);

select * from employee_composite_key;

insert into employee_composite_key values
(1,1,'mohit','male',22000,'IT','tamanna','delhi'),
(2,2,'yogita','female',24000,'HR','tamanna','mumbai'),
(3,1,'saurav','male',21000,'IT','tamanna','delhi'),
(4,2,'tanuj','male',25000,'HR','tamanna','mumbai'),
(5,1,'triveni','female',29000,'IT','tamanna','delhi');

-------------------------------first,second,third normal form
-------55-74
-------string functions

select ascii('A');
select ascii('Z');
select ascii('a');
select ascii('z');
select ascii('0');
select ascii('9');
select ascii('10');
select ascii('100');

select char(65);

declare @start int
set @start=65
while(@start <= 90)
begin
print char(@start)
set @start = @start + 1
end

declare @start int
set @start=65
while(@start <= 90)
begin
select char(@start)
set @start = @start + 1
end

select ltrim('     hello');


create table bio_data
(
id int not null identity,
first_name varchar(50) not null,
middle_name varchar(50) not null,
monitor_name varchar(50) not null,
city_name varchar(50) not null,
);

drop table bio_data;
select * from bio_data;

insert into bio_data values
('  mohit','mudgal  ','tamanna','delhi'),
('   yogita','nain  ','tamanna','mumbai'),
('  saurav',' sharma ','tamanna','delhi'),
('    tanuj','rana ','tamanna','mumbai'),
('  triveni','kaul ','tamanna','delhi');

select first_name+' '+middle_name+''+monitor_name from bio_data;
select ltrim(first_name) from bio_data;
select ltrim(rtrim(middle_name)) from bio_data;
select ltrim(first_name)+' '+ltrim(rtrim(middle_name))as full_name from bio_data;

select upper(first_name)+' '+lower(middle_name)+' '+reverse(monitor_name)+' '+cast(len(city_name)as varchar) from bio_data;

select upper(first_name) from bio_data;
select lower(first_name) from bio_data;
select reverse(first_name) from bio_data;
select len(city_name) from bio_data;


------------------------------indexes in sql-------------------
---index--two types--dictionary(word index)--page index-----if 1000 records(rows), it improve speed.
----right click----new index--clustered index(word index)---non clustered(page index)
--- tables--employee_salary--index/triggers/constraints/keys/column

 create table employee_salary
(
emp_id int not null,
dept_id int not null,
emp_name varchar(50),
emp_gender varchar(50),
emp_salary int,
dept_name varchar(50),
dept_head varchar(50),
dept_location varchar(50),
);

select * from employee_salary;

insert into employee_salary values
(1,1,'mohit','male',22000,'IT','tamanna','delhi'),
(2,2,'yogita','female',24000,'HR','tamanna','mumbai'),
(3,1,'saurav','male',21000,'IT','tamanna','delhi'),
(4,2,'tanuj','male',25000,'HR','tamanna','mumbai'),
(5,1,'triveni','female',29000,'IT','tamanna','delhi');
clustered
create index ix_fte_salary on employee_salary (emp_salary asc);
create nonclustered index ix_fte_salary on employee_salary (emp_salary asc);
create nonclustered index ix_fte_name_salary on employee_salary (emp_name asc,emp_salary asc);
select * from employee_salary;-------index work on name and salary

select * from employee_salary where emp_salary>23000 and emp_salary<28000 ;
sp_helpindex employee_salary;
drop index employee_salary.ix_fte_salary;

truncate table employee_salary;
alter table employee_salary add primary key (emp_id);
   
---------------------------------------------------------------------------------
alter table voter_table add primary key (voter_id);
alter table voter_table alter column voter_id int not null;
alter table voter_table drop constraint [PK__voter_ta__B795031306CE23B1];
alter table voter_table add unique(voter_id);
update voter_list set voter_city = 'hyderabad' where voter_id = 1;
alter table voter_list drop column voter_city;
alter table voter_list alter column voter_name nvarchar(50);
-------------------------------------------------------------------------------------

drop index employee_salary.ix_fte_id_clustered;
create clustered index ix_fte_id_clustered on employee_salary (emp_id asc);
create clustered index ix_fte_gender_salary_clustered on employee_salary (emp_gender desc,emp_salary asc);
--Cannot create more than one clustered index on table 'employee_salary'. Drop the existing clustered index 'ClusteredIndex-20210923-165629' before creating another.
drop index employee_salary.ix_fte_id_clustered;
select * from employee_salary;-------------emp_gender desc,emp_salary asc
--on one table one clustered index, but one clustered index on mulple columns. called composite index 
--non clustered index could be many on table, as the don't use primary key/unique/desc like property, they stored separately from actual data. 
drop table employee_salary;
sp_helpindex employee_salary;

--unique and non unique indexees
--if primary key or unique property is set on column then unique index automatically created. 
--it's a property and both clustered/nonclustered could use unique, if no duplicate value present on it.
--no big difference between unique constraint and unique index.
--non-unique index automatically created when clustered/nonclustered index created.

create unique clustered index cix_books_id on books(bookid asc);
create unique nonclustered index ncix_books_id on books(bookname asc);

--computed columns in sql 

create table employee_payroll
(
emp_id int identity,
emp_name varchar(50),
emp_designation varchar(50),
basic_pay int,
house_rent_allowance int,
convenience_allowance int,
medical_allowance int,
gross_pay as basic_pay+house_rent_allowance+convenience_allowance+medical_allowance persisted);-----computed column

insert into employee_payroll values('mohit','manager',25000,7000,4000,6000);
insert into employee_payroll values('rohit','assistant',21000,4000,5000,3000);
insert into employee_payroll values('triveni','incharge',19000,6000,2000,4000);
insert into employee_payroll values('yogita','a manager',22000,9000,3000,5000);

truncate table employee_payroll;
select * from employee_payroll;
alter table employee_payroll add [company_name] as 'abc company';
alter table employee_payroll add [date] as getdate();
update employee_payroll set basic_pay = 30000 where emp_id=3;

drop table employee_payroll;
select gross_pay from employee_payroll;
select * from employee_payroll where gross_pay>25000;
select * from employee_payroll order by gross_pay asc;

update employee_payroll set gross_pay = 36000 where emp_id=2;
--The column "gross_pay" cannot be modified because it is either a computed column or is the result of a UNION operator.
alter table employee_payroll add bonus as [gross_pay] > 2000;


create table product_sales_cost
(
p_id int identity primary key,
p_name varchar(50),
num_unit int,
unit_price int,
total_cost as unit_price * num_unit persisted);

insert into product_sales_cost values('mohit',3,200);
insert into product_sales_cost values('rohit',4,300);
insert into product_sales_cost values('triveni',2,700);
insert into product_sales_cost values('yogita',4,600);

drop table product_sales_cost;

select gross_pay from employee_payroll;

create index ix_products_totalcost on product_sales_cost (total_cost asc);
select * from product_sales_cost;

update product_sales_cost set unit_price = 600 where p_id=3;

------------------cube and roll up in sql------------------------------

select * from [dbo].[employee];

select city,gender,sum(salary) as total_salary
from employee
group by city,gender;

select city,gender,sum(salary) as total_salary
from employee
group by cube(city,gender);

select city,gender,sum(salary) as total_salary
from employee
group by city,gender with cube;

/*
delhi	f	34000
mumbai	f	54000
NULL	f	88000
delhi	m	48000
mumbai	m	44000
NULL	m	92000
NULL	NULL	180000
delhi	NULL	82000
mumbai	NULL	98000
*/

select city,gender,sum(salary) as total_salary
from employee
group by city,gender with rollup;

/*
delhi	f	34000
delhi	m	48000
delhi	NULL	82000
mumbai	f	54000
mumbai	m	44000
mumbai	NULL	98000
NULL	NULL	180000         ----------------both
*/

select city,sum(salary) as total_salary
from employee
group by city with cube;

select city,sum(salary) as total_salary
from employee
group by city with rollup;

--diff seen if more than one column

--grouping sets----group together multiple groupings of columns followed by optional grand total row,donated by () parenthesis.
--more efficient to use grouping sets instead of multiple group by with union clauses (processing issue) 

select city, gender, sum(salary) as total_salary
from employee
group by
grouping sets
(
(city, gender),
(city),
(gender),
()---------------------optional grand total row
)
order by grouping(city),grouping(gender);

/*
delhi	m	48000
mumbai	m	44000
delhi	f	34000
mumbai	f	54000
delhi	NULL	82000
mumbai	NULL	98000
NULL	f	88000
NULL	m	92000
NULL	NULL	180000*/



select * from [dbo].[employee];

select city,gender,sum(salary) as total_salary
from employee
group by city,gender
union all
select city,null,sum(salary) as total_salary
from employee
group by city
union all
select null,gender,sum(salary) as total_salary
from employee
group by gender;

select city,sum(salary) as total_salary
from employee
group by cube(city);

select city,sum(salary) as total_salary
from employee
group by rollup(city);


select city,gender,sum(salary) as total_salary
from employee
group by city,gender
union all
select city,null,sum(salary) as total_salary
from employee
group by city
union all
select null,gender,sum(salary) as total_salary
from employee
group by gender;

select null,null as [m/f],sum(salary) as total_salary
from employee
group by city;

---------------merge statement--------------------------------

create table emp_target(id int not null identity, name varchar(50),gender varchar(50));
create table emp_source(id int not null identity, name varchar(50),gender varchar(50));

insert into emp_source values('ali','m');
insert into emp_source values('afshan','f');
insert into emp_source values('usman','m');

insert into emp_target values('amir','m');
insert into emp_target values('usman','m');
insert into emp_target values('muntaha','f');
insert into emp_target values('momina','f');

drop table emp_source;
drop table emp_target;

select * from emp_source;
select * from emp_target;

--insert in target from source, if it is missing in target
--update target row if it present in source
--delete target row if it is not present in source

merge emp_target as t
using emp_source as s
on t.id=s.id
when matched then
update set t.[name]=s.[name],t.gender=s.gender
when not matched by target then
insert ([name],gender) values (s.[name],s.gender)
when not matched by source then
delete;

merge emp_target as t
using emp_source as s
on t.id=s.id
when matched then
update set t.[name]=s.[name],t.gender=s.gender
when not matched by target then
insert ([name],gender) values (s.[name],s.gender);

-------------transaction in sql----------------------
--begin transaction
--rollback transaction----------undo
--commit transaction------------permanent save
--begin transaction------rollback transaction or commit transaction
--transaction have states
--begin(active)---partially committed---commited---end
--begin(active)---partially committed---failed-----aborted----end

create table emp_target(id int not null identity, name varchar(50),gender varchar(50));
create table emp_source(id int not null identity, name varchar(50),gender varchar(50));

drop table emp_source;
drop table emp_target;

select * from emp_source;
select * from emp_target;

begin transaction
insert into emp_source values('ali','m');
insert into emp_source values('afshan','f');
insert into emp_source values('usman','m');
rollback transaction;-------------(0 rows affected)

begin transaction
insert into emp_target values('amir','m');
insert into emp_target values('usman','m');
insert into emp_target values('muntaha','f');
insert into emp_target values('momina','f');
commit transaction

set transaction isolation level read uncommitted;


-----------try catch in sql----------------------------------------
select * from [dbo].[tbl_student];
begin try
select 10/0

end try
begin catch
	print 'you cannot divide number by zero'
end catch


begin try
update [dbo].[tbl_student] set s_age='abc' where s_id=1
end try
begin catch
	print 'you cannot insert string into integer column'
end catch

begin try
update [dbo].[tbl_student] set s_age='abc' where s_id=1
end try
begin catch
	select
	ERROR_NUMBER() as [ERROR_NUMBER],
	ERROR_SEVERITY() as [ERROR_SEVERITY],
	ERROR_STATE() as [ERROR_STATE],
	ERROR_PROCEDURE() as [ERROR_PROCEDURE],
	ERROR_LINE() as [ERROR_LINE],
	ERROR_MESSAGE() as [ERROR_MESSAGE]
end catch
--you cannot divide number by zero
--you cannot insert string into integer column
select * from [dbo].[tbl_student];


begin try
begin transaction
insert into tbl_student values(14,'shobhit','male',19,9,40)
insert into tbl_student values(12,'surbhi','female',19,9,50)
insert into tbl_student values(13,'rahul','male',19,10,30)
commit transaction
print 'transaction successfully done';
end try
begin catch
rollback transaction
print 'transaction failed';
select ERROR_MESSAGE() as [ERROR_MESSAGE]
end catch

--if some problem accurs in try block immediately goes to catch block


----------------global(##)/local(#) temporary table----------------------   
--databases--system databases--tempdb--temporary tables--[dbo].[#empdetails_______________________________[dbo].[#empdetails_________________________________________________________________________________________________________000000000043]__________________________________________________________________________000000000043]
create table #empdetails ([name] varchar(25),[gender] varchar(25));
drop table #empdetails;
select [name] from tempdb..sysobjects where [name] like '%empdetails%';

insert into #empdetails values ('minakshi','female');
insert into #empdetails values ('mukesh','male');
insert into #empdetails values ('ramesh','male');

select * from #empdetails;

--open new query window and run select * from #empdetails;  
--Invalid object name '#empdetails'.------run only in query window where local temporary table created, dropped if connection closed.
--if created inside sp then dropped if stored procedure stops execution.
--with same name, we could create local temporary table in different connections.(as tail number differ)
drop table #empdetails;

create procedure spempdata
as
begin
create table #empdata ([name] varchar(25),[gender] varchar(25));

insert into #empdata values ('minakshi','female');
insert into #empdata values ('mukesh','male');
insert into #empdata values ('ramesh','male');

select * from #empdata;
end

execute spempdata;
select * from #empdata;


create table ##empdata1 ([name] varchar(25),[gender] varchar(25));

insert into ##empdata1 values ('minakshi','female');
insert into ##empdata1 values ('mukesh','male');
insert into ##empdata1 values ('ramesh','male');

select * from ##empdata1;---------------open in all connection windows, 

drop table ##empdata1;
select [name] from tempdb..sysobjects where [name] like '%empdata1%';-----------[dbo].[##empdata1]

-------open in all connection windows, 
-------dropped when last connection which is using global temporary table closed
-------connection which created global temporary table if closed, global temporary table dropped automatically.
-------with same name global temporary table can't be created in multiple connection window.
-------they both created in tempdb.












































































































































































