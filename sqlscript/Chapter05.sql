-- 5-1.
CREATE TABLE score_table (
       YEARS           VARCHAR2(4),   -- 연도
       GUBUN           VARCHAR2(30),  -- 구분(중간/기말)
       SUBJECTS        VARCHAR2(30),  -- 과목
       SCORE           NUMBER         -- 점수  
	   );      

-- 5-2
INSERT INTO score_table VALUES('2021','중간고사','국어',92);
INSERT INTO score_table VALUES('2021','중간고사','영어',87);
INSERT INTO score_table VALUES('2021','중간고사','수학',67);
INSERT INTO score_table VALUES('2021','중간고사','과학',80);
INSERT INTO score_table VALUES('2021','중간고사','지리',93);
INSERT INTO score_table VALUES('2021','중간고사','독일어',82);
INSERT INTO score_table VALUES('2021','기말고사','국어',88);
INSERT INTO score_table VALUES('2021','기말고사','영어',80);
INSERT INTO score_table VALUES('2021','기말고사','수학',93);
INSERT INTO score_table VALUES('2021','기말고사','과학',91);
INSERT INTO score_table VALUES('2021','기말고사','지리',89);
INSERT INTO score_table VALUES('2021','기말고사','독일어',83);
INSERT INTO score_table VALUES('2022','중간고사','국어',88);
INSERT INTO score_table VALUES('2022','중간고사','영어',85);
INSERT INTO score_table VALUES('2022','중간고사','수학',92);
INSERT INTO score_table VALUES('2022','중간고사','과학',97);
INSERT INTO score_table VALUES('2022','중간고사','지리',77);
INSERT INTO score_table VALUES('2022','중간고사','독일어',86);

COMMIT; 

-- 5-3
SELECT *
  FROM score_table; 
  

-- 5-4
SELECT years,
       gubun,
       CASE WHEN subjects = '국어'   THEN score ELSE 0 END 국어,
       CASE WHEN subjects = '영어'   THEN score ELSE 0 END 영어,
       CASE WHEN subjects = '수학'   THEN score ELSE 0 END 수학,
       CASE WHEN subjects = '과학'   THEN score ELSE 0 END 과학,
       CASE WHEN subjects = '지리'   THEN score ELSE 0 END 지리,
       CASE WHEN subjects = '독일어' THEN score ELSE 0 END  독일어
  FROM score_table ;
  
  
-- 5-5
SELECT years, gubun,
       SUM(국어) AS 국어, SUM(영어) AS 영어, SUM(수학) AS 수학, 
	   SUM(과학) AS 과학, SUM(지리) AS 지리, SUM(독일어) AS 독일어
  FROM ( SELECT years,
                gubun,
                CASE WHEN subjects = '국어'   THEN score ELSE 0 END 국어,
                CASE WHEN subjects = '영어'   THEN score ELSE 0 END 영어,
                CASE WHEN subjects = '수학'   THEN score ELSE 0 END 수학,
                CASE WHEN subjects = '과학'   THEN score ELSE 0 END 과학,
                CASE WHEN subjects = '지리'   THEN score ELSE 0 END 지리,
                CASE WHEN subjects = '독일어' THEN score ELSE 0 END  독일어
           FROM score_table 
		)
 GROUP BY years, gubun		
 ORDER BY 1, 2 DESC  ;
 
-- 5-6
SELECT years, gubun,
       SUM(CASE WHEN subjects = '국어'   THEN score ELSE 0 END) AS 국어,
       SUM(CASE WHEN subjects = '영어'   THEN score ELSE 0 END) AS 영어,
       SUM(CASE WHEN subjects = '수학'   THEN score ELSE 0 END) AS 수학,
       SUM(CASE WHEN subjects = '과학'   THEN score ELSE 0 END) AS 과학,
       SUM(CASE WHEN subjects = '지리'   THEN score ELSE 0 END) AS 지리,
       SUM(CASE WHEN subjects = '독일어' THEN score ELSE 0 END) AS 독일어
  FROM score_table 
 GROUP BY years, gubun		
 ORDER BY 1, 2 DESC  ; 


-- 5-7
SELECT years, gubun,
       SUM(DECODE(subjects, '국어',  score, 0)) AS 국어,
       SUM(DECODE(subjects, '영어',  score, 0)) AS 영어,
       SUM(DECODE(subjects, '수학',  score, 0)) AS 수학,
       SUM(DECODE(subjects, '과학',  score, 0)) AS 과학,
       SUM(DECODE(subjects, '지리',  score, 0)) AS 지리,
       SUM(DECODE(subjects, '독일어', score, 0)) AS 독일어
  FROM score_table 
 GROUP BY years, gubun		
 ORDER BY 1, 2 DESC  ; 
 

-- 5-8
SELECT *
  FROM  score_table 
 PIVOT ( SUM(score)
          FOR subjects IN ( '국어', '영어', '수학', 
                            '과학', '지리', '독일어')
        )
 ORDER BY 1, 2 DESC  ; 
 
 
-- 5-9
INSERT INTO score_table VALUES ('2022','중간고사', '프랑스어', 95);

SELECT *
  FROM  score_table 
 PIVOT ( SUM(score)
          FOR subjects IN ( '국어', '영어', '수학', 
                            '과학', '지리', '독일어', '프랑스어')
        )
 ORDER BY 1, 2 DESC  ;  
 

-- 5-10
SELECT years, gubun, 
       NVL(국어,0)
  FROM  score_table 
 PIVOT ( SUM(score)
          FOR subjects IN ( '국어', '영어', '수학', 
                            '과학', '지리', '독일어', '프랑스어')
        )
 ORDER BY 1, 2 DESC  ;  
 
 
-- 5-11
SELECT years, gubun, 
       NVL('국어',0)
  FROM  score_table 
 PIVOT ( SUM(score)
          FOR subjects IN ( '국어', '영어', '수학', 
                            '과학', '지리', '독일어', '프랑스어')
        )
 ORDER BY 1, 2 DESC  ;   
 
 
-- 5-12
SELECT years, gubun, 
       NVL("'국어'",0)
  FROM  score_table 
 PIVOT ( SUM(score)
          FOR subjects IN ( '국어', '영어', '수학', 
                            '과학', '지리', '독일어', '프랑스어')
        )
 ORDER BY 1, 2 DESC  ;   
 
 
-- 5-13
SELECT years, gubun, 
       NVL(국어,0), NVL(영어,0), NVL(수학,0), NVL(과학,0), 
	   NVL(지리,0), NVL(독일어,0), NVL(프랑스어,0)
  FROM  score_table 
 PIVOT ( SUM(score)
          FOR subjects IN ( '국어' AS 국어, '영어' AS 영어
		                  , '수학' AS 수학, '과학' AS 과학
						  , '지리' AS 지리, '독일어' AS 독일어
						  , '프랑스어' AS 프랑스어)
        )
 ORDER BY 1, 2 DESC  ; 
 
 
-- 5-14
SELECT *
  FROM  score_table 
 PIVOT ( SUM(score) AS sc
          FOR subjects IN ( '국어' AS 국어, '영어' AS 영어
		                  , '수학' AS 수학, '과학' AS 과학
						  , '지리' AS 지리, '독일어' AS 독일어
						  , '프랑스어' AS 프랑스어)
        )
 ORDER BY 1, 2 DESC  ;  
 
 
-- 5-15
SELECT *
  FROM  score_table 
 PIVOT XML ( SUM(score) AS sc
             FOR subjects IN ( SELECT subjects
			                     FROM score_table )
            )
 ORDER BY 1, 2 DESC  ;   
 


<PivotSet>
  <item><column name = "SUBJECTS">과학</column><column name = "SC">80</column></item>
  <item><column name = "SUBJECTS">국어</column><column name = "SC">92</column></item>
  <item><column name = "SUBJECTS">독일어</column><column name = "SC">82</column></item>
  <item><column name = "SUBJECTS">수학</column><column name = "SC">67</column></item>
  <item><column name = "SUBJECTS">영어</column><column name = "SC">87</column></item>
  <item><column name = "SUBJECTS">지리</column><column name = "SC">93</column></item>
  <item><column name = "SUBJECTS">프랑스어</column><column name = "SC"></column></item>
</PivotSet>
