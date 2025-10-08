# EMPLOYEE-MANAGEMENT-SYSTEM-SQL-
Developed a complete Employee Management System using SQL. Created normalized tables for employees, departments, payroll, leaves, and qualifications. Loaded CSV data, executed analytical queries for salary, bonus, and leave insights. Enhanced decision-making with data-driven analysis.

Database Structure and Tables
The project establishes a relational database named employee_management_system and defines six interconnected tables:

JobDepartment: Stores information about job roles and the departments they belong to, including Job_ID (primary key), department name (jobdept), job title (name), job description, and a salaryrange.

SalaryBonus: Holds salary and bonus details, with columns for salary_ID (primary key), Job_ID (foreign key), monthly amount, annual salary, and bonus amount. It has a one-to-many relationship with JobDepartment.

Employee: The main table for employee data, including emp_ID (primary key), names, gender, age, contact information, unique email, password, and Job_ID (foreign key). It has a one-to-many relationship with JobDepartment.

Qualification: Records employee qualifications, including QualID (primary key), Emp_ID (foreign key), Position, Requirements, and Date_In. It has a one-to-many relationship with Employee.

Leaves: Tracks employee leave requests with leave_ID (primary key), emp_ID (foreign key), date, and reason. It has a one-to-many relationship with Employee.

Payroll: A central table linking various employee data points to process payroll, including payroll_ID (primary key), and foreign keys to Employee, JobDepartment, SalaryBonus, and Leaves. It records the date, a report, and the total_amount paid.


