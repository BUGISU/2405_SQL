alter session set "_oracle_script"=true;
-- 관리자가 사용자 생성
create user oraclestudy
IDENTIFIED by oracle;
-- create session  권한 부여 : 데이터베이스 접근 
grant create session to oraclestudy;
-- 테이블 생성 권한
grant create table to oraclestudy;
-- 롤 부여 (connect, resource 부여)
grant resource, connect to oraclestudy;
---------------------------
-- 1. 사용자 :  test_user  // 비번 : 1234  
create user test_user
IDENTIFIED by 1234;

-- 2. 데이터베이스 접근 권한 부여 
grant create session to test_user;
--3. 비번 변경
alter user test_user IDENTIFIED by abcd;
drop user test_user;
----- 롤(role)
-- connect : create session 권한
-- resource

--user 삭제
drop user oraclestudy cascade;
----------------------
--1. test 계정 생성 비번  test
create user test identified by test;
--2. test 계정 권한 부여 resource, connect ,unlimited tablespace 
grant resource, connect, unlimited tablespace  to test;
--3. test 접속하여 dbtest 테이블 생성
  -- dbtest(num, id,       job,       regdate)
      number(기본키)  기본값 '사원'  date 형 기본값 sysdate
-- dbtest 테이블에 데이터(num : 1 , id :'aa') 추가      
-----------
-----p416 15장연습문제
-- 1. PREV_HW  계정생성 (비번  oracle) 접속 가능하도록 생성 ==> 관리자계정에서 작업
create user PREV_HW identified by oracle;
grant resource, connect, unlimited tablespace  to PREV_HW; 






