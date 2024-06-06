 select * from employees;
 --1. sal_history(empid, hiredate,sal) 테이블 employees 이용
 create table  sal_history
 as select employee_id, hire_date, salary
 from employees;
 select * from sal_history;
 
 
 --2. sal_history2(empid, hiredate,sal) 테이블 employees 이용 구조만
 create table  sal_history2
 as select employee_id, hire_date, salary
 from employees
 where 1=2;
 select * from sal_history2;
 
 create table  sal_history3(id,hire, sal) 
 as select employee_id, hire_date, salary
 from employees
 where 1=2;
 select * from sal_history3;
 drop table sal_history;
 drop table sal_history2;
 drop table sal_history3;
 -- 1.sal_history 구조만 복사
 create table sal_history
 as select employee_id as empid, hire_date as hiredate, salary as sal
 from employees
 where 1=2;
 select * from sal_history;
 --employees 테이블에서 employee_id 가 200보다 큰 데이터를 
 --sal_history 에 데이터 넣기
 insert into sal_history 
 select employee_id empid, hire_date hiredate, salary sal
 from employees
 where employee_id > 200;

 --취소
rollback;
select * from sal_history;
--2.mgr_history(empid,  mgr,sal) 테이블 만드는데 employees 이용하여 구조만 생성 
 create table mgr_history
 as select employee_id as empid, manager_id as mgr, salary as sal
 from employees
 where 1=2; 
 select * from mgr_history;
 -- 3.employee_id 가 200보다 큰 데이터를 
 -- 각각 sal_history, mgr_history 에 데이터 넣기
 -- 조건없는 insert(unconditional insert)
 insert all
 into sal_history values(empid, hiredate,sal)
 into mgr_history values(empid, mgr,sal)
 select employee_id empid, hire_date hiredate, salary sal, manager_id mgr
 from employees
 where employee_id > 200;
 
 select * from sal_history;
 select * from mgr_history;
 --  sal_history,mgr_history 데이터 삭제
 delete from sal_history;
 delete from mgr_history;
 commit;
 
 --4.employee_id 가 200보다 큰 데이터 중에서 sal 이 10000보다 크면 sal_history
 -- mgr 이 200보다 크면 mgr_history 에 데이터 넣기
 --조건있는 insert(conditional insert)
 insert all
 when  sal > 10000 then
                   into sal_history values(empid, hiredate,sal)
 when  mgr > 200 then into mgr_history values(empid, mgr, sal)
 select employee_id empid, hire_date hiredate,salary sal, manager_id mgr
 from employees 
 where employee_id >200;
 commit;
 
 select * from sal_history;
 select * from mgr_history;
  
 --테이블 삭제 sal_history,mgr_history
 drop table sal_history;
 drop table mgr_history;
 ---------------
--dept2 테이블에서  dcode가 1000,1001,1002인 데이터로 구성된
--dept6 테이블 생성(dcode, dname, area 구성)
select dcode, dname, area
from dept2
where dcode in (1000,1001,1002);

create table dept6
as select dcode, dname, area
from dept2
where dcode in (1000,1001,1002);
select * from dept6;

--1. location(크기 200) 컬럼 추가
alter table dept6
add(location varchar2(200));

--2. dcode 1000 의 location 을 부산 수정
update dept6
set location='부산'
where dcode=1000;
commit;

--3. (2000, TEAM , BUSAN,  부산) --> dept6 추가
insert into dept6(dcode, dname, area,location)
values(2000, 'TEAM' , 'BUSAN',  '부산');
commit;

insert into dept6
values(2001, 'TEAM1' , 'BUSAN1',  '부산1');
commit;
select * from dept6;
--4.dcode가 2000 번 삭제
delete from dept6
where dcode = 2000;
commit;
select * from dept6;
-- 5.location 컬럼 크기를 70 으로 수정
alter table dept6
modify(location varchar2(70));
desc dept6;

--6.location 컬럼이름을  loc  변경
alter table dept6
rename column location to loc;
select * from dept6;
--7. loc   컬럼 삭제
alter table dept6
drop column loc;
--8. dept6 테이블 삭제
drop table dept6;


 
 
 
 
 
 
 
 
 
 