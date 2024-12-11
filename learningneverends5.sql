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
insert into voter_list(voter_name,voter_age) values(1,'mohit',21);

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


create trigger tr_customer_insteadofdeleteaudit
on tbl_customer
instead of delete
as
begin
	insert into tbl_customer_audit values(' someone has tried to delete data in customer table at:  '+cast(getdate() as varchar(50)));
end

drop trigger tr_customer_insteadof_delete;
delete from tbl_customer where id=6;

select * from tbl_customer;
select * from tbl_customer_audit;

























































































































































