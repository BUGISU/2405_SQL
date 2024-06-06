
--7장 연습문제 p212~213
--1번 
select * from emp;

select deptno, round(avg(sal))AVG_SAL , max(sal)MAX_SAL, min(sal)MIN_SAL, count(*)CNT
from emp
group by deptno
order by deptno DESC;

--2번
select job, count(*)
from emp
group by job
having count(*) >=3;
--3번
select to_char(hiredate,'YYYY') HIRE_YEAE, deptno, count(*)CNT
from emp 
group by deptno, to_char(hiredate,'YYYY');
--4
select * from emp;
select nvl2(comm,'O','X') EXIST_COMM ,count(*)CNT
from emp
group by nvl2(comm,'O','X');

--5
select deptno,nvl(to_char(hiredate,'YYYY'),' ') HIRE_YEAE,
count(*) CNT, max(sal) MAX_SAL, sum(sal) SUM_SAL, avg(sal) AVG_SAL
from emp
group by rollup(deptno , to_char(hiredate,'YYYY'))
order by deptno;