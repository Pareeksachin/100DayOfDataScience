-- Create employee table
CREATE TABLE employee (
    emp_id VARCHAR(20),
    emp_name VARCHAR(50),
    salary INT,
    dept_id character varying(20),
    manager_id character varying(20)
);

-- Insert data into the manager table
INSERT INTO manager (manager_id, manager_name, dept_id)
VALUES 
    ('M1', 'Prem', 'D3'),
    ('M2', 'Shripadh', 'D4'),
    ('M3', 'Nick', 'D1'),
    ('M4', 'Cory', 'D1');

-- View the contents of the manager tables
SELECT * FROM manager;


select * from employee;