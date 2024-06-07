--1. emp 테이블에서 사원번호가 7369 인 사람 중 이름, 입사일, 부서번호를 출력하시오.
select ename 이름, hiredate 입사일, deptno 부서번호
from emp
where empno = 7369;

select * from emp;
delete from emp where ename='홍길동';

select deptno 부서번호, Round(avg(sal)) 평균급여, max(sal) 최고급여, min(sal) 최저급여 , COUNT(*)사원수
from emp
group by deptno; 

select rpad(substr(empno, 1,2),length(empno),'*') 사원번호
from emp;

select empno 사원번호, ename 사원이름, nvl2(mgr,to_char(mgr),'CEO') 상사
from emp;

select empno 사원번호, ename, job, decode(job, 'MANAGER', sal*1.5,
'SALESMAN',SAL*1.2, 'ANALST',sal *1.05, sal*1.04)인상_급여률
from emp;

select deptno, avg(sal)
from emp 
where sal>=1000
group by deptno
having avg(sal) >=2000;

select * from emp;
select * from dept;

select ename 사원이름
from emp
where deptno = (select deptno from emp where ename ='SMITH')and ename <> 'SMITH';

select e.ename 사원이름 , e.deptno 부서번호, d.dname 부서명
from emp  e, dept d
where e.deptno = d.deptno;

select deptno, max(sal)
from emp
group by deptno;

select *
from emp
where sal in (
select max(sal)
from emp
group by deptno
);

select decode(mod(empno,3),0,'A',
                    1,'B',
                    2,'C') teamName, ename, job, deptno
from emp;

select e.deptno 부서번호, d.dname 부서명 ,e.ename 사원이름
from emp e, dept d
where e.deptno = d.deptno;

select empno 사원번호, ename 사원이름, deptno 부서번호
from emp
where deptno =30;

create view view_emp_dept30 as ( 
select empno 사원번호, ename 사원이름, deptno 부서번호
from emp
where deptno =30);

select * from view_emp_dept30;

