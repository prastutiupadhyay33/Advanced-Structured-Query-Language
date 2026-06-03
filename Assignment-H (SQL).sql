create database emps;
use emps;
create table employs (
emp_id int primary key,
name varchar(50),
salary decimal(10,2)
);
create table employsss_log (
log_id int auto_increment primary key,
emp_id int,
action varchar(50),
log_time timestamp default current_timestamp 
);
insert into employs (emp_id,name,salary) values
(1,'Amit','50000.00'),
(2,'Neha', '62000.00'),
(3,'Ravi','45000.00'),
(4,'Priya','70000.00');
# Trigger to Log Insert Activity.
Delimiter //
create trigger trg_after_insert_employs
after insert on employs
for each row
begin
insert into employsss_log(emp_id, action)
values (NEW.emp_id,'Employee Inserted');
end //
Delimiter ;
insert into employs values (5,'Rina',60000);
# Trigger to Log Employee Delete.
Delimiter //
create trigger trg_after_delete_employs
after delete on employs
for each row
begin
insert into employsss_log(emp_id, action)
values (OLD.emp_id,'Employee Deleted');
end //
Delimiter ;
delete from employs where emp_id = 1;
# Trigger to Log Salary Update.
Delimiter //
create trigger trg_after_salary_update
after update on employs
for each row
begin
if OLD.salary <> NEW.salary then
   insert into employsss_log(emp_id, action)
   values (NEW.emp_id,'Salary Updated');
end if;
end //
Delimiter ;
set sql_safe_updates=0;
update employs
set salary = 60000
where emp_id = 2;
# Trigger to Prevent Negative Salary.
Delimiter //
create trigger trg_before_insert_salary
before insert on employs
for each row
begin
if NEW.salary < 0 then
   signal sqlstate '55000'
   set message_text ='Salary cannot be negative';
end if;
end //
Delimiter ;
insert into employs values (6,'Aarya',-10000);
# Trigger to Automatically Increase Salary by 10%.
Delimiter //
create trigger trg_before_insert_inc
before insert on employs
for each row
begin
set NEW.salary = NEW.salary * 1.10;
end //
Delimiter ;
insert into employs values (7,'Nitin',20000);
# Trigger to Store Old and New Salary Change.
Delimiter //
create trigger trg_salary_change
after update on employs
for each row
begin
if OLD.salary <> NEW.salary then
   insert into employsss_log(emp_id, action)
   values (
      NEW.emp_id,
      concat('Salary changed from ',
             OLD.salary,
             ' to ',
             NEW.salary));
end if;
end //
Delimiter ;
update employs
set salary = 80000
where emp_id = 3;
# Trigger to Convert Employee Name to Uppercase.
Delimiter //
create trigger trg_uppercase_name
before insert on employs
for each row
begin
set NEW.name = upper(NEW.name);
end //
Delimiter ;
insert into employs values (8,'Kinjal',65000);
# Trigger to Restrict Salary Reduction.
Delimiter //
create trigger trg_prevent_salary_reduce
before update on employs
for each row
begin
if NEW.salary < OLD.salary then
   signal sqlstate '50000'
   set message_text = 'Salary reduction not allowed';
end if;
end //
Delimiter ;
update employs
set salary = 20000
where emp_id = 2;
# Trigger to Log Name Changes.
Delimiter //
create trigger trg_name_change
after update on employs
for each row
begin
if OLD.name <> NEW.name then
   insert into employsss_log(emp_id, action)
   values (NEW.emp_id,'Employee Name Changed');
end if;
end //
Delimiter ;
update employs
set name ='Prayusha'
where emp_id = 4;
select*from employs;
select*from employsss_log;
# Trigger to Prevent Salary Above Limit.
DELIMITER //
create trigger trg_salary_limit
before insert on employs
for each row
begin
    if new.salary > 100000 THEN
        signal sqlstate '45000'
        set message_text = 'Salary cannot exceed 100000';
    end if;
end //
DELIMITER ;
insert into employs values (1,'Amit',50000);
insert into employs values (2,'Neha',120000);
# Trigger to Prevent Updating Employee ID.
DELIMITER //
create trigger trg_no_id_update
before update on employs
for each row
begin
    if new.emp_id <> old.emp_id THEN
        signal sqlstate '45000'
        set message_text = 'Employee ID cannot be changed';
    end if;
end //
DELIMITER ;
update employs
set emp_id = 10
where emp_id = 1;
# Trigger to Add Bonus Salary on Update.
Delimiter //
create trigger trg_bonus_salary
before update on employs
for each row
begin
if OLD.salary <> NEW.salary then
   set NEW.salary = NEW.salary + 1000;
end if;
end //
Delimiter ;
update employs
set salary = 80000
where emp_id = 2;
# Trigger to Add Joining Message.
Delimiter //
create trigger trg_join_message
after insert on employs
for each row
begin
insert into employsss_log(emp_id, action)
values (NEW.emp_id,'Welcome New Employee');
end //
Delimiter ;
insert into employs values (12,'Riya',45000);
# Trigger to Log High Salary Employee.
Delimiter //
create trigger trg_high_salary
after insert on employs
for each row
begin
if NEW.salary > 80000 then
   insert into employsss_log(emp_id, action)
   values (NEW.emp_id, 'High Salary Employee Added');
end if;
end //
Delimiter ;
insert into employs values (10,'Kartik',90000);
# Trigger to Prevent Duplicate Employee Name.
Delimiter //
create trigger trg_duplicate_name
before insert on employs
for each row
begin
if exists (
   select * from employs
   where name = NEW.name
) then
   signal sqlstate '55000'
   set message_text = 'Employee name already exists';
end if;
end //
Delimiter ;
insert into employs values (12,'Amit',60000);









