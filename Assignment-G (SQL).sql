create database store;
use store;
create table employyes(
    id INT,
    name varchar(30),
    department varchar(10),
	salary int
);
insert into employyes (id,name,department,salary) values
(1, 'Alice','HR',50000),
(2, 'Bob','IT',70000),
(3, 'Charlie','IT',60000),
(4, 'David','HR',55000),
(5, 'EVe','Finance',65000);
# Create a procedure to show all employees details.
Delimiter // 
create procedure showallemployyes()Begin select*from employyes;
End //
Delimiter ;
Call showallemployyes();
# Create a stored procedure to fetch all employees from a specific department.
Delimiter // 
create procedure getemployyesByDept(In dept_name varchar(50))Begin select*from employyes where department=dept_name;
End //
Delimiter ;
Call getemployyesByDept('IT');
# Create a stored procedure to increase salary by a given percentage for a department.
Delimiter // 
create procedure IncreaseSalaryByDepty(In dept_name VARCHAR(50),In percent_increase Decimal(5,2))Begin update employyes set salary=salary+(salary*percent_increase/100) where department=dept_name;
End //
Delimiter ;
set sql_safe_updates=0;
Call IncreaseSalaryByDepty('IT',10);
# Create a procedure to return the total salary of all employees.
Delimiter //
create procedure totalsalary() Begin select sum(salary) from employyes;
End //
Delimiter ;
Call totalsalary(); 
# Create a procedure to insert a new employee into an existing table.
Delimiter //
create procedure addemployyes( In emp_name Varchar(50),In emp_dept Varchar(50),In emp_salary INT) Begin insert into employyes(name,department,salary) values (emp_name,emp_dept,emp_salary);
End //
Delimiter ;
Call addemployyes('Frank','Finance',62000);
# Create a procedure to delete an existing employee from the table by id.
Delimiter //
create procedure deleteemployesbyid( In empid INT) Begin delete from employyes where empid=id;
End //
Delimiter ;
Call deleteemployesbyid(3);
# Create a procedure to return average salary.
Delimiter //
create procedure returnavgsalary() Begin select avg(salary) from employyes;
End //
Delimiter ;
Call returnavgsalary();
# Create a procedure to get employees above a salary.
Delimiter // 
create procedure getemployyesabovesalary(In salary_emp int)Begin select*from employyes where salary>salary_emp;
End //
Delimiter ;
Call getemployyesabovesalary(50000);
# Create a procedure to get highest salary.
Delimiter // 
create procedure highestsalary()Begin select max(salary) from employyes;
End //
Delimiter ;
Call highestsalary();
# Create a procedure to update employee name.
DELIMITER //
create procedure updateemployees(IN emp_name varchar(50),in id_emp int) begin update employyes set name=emp_name where id_emp=id;
END //
DELIMITER ;
set sql_safe_updates=0;
Call updateemployees('Avii',1);
select* from employyes;