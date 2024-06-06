select * from sal_history;
--1. sal_history(empid, hiredate,sal) 테이블 employees 이용
create table sal_history as select * from employees;
create table sal_history as select employee_id, hire_date, salary from employees;
drop table sal_history;

--2.sal_history(empid, hiredate,sal) 테이블 employees 이용 구조만 복사
create table sal_history2(id,hire,sal) as select * from employees where 1<>1;
drop table sal_history2;

--2.1
create table  sal_history
as select employee_id as empid, hire_date as hiredate, salary as sal
from employees
where 1=2;
select * from sal_history;

-- employee_id 가 200보다 큰 데이터를 sal_history 에 데이터 넣기
select * from employees;
insert into sal_history(employee_id) 
select employee_id empid, hire_date hiredate, salary sal 
from employees where employee_id >200;
select * from sal_history;
rollback;
--
select * from sal_history;
--2. mgr_histroy(empid, mgr, sal) 테이블을 만드는데 employees 이용하여 구조만 생성
create table mgr_histroy
as select employee_id as empid, manager_id as mgr , salary as sal 
from employees
where 1=2;

--3. employee_id 가 200보다 큰 데이터를 
--각각 sal_history , mgr_history 에 데이터 넣기 
--조건 없는 insert
insert all 
into sal_history values(empid, hiredate, sal)
into mgr_histroy values(empid, mgr, sal)
select employee_id empid, hire_date hiredate, salary sal, manager_id mgr
from employees
where employee_id>200;

--sal_history , mgr_history 데이터 삭제 
delete from sal_history; 
delete from mgr_history; 

--4. employee_id 가 200보다 큰 데이터 중에서 sal이 10000보다 크면 sal_history
--mgr이 200보다 크면 mgr_history 에 데이터 넣기
--조건 있는 insert(conditional insert)
insert all
when sal >10000 then
        into sal_history values(empid, hiredate , sal)
when mgr >200 then
        into mgr_history values(empid, mgr, sal)
select employee_id empid , hire_date hiredate, salary sal, manager_id mgr
from employees
where employee_id >200;

drop table sal_history; 
drop table mgr_history; 

--------------------------------------------------------------------
-- dept2 테이블에서 dcode가 1000, 1001, 1002 인 데이터로 구성된
-- dept6 테이블 생성( decode, dname ,area 구성)
select *from dept2;
select *from dept6;
drop table dept6;

create table dept6 as 
select dcode, dname, area from dept2 
where dcode in (1000 , 1001,1002) ;

select *from dept6;
--1.  location (크기 200) 컬럼 추가 
alter table dept6 
add(location VARCHAR2(200));

--2. dcode 1000인 location 을 부산 수정
update dept6 set location='부산' where dcode=1000;
commit;

--3. (2000,TEAM, BUSAN, 부산) -->dept6 추가
insert into dept6 values (2000,'TEAM','BUSAN','부산');

--4. decode가 2000번 삭제
delete dept6 where dcode =2000;

--5. location 크기 (70) 으로 수정
alter table dept6
modify(location varchar2(70));
desc dept6;

--6. locaiotn 컬럼 이름을 loc로 변경
alter table dept6
rename COLUMN location to loc;
commit;

--7. loc 컬럼을 삭제
alter table dept6
drop column loc;

--8. dept6 테이블 삭제 
drop table dept6;

----------------------------------------------------------------------

