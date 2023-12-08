create database hr;

use hr;

create table employe
(
EM_ID INT primary KEY,
EM_FNAME varchar(50),
EM_LNAME varchar(50),
EM_MOBILE bigint,
EM_GENDER varchar(50),
EM_AGE INT ,
EM_JOBTITLE VARCHAR(40) ,
EM_YEARSOFEXP INT ,
EM_DEPT VARCHAR(30) ,
EM_HIREDATE DATETIME ,
EM_ADDRESS VARCHAR(95) ,
EM_POSTALCODE INT ,
EM_CITY VARCHAR(20) ,
EM_COUNTRY VARCHAR(25) ,
EM_DEPTNO VARCHAR(10)
) ;

CREATE TABLE DEPARTMENT
(
	DEPT_INDEX INT PRIMARY KEY ,
	DEPT_NO INT ,
	EM_DEPARTMENT VARCHAR(30) ,
	DEPT_ID VARCHAR(25) ,
	EM_ID_DEPT_INDEX INT , 
    FOREIGN KEY(DEPT_INDEX) REFERENCES EMPLOYEES(EM_ID)
    ) ;
    
    -- 1.  Display all information in the tables EMP and DEPT. 
SELECT * FROM EMPLOYEES
INNER JOIN DEPARTMENT
ON EMPLOYEES.EM_ID = EM_ID_DEPT_IND ;

-- 2.  Display only the hire date and employee name for each employee.
SELECT HIRE_DATE , FNAME FROM EMPLOYEES ;

/* 3. Display the ename concatenated with the job ID, separated by a comma and space, and 
name the column Employee and Title.*/
SELECT FNAME , JOB_ID , CONCAT_WS(",  ", FNAME , JOB_ID) 
AS EMPLOYEE_TITLE FROM EMPLOYEES ;

-- 4. Display the hire date, name and department number for all clerks. 
SELECT HIRE_DATE , FNAME ,DEPT_NO  FROM EMPLOYEES
INNER JOIN DEPARTMENT 
ON EMPLOYEES.EMP_ID = EMP_ID_DEPT_IND WHERE JOB_TITLE = 'CLERK'; 

/* 5. Create a query to display all the data from the EMP table. Separate each column by a 
comma. Name the column THE OUTPUT. */
SELECT * , CONCAT_WS("," ,EM_ID, FNAME, LNAME, EMAIL, PHONE, GENDER, AGE, 
JOB_TITLE, YRS_OF_EXP, SALARY,EMP_DEPT,EMP_DOJ , HIRE_DATE, ADDRESS, POSTAL_CODE, 
CITY, COUNTRY,  COMMISSION) AS THE_OUTPUT FROM EMPLOYEES ; 

-- 6.  Display the names and salaries of all employees with a salary greater than 2000. 
SELECT FNAME , SALARY FROM EMPLOYEES HAVING SALARY > 2000 ; 

/* 7. Display the names and dates of employees with the column headers "Name" and "Start 
Date". */ 
SELECT FNAME AS "NAME" , EMP_DOJ AS "START_DATE" FROM EMPLOYEES ;

  -- 8. Display the names and hire dates of all employees in the order they were hired.   
 SELECT FNAME , HIRE_DATE FROM EMPLOYEES ORDER BY HIRE_DATE ASC ;
 
 -- 9. Display the names and salaries of all employees in reverse salary order .
 SELECT FNAME , SALARY FROM EMPLOYEES ORDER BY SALARY DESC ; 
 
 /* 10. Display 'ename" and "deptno" who are all earned commission and display salary in 
reverse order. */
SELECT COUNT(EM_ID) , EM_DEPARTMENT , COMMISSION
FROM EMPLOYEES GROUP BY EM_DEPARTMENT , COMMISSION ;
 
-- 11.  Display the last name and job title of all employees who do not have a manager.
SELECT LNAME , JOB_TITLE FROM EMPLOYEES WHERE JOB_TITLE NOT IN ("HR MANAGER") ;

/* 12.  Display the last name, job, and salary for all employees 
whose job is sales representative or stock clerk and whose salary
 is not equal to $2,500, $3,500, or $5,000. */
 SELECT LNAME , EMP_DEPT , SALARY FROM EMPLOYEES WHERE EMP_DEPT IN ('SALES' OR 'CLERK') 
 AND SALARY NOT IN (2500 , 3500 ,5000) ;
 
 -- ***********************************HR2************************************* --
 
 -- 1.  Display the maximum, minimum and average salary and commission earned. 
 SELECT MAX(SALARY) AS MAXIMUM_SALARY , MIN(SALARY) AS MINIMUN_SALARY , 
 AVG(SALARY) AS AVERAGE_SALARY , MAX(COMMISSION) AS MAXIMUM_COMMISSION , 
 MIN(COMMISSION) AS MINIMUN_COMMISSION , AVG(COMMISSION) AS AVERAGE_COMMISSION
 FROM EMPLOYEES ;
 
 /* 2. Display the department number, total salary payout and total commission payout for 
each department.*/
SELECT EM_ID ,
SUM(SALARY) ,
SUM(COMMISSION)


FROM EMPLOYEES
GROUP BY EM_ID ;

-- 3.  Display the department number and number of employees in each department. 
SELECT DEPARTMENT.DEPT_NO , COUNT(DEPARTMENT.DEPT_NO) AS TOTAL_EMPLOYEE
FROM EMPLOYEES
INNER JOIN DEPARTMENT
ON EMPLOYEES.EM_ID = EMP_ID_DEPT_IND
GROUP BY DEPARTMENT.DEPT_NO ;

/* 4. Display the department number and total salary of employees in 
each department. */
SELECT DEPARTMENT.DEPT_NO , SUM(EMPLOYEES.SALARY) AS TOTAL_SALARY
FROM EMPLOYEES
INNER JOIN DEPARTMENT
ON EMPLOYEES.EMP_ID = EMP_ID_DEPT_IND
GROUP BY DEPARTMENT.DEPT_NO ;

/* 5.Display the employee's name who doesn't earn a commission. Order the result set 
without using the column name. */
SELECT FNAME , COMMISSION AS " " FROM EMPLOYEES
WHERE COMMISSION = 0 ;

/* 6. Display the employees name, department id and commission. If an Employee doesn't 
earn the commission, then display as 'No commission'. Name the columns appropriately. */
SELECT EMPLOYEES.FNAME , DEPARTMENT.DEPT_ID ,
CASE 
WHEN EMPLOYEES.COMMISSION = 0 THEN "NO_COMMISSION"
ELSE EMPLOYEES.COMMISSION END AS COMMSSION_EARN FROM EMPLOYEES
INNER JOIN DEPARTMENT ON EMPLOYEES.EMP_ID = EMP_ID_DEPT_IND ;

/* 7. Display the employee's name, salary and commission multiplied by 2. If an Employee 
doesn't earn the commission, then display as 'No commission. Name the columns 
appropriately. */
SELECT EMPLOYEES.FIRST_NAME , SALARY , 
CASE 
WHEN  EMPLOYEES.COMMISSION = 0 THEN "NO_COMMISSION"
WHEN EMPLOYEES.COMMISSION > 0 THEN COMMISSION *2
ELSE EMPLOYEES.COMMISSION END AS COMMSSION_EARN FROM EMPLOYEES
INNER JOIN DEPARTMENT ON EMPLOYEES.EMP_ID = EMP_ID_DEPT_IND ;

/* 8. Display the employee's name, department id who have the first name same as another 
employee in the same department. */
 SELECT EMPLOYEES. FNAME , DEPARTMENT . DEPT_ID 
 FROM EMPLOYEES
 INNER JOIN DEPARTMENT ;
 
  -- 9. Display the sum of salaries of the employees working under each Manager.
SELECT  JOB_TITLE, SUM(SALARY) FROM EMPLOYEES 
GROUP BY JOB_TITLE ;

-- 10. Select the Managers name, the count of employees working under and the department D of the manager.
 SELECT JOB_TITLE ,COUNT(JOB_ID) FROM EMPLOYEES;

/*11. Select the employee name, department id, and the salary. Group the result with the 
manager name and the employee last name should have second letter 'a!*/
SELECT FNAME , LNAME , JOB_ID , SALARY FROM EMPLOYEES 
WHERE LNAME LIKE "_A%";

/* 12. Display the average of sum of the salaries and group the result with the department id. 
Order the result with the department id */
SELECT JOB_ID, AVG(SALARY) AS AVERAGE_SALARY
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID;

/* 14. Display the commission, if not null display 10% of salary, 
if null display a default value 1 */
SELECT  EM_ID , COMMISSION ,
CASE 
    WHEN C
    OMMISSION = 0 THEN '1'
    ELSE 10 % (SALARY)
END AS SALARY
FROM EMPLOYEES;

-- ***********************************HR3************************************* --

/* 1. Write a query that displays the employee's last names only from the string's 2-5th 
position with the first letter capitalized and all other letters lowercase, Give each column an 
appropriate label*/
SELECT LNAME, CONCAT(UCASE(MID(LNAME,2,1)),LCASE(MID(LNAME,3,3))) AS NAM
FROM EMPLOYEES;

/* 2. Write a query that displays the employee's first name and last name along with a " in 
between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the 
month on which the employee has joined.*/
SELECT FNAME,LNAME,CONCAT_WS("-",FNAME,LNAME) AS EMPLOYEES , 
DATE_FORMAT(EMP_DOJ,"%M")  AS HIRING_DATE FROM EMPLOYEES;

 
/* 3. Write a query to display the employee's last name and if half of the salary 
is greater than ten thousand then increase the salary by 10% else by 11.5%
 along with the bonus amount of 1500 each. Provide each column an appropriate label.*/
-- SELECT EMPLOYEES LNAME ,
-- CASE 
-- WHEN SALARY > 10000 THEN SALARY > 10% 


/* 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, 
department id, salary and the manager name all in Upper case, if the Manager name 
consists of 'z' replace it with '$! */
SELECT EM_ID , CONCAT(INSERT(EM_ID , 2 , 0 , "OO") , "E") AS EM_ID , JOB_ID , SALARY ,
UCASE (JOB_TITLE) AS MANAGER ,
CASE
WHEN JOB_TITLE LIKE 'Z%' THEN '$!'
  WHEN JOB_TITLE LIKE '%Z%' THEN '$!'
  WHEN JOB_TITLE LIKE '%Z' THEN '$!'
  ELSE JOB_TITLE
  END AS MANAGER
  FROM EMPLOYEES;
  
  
  /* 5. Write a query that displays the employee's last names with the 
  first letter capitalized and all other letters lowercase, and the length of the names,
 for all employees whose name starts with J, A, or M. Give each column an appropriate label.
 Sort the results by the employees' last names. */
SELECT CONCAT(UCASE(MID(LNAME,1,1)),LCASE(MID(LNAME,2))) AS EMPLOYEE_NAME,
LENGTH(LNAME) AS CHAR_LENGTH FROM EMPLOYEES
WHERE LNAME LIKE 'A%' OR LNAME LIKE 'J%' OR LNAME LIKE 'M%'
ORDER BY LNAME;

/* 6. Create a query to display the last name and salary for all employees. 
Format the salary to be 15 characters long, left-padded with $.Label the column SALARY. */
SELECT LAST_NAME,SALARY,CONCAT('$'," ",(FORMAT(SALARY,15))) AS SALARY
FROM EMPLOYEES;


-- 7. . Display the employee's name if it is a palindrome 
SELECT FNAME FROM EMPLOYEES
WHERE FNAME = REVERSE(FNAME);

-- 8. Display First names of all employees with initcaps. 
SELECT CONCAT(UCASE(SUBSTR(FNAME,1,1)),LCASE(SUBSTR(FNAME,2))) 
AS EMPLOYEES_NAMES FROM EMPLOYEES;

/* 10. Extract first letter from First Name column and append it with the Last Name. Also add 
"@systechusa.com" at the end. Name the column as e-mail address. All characters should 
be in lower case. Display this along with their First Name. */
SELECT FNAME,LNAME,LCASE(CONCAT(MID(FNAME,1,1),LNAME,"@systechusa.com")) 
AS EMAIL_ADDRESS FROM EMPLOYEES;

-- 11. Display the names and job titles of all employees with the same job as Trenna.
SELECT CONCAT_WS(" ",FNAME,LNAME) AS FNAME,JOB_ID
FROM EMPLOYEES 
WHERE JOB_ID IN 
(SELECT JOB_ID FROM EMPLOYEES WHERE FNAME ='TRENNA'); 

-- 13.  Display the name of the employee whose salary is the lowest.
SELECT CONCAT_WS(" ",FNAME,LNAME) AS FULL_NAME
FROM EMPLOYEES
WHERE SALARY  IN (SELECT MIN(SALARY) FROM EMPLOYEES);

-- 14. Display the names of all employees except the lowest paid
SELECT CONCAT_WS(" ",FNAME,LNAME) AS FULL_NAME
FROM EMPLOYEES
WHERE SALARY NOT IN (SELECT MIN(SALARY) FROM EMPLOYEES);


