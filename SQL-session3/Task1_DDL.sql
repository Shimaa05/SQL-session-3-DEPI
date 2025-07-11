create database Company;
GO

use Company;
Go

create table Department(
	DeptID int primary key,
	DeptName varchar(100) not null unique,
	managerID int unique
);

create table Employee(
	EmpID int primary key,
	EmpName varchar(100) not null,
	Gender char(1) not null check(Gender in('M' , 'F')),
	Date_of_Birth date,
	DeptID int not null,
	Salary decimal(10,2) default 5000 check (Salary >= 0)
);

alter table Department
add constraint FK_Department_Manager foreign key (managerID) references Employee(EmpID)
on delete set null on update cascade;

alter table Employee
add constraint FK_Employee_Department foreign key (DeptID) references Department(DeptID)
on delete no action on update no action;

create table Dependentt(
	DepID int primary key,
	DepName varchar(100) not null,
	Gender char(1) not null check(Gender in('M' , 'F')),
	Date_of_Birth date,
	EmpID int not null
);

alter table Dependentt
add constraint FK_Dependent_Employee foreign key (EmpID) references Employee(EmpID)
on delete cascade on update cascade;

create table Project(
	ProjectID int primary key,
	ProjectName varchar(100) not null unique,
	DeptID int not null
);

alter table Project
add constraint FK_Project_Department foreign key (DeptID) references Department(DeptID)
on delete no action on update cascade;

create table Works_On(
	EmpID int not null,
	ProjectID int not null,
	HoursWorked int check(HoursWorked >= 0),
	primary key (EmpID , ProjectID),
	foreign key (EmpID) references Employee(EmpID) on delete cascade on update no action,
	foreign key (ProjectID) references Project(ProjectID) on delete no action on update no action
);

alter table Employee
add Email varchar(100) unique;

alter table Employee
alter column EmpName varchar(150);

alter table Department
drop constraint FK_Department_Manager;


insert into Department (DeptID, DeptName, managerID) values
(1, 'HR', 101),
(2, 'IT', 102);

insert into Employee (EmpID, EmpName, Gender, Date_of_Birth, DeptID, Salary, Email) values
(101, 'Fatma Mohamed', 'F', '2000-05-10', 1, 7000, 'fatma@gmai.com'),
(102, 'Ahmed Ali', 'M', '2002-03-22', 2, 6500, 'Ahmed@gmai.com');

update Department set managerID = 101 where DeptID = 1;
update Department set managerID = 102 where DeptID = 2;

insert into Dependentt (DepID, DepName, Gender, Date_of_Birth, EmpID) values
(1, 'Mariam Amr', 'F', '1999-06-01', 101),
(2, 'Youssef Ahmed', 'M', '1998-09-17', 102);

insert into Project(ProjectID, ProjectName, DeptID) values
(200, 'Payroll System', 2),
(201, 'AI Platform', 1);

insert into Works_On(EmpID, ProjectID, HoursWorked) values
(101, 201, 40),
(102, 200, 35);