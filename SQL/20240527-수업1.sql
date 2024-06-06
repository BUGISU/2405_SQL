--p251 ( 다중행 서브쿼리)
select ename, sal
from emp
where sal < any(select sal 
        from emp    
        where job = 'SALESMAN');
        
select ename, sal from emp; 
select sal
from emp 
where job = 'SALESMAN';

select ename, sal
from emp
where sal < ALL(select sal 
        from emp    
        where job = 'SALESMAN');
        
-- 30번 부서에서 최대급여보다 적은 급여를 받는 사원 출력(all, any 사용)
select ename , sal
from emp
where sal < any(select sal from emp where deptno=30);

select * from dept;
select *
from dept
where EXISTS (select deptno
from dept
where deptno = 20);

-----------------------------------------------------------------------------
--p266
--DML (data manipulation language 조작어) :데이터를 추가, 수정, 삭제는 데이터 조작어
--DDL (data definition language):객체를 생성, 변경, 삭제하는 데이터 정의어(p311)

--test1(no, name, address, tel)
  --number(5), 문자열(20), 문자열(50), 문자열(20)
--테이블 생성하는 Create Table
create table test1(
no number(5),
name varchar2(20),
address VARCHAR2(50),
tel varchar2(20)
);

select * from test1;
---행 추가
--(1,'aaa') 추가 (no, name)
insert into test1(no, name) values(1,'aaa');
--(2,'bbb','부산', '010-111-2222') 추가
insert into test1(no, name, address, tel) values(2,'bbb','부산', '010-111-2222');
--(3,'ccc','서울', '010-333-4444') 추가
--모든 컬럼일 경우, 생략이 가능하다
insert into test1 values(3,'ccc','서울', '010-333-4444');

insert into test1 values(4,'ccc','인천'); -- 오류(값의 수가 충분하지 않음)
insert into  test1(no, name, address) values(4,'ccc','인천');

commit; -- 완료가 되도록 해줌 , 커밋하지 않으면 명령프롬프트 안에서는 확인이 불가능하다

insert into test1 values(3,'ccc','서울1', '010-3344-4455');
select * from test1;

rollback; -- 이전 상태로 다시 되돌려줌

-- 수정(변경)
-- no 2번인 사람의 이름을 홍길동으로 수정
update test1 set name  ='홍길동' where no =2;
commit;

-- no r가 4인 name을 test /adress 서울로 수정
update test1 
set name ='test',address ='서울' 
where no=4;
--삭제 
-- test1 에서 no 1번 삭제 
delete test1 where no =1;
delete from test1 where no=2;

delete from test1; -- 전체 삭제
select *from test1;
rollback;


--test 테이블 생성( no, name, hiredate) default 값 사용하기 -----------------------
create table test(
no number(3) default 0,
name VARCHAR2(20) default 'NO NAME',
hiredate date default sysdate
);
select * from test;
--test (1, 홍길동) 추가 
INSERT into test(no,name) values(1,'홍길동'); 
--test에 날짜 24/5/20 추가
INSERT into test(hiredate) values('24/5/20'); 

-- test에서 번호가 1번인 사람의 이름을 강감찬으로 수정
update test set name='강감찬' where no =1;
-- test에서 번호가 0인것을 삭제하고 번호가 2인 데이터를 추가
delete from test where no=0;
insert into test(no) values(2);
commit;
--CRUD (create, select, update, delete)
--p266(CTAS : create table as select) : select에 대한 값을 가지고 테이블을 만들어라
create table dept_temp as select * from dept;
select * from dept_temp;

--dept_temp 테이블에 50, DATABASE, SEOUL 추가 
insert into dept_temp(deptno, dname, loc) values( 50, 'DATABASE', 'SEOUL');
commit;
-- 테이블 구조만 복사
create table emp_temp
as select *from emp
where 1<>1; -- false값으로 테이블 구조만 가지고 온다
desc emp_temp;

select * from emp_temp;
-- emp_temp ; empno, ename, job, mgr, hiredate,sal, comm, deptno
-- 2111, '이순신' , 'MANAGER', 9999,'07/01/2019', 4000,NULL,20 추가

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(2111,'이순신','MANAGER',9999,to_date('07/01/2019','DD/MM/YYYY'),4000, NULL ,20);
-- 모든 데이터 삽입
insert into emp_temp
values(2111,'이순신2','MANAGER',9999,to_date('07/01/2019','DD/MM/YYYY'),4000, NULL ,20);

-- 3111,'강감찬','MANAGER',9999,4000,NULL,20 입사일은 오늘날자로 추가
insert into emp_temp
values(3111,'강감찬','MANAGER',9999,sysdate,4000,NULL,20);

--emp_temp 모든 사원 삭제
delete from emp_temp;
commit;

--p262 9장 연습 문제 
--1
select e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e , dept d
where e.deptno = d.deptno and job = (select job from emp where ename='ALLEN');

--2
select * from emp;
select * from dept;
select * from salgrade;

select empno, ename, d.dname, e.hiredate, d.loc, e.sal,s.grade
from emp e, dept d , salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal 
and e.sal>(select avg(sal) from emp)
order by sal desc , e.empno asc;

--3 
select e.empno,e.ename,e.job,e.deptno,d.dname,d.loc
from emp e, dept d
where e.deptno = d.deptno 
and e.deptno =10 
and job not in(select job from emp where deptno =30) ;

--4
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal 
and e.sal > (select max(sal) from emp where job='SALESMAN')
order by empno asc;

select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal 
and e.sal > all(select(sal) from emp where job='SALESMAN')
order by empno asc;
------------------------
--p275 서브쿼리를 이용해서 한번에 여러 데이터 추가(valuse 사용하지 않는다)
-- 급여 등급(salgrade)이 1인 사원만 emp_temp에 추가 
select *from emp_temp;
select *from salgrade;
select *from emp where sal between 700 and 1200;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp
where sal between 700 and 1200;
commit;
select * from emp_temp ;

delete from emp_temp;

--비등가조인 사용
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal and s.grade =1;
commit;
--dept 테이블을 복사해서 dept_temp2 테이블을 생성하고 
--40 번 부서명을 DATABASE 지역 SEOUL 수정
--
create table dept_temp2 as select * from dept;

--drop table dept_temp2;

update dept_temp2 set loc ='SEOUL' ,dname='DATABASE' where deptno=40;
select *from dept_temp2;
commit;

--
select *from emp_temp;
--7900번 사원 이름을 강감찬으로 수정하고 수정 확인 후 수정 취소
update emp_temp set ename = '강감찬' where empno = 7900;
rollback;
-- dept_temp2 테이블 40번 내용 수정하기
select * from dept_temp2;
select * from dept;
-- dept 테이블의 40번이 가지는 부서명과 지역으로 수정하기
--1
update dept_temp2 set dname = 'OPERATIONS',loc='BOSTON' where deptno=40;
--2
update dept_temp2 set dname =( select dname from dept where deptno =40),
loc =( select loc from dept where deptno =40)
where deptno=40;
--3
update dept_temp2
set(dname, loc) = (select dname, loc
                    from dept
                    where deptno =40)
where deptno =40;

rollback;
commit;

-- dept_temp2
delete from  dept_temp2;
select * from dept_temp2;-- 테이블은 존재
--테이블 삭제 
drop table dept_temp2;

-- dept 테이블 이용해서 dept_tmp 테이블 생성
create table dept_tmp
as select * from dept;

select *from dept_tmp;
--dept_tmp 테이블에 LOCATION 컬럼 추가
alter table dept_tmp
add (LOCATION varchar2(50));
-- 10번 부서의 location을 뉴욕으로 수정
update dept_tmp set location='뉴욕' where deptno =10;
commit;

--dept_tmp 테이블에 LOCATION 컬럼 변경  varchar2(70)
alter table dept_tmp 
modify(location varchar2(70));
desc dept_tmp;

-- location 컬럼 삭제 
alter table dept_tmp
drop column location;

-- 컬럼명 loc 를 location 으로 변경
alter table dept_tmp
rename column loc to location;
select *from dept_tmp;

--테이블 명 수정
rename dept_tmp to dept_tmptmp;
select *from dept_tmptmp;

--모든 데이터 삭제 
delete from dept_tmptmp;
rollback;
-- 모든 데이터 삭제 (truncate)(DDL:명령어): 롤백해도 데이터가 돌아오지 않음, 복구안됨
truncate table dept_tmptmp;
--테이블 삭제 
drop table dept_tmptmp;
-- p 287
create table chap10hw_emp as select *from emp;
create table chap10hw_dept as select *from dept;
create table chap10hw_salgrade as select *from salgrade;

select *  from chap10hw_dept;
--01
insert into chap10hw_dept(deptno, dname,loc) values(50,'ORACLE','BUSAN');
insert into chap10hw_dept(deptno, dname,loc) values(60,'SQL','ILSAN');
insert into chap10hw_dept(deptno, dname,loc) values(70,'SELECT','INCHEON');
insert into chap10hw_dept(deptno, dname,loc) values(80,'DML','BUNDANG');
commit;
--02
select *  from chap10hw_emp;
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7201,'TEST_USER1','MANAGER',7788,to_date('2016-01-02'),4500,50);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7202,'TEST_USER2','ClERK',7201,to_date('2016-02-21'),1800,50);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7203,'TEST_USER3','ANALYST',7201,to_date('2016-04-11'),3400,60);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate,sal,comm, deptno)
values(7204,'TEST_USER4','SALESMAN',7201,to_date('2016-05-31'),2700,300,60);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7205,'TEST_USER5','ClERK',7201,to_date('2016-07-20'),2600,60);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7206,'TEST_USER6','ClERK',7201,to_date('2016-09-08'),2600,70);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7207,'TEST_USER7','LECTURER',7201,to_date('2016-10-28'),2300,80);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7208,'TEST_USER8','LECTURER',7201,to_date('2018-03-09'),1200,80);

--03
select *  from chap10hw_emp;
update chap10hw_emp set deptno = 70 where sal > (select avg(sal) from chap10hw_emp where deptno=50);
commit;
--04
update chap10hw_emp set deptno =80 , sal = sal*1.1
where hiredate >(select min(hiredate) from chap10hw_emp where deptno=60);
commit;
--05
delete from chap10hw_emp where empno in (select empno from chap10hw_emp e, chap10hw_salgrade s 
where e.sal between s.losal and s.hisal and s.grade = 5); 
