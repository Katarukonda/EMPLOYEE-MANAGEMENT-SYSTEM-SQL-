-- 1. EMPLOYEE INSIGHTS

-- How many unique employees are currently in the system?
SELECT COUNT(DISTINCT Emp_ID) AS Total_Unique_Employees FROM Employee;

-- Which departments have the highest number of employees?
SELECT
    JD.jobdept,
    COUNT(E.emp_ID) AS Number_Of_Employees
FROM Employee AS E
JOIN JobDepartment AS JD
    ON E.Job_ID = JD.Job_ID
GROUP BY
    JD.jobdept
ORDER BY
    Number_Of_Employees DESC;

-- What is the average salary per department?
SELECT
    JD.jobdept,
    AVG(SB.amount) AS Average_Salary
FROM Employee AS E
JOIN JobDepartment AS JD
    ON E.Job_ID = JD.Job_ID
JOIN SalaryBonus AS SB
    ON E.Job_ID = SB.Job_ID
GROUP BY
    JD.jobdept
ORDER BY
    Average_Salary DESC;

-- Who are the top 5 highest-paid employees?
SELECT
    E.firstname,
    E.lastname,
    SB.amount AS Salary
FROM Employee AS E
JOIN SalaryBonus AS SB
    ON E.Job_ID = SB.Job_ID
ORDER BY
    SB.amount DESC
LIMIT 5;

-- What is the total salary expenditure across the company?
SELECT
    SUM(SB.amount) AS Total_Salary_Expenditure
FROM SalaryBonus AS SB;

-- 2. JOB ROLE AND DEPARTMENT ANALYSIS

-- How many different job roles exist in each department?
SELECT
    jobdept,
    COUNT(name) AS Number_of_Job_Roles
FROM JobDepartment
GROUP BY
    jobdept
ORDER BY
    Number_of_Job_Roles DESC;

-- What is the average salary range per department?
SELECT
    jobdept,
    AVG(SUBSTRING_INDEX(salaryrange, '-', 1)) AS Average_Min_Salary,
    AVG(SUBSTRING_INDEX(salaryrange, '-', -1)) AS Average_Max_Salary
FROM JobDepartment
GROUP BY
    jobdept;


-- Which job roles offer the highest salary?
SELECT
    JD.name,
    SB.amount AS Salary
FROM SalaryBonus AS SB
JOIN JobDepartment AS JD
    ON SB.Job_ID = JD.Job_ID
ORDER BY
    SB.amount DESC
LIMIT 1;

-- Which departments have the highest total salary allocation?
SELECT
    JD.jobdept,
    SUM(SB.amount) AS Total_Salary_Allocation
FROM Employee AS E
JOIN JobDepartment AS JD
    ON E.Job_ID = JD.Job_ID
JOIN SalaryBonus AS SB
    ON E.Job_ID = SB.Job_ID
GROUP BY
    JD.jobdept
ORDER BY
    Total_Salary_Allocation DESC;

-- 3. QUALIFICATION AND SKILLS ANALYSIS

-- How many employees have at least one qualification listed?
SELECT COUNT(DISTINCT Emp_ID) AS Employees_With_Qualifications FROM Qualification;

-- Which positions require the most qualifications?
SELECT
    Position,
    COUNT(*) AS Number_of_Qualifications
FROM Qualification
GROUP BY
    Position
ORDER BY
    Number_of_Qualifications DESC
LIMIT 5;

-- Which employees have the highest number of qualifications?
SELECT
    E.firstname,
    E.lastname,
    COUNT(Q.QualID) AS Number_of_Qualifications
FROM Employee AS E
JOIN Qualification AS Q
    ON E.emp_ID = Q.Emp_ID
GROUP BY
    E.emp_ID
ORDER BY
    Number_of_Qualifications DESC
LIMIT 5;

-- 4. LEAVE AND ABSENCE PATTERNS

-- Which year had the most employees taking leaves?
SELECT YEAR(date) AS Leave_Year, COUNT(DISTINCT emp_ID) AS Number_of_Employees FROM Leaves GROUP BY Leave_Year ORDER BY Number_of_Employees DESC LIMIT 1;

-- What is the average number of leave days taken by its employees per department?
SELECT
    JD.jobdept,
    COUNT(L.leave_ID) / COUNT(DISTINCT E.emp_ID) AS Avg_Leave_Days
FROM Leaves AS L
JOIN Employee AS E
    ON L.emp_ID = E.emp_ID
JOIN JobDepartment AS JD
    ON E.Job_ID = JD.Job_ID
GROUP BY
    JD.jobdept
ORDER BY
    Avg_Leave_Days DESC;

-- Which employees have taken the most leaves?
SELECT
    E.firstname,
    E.lastname,
    COUNT(L.leave_ID) AS Number_of_Leaves
FROM Leaves AS L
JOIN Employee AS E
    ON L.emp_ID = E.emp_ID
GROUP BY
    E.emp_ID
ORDER BY
    Number_of_Leaves DESC
LIMIT 5;

-- What is the total number of leave days taken company-wide?
SELECT COUNT(leave_ID) AS Total_Leave_Days FROM Leaves;

-- How do leave days correlate with payroll amounts?
SELECT
    P.total_amount,
    COUNT(L.leave_ID) AS Total_Leave_Days
FROM Leaves AS L
JOIN Payroll AS P
    ON L.leave_ID = P.leave_ID
GROUP BY
    P.total_amount
ORDER BY
    Total_Leave_Days DESC;

-- 5. PAYROLL AND COMPENSATION ANALYSIS

-- What is the total monthly payroll processed?
SELECT SUM(total_amount) AS Total_Monthly_Payroll FROM Payroll;

-- What is the average bonus given per department?
SELECT
    JD.jobdept,
    AVG(SB.bonus) AS Average_Bonus
FROM Employee AS E
JOIN SalaryBonus AS SB
    ON E.Job_ID = SB.Job_ID
JOIN JobDepartment AS JD
    ON E.Job_ID = JD.Job_ID
GROUP BY
    JD.jobdept
ORDER BY
    Average_Bonus DESC;

-- Which department receives the highest total bonuses?
SELECT
    JD.jobdept,
    SUM(SB.bonus) AS Total_Bonus_Amount
FROM Employee AS E
JOIN SalaryBonus AS SB
    ON E.Job_ID = SB.Job_ID
JOIN JobDepartment AS JD
    ON E.Job_ID = JD.Job_ID
GROUP BY
    JD.jobdept
ORDER BY
    Total_Bonus_Amount DESC
LIMIT 1;

-- What is the average value of total_amount after considering leave deductions?
SELECT
    AVG(total_amount) AS Average_Total_Amount
FROM Payroll;