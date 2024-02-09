#Inner Join : fatch only matching records from both tables

#Ques: Get the details of employees along with their corresponding department names. don't fatch employees those do not belong to any department
select emp.emp_name, dept.dept_name from employee emp join department dept on emp.dept_id = dept.dept_id;

#Left join : Retrieve all records from the left table and the matched records from the right table, with NULL values in place where there is no match

#Ques : List all employees and their corresponding managers, including employees without managers
select emp.emp_name,mng.manager_name from employee emp left join manager mng on emp.manager_id=mng.manager_id;

#Right Join : Retrieve all records from the right table and the matched records from the left table, with NULL values in place where there is no match

# Ques : Display all managers and their associated department names, including managers without departments.
select mng.manager_name, dept.dept_name from department dept right join manager mng on dept.dept_id=mng.dept_id;

#Full Join : Retrieve all records from both tables, merging records where a match exists and including NULL values where there is no match.

# Ques :  Retrieve all employee and manager details, including those employees who are not managers and managers who do not have any employees reporting to them.
#Note : MySQL doesn't support the FULL JOIN syntax directly. Instead, you can simulate a FULL JOIN using a combination of LEFT JOIN and RIGHT JOIN, along with UNION to combine the results.
SELECT *
FROM employee emp
LEFT JOIN manager mng ON emp.manager_id = mng.manager_id
UNION
SELECT *
FROM employee emp
RIGHT JOIN manager mng ON emp.manager_id = mng.manager_id;


#Cross Join :Retrieve the Cartesian product of the two tables, resulting in a combination of all records from both tables.

# Ques:  Generate all possible combinations of employees and departments. 

select emp.*, dept.* from employee emp CROSS JOIN department dept;

#why Cross Join:
# Scenerio : Write a query to fetch the employee name and their corresponding department name, also make sure to display the company
# name and the comapny location corresponding to each employee

-- Create the company table
CREATE TABLE company (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100),
    location VARCHAR(100)
);

-- Insert data into the company table
INSERT INTO company (company_id, company_name, location)
VALUES (1, 'DarkBRown', 'Jaipur');

select * from company;

select emp.emp_name, dept.dept_name, c.company_name,c.location from employee emp inner join department dept on emp.dept_id = dept.dept_id
cross join company c;

#Note : cross join doesn't need join condition

# Self join :  Join a table with itself, typically to compare rows within the same table.
CREATE TABLE family (
    member_id VARCHAR(20),
    name VARCHAR(50),
    age INT,
    parent_id VARCHAR(20)
);

INSERT INTO family (member_id, name, age, parent_id) VALUES
('M1', 'John', 40, NULL),
('M2', 'Alice', 38, NULL),
('C1', 'David', 15, 'M1'),
('C2', 'Emma', 12, 'M1'),
('C3', 'Sophia', 10, 'M2'),
('C4', 'Michael', 8, 'M2'),
('C5', 'Olivia', 6, 'M1'),
('C6', 'William', 4, 'M1'),
('C7', 'Ava', 3, 'M2');


# Question: .Retrieve the names of children along with the names of their parents
SELECT child.name AS child_name, parent.name AS parent_name
FROM family child
JOIN family parent ON child.parent_id = parent.member_id;

# Natural Join : not same as inner join 

# Not recommended to use, Becuase SQL will decide on which column join should happen, so we don't need to use any join conidtions

select emp.emp_name,dept.dept_name from employee emp natural join department dept;






