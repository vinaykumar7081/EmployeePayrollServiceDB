----UC1_CreatingDatabase------*
Create Database Payroll_Service;
----Use DataBase-----
Use Payroll_Service;

-----UC2_Ctreating table in the data Base------
Create table Employee_Payroll(Id int  NOT NULL primary key IDENTITY(101,1),Name varchar(35) NOT NULL,Salary Money NOT NULL, StartDate Date NOT NULL
);

-----UC3_Inserting Value in the Table-----
insert into Employee_Payroll 
values
('Anish',30000,'2021.APR.15'),
('Akash',20000,'2022.MAY.15'),
('Anurag',22000,'2022.APR.12'),
('Geetanjali',50000,'2022.01.01'),
('Babu',22000,'2022.03.15'),
('Shudhakr',22000,'2022.Jan.01'),
('Harshal',30000,'2022.May.20'),
('Chetna',30000,'2022.May.21'),
('Abhinav',23000,'2022.APR.13');

----- UC4-Display All Fields and Record of Table Whose Present in Data Base------

	select *from Employee_Payroll;


----UC5-Display Spefic Selected Data from Employee_Payroll Table  and Display from Selected until Present Date---- 

select Salary from Employee_Payroll
where Name='Babu';

select StartDate  from Employee_Payroll
 WHERE (StartDate BETWEEN '2022-03-15' AND GETDATE());

 -----UC6-Adding New Column in Employee_Payroll column name As Gender Gender------
 Alter table Employee_Payroll Add Gender varchar(1);

 -----UC7-Update Gender Column in Employee_Payroll and Perform some Specific Operation----
 Update Employee_Payroll set Gender='M' where Id in(101,102,103,105,106,109);

 Update Employee_Payroll set Gender='F' where Id in(104,107,108);


 select Name from Employee_Payroll
 where Gender='F';

 select Sum(Salary) from Employee_Payroll;

 select Sum(Salary) from Employee_Payroll where Gender='F' group by Gender;

 Select AVG(Salary) from Employee_Payroll
 where Gender ='M' Group by Gender;

 Select MIN(Salary) from Employee_Payroll;

 Select MAX(Salary) from Employee_Payroll;


 Select COUNT(Id) from Employee_Payroll; 

 -----UC8-Adding three New Column in the Employee_Payroll Table with Name ContactNumber, Address,Department-----
  Alter table Employee_Payroll 
  Add ContactNumber varchar(10), Address Varchar(50), Department varchar(25);

  -----UC9-Adding New Column Employee_Payroll table
  select *from Employee_Payroll;

   Alter table Employee_Payroll 
  Add Pay decimal(10), Deduction decimal(10), TaxablePay decimal(10), IncomeTax decimal(10), NetPay decimal(10) ;

  Update Employee_Payroll Set ContactNumber='9187248525', Address='Delhi', Department='Sales' ,Pay=200, Deduction=650, TaxablePay=400, IncomeTax=900, NetPay=2150 where Id=109;


	SELECT * FROM sys.assemblies;

	SELECT  * FROM sys.schemas 

	      ------Creating Procedure-------- 

		  -----Creating Procedure Without Parameter-------

	Alter PROCEDURE spGetEmployeePayroll
	AS
	BEGIN
			Select Name, Salary from Employee_Payroll 
	END

	Alter PROCEDURE spGetAllEmployeePayroll
	AS
	BEGIN
			Select * from Employee_Payroll 
	END
	execute spGetAllEmployeePayroll

	 Execute spGetEmployeePayroll

	create PROCEDURE spGetEmployeePayrollService --Stored Procedure With Input Parameter--
	@Id int
	AS
	BEGIN
		Select Id,Name,Salary from Employee_Payroll where Id=@Id 
    End
	
  spGetEmployeePayrollService 104

  Alter  PROC spUpdateEmployeePayRoll --with the Store Procedure Updating the Data--
  
  @Id int,
  @Name varchar(20)
  as
  begin
		update  Employee_Payroll  Set Name=@Name  where Id=@Id
		end

spUpdateEmployeePayRoll 101,'Akash'

Alter PROC spCrudOperationEmployeePayRoll
@Id int,
@Name varchar(25),
@Salary decimal(10),
@startDate Date,
@Gender varchar(1),
@Contact varchar(12),
@Address varchar(50),
@Department varchar(25),
@Pay decimal(10),
@Deduction decimal(10),
@TaxablePay decimal(10),
@IncomeTax decimal(10),
@NetPay decimal(10),

@operation varchar(20)
as
BEGIN
  if(@operation='Insert')
   begin
   insert into Employee_Payroll (Id, Name, Salary, StartDate, Gender,ContactNumber, Address, Department, Pay, Deduction, TaxablePay, IncomeTax, NetPay)
   Values

   (
    @Id,
    @Name, 
	@Salary,
	@startDate,
	@Gender,
	@Contact,
	@Address,
	@Department,
	@Pay,
	@Deduction,
	@IncomeTax,
	@IncomeTax,
	@NetPay)
   
   end
   if(@operation='Select')
   begin
  Select* from Employee_Payroll
   end
   if(@operation='Update')
   begin
  update Employee_Payroll Set Name=@Name where Id=@id
   end
   if(@operation='Delete')
   begin
  Delete from Employee_Payroll  where Id=@id
   end

END

spCrudOperationEmployeePayRoll @operation='Insert', @Id=110, @Name='Manish', @Salary=25000, @Date='2022-04-15', @Gender='F', @Contact='99185421030', @Address='Pune', @Department='Analyse', @Pay=100, @Deduction=1000, @TaxablePay=400, @IncomeTax=1200, @NetPay=2700 

spCrudOperationEmployeePayRoll @operation='Update', @Name='Vinod', @Id=102 

 spCrudOperationEmployeePayRoll @operation='Delete', @Id=109

 -----Creating User Defined Function---------------

 ------Scalar Function-----------(Scalar Function Accept Zero or More Parameter and Return Single Value)--

 Create Function GetEmployeeName(@Id int)
 RETURNS VARCHAR(25)
 AS
 Begin
 RETURN (SELECT Name, Department,Salary FROM Employee_Payroll WHERE Id=@Id)  
 End

 Print dbo.GetEmployeeName(101)

 -----Tabular Function (A-Inline Function)------
 CREATE FUNCTION GetAllEmployee(@Salary Decimal)  
RETURNS TABLE  
AS 
 
RETURN  
    SELECT *FROM Employee_Payroll WHERE Salary>=@Salary 
	
	Select * from GetAllEmployee(22000)

	-----Tabular Function (B-Multi-Statement Table Valued Function)----

	CREATE FUNCTION FN_MSTVF_GetEmployee()  
RETURNS @Table TABLE (Id int, Name varchar(20),Salary decimal(10),Gender varchar(1)) 
AS  
begin
      insert into @Table
        Select Id, Name, Salary, Gender from Employee_Payroll 
		return
End    

Select*from FN_MSTVF_GetEmployee();

------UC10----

select * from Department;
Select * From EmployeeMapping;
Create Table Department 
(DptId int NOT NULL Primary Key Identity(101,1),DeptName varchar(35) NOT NULL);

Create Table EmployeeMapping
(EmpId int Primary Key NoT Null Identity(101,1),
MappingId int,
EmployeePayRollId int Foreign Key References Employee_Payroll(Id),
DeptId int Foreign Key References Department(DptId));

insert into Department
values
('Development'),
('Testing'),
('Management'),
('Marketing'),
('NetWorking'),
('Sales'),
('Development');

insert into EmployeeMapping
values
(101,101,101),
(101,102,103);

Alter Table Employee_PayRoll
Drop Column Department;


Select Name,Salary,StartDate, Gender,ContactNumber,Address, Pay, Deduction,TaxablePay,NetPay,
 Department.DeptName from Employee_Payroll INNER JOIN EmployeeMapping ON 
Employee_Payroll.Id=EmployeeMapping.EmployeePayRollId
INNER JOIN Department ON  Department.DptId=EmployeeMapping.DeptId;
