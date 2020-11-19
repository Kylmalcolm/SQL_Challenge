CREATE TABLE employees(
emp_no INTEGER,
emp_title_id VARCHAR(30),
birth_date VARCHAR(15),
first_name VARCHAR(30),
last_name VARCHAR(30),
sex VARCHAR(2),
hire_date VARCHAR(15),
PRIMARY KEY (emp_no)
);

COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM 'C:/Users/kylie/OneDrive/Desktop/uofm-stp-data-pt-09-2020-u-c/02-Homework/09-SQL/SQL_Challenge/EmployeeSQL/employees.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM employees;