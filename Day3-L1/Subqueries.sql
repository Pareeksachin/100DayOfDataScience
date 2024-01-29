-- Table: Employee
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(255),
  dept_name VARCHAR(255),
  salary DECIMAL(10, 2)
);

-- Inserting 20 records into the employee table
INSERT INTO employee (emp_id, emp_name, dept_name, salary)
VALUES
  (1, 'John Doe', 'IT', 60000.00),
  (2, 'Jane Smith', 'HR', 55000.00),
  (3, 'Bob Johnson', 'Finance', 70000.00),
  (4, 'Alice Brown', 'IT', 62000.00),
  (5, 'Charlie Davis', 'Marketing', 58000.00),
  (6, 'Emma White', 'Finance', 72000.00),
  (7, 'Frank Miller', 'IT', 65000.00),
  (8, 'Grace Wilson', 'Marketing', 60000.00),
  (9, 'Henry Taylor', 'HR', 58000.00),
  (10, 'Isabel Martin', 'Finance', 71000.00),
  (11, 'Jack Harris', 'IT', 63000.00),
  (12, 'Katherine Allen', 'Marketing', 59000.00),
  (13, 'Liam Turner', 'Finance', 73000.00),
  (14, 'Mia Garcia', 'IT', 67000.00),
  (15, 'Noah Lee', 'Marketing', 61000.00),
  (16, 'Olivia Johnson', 'HR', 59000.00),
  (17, 'Peter Wilson', 'IT', 64000.00),
  (18, 'Quinn Smith', 'Finance', 74000.00),
  (19, 'Ryan Brown', 'Marketing', 62000.00),
  (20, 'Sophia Davis', 'HR', 60000.00);

-- Table: Department
CREATE TABLE department (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(255),
  location VARCHAR(255)
);

-- Inserting 6 records into the department table
INSERT INTO department (dept_id, dept_name, location)
VALUES
  (101, 'IT', 'New York'),
  (102, 'HR', 'Los Angeles'),
  (103, 'Finance', 'Chicago'),
  (104, 'Marketing', 'San Francisco'),
  (105, 'Operations', 'Houston'),
  (106, 'Sales', 'Miami');

select * from employee;
select * from department;

describe department;

-- Remove primary key from dept_id
ALTER TABLE department
DROP PRIMARY KEY;

-- Add primary key to dept_name
ALTER TABLE department
ADD PRIMARY KEY (dept_name);


-- What is a Sub-Query? How Does SQL process a statment containing sub-query ?

-- Q1: find the employees who's salary is more than the average salary earned by all employees?
   -- find the avg salary :select avg(salary) from employee; #63650.000000
   -- filter the employees bases on the above result

select * from employee where salary > (select avg(salary) from employee);

-- Q2 : Find the employees who earns the highest salary in each department ?
	-- what is the highest salary in each department
    select dept_name,max(salary) from employee group by dept_name;
    -- filter out the employees bases on above result 
    
select * from employee where ( dept_name,salary) in ( select dept_name,max(salary) from employee group by dept_name);


-- Q3 : find dept who do not have any employee
	-- find the  dept where are some employee
		select distinct dept_name from employee;
        
	-- this won't work  : select dept_name from department where dept_name not in (select distinct dept_name from employee);
    
-- Q4 : Find the employees in each department who earn more than the average salary in that department

	-- Approach
	-- find the average salary of each department =>  select dept_name, avg(salary) from employee group by dept_name;
	
--	select * from employee where (dept_name,salary) > (select dept_name,avg(salary) from employee group by dept_name); - this will not work 
	-- because it will return more than one raw
	
	-- Query : 
	-- for each record of the employee inner query will run every time
	-- it is correlated query - not recommended to use because of efficiency

select * from employee e1 where salary > (select avg(salary) from employee e2 where e2.dept_name = e1.dept_name);

    
    
