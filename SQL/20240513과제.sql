--p125~126
--1. 
SELECT ename
from emp
where ename like '%S';
--02
SELECT empno, ename, job, sal, deptno
from emp
where deptno =30 and job ='SALESMAN';
--03
SELECT empno, ename, job, sal, deptno
from emp
where deptno =20 and sal >2000
union
SELECT empno, ename, job, sal, deptno
from emp
where deptno =30 and sal >2000;

SELECT empno, ename, job, sal, deptno
from emp
where deptno in(20,30) and sal >2000;
--04
SELECT *
from emp
where sal <= 2000 and sal >=3000;

--05
SELECT ename,empno, sal, deptno
from emp
where ename like '%E%' and deptno = 30 and sal between 1000 and 2000;

--06
SELECT *
from emp
where comm is null and job in( 'MANAGER','CLEARK') and ename not like ('_L%')