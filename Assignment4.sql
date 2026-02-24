-- Drop tables
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS sales;


-- Create tables
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    job_role VARCHAR(50),
    salary DECIMAL(10,2),
    commission DECIMAL(10,2)
);



CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);


CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    region VARCHAR(50),
    amount DECIMAL(10,2)
);


-- Insert data in tables
INSERT INTO employees VALUES
(1, 'Amit', 'IT', 'Developer', 60000, NULL),
(2, 'Priya', 'HR', 'Manager', 50000, 5000),
(3, 'Rahul', 'IT', 'Tester', 45000, NULL),
(4, 'Sneha', 'Sales', 'Executive', 55000, 7000),
(5, 'Karan', 'IT', 'Developer', 70000, NULL),
(6, 'Meena', 'HR', 'Executive', 40000, 3000),
(7, 'Rohit', 'Sales', 'Manager', 80000, 10000);



INSERT INTO students VALUES
(1, 'Anu', 75),
(2, 'Riya', 35),
(3, 'Vikas', 65),
(4, 'Tina', 82),
(5, 'Arjun', 55);


INSERT INTO sales VALUES
(1, 'North', 30000),
(2, 'South', 40000),
(3, 'North', 25000),
(4, 'East', 60000),
(5, 'South', 20000),
(6, 'West', 45000);


-- ==========================================
-- Assignment 4
-- ==========================================


/* -------------------------------------------------
Question 1:
Write an SQL query to display the names and salaries 
of employees whose salary is greater than the 
average salary in the company.
Explain how the subquery works.
-------------------------------------------------- */

SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

/*
Explanation:
The subquery (SELECT AVG(salary) FROM employees)
first calculates the average salary of all employees.
Then the outer query compares each employee's salary
with that average and returns only those earning more.
*/



/* -------------------------------------------------
Question 2:
Write a query to retrieve the top 5 highest-paid 
employees from an employees table.
Explain how sorting affects the output.
-------------------------------------------------- */

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;

/*
Explanation:
ORDER BY salary DESC sorts employees from highest 
to lowest salary. LIMIT 5 returns only the top 5 
records after sorting.
*/



/* -------------------------------------------------
Question 3:
Calculate:
- Total number of employees
- Average salary
- Minimum and maximum salary
Explain difference between aggregate and scalar functions.
-------------------------------------------------- */

SELECT 
    COUNT(*) AS total_employees,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;

/*
Explanation:
Aggregate functions (COUNT, AVG, MIN, MAX) work on 
multiple rows and return a single result.

Scalar functions work on single values and return 
one value per row (example: UPPER(), ROUND()).
*/



/* -------------------------------------------------
Question 4:
Given a sales table (region, amount),
find total sales per region.
Filter regions where total sales exceed 50,000.
-------------------------------------------------- */

SELECT region, SUM(amount) AS total_sales
FROM sales
GROUP BY region
HAVING SUM(amount) > 50000;



/* -------------------------------------------------
Question 5:
Find the number of unique job roles in employees table.
Explain why DISTINCT is necessary.
-------------------------------------------------- */

SELECT COUNT(DISTINCT job_role) AS unique_job_roles
FROM employees;

/*
Explanation:
DISTINCT removes duplicate job roles before counting.
Without DISTINCT, duplicate roles would be counted 
multiple times.
*/



/* -------------------------------------------------
Question 6:
Retrieve students who scored between 60 and 80 marks.
Rewrite using BETWEEN.
-------------------------------------------------- */

-- Using conditions
SELECT *
FROM students
WHERE marks >= 60 AND marks <= 80;

-- Using BETWEEN
SELECT *
FROM students
WHERE marks BETWEEN 60 AND 80;



/* -------------------------------------------------
Question 7:
Display employees whose commission is NULL.
Explain correct way to check NULL in SQL.
-------------------------------------------------- */

SELECT *
FROM employees
WHERE commission IS NULL;

/*
Explanation:
In SQL, NULL cannot be checked using = NULL.
We must use IS NULL or IS NOT NULL.
*/



/* -------------------------------------------------
Question 8:
Increase salary of employees in IT department by 10%.
Explain arithmetic handling in SQL.
-------------------------------------------------- */

UPDATE employees
SET salary = salary + (salary * 0.10)
WHERE department = 'IT';

/*
Explanation:
SQL performs arithmetic operations row by row.
salary * 0.10 calculates 10% increase.
Then it adds the value to the existing salary.
*/



/* -------------------------------------------------
Question 9:
Delete records of students who scored less than 40.
What precaution should be taken?
-------------------------------------------------- */

DELETE FROM students
WHERE marks < 40;

/*
Precaution:
Always use WHERE condition carefully.
Without WHERE, all records will be deleted.
It is safer to run SELECT first to check affected rows.
*/



/* -------------------------------------------------
Question 10:
Find employees who earn more than the average 
salary of their department (without using joins).
Explain subquery logic.
-------------------------------------------------- */

SELECT name, salary, department
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
);

/*
Explanation:
The subquery calculates the average salary 
for each department.
For every employee, it compares their salary 
with the average of their own department.
*/

