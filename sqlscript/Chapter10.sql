-- 10-1.
SELECT *
  FROM employees
 WHERE job_id IN ('AD_PRES', 'AD_VP') ;



-- 10-2
SELECT *
  FROM employees
 WHERE salary BETWEEN 2500 AND 5000 ;



-- 10-3
SELECT a.employee_id, a.first_name, a.last_name, 
       t.department_name, t.city
  FROM employees a
     ,(select b.department_id, b.department_name, 
              c.city
        from departments b,
             locations c
       where b.location_id = c.location_id ) t
 WHERE a.department_id = t.department_id
   and a.employee_id = 150;



-- 10-4
SELECT a.employee_id, a.first_name, a.last_name, 
       t.department_name, t.city
  FROM employees a
     ,(select b.department_id, b.department_name, 
              c.city
        from departments b,
             locations c
       where b.location_id = c.location_id ) t
 WHERE a.department_id = t.department_id
   and a.employee_id = 150;
  
  
-- 10-5
SELECT a.employee_id, a.first_name, a.last_name, 
       t.department_name, t.city
  FROM employees a
     ,(select b.department_id, b.department_name, 
              c.city
        from departments b,
             locations c
       where b.location_id = c.location_id ) t
 WHERE a.department_id = t.department_id
   and a.employee_id >= 150;


	

-- 10-6
CREATE TABLE emp2 ( 
  employee_id    NUMBER       NOT NULL, 
	first_name     VARCHAR2(20), 
	last_name      VARCHAR2(25), 
	email          VARCHAR2(25), 
	phone_number   VARCHAR2(20), 
	hire_date      DATE         NOT NULL, 
	job_id         VARCHAR2(10) NOT NULL, 
	salary         NUMBER, 
	commission_pct NUMBER, 
	manager_id     NUMBER, 
	department_id  NUMBER );

INSERT INTO emp2
SELECT * FROM employees;

COMMIT;

-- 10-7
SELECT table_name, num_rows, blocks,  avg_row_len
  FROM user_tables
 WHERE table_name ='EMP2';
 
-- 10-8
SELECT a.employee_id, a.first_name, a.last_name, 
       t.department_name, t.city
  FROM emp2 a
     ,(SELECT b.department_id, b.department_name, 
              c.city
        FROM departments b,
             locations c
       WHERE b.location_id = c.location_id ) t
 WHERE a.department_id = t.department_id
   and a.employee_id >= 101;


-- 10-9
EXEC DBMS_STATS.GATHER_TABLE_STATS('HR', 'EMP2'); 

SELECT table_name, num_rows, blocks,  avg_row_len
  FROM user_tables
 WHERE table_name ='EMP2';
 
 
-- 10-10
SELECT employee_id, first_name, last_name, ROWID
  FROM employees;

-- 10-11
SELECT employee_id, first_name, last_name, email
  FROM employees
 WHERE email = 'COLSEN';
 
SELECT employee_id, first_name, last_name, email
  FROM employees
 WHERE email LIKE 'C%'; 
 
SELECT employee_id, first_name, last_name, email
  FROM employees
 WHERE email LIKE '%MAN';
 
 
-- 10-12
SELECT employee_id, first_name, last_name, email
  FROM employees
 WHERE SUBSTR(email, 2,2) = 'BA';
 
 
SELECT employee_id, first_name, last_name, hire_date
  FROM employees
 WHERE TO_CHAR(hire_date, 'YYYYMM') = '200502';
 
-- 10-13
SELECT employee_id, first_name, last_name, hire_date
  FROM employees
 WHERE hire_date BETWEEN '20050201' AND '20050228';
 
SELECT employee_id, first_name, last_name, hire_date
  FROM employees
 WHERE hire_date BETWEEN TO_DATE('20050201', 'YYYYMMDD') 
                     AND TO_DATE('20050228', 'YYYYMMDD'); 
                     
-- 10-14
CREATE INDEX emp_idx99 ON employees (first_name, last_name); 

-- 10-15
SELECT employee_id, first_name, last_name
  FROM employees 
 WHERE 1=1
   AND first_name = 'David'
   AND last_name  = 'Austin' ; 
   
-- 10-16
SELECT employee_id, first_name, last_name
  FROM employees 
 WHERE 1=1
   AND first_name = 'David' ;
   
   
SELECT employee_id, first_name, last_name
  FROM employees 
 WHERE 1=1
   AND last_name = 'Austin' ;   
   
   
-- 10-17
SELECT employee_id, first_name, last_name
  FROM employees 
 WHERE 1=1
   AND first_name = 'David'
   AND last_name  = 'Austin' ; 
   
SELECT employee_id, first_name, last_name
  FROM employees 
 WHERE 1=1
   AND last_name  = 'Austin' 
   AND first_name = 'David'  ;      
   
   
-- 10-18
SELECT a.employee_id, a.first_name, a.last_name,
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id
       ) dept_name
  FROM employees a
 WHERE a.department_id = 90;  
 
 
-- 10-19
SELECT a.employee_id, a.first_name, a.last_name,
       b.department_name
  FROM employees a
      ,departments b
 WHERE a.department_id = 90
   AND a.department_id = b.department_id;  
   
   
-- 10-20   
SELECT a.employee_id, a.first_name, a.last_name,
       b.department_name
  FROM employees a
      ,departments b
 WHERE a.department_id = b.department_id
   AND a.employee_id = 178;
   
SELECT a.employee_id, a.first_name, a.last_name,
       ( SELECT b.department_name
           FROM departments b
          WHERE a.department_id = b.department_id
       ) dept_name
  FROM employees a
 WHERE a.employee_id = 178;
 
 
-- 10-21
SELECT a.employee_id, a.first_name, a.last_name,
       b.department_name
  FROM employees a
  LEFT JOIN departments b
    ON a.department_id = b.department_id
 WHERE a.employee_id >= 178
   AND a.employee_id <= 190
 ORDER BY 1;
  
