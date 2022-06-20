-- 8-1.
CREATE TABLE book_meeting_room (
    room_no     VARCHAR2(30)
   ,start_time  DATE
   ,end_time    DATE
   ,booker      VARCHAR2(50)
   ,PRIMARY KEY (room_no, start_time)
);

INSERT INTO book_meeting_room VALUES ('회의실1', '2022-06-01 10:00', '2022-06-01 11:00', '홍대리');
INSERT INTO book_meeting_room VALUES ('회의실2', '2022-06-01 10:00', '2022-06-01 12:00', '김과장');
INSERT INTO book_meeting_room VALUES ('회의실1', '2022-06-01 11:00', '2022-06-01 12:00', '최사원');
INSERT INTO book_meeting_room VALUES ('회의실1', '2022-06-01 13:00', '2022-06-01 15:00', '장부장');
INSERT INTO book_meeting_room VALUES ('회의실2', '2022-06-01 13:00', '2022-06-01 14:00', '홍대리');
INSERT INTO book_meeting_room VALUES ('회의실2', '2022-06-01 15:00', '2022-06-01 17:00', '전과장');
COMMIT;


-- 8-2
SELECT *
FROM book_meeting_room
ORDER BY 1, 2 ;

-- 8-3
SELECT TO_DATE('2022-06-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS') 
       + (LEVEL - 1) / 24 times
  FROM DUAL
CONNECT BY LEVEL <= 10 ;


-- 8-4
WITH schedule AS ( 
   SELECT TO_DATE('2022-06-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS') 
          + (LEVEL - 1) / 24 times
     FROM DUAL
   CONNECT BY LEVEL <= 10 )
SELECT b.room_no 회의실 
      ,TO_CHAR(a.times, 'hh24') AS 기준시간
      ,TO_CHAR(b.start_time, 'hh24:mi') AS 시작
      ,TO_CHAR(b.end_time, 'hh24:mi') AS 종료
      ,b.booker 예약자 
  FROM schedule a
  LEFT OUTER JOIN book_meeting_room b
    ON a.times >= b.start_time 
   AND a.times <  b.end_time 
  ORDER BY 1, 2 ;
  
  
-- 8-5
WITH schedule AS ( 
   SELECT TO_DATE('2022-06-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS') 
          + (LEVEL - 1) / 24 times
     FROM DUAL
   CONNECT BY LEVEL <= 10 )
SELECT b.room_no 회의실 
      ,TO_CHAR(a.times, 'hh24') AS 기준시간
      ,TO_CHAR(b.start_time, 'hh24:mi') AS 시작
      ,TO_CHAR(b.end_time, 'hh24:mi') AS 종료
      ,b.booker 예약자 
  FROM schedule a
  FULL OUTER JOIN book_meeting_room b
    ON a.times >= b.start_time 
   AND a.times <  b.end_time 
  ORDER BY 1, 2 ;  

WITH SCHEDULE AS (
SELECT TO_DATE('2022-06-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS') + (LEVEL - 1) / 24 TIMES
  FROM DUAL
  CONNECT BY LEVEL <= 10
)
SELECT b.room_no
      ,TO_CHAR(a.times, 'hh24')
      ,TO_CHAR(b.start_time, 'hh24:mi')
      ,TO_CHAR(b.end_time, 'hh24:mi')
      ,b.booker
FROM SCHEDULE a
left outer join book_meeting_room b
partition by (b.room_no)
  on a.times >= b.start_time 
 and a.times < b.end_time
order by 1
;  



SELECT employee_id, first_name, last_name, manager_id, LEVEL
  FROM employees
 START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id ;
	

-- 6-2
SELECT employee_id, first_name, last_name, manager_id, LEVEL
  FROM employees
 START WITH manager_id IS NULL
CONNECT BY PRIOR manager_id = employee_id ;

-- 6-3
SELECT employee_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || first_name || ' ' || last_name AS emp_name, 
       manager_id, LEVEL
  FROM employees
 START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id ;


-- 6-4
CREATE TABLE king_family ( 
    c_id  NUMBER,
    p_id  NUMBER,
    names VARCHAR2(100)
);


-- 6-5
INSERT INTO king_family VALUES (1, NULL, '태조');
INSERT INTO king_family VALUES (2, 1, '정조');
INSERT INTO king_family VALUES (3, 1, '태종');
INSERT INTO king_family VALUES (4, 3, '세종');
INSERT INTO king_family VALUES (5, 4, '문종');
INSERT INTO king_family VALUES (6, 5, '단종');
INSERT INTO king_family VALUES (7, 4, '세조');
INSERT INTO king_family VALUES (8, 7, '예종');
COMMIT; 

 
-- 6-6
SELECT *
  FROM king_family;


-- 6-7
SELECT c_id, p_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || names AS king_name, 
       LEVEL, 
	   CONNECT_BY_ROOT names AS root_name,
       SYS_CONNECT_BY_PATH(names, '/') paths,
       CONNECT_BY_ISLEAF ISLEAF
  FROM king_family
 START WITH p_id IS NULL
CONNECT BY PRIOR c_id = p_id;


-- 6-8
INSERT INTO king_family VALUES (7, 8, '세조2');
COMMIT;

-- 6-9
SELECT c_id, p_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || names AS king_name, 
       LEVEL
  FROM king_family
 START WITH p_id IS NULL
CONNECT BY PRIOR c_id = p_id;


-- 6-10
SELECT c_id, p_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || names AS king_name, 
       LEVEL
  FROM king_family
 START WITH p_id IS NULL
CONNECT BY NOCYCLE PRIOR c_id = p_id;


-- 6-11
SELECT c_id, p_id, 
       LPAD(' ', 2 * (LEVEL-1), ' ') || names AS king_name, 
       LEVEL,
	   CONNECT_BY_ISCYCLE ISCYCLE
  FROM king_family
 START WITH p_id IS NULL
CONNECT BY NOCYCLE PRIOR c_id = p_id;


-- 6-12
DELETE FROM king_family
 WHERE p_id = 8;
 
COMMIT;


-- 6-13
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


-- 6-14 
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