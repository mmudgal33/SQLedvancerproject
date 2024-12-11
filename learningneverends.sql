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
create table employee_details (id int primary key identity, name varchar(50) not null, gender varchar(50) not null,
salary varchar(50) not null, city varchar(50) not null);

insert into employee_details values('aashish','male','10000','noida');
insert into employee_details values('anshika','female','14000','lucknow');
insert into employee_details values('aakansha','female','15000','patna');
insert into employee_details values('rakesh','male','18000','mumbai');
insert into employee_details values('suresh','male','22000','delhi');
insert into employee_details values('mukesh','male','19000','pune');
insert into employee_details values('saurav','male','16000','surat');
insert into employee_details values('monika','female','15000','bhopal');
insert into employee_details values('triveni','female','25000','gurgaon');

drop table employee_details;
select * from employee_details;

select sum(CAST(salary AS int)) as total_salary from employee_details;
select max(CAST(salary AS int)) as maximum_salary from employee_details;
select min(CAST(salary AS int)) as minimum_salary from employee_details;
select avg(CAST(salary AS int)) as average_salary from employee_details;
select count(CAST(salary AS int)) as count_salary from employee_details;

--group by

















