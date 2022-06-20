-- 6-1.
CREATE TABLE score_col_table  (
    YEARS     VARCHAR2(4),   -- 연도
    GUBUN     VARCHAR2(30),  -- 구분(중간/기말)
    KOREAN    NUMBER,        -- 국어점수
    ENGLISH   NUMBER,        -- 영어점수
    MATH      NUMBER,        -- 수학점수
    SCIENCE   NUMBER,        -- 과학점수
    GEOLOGY   NUMBER,        -- 지리점수
    GERMAN    NUMBER,        -- 독일어점수
	FRENCH    NUMBER         -- 프랑스어점수 
    ); 
	
	

    

-- 6-2
INSERT INTO score_col_table
VALUES ('2021', '중간고사', 92, 87, 67, 80, 93, 82, NULL );

INSERT INTO score_col_table
VALUES ('2021', '기말고사', 88, 80, 93, 91, 89, 83, NULL );

INSERT INTO score_col_table
VALUES ('2022', '중간고사', 88, 85, 92, 97, 77, 86, 95 );

COMMIT; 

-- 6-3
SELECT *
  FROM score_col_table; 
  

-- 6-4
SELECT YEARS, GUBUN, '국어' AS SUBJECT, KOREAN AS SCORE
  FROM score_col_table;

  
  
-- 6-5
SELECT YEARS, GUBUN, '국어' AS SUBJECT, KOREAN AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '영어' AS SUBJECT, ENGLISH AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '수학' AS SUBJECT, MATH AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '과학' AS SUBJECT, SCIENCE AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '지리' AS SUBJECT, GEOLOGY AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '독일어' AS SUBJECT, GERMAN AS SCORE
  FROM score_col_table
 UNION ALL
SELECT YEARS, GUBUN, '프랑스어' AS SUBJECT, FRENCH AS SCORE
  FROM score_col_table  
 ORDER BY 1, 2 DESC, 3; 

 
-- 6-6
SELECT *
  FROM score_col_table
  UNPIVOT ( score
            FOR subject  IN ( korean   AS '국어',
                              english  AS '영어',
                              math     as '수학',
                              science  as '과학',
                              geology  as '지리',
                              german   as '독일어',
							  french   as '프랑스어'
                            )
        ); 


-- 6-7
SELECT *
  FROM score_col_table
  UNPIVOT INCLUDE NULLS
          ( score
            FOR subject  IN ( korean   AS '국어',
                              english  AS '영어',
                              math     as '수학',
                              science  as '과학',
                              geology  as '지리',
                              german   as '독일어',
							  french   as '프랑스어'
                            )
        );
 

