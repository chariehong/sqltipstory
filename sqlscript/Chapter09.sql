-- 9-1.
CREATE TABLE groupbymultiply (
  dept_name   VARCHAR2(100),
  num_data    NUMBER 
);

insert into groupbymultiply values ('dept1', 10);
insert into groupbymultiply values ('dept1', 20);
insert into groupbymultiply values ('dept1', 30);
insert into groupbymultiply values ('dept2', 5);
insert into groupbymultiply values ('dept2', 7);
insert into groupbymultiply values ('dept2', 40);
insert into groupbymultiply values ('dept3', 69);
insert into groupbymultiply values ('dept3', 71);
insert into groupbymultiply values ('dept3', 12);
commit;



-- 9-2
SELECT *
  FROM groupbymultiply ;


-- 9-3
SELECT dept_name, SUM(num_data)
  FROM groupbymultiply 
 GROUP BY dept_name 
 ORDER BY 1;



-- 9-4
SELECT dept_name
     , SUM(LN(num_data))
  FROM groupbymultiply 
 GROUP BY dept_name 
 ORDER BY 1;
  
  
-- 9-5
SELECT dept_name
     , EXP(SUM(LN(num_data)))
  FROM groupbymultiply 
 GROUP BY dept_name 
 ORDER BY 1;

	

-- 9-6
SELECT dept_name
     , ROUND(EXP(SUM(LN(num_data))))
  FROM groupbymultiply 
 GROUP BY dept_name 
 ORDER BY 1;

