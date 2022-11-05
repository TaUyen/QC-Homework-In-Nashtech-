--1. Create a query that displays the last name and hire date of any employee in the same department as the employee 
--with name = Zlotkey and excluding employee Zlotkey from the result returns.
Select last_name, hire_date from employees
where department_id in (select department_id from employees where last_name= 'Zlotkey')
and last_name <> 'Zlotkey'


--2. Create a report that displays the employee number, last name, and salary of all employees who earn more than the average salary. 
--Sort the results in order of ascending salary.
Select  employee_id, last_name, salary from employees
where salary> (select AVG(salary) from employees)
order by salary asc


--3. Write a query that displays the employee number and last name of all employees who work in a department 
--with any employee whose last name contains the letter “u”
Select  employee_id, last_name from employees
where department_id in (select department_id from employees where last_name like '%u%')


--4. The HR department needs a report that displays the last name, department number, and job ID of all employees whose department location ID is 1700.
Select e. last_name, e.department_id, e.job_id
from employees e join departments d
on (e.department_id=d.department_id)
where d.location_id=1700


--5. Create a report for HR that displays the last name and salary of every employee who reports to King.
--C1
Select last_name, salary from employees where manager_id in (select employee_id from employees where last_name='King')
--C2
Select e.last_name, e.salary from employees e
inner join  employees manager on e.manager_id=manager.employee_id
where manager.last_name='King'


--6. Create a report for HR that displays the department number, last name, and job ID for every employee in the Executive department.
Select e.last_name, e.department_id, e.job_id 
from employees e join departments d
on (e.department_id=d.department_id)
where d.department_name='Executive'


--7. Create query to display the employee number, last name, and salary of all the employees who earn more than the average salary 
--and who work in a department with any employee whose last name contains a letter “u”.
Select employee_id, last_name, salary from employees
where (salary> (select AVG(salary) from employees)) 
and (department_id in (select department_id from employees 
						where last_name like '%u%'and last_name not like '%u%u%' and last_name not like '%u%u%u%'))


--8. Find the highest, lowest, sum, and average salary of all employees. Label the columns as Maximum, Minimum, Sum, and Average, respectively. 
--Round your results to the nearest whole number
select cast(min(salary)as numeric(10,0)) as Min, 
cast(max(salary)as numeric(10,0)) as Max, 
cast(avg(salary) as numeric(10,0)) as Average, 
cast(sum(salary)as numeric(10,0)) as Sumary
from employees


--9. Write a query that displays the last name (with the first letter in uppercase and all the other letters in lowercase) 
--and the length of the last name for all employees whose name starts with the letters “J,” “A,” or “M.” Give each column an appropriate label. 
--Sort the results by the employees’ last names.
select (upper(left(last_name,1))+lower(substring(last_name,2,len(last_name)))) as Last_name , len(last_name) as Length_last_name
from employees
where first_name like 'J%' or first_name like 'A%' or first_name like 'M%'
Order by Last_name 


--10. The HR department needs a report to display the employee number, last name, salary, and salary increased by 15.5% (expressed as a whole number) for each employee.
--Label the column New Salary
select employee_id, last_name, cast(salary as numeric(10,0)) as Salary, cast(salary*115.5/100 as numeric(10,0)) as NewSalary
from employees 

--11.The HR department needs a report with the following specifications:
--•	Last name and department ID of all employees from the employees table, regardless of whether or not they belong to a department
--•	Department ID and department name of all departments from the departments table, regardless of whether or not they have employees working in them
--Write a compound query to accomplish this.//
select e.last_name,e.department_id, d.department_name
from employees e join departments d on e.department_id=d.department_id


--12. Produce a list of employees who joined the company later than their manager and who work in Toronto. Display the employee_id by using the set operators.
select e.employee_id from employees e join employees m on m.employee_id=e.manager_id
where e.hire_date >m.hire_date 
and e.department_id=(select department_id from locations join departments on departments.location_id=locations.location_id where locations.city='Toronto')

