Create Database Payroll_Service;

Use Payroll_Service;

Create table Employee_Payroll(Id int  NOT NULL primary key IDENTITY(101,1),Name varchar(35) NOT NULL,Salary Money NOT NULL, StartDate Date NOT NULL
);

select *from Employee_Payroll;