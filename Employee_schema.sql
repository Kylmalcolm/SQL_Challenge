-- Create tables and import data

CREATE TABLE titles(
title_id varchar,
title varchar,
PRIMARY KEY (title_id)
);

COPY titles(title_id, title)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/titles.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM titles;

CREATE TABLE employees(
emp_no INTEGER NOT NULL,
emp_title_id VARCHAR,
birth_date DATE,
first_name VARCHAR,
last_name VARCHAR,
sex VARCHAR,
hire_date DATE,
PRIMARY KEY (emp_no),
FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/employees.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM employees;

CREATE TABLE departments(
dept_no varchar NOT NULL,
dept_name varchar,
PRIMARY KEY (dept_no)
);

COPY departments(dept_no, dept_name)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/departments.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM departments;

CREATE TABLE dept_manager(
dept_no varchar,
emp_no INTEGER,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY dept_manager(dept_no, emp_no)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/dept_manager.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dept_manager;

CREATE TABLE salaries(
emp_no INTEGER,
salary INTEGER,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY salaries(emp_no, salary)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/salaries.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM salaries;

CREATE TABLE dept_emp(
emp_no INTEGER,
dept_no VARCHAR,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

COPY dept_emp(emp_no, dept_no)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/dept_emp.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dept_emp;

-- 1) Employee number, last name, first name, sex, and salary

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no;

-- 2) First name, last name, and hire date for employees who were hired in 1986

SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date >= '1986-01-01' AND e.hire_date < '1987-01-01';

-- 3) Manager of each department with department number, department name, the manager's employee number, last name, first name

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
LEFT JOIN departments d
ON dm.dept_no = d.dept_no
LEFT JOIN employees e
ON dm.emp_no = e.emp_no;

-- 4) Department of each employee with employee number, last name, first name, and department name

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no

-- 5) First name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B"

SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%';

-- 6) All employees in the Sales department, their employee number, last name, first name, and department name

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments d
INNER JOIN dept_emp de
ON d.dept_no = de.dept_no
LEFT JOIN employees e
ON de.emp_no = e.emp_no
WHERE d.dept_name == "Sales";

-- 7) The frequency count of employee last names (how many employees share each last name) in descending order

SELECT COUNT(e.last_name), e.last_name
FROM employees e
GROUP BY e.last_name
ORDER BY COUNT(e.last_name) DESC;
