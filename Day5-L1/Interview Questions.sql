# Interview Questions

-- Create Person table
CREATE TABLE Person (
    Person_id INT PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50)
);

-- Create Address table
CREATE TABLE Address (
    Address_id INT PRIMARY KEY,
    Person_id INT,
    City VARCHAR(50),
    State VARCHAR(50),
    FOREIGN KEY (Person_id) REFERENCES Person(Person_id)
);

-- Insert data into Person table
INSERT INTO Person (Person_id, LastName, FirstName) VALUES
(1, 'Doe', 'John'),
(2, 'Smith', 'Alice'),
(3, 'Johnson', 'Michael'),
(4, 'Brown', 'Emily'),
(5, 'Taylor', 'James');

-- Insert data into Address table
INSERT INTO Address (Address_id, Person_id, City, State) VALUES
(1, 1, 'New York', 'NY'),
(2, 2, 'Los Angeles', 'CA'),
(3, 3, 'Chicago', 'IL'),
(4, 4, 'Houston', 'TX');

# Ques 1 : Write an SQL Query to resport the full name ( first name + last name) , city and state of each person in the person table. if the 
#	 			address of a person is not present in the address table then report null instead.

select concat(p.firstname, " ",p.lastname) as full_name,a.city ,a.state from person p left join address a on p.person_id = a.person_id;

# Ques 2 : Write an SQL Query to report the second highest salaary from the employee table. if there is no second highest salary, the query
# 	 report null

-- Create employee1 table
CREATE TABLE employee1 (
    id INT,
    salary DECIMAL(10, 2)
);

-- Create employee2 table
CREATE TABLE employee2 (
    id INT PRIMARY KEY,
    salary DECIMAL(10, 2)
);

-- Insert data into employee1 table
INSERT INTO employee1 (id, salary) VALUES
(1, 50000.00),
(2, 64000.00),
(3, 64000.00),
(4, 60000.00),
(5, 65000.00);

-- Insert data into employee2 table
INSERT INTO employee2 (id, salary) VALUES
(1, 70000.00);


# Second highest salary from both tables
select distinct salary from employee1 order by salary desc limit 1,1;
#NOTE : LIMIT 1, 1: This skips the first salary (because of 1 after the comma) 
# second highest salary 

select id,salary from employee1 where salary = (select salary from employee1 order by salary DESC limit 2,1);

# if second highest is not present in the table 

select id,salary from employee2 order by salary desc limit 2,1;

-- Ques 3 : Write an SQL query to report the nth highest salary from the mployee table. if there is no nth highest 
-- salary the query should report null
# fetch nth highest salary ( n = 3)

with RankSalaries as (select id,salary, dense_rank() over(order by salary desc) as SalaryRank from employee1)
select id,salary from RankSalaries where SalaryRank = 3; 


-- Ques4 : Write an SQL query to rank the score. the ranking should be calculated according to the following rules.
-- > The score should be ranking from highest to lowest
-- > if there is a tie between two scores both should have the same ranking
-- > after a tie net ranking number should be the next consecutive interger value in other words there should be no holes between ranks

-- Create the Score table
CREATE TABLE Score (
    id INT PRIMARY KEY,
    score DECIMAL(10, 2)
);

-- Insert sample data into the Score table
INSERT INTO Score (id, score) VALUES
(1, 98.50),
(2, 92.75),
(3, 98.50),
(4, 84.25),
(5, 90.00),
(6, 92.75),
(7, 87.50);


select id,score, dense_rank() over(order by score desc) as rank_ from score order by score desc;


-- Ques 5 : Consecutive Numbers 
-- Write an SQL query to find all numbers that appear at least three time consecutively 

-- Create the Numbers table
CREATE TABLE Numbers (
    Id INT PRIMARY KEY,
    num VARCHAR(20)
);

-- Insert sample data into the Numbers table
INSERT INTO Numbers (Id, num) VALUES
(1, '1'),
(2, '2'),
(3, '2'),
(4, '2'),
(5, '3'),
(6, '3'),
(7, '3'),
(8, '4'),
(9, '5'),
(10, '5'),
(11, '5'),
(12, '5');

SELECT DISTINCT num
FROM (
    SELECT
        num,
        LEAD(num, 1) OVER (ORDER BY Id) AS next_num,
        LEAD(num, 2) OVER (ORDER BY Id) AS next_next_num
    FROM
        Numbers
) AS subquery
WHERE
    num = next_num AND num = next_next_num;
    
    
    #Question 6 : Employees Earning more than their managers
    
    -- Create Employee table
INSERT INTO Employee (id, name, salary, manager_id) VALUES
(1, 'John', 50000, 4),
(2, 'Alice', 60000, 4),
(3, 'Bob', 55000, 5),
(4, 'David', 70000, NULL),
(5, 'Carol', 58000, 6),
(6, 'Eve', 62000, 7),
(7, 'Frank', 53000, 7),
(8, 'Grace', 71000, 5),
(9, 'Henry', 65000, 6),
(10, 'Ivy', 72000, 6),
(11, 'Jack', 54000, 7),
(12, 'Kate', 59000, 5),
(13, 'Leo', 68000, 6),
(14, 'Mia', 61000, 5),
(15, 'Nick', 75000, 7);

SELECT e.id,e.name AS employee_name, e.salary AS employee_salary, m.name AS manager_name, m.salary AS manager_salary
FROM Employee e
INNER JOIN Employee m ON e.manager_id = m.id
WHERE e.salary > m.salary;


# Ques 7 : Duplicates Emails : Write a SQL Query to report all the duplicate emails. Note that it is guranteed that the email field is not NULL

CREATE TABLE person_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);

INSERT INTO person_data (email) VALUES
('john@example.com'),
('alice@example.com'),
('bob@example.com'),
('john@example.com'),
('dave@example.com'),
('alice@example.com'),
('sarah@example.com');

select email from person_data group by email having count(*)>1;


# Ques 8 : Customers who never order
-- Create Customers table
CREATE TABLE Customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Insert some sample data into Customers table
INSERT INTO Customers (name) VALUES
('John Doe'),
('Jane Smith'),
('Alice Johnson'),
('Bob Brown');

-- Create Orders table
CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

-- Insert some sample data into Orders table
-- Let's assume John Doe and Alice Johnson have placed orders
INSERT INTO Orders (customer_id) VALUES
(1),  -- John Doe
(3);  -- Alice Johnson


select * from customers;
select * from orders;

select c.id,c.name from customers c left join orders o on c.id = o.customer_id where o.customer_id is NULL;


# Ques 9 : Department Highest Salary 

drop table if exists Employees;
create table Employees(
	id INT AUTO_INCREMENT PRIMARY key,
    name varchar(20),
    salary int,
    departmentID int,
    FOREIGN KEY( departmentID) REFERENCES department(id)
);

INSERT INTO Employees (name, salary, departmentID) VALUES
('John', 50000, 1), 
('Jane', 60000, 1),  
('Alice', 55000, 2),  
('Bob', 65000, 2),    
('Charlie', 70000, 3),
('David', 72000, 3);  

create table department(
id INT auto_increment primary key,
name varchar(20)
);

-- Insert sample data into Departments table
INSERT INTO Department (name) VALUES
('HR'),
('Finance'),
('IT');

select * from employees;
select * from department;

select dept_name, emp_name , salary from (
select  d.name as dept_name, e.name as emp_name, e.salary as salary , row_number() over(partition by e.departmentID order by e.salary desc) AS rank_ from employees e join department d
on e.departmentID = d.id) ranked where rank_ = 1;


 