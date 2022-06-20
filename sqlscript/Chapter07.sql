-- 7-1.
SELECT employee_id, first_name, last_name, manager_id, LEVEL
  FROM employees
 START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id ;
	

-- 7-2
SELECT employee_id, first_name, last_name, manager_id, LEVEL
  FROM employees
 START WITH manager_id IS NULL
CONNECT BY PRIOR manager_id = employee_id ;

-- 7-3
SELECT employee_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || first_name || ' ' || last_name AS emp_name, 
       manager_id, LEVEL
  FROM employees
 START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id ;


-- 7-4
CREATE TABLE king_family ( 
    c_id  NUMBER,
    p_id  NUMBER,
    names VARCHAR2(100)
);


-- 7-5
INSERT INTO king_family VALUES (1, NULL, '태조');
INSERT INTO king_family VALUES (2, 1, '정조');
INSERT INTO king_family VALUES (3, 1, '태종');
INSERT INTO king_family VALUES (4, 3, '세종');
INSERT INTO king_family VALUES (5, 4, '문종');
INSERT INTO king_family VALUES (6, 5, '단종');
INSERT INTO king_family VALUES (7, 4, '세조');
INSERT INTO king_family VALUES (8, 7, '예종');
COMMIT; 

 
-- 7-6
SELECT *
  FROM king_family;


-- 7-7
SELECT c_id, p_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || names AS king_name, 
       LEVEL, 
	   CONNECT_BY_ROOT names AS root_name,
       SYS_CONNECT_BY_PATH(names, '/') paths,
       CONNECT_BY_ISLEAF ISLEAF
  FROM king_family
 START WITH p_id IS NULL
CONNECT BY PRIOR c_id = p_id;


-- 7-8
INSERT INTO king_family VALUES (7, 8, '세조2');
COMMIT;

-- 7-9
SELECT c_id, p_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || names AS king_name, 
       LEVEL
  FROM king_family
 START WITH p_id IS NULL
CONNECT BY PRIOR c_id = p_id;


-- 7-10
SELECT c_id, p_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || names AS king_name, 
       LEVEL
  FROM king_family
 START WITH p_id IS NULL
CONNECT BY NOCYCLE PRIOR c_id = p_id;


-- 7-11
SELECT c_id, p_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || names AS king_name, 
       LEVEL,
	   CONNECT_BY_ISCYCLE ISCYCLE
  FROM king_family
 START WITH p_id IS NULL
CONNECT BY NOCYCLE PRIOR c_id = p_id;


-- 7-12
DELETE FROM king_family
 WHERE p_id = 8;
 
COMMIT;


-- 7-13
WITH CTE (c_id, p_id, names, lvl) AS 
(
  SELECT c_id, p_id, names
         , 1 AS lvl
    FROM king_family
   WHERE p_id IS NULL
   UNION ALL
  SELECT b.c_id, b.p_id, b.names
        ,a.lvl + 1
    FROM cte a,
         king_family b
   WHERE a.c_id = b.p_id
)
SELECT *
  FROM cte 
 ORDER BY 1;


-- 7-14 
WITH CTE (c_id, p_id, names, lvl, path) AS 
(
  SELECT c_id, p_id, names
         , 1 AS lvl
         , '/' || names 
    FROM king_family
   WHERE p_id IS NULL
   UNION ALL
  SELECT b.c_id, b.p_id, b.names
        ,a.lvl + 1
        ,a.path || '/' || b.names
    FROM cte a,
         king_family b
   WHERE a.c_id = b.p_id
)
SELECT *
  FROM cte 
 ORDER BY 1;