--

-- JOBS
create table JOBS
(
  job_id     VARCHAR2(10) not null,
  job_title  VARCHAR2(35),
  min_salary NUMBER(6),
  max_salary NUMBER(6)
);


alter table JOBS
  add constraint JOB_ID_PK primary key (JOB_ID);
  
alter table JOBS
  add constraint JOB_TITLE_NN
  check ("JOB_TITLE" IS NOT NULL);


-- REGIONS
create table REGIONS
(
  region_id   NUMBER,
  region_name VARCHAR2(25)
);


alter table REGIONS
  add constraint REG_ID_PK primary key (REGION_ID);
  
alter table REGIONS
  add constraint REGION_ID_NN
  check ("REGION_ID" IS NOT NULL);


-- COUNTRIES
create table COUNTRIES
(
  country_id   CHAR(2),
  country_name VARCHAR2(40),
  region_id    NUMBER,
  constraint COUNTRY_C_ID_PK primary key (COUNTRY_ID)
)
organization index;


alter table COUNTRIES
  add constraint COUNTR_REG_FK foreign key (REGION_ID)
  references REGIONS (REGION_ID);

alter table COUNTRIES
  add constraint COUNTRY_ID_NN
  check ("COUNTRY_ID" IS NOT NULL);
  
  
-- LOCATIONS
create table LOCATIONS
(
  location_id    NUMBER(4) not null,
  street_address VARCHAR2(40),
  postal_code    VARCHAR2(12),
  city           VARCHAR2(30),
  state_province VARCHAR2(25),
  country_id     CHAR(2)
);


create index LOC_CITY_IX on LOCATIONS (CITY);

create index LOC_COUNTRY_IX on LOCATIONS (COUNTRY_ID);

create index LOC_STATE_PROVINCE_IX on LOCATIONS (STATE_PROVINCE);


alter table LOCATIONS
  add constraint LOC_ID_PK primary key (LOCATION_ID);
  
alter table LOCATIONS
  add constraint LOC_C_ID_FK foreign key (COUNTRY_ID)
  references COUNTRIES (COUNTRY_ID);
  
alter table LOCATIONS
  add constraint LOC_CITY_NN
  check ("CITY" IS NOT NULL);


-- DEPARTMENTS 
create table DEPARTMENTS
(
  department_id   NUMBER(4) not null,
  department_name VARCHAR2(30),
  manager_id      NUMBER(6),
  location_id     NUMBER(4)
);


create index DEPT_LOCATION_IX on DEPARTMENTS (LOCATION_ID);

alter table DEPARTMENTS
  add constraint DEPT_ID_PK primary key (DEPARTMENT_ID);
  
alter table DEPARTMENTS
  add constraint DEPT_LOC_FK foreign key (LOCATION_ID)
  references LOCATIONS (LOCATION_ID);
  
alter table DEPARTMENTS
  add constraint DEPT_NAME_NN
  check ("DEPARTMENT_NAME" IS NOT NULL);






-- EMPLOYEES
create table EMPLOYEES
(
  employee_id    NUMBER(6) not null,
  first_name     VARCHAR2(20),
  last_name      VARCHAR2(25),
  email          VARCHAR2(25),
  phone_number   VARCHAR2(20),
  hire_date      DATE,
  job_id         VARCHAR2(10),
  salary         NUMBER(8,2),
  commission_pct NUMBER(2,2),
  manager_id     NUMBER(6),
  department_id  NUMBER(4)
);



-- Create/Recreate indexes 
create index EMP_DEPARTMENT_IX on EMPLOYEES (DEPARTMENT_ID);

create index EMP_JOB_IX on EMPLOYEES (JOB_ID);

create index EMP_MANAGER_IX on EMPLOYEES (MANAGER_ID);

create index EMP_NAME_IX on EMPLOYEES (LAST_NAME, FIRST_NAME);

alter table EMPLOYEES
  add constraint EMP_EMP_ID_PK primary key (EMPLOYEE_ID);
  
alter table EMPLOYEES
  add constraint EMP_EMAIL_UK unique (EMAIL);
  
alter table EMPLOYEES
  add constraint EMP_DEPT_FK foreign key (DEPARTMENT_ID)
  references DEPARTMENTS (DEPARTMENT_ID);
  
alter table EMPLOYEES
  add constraint EMP_JOB_FK foreign key (JOB_ID)
  references JOBS (JOB_ID);
  
alter table EMPLOYEES
  add constraint EMP_MANAGER_FK foreign key (MANAGER_ID)
  references EMPLOYEES (EMPLOYEE_ID);
  
alter table EMPLOYEES
  add constraint EMP_EMAIL_NN
  check ("EMAIL" IS NOT NULL);
  
alter table EMPLOYEES
  add constraint EMP_HIRE_DATE_NN
  check ("HIRE_DATE" IS NOT NULL);
  
alter table EMPLOYEES
  add constraint EMP_JOB_NN
  check ("JOB_ID" IS NOT NULL);
  
alter table EMPLOYEES
  add constraint EMP_LAST_NAME_NN
  check ("LAST_NAME" IS NOT NULL);
  
alter table EMPLOYEES
  add constraint EMP_SALARY_MIN
  check (salary > 0);
  


-- JOB_HISTORY
create table JOB_HISTORY
(
  employee_id   NUMBER(6),
  start_date    DATE,
  end_date      DATE,
  job_id        VARCHAR2(10),
  department_id NUMBER(4)
);


create index JHIST_DEPARTMENT_IX on JOB_HISTORY (DEPARTMENT_ID);

create index JHIST_EMPLOYEE_IX on JOB_HISTORY (EMPLOYEE_ID);

create index JHIST_JOB_IX on JOB_HISTORY (JOB_ID);


alter table JOB_HISTORY
  add constraint JHIST_EMP_ID_ST_DATE_PK primary key (EMPLOYEE_ID, START_DATE);
  
alter table JOB_HISTORY
  add constraint JHIST_DEPT_FK foreign key (DEPARTMENT_ID)
  references DEPARTMENTS (DEPARTMENT_ID);
  
alter table JOB_HISTORY
  add constraint JHIST_EMP_FK foreign key (EMPLOYEE_ID)
  references EMPLOYEES (EMPLOYEE_ID);
  
alter table JOB_HISTORY
  add constraint JHIST_JOB_FK foreign key (JOB_ID)
  references JOBS (JOB_ID);

alter table JOB_HISTORY
  add constraint JHIST_DATE_INTERVAL
  check (end_date > start_date);
  
alter table JOB_HISTORY
  add constraint JHIST_EMPLOYEE_NN
  check ("EMPLOYEE_ID" IS NOT NULL);
  
alter table JOB_HISTORY
  add constraint JHIST_END_DATE_NN
  check ("END_DATE" IS NOT NULL);
  
alter table JOB_HISTORY
  add constraint JHIST_JOB_NN
  check ("JOB_ID" IS NOT NULL);
  
alter table JOB_HISTORY
  add constraint JHIST_START_DATE_NN
  check ("START_DATE" IS NOT NULL);