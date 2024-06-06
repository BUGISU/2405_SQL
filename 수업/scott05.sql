--p251 (다중행서브쿼리)
select ename, sal
from emp
where sal < any(select sal
                from emp
                where job = 'SALESMAN');
                
select ename, sal from emp;  -- 12개
select sal  --1600 ,1250, 1250, 1500
from emp
where job = 'SALESMAN';

select ename, sal
from emp
where sal < all(select sal
                from emp
                where job = 'SALESMAN');
-- 30번 부서에서  최대급여보다 적은 급여를 받는 사원 출력(any, all 사용)
select *
from emp
where sal < (select max(sal)
            from emp
            where deptno=30);
select sal from emp where deptno =30;  --1600,1250,1250,2850,1500,950

select *
from emp
where sal < any(select sal
            from emp
            where deptno=30);
  ---------
select * from dept;            
select *
from dept
where EXISTS (select deptno
                from dept
                where deptno=20);
--p266
--DML(조작어 : data manipulation language) : 데이터를 추가, 수정, 삭제하는 데이터조작어
--DDL(data definition language): 객체를 생성, 변경, 삭제하는 데이터정의어(p311)
--DCL
-- test1(no, name, address, tel)
--number(5),  문자열(20), 문자열(50), 문자열(20)
create table test1(
    no number(5),
    name varchar2(20),
    address varchar2(50),
    tel varchar2(20)
);
select * from test1;
--(1,'aaa') 추가 (no, name)
insert into test1(no,name) values(1,'aaa');
--(2,'bbb','부산','010-1111-2222') 추가 
insert into test1(no, name, address, tel) 
values(2,'bbb','부산','010-1111-2222');
--(3,'ccc','서울','010-3333-4444') 추가 
insert into test1 values(3,'ccc','서울','010-3333-4444');
insert into test1(no, name, address) values(4,'ddd','인천');
commit;
insert into test1 values(5,'eee','서울1','010-3344-4455');
select * from test1;
rollback;
--수정
-- no 2번인 사람의 이름을 홍길동으로 수정
update test1
set name = '홍길동'
where no = 2;
select * from test1;
-- no가 4인 name을 test  /  address 서울로 수정
update test1
set name= 'test', address='서울'
where no=4;
--삭제
-- test1에서 no 1번 삭제
delete test1 where no =1;
delete from test1 where no=2;
commit;

delete from test1;
select * from test1;
rollback;

-- test 테이블 생성 (no, name, hiredate)
create table test(
    no number(3) default 0,
    name varchar2(20) default 'NONAME',
    hiredate date default sysdate
);
-- test 에 (1, 홍길동) 추가
insert into test(no, name) values(1,'홍길동');
select * from test;
-- test 에 24/5/20 추가
insert into test(hiredate) values('24/5/20');
-- test에서 번호가 1번인 사람의 이름을 강감찬 수정
update test
set name ='강감찬'
where no = 1;
commit;
--test에서 번호가 0인 것을 삭제하고
-- 번호가 2인 데이터를 추가하기
delete from test where no=0;
insert into test(no) values(2);
commit;
-------------------
--CRUD(create, select, update, delete)
--p266(CTAS : create table as select)
create table dept_temp
as select * from dept;
select * from dept_temp;

--dept_temp 테이블에 50, DATABASE , SEOUL 추가
insert into dept_temp values(50, 'DATABASE' , 'SEOUL');
commit;
--테이블 구조만 복사
create table emp_temp
as select * from emp
where 1<>1;
select * from emp_temp;
desc emp_temp;
--emp_temp : empno, ename, job, mgr, hiredate, sal, comm, deptno
--(2111,'이순신','MANAGER',9999,'07/01/2019',4000,NULL,20) 추가
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(2111,'이순신','MANAGER',9999,to_date('07/01/2019','DD/MM/YYYY'),4000,NULL,20);
select * from emp_temp;
insert into emp_temp
values(2112,'이순신2','MANAGER',9999,to_date('07/01/2019','DD/MM/YYYY'),4000,NULL,20);
--(3111,'강감찬','MANAGER',9999,4000,NULL,20) 입사일은 오늘날짜로  추가
insert into emp_temp
values(3111,'강감찬','MANAGER',9999,sysdate,4000,NULL,20);
--emp_temp 모든 사원 삭제
delete from emp_temp;
commit;
---------------------------
--p262 9장 연습문제
--1. 전체 사원 중 ALLEN 과 같은 직책(JOB)인 사원들의 사원정보, 부서정보 출력
select e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno
and job =(select job
          from emp
          where ename = 'ALLEN');

--2.전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보 출력
--(급여가 많은 순, 같으면 사원번호 오름차순)
select e.empno, e.ename, d.dname, e.hiredate,d.loc, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal
and sal > (select avg(sal) from emp )
order by sal desc, empno ;

--3 10번 부서에 근무하는 사원 중
--30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보 부서정보 출력
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and e.deptno = 10
and job not in (select job from emp where deptno=30);

select job from emp where deptno=30;
--4.직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원정보, 급여 등급정보
--(사원번호 오름차순)
-- 다중행 함수를 사용하지 않는 방법
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > (select max(sal) from emp where job ='SALESMAN')
order by empno asc;
--다중행 함수를 사용 방법
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and sal > all(select sal from emp where job ='SALESMAN')
order by empno asc;

--------------------
--p275 서브쿼리를 이용해서 한 번에 여러 데이터  추가(values  사용하지 않는다)
-- 급여등급(salgrade)이 1인 사원만 emp_temp 에 추가
select * from emp_temp;
select * from salgrade;
select * from emp where sal between 700 and 1200;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp 
where sal  between 700 and 1200;
commit;
select * from emp_temp;

delete from emp_temp;
commit;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select e.empno, e.ename, e.job, e.mgr, e.hiredate,e.sal, e.comm, e.deptno 
from emp e, salgrade s
where e.sal between s.losal and s.hisal and s.grade=1;
commit;
-- dept 테이블을 복사해서  dept_temp2 테이블을 생성하고
-- 40번 부서명을  DATABASE 지역  SEOUL 수정

create table dept_temp2
as select * from dept;

update dept_temp2 
set dname='DATABASE', loc='SEOUL'
where deptno = 40;
commit;

select * from dept_temp2;
-----
select * from emp_temp;
--7900번 사원 이름을 강감찬으로 수정 / 수정 확인 후 / 수정 취소
update emp_temp
set ename = '강감찬'
where empno = 7900;
select * from emp_temp;
rollback;

--dept_temp2 테이블 40번 내용 수정하기
-- dept 테이블의 40번이 가지는 부서명과 지역으로 수정하기
select * from dept;
select * from dept_temp2;

update dept_temp2
set dname = (select dname from dept where deptno = 40), 
     loc=(select loc from dept where deptno=40)
where deptno = 40;
rollback;

update dept_temp2
set (dname, loc) = (select dname, loc
                    from dept
                    where deptno=40)
where deptno = 40; 
select * from dept_temp2;
commit;

-- dept_temp2  모든 데이터 삭제
 delete from dept_temp2;
 select * from dept_temp2;
 --테이블 삭제
 drop table dept_temp2;
 
 --dept 테이블 이용해서 dept_tmp 테이블 생성
 create table dept_tmp
 as select * from dept;
 
 select * from dept_tmp;
 --dept_tmp 테이블에 LOCATION 컬럼추가
 alter table dept_tmp add(LOCATION varchar2(50));
--10번 부서의 location 을 뉴욕으로 수정
update dept_tmp
set location='뉴욕'
where deptno=10;
commit;

 --dept_tmp 테이블에 LOCATION 컬럼 을 변경 varchar2(70)
 alter table dept_tmp
 modify(location varchar2(70));
 select * from dept_tmp;
 
 describe dept_tmp;
 --location 컬럼 삭제
 alter table dept_tmp
 drop column location;
 
 select * from dept_tmp;
 --컬럼명 loc 를 location으로 변경
 alter table dept_tmp
 rename column loc to location;
 --테이블 명 수정
rename dept_tmp to dept_tmptmp;
select * from dept_tmptmp;

--모든 데이터 삭제(delete)
delete from dept_tmptmp;
--취소
rollback;
select * from dept_tmptmp;
-- 모든 데이터 삭제(truncate DDL 이므로 rollback 적용되지 않아 복구 안됨)
truncate table dept_tmptmp;
rollback;  -- rollback 사용해도 데이터 복구 안됨
select * from dept_tmptmp;
--테이블 삭제
drop table dept_tmptmp;

---10장 연습문제 p287
--1. 
create table chap10hw_emp 
as select * from emp;
create table chap10hw_dept
as select * from dept;
create table chap10hw_salgrade
as select * from salgrade;
-- 10-1 CHAP10HW_DEPT 테이블에 50,60,70,80 정보 추가
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (50, 'ORACLE', 'BUSAN'); 
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (80, 'DML', 'BUNDANG'); 
commit;
select * from CHAP10HW_DEPT;
-- 10-2  CHAP10HW_DEPT 테이블에 아래 8명의 사원 추가
INSERT INTO CHAP10HW_EMP
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'YYYY-MM-DD'), 4500, NULL, 50);
INSERT INTO CHAP10HW_EMP
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'YYYY-MM-DD'), 1800, NULL, 50);
INSERT INTO CHAP10HW_EMP
VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'YYYY-MM-DD'), 3400, NULL, 60);
INSERT INTO CHAP10HW_EMP
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'YYYY-MM-DD'), 2700, 300, 60);
INSERT INTO CHAP10HW_EMP
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'YYYY-MM-DD'), 2300, NULL, 80);
 
INSERT INTO CHAP10HW_EMP
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018-03-09', 'YYYY-MM-DD'), 1200, NULL, 80);

commit;
select * from CHAP10HW_EMP;
--3. CHAP10HW_EMP 에 속한 사원 중 
-- 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을
-- 70번 부서로 옮기기
select avg(sal)
from CHAP10HW_EMP
where deptno =50;

update CHAP10HW_EMP
set deptno = 70
where sal > (
            select avg(sal)
            from CHAP10HW_EMP
            where deptno =50
            );
commit;
select sal from CHAP10HW_EMP where deptno= 70;
--4. CHAP10HW_EMP 에 속한 사원 중
--60번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 입사한 
-- 사원의 급여를 10% 인상하고 80번 부서로  옮기기
update CHAP10HW_EMP
set deptno = 80, sal = sal*1.1
where hiredate > (select min(hiredate)
                    from CHAP10HW_EMP
                    where deptno=60);
commit;
select * from CHAP10HW_EMP;
--5. CHAP10HW_EMP에 속한 사원 중 급여 등급이 5인 사원을 삭제한는 SQL
select sal
from  CHAP10HW_EMP c ,CHAP10HW_salgrade s
where c.sal between s.losal and s.hisal and s.grade=5;

select * from CHAP10HW_EMP
where sal in (
            select sal
            from  CHAP10HW_EMP c ,CHAP10HW_salgrade s
            where c.sal between s.losal and s.hisal and s.grade=5
);

select * from CHAP10HW_EMP
where sal = any (
            select sal
            from  CHAP10HW_EMP c ,CHAP10HW_salgrade s
            where c.sal between s.losal and s.hisal and s.grade=5
);

delete from CHAP10HW_EMP
where sal in (select sal
            from  CHAP10HW_EMP c ,CHAP10HW_salgrade s
            where c.sal between s.losal and s.hisal and s.grade=5);
rollback;

delete from CHAP10HW_EMP
where empno in (select empno
            from  CHAP10HW_EMP c ,CHAP10HW_salgrade s
            where c.sal between s.losal and s.hisal and s.grade=5);
commit;
select * from chap10hw_emp;










