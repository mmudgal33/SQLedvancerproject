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
drop table employee_backup;

select * from my_employees;
select * from my_department;

select emp_id,emp_name,salary 
into employee_backup from my_employees;

select * from employee_backup;

select * into employee_backup from my_employees
where city = 'delhi';

select * into employee_backup from my_employees as a
inner join my_department as b
on b.dept_id=a.emp_id;

alter table my_department alter column  varchar(50) not null;














