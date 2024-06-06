--system
alter session set "_oracle_script" = true;
-- 관리자가 사용자 생성
create user oraclestudy
identified by oracle;

-- create session 권한 부여 : 데이터베이스 접근
grant CREATE session to oraclestudy;
---테이블 생성 권한 
grant create table to oraclestudy;
-- 롤 부여 (connect, resource 부여)
grant resource, connect to oraclestudy;
--1. 사용자: test_user 비번: 1234
create user test_user
identified by 1234;
--2. 데이터베이스 접근 권한 부여하기 
grant create session to test_user; 
---3. 비번변경
alter user test_user identified by abcd;
--4. 계정 삭제 
drop user test_user;
-- 롤 (role) 
-- connect:create session 권한
-- resource 권한

-- user 삭제
drop user oraclestudy cascade;
drop user test_user cascade;

----------------------------------
--1. test 계정 생성 비번 test
create user test identified by test;
--2. test 계정 권한 부여 resource, connect, unlimited tablespace
grant resource, connect,unlimited tablespace to test;
--3. test 접속하여 dbtest 테이블 생성 
    -- dbtest(num, id, job, regdate)
--   num: number(기본키) job 기본값 : '사원', regdate :date형 기본값 sysdate
-- 4. dbtest 테이블에 데이터 추가(num:1, id:'aa')추가 

---------------------------------------
---p416 15장 연습 문제
-- 1.prev_hw 계정 생성(비번 oracle) 접속 가능하도록 생성
create user PREV_HW identified by oracle;
--2. scott 계정으로 접속해서 
--prev_hw에 emp, dept, salgrade 테이블의 select 권한 부여 
grant resource, connect, unlimited tablespace to PREV_HW;

