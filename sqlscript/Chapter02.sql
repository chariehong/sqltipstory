-- 2-1
SELECT employee_id
     , first_name
     , last_name
     , salary
  FROM employees
 ORDER BY salary DESC;
 
-- 2-2 
SELECT employee_id
     , first_name || ' ' || last_name emp_name
     , ROWNUM
  FROM employees ;

-- 2-3  
SELECT employee_id
     , first_name || ' ' || last_name emp_name
     , salary , ROWNUM
  FROM employees 
 WHERE ROWNUM <= 5
 ORDER BY salary DESC;
 
-- 2-4
SELECT employee_id, emp_name, salary
  FROM ( SELECT employee_id
              , first_name || ' ' || last_name emp_name
              , salary 
           FROM employees 
          ORDER BY salary DESC
       )
 WHERE ROWNUM <= 5;
 
 
-- 2-5
SELECT employee_id, emp_name, salary
  FROM ( SELECT employee_id
              , first_name || ' ' || last_name emp_name
              , salary 
              , ROW_NUMBER() OVER ( ORDER BY salary DESC) rowseq
           FROM employees 
       )
 WHERE rowseq <= 5;  
 
-- 2-6
SELECT employee_id
     , first_name || ' ' || last_name emp_name
     , salary 
  FROM employees 
 ORDER BY salary DESC
 FETCH FIRST 5 ROWS ONLY;
 

-- 2-7 
SELECT employee_id
     , first_name || ' ' || last_name emp_name
     , salary 
  FROM employees 
 ORDER BY salary DESC
 FETCH FIRST 7 ROWS WITH TIES;
 
 
-- 2-8
SELECT employee_id
     , first_name || ' ' || last_name emp_name
     , salary 
  FROM employees 
 ORDER BY salary DESC
 FETCH FIRST 5 PERCENT ROWS ONLY;