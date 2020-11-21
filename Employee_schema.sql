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

-- Drop and add again to make sure date is correct
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
dept_name varchar NOT NULL,
PRIMARY KEY (dept_no)
);

COPY departments(dept_no, dept_name)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/departments.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM departments;

CREATE TABLE dept_manager(
dept_no varchar NOT NULL,
emp_no INTEGER NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY dept_manager(dept_no, emp_no)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/dept_manager.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dept_manager;

CREATE TABLE salaries(
emp_no INTEGER NOT NULL,
salary INTEGER NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

COPY salaries(emp_no, salary)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/salaries.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM salaries;

CREATE TABLE dept_emp(
emp_no INTEGER NOT NULL,
dept_no VARCHAR NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

COPY dept_emp(emp_no, dept_no)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/dept_emp.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM dept_emp;

SELECT employees.emp_no,
employees.last_name,
employees.first_name,
employees.sex,
salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no=salaries.emp_no

