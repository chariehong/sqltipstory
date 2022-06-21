-- hr 스키마 신규 설치 방법

-- 1. hr 유저 확인
-- 관리자 계정으로 로그인해 다음 쿼리 수행 
SELECT *
FROM ALL_USERS
WHERE USERNAME = 'HR';


-- 2. 존재하지 않으면 HR 계정 생성
CREATE USER hr identified by hr default tablespace users ;

ALTER USER hr DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;

grant create table to hr;

grant create session to hr;

GRANT ANALYZE ANY TO hr;


-- 3. hr object 생성
-- (1) SQL Developer를 실행해 hr 계정으로 로그인 
-- (2) SQL 워크시트 창을 열어 01.hr_objects.sql 파일 내용을 복사해 붙여 넣기
-- (3) F5 키를 눌러 실행
-- (4) SQL 워크시트 창 내용을 모두 지운 후, 02.hr_data.sql 파일 내용을 복사해 붙여 넣기
-- (5) F5 키를 눌러 실행


-- 4. hr objects 삭제
   -- hr objects 생성 시 오류 발생한 경우, SQL 워크시트 창 내용을 모두 지운 후 03.hr_drop.sql 파일 내용을 복사해 붙여 넣기
   -- F5 키를 눌러 실행
   -- 3번 작업 재실행해 다시 생성 
   
-- 5. 통계정보 생성
   EXEC DBMS_STATS.GATHER_SCHEMA_STATS('HR');
   -- 위 문장 실행
   -- DBMS_STATS 실행하려면 ANALYZE ANY 권한 필요
   


