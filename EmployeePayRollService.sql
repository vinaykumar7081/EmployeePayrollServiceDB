Create Database Payroll_Service;

Use Payroll_Service;

Create table Employee_Payroll(Id int  NOT NULL primary key IDENTITY(101,1),Name varchar(35) NOT NULL,Salary Money NOT NULL, StartDate Date NOT NULL
);



insert into Employee_Payroll 
values
('Anish',30000,'2022.APR.15'),
('Akash',20000,'2022.MAY.15'),
('Anurag',22000,'2022.APR.12'),
('Geetanjali',50000,'2022.01.01'),
('Babu',22000,'2022.03.15'),
('Shudhakr',22000,'2022.Jan.01'),
('Harshal',30000,'2022.May.20'),
('Chetna',30000,'2022.May.21'),
('Abhinav',23000,'2022.APR.13');

select *from Employee_Payroll;