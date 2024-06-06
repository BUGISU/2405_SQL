--p177
--급여 합계(sum)와 comm 합계
select sum(sal), sum(comm)
from emp;
select comm
fromm emp;

--갯수(count) 확인하기
select sal from emp;
-- 행의 갯수를 세어줌
select count(sal) from emp;
--distinct 중복값을 카운트 하지 않는다
select count(distinct(sal)) from emp;
select *from emp;
select count(*) from emp;
--부서번호가 30인 사원 수
select count(empno)
from emp
where deptno = 30;

--comm 이 null이 아닌 개수 
select count(comm)
from emp
where comm is not null;

select count(sal), count(distinct(sal)), count(all sal)
from emp;

select sal from  emp;
--최대값
select max(sal) from emp;
--최소값
select min(sal) from emp;
select max(sal), min(sal) from emp;
-- 평균,반올림해서(소수 첫째까지 출력)
select round(avg(sal),1) from emp;

--부서 번호가 20인 사원의 입사일 중 가장 최근 입사일 출근
select max(hiredate)
from emp
where deptno= 20;
--professor 테이블에서 

--1. 총 교수 수 출력
select count(name), from professor; 

--2. 교수 급여 합계
select sum(pay) from professor;
--3. 급여 평균
select count(name),  from professor; 
--4. 교수들 급여의 평균을 소수점 첫째자리에서 반올림
select round(avg(pay)) from professor; 
--5. 최고 급여
select round(max(pay)) from professor; 
--6. 최저 급여
select round(min(pay)) from professor; 
--7. 교수 중 최고 급여를 받는 사람의 이름과 급여 출력
select name, pay
from professor
where pay = 570;
-- -- 10번 부서의 평균 급여
select avg(sal) from emp where deptno =10;
-- 20번 부서의 평균 급여 
select avg(sal) from emp where deptno =20;
-- 30번 부서의 평균 급여
select avg(sal) from emp where deptno =30;
--
select avg(sal) from emp where deptno =10
union
select avg(sal) from emp where deptno =20
union
select avg(sal) from emp where deptno =30;

--부서별 직원 평균 급여 출력(부서번호, 평균 급여) 부서별 오름차순 출력
select deptno, round(avg(sal))
from emp
group by deptno
order by deptno;
--부서번호 및 직책 (job) 별 평균급여, 부서번호 내림차순, job 오름차순
select deptno,job,avg(sal) 
from emp
group by deptno, job
order by deptno desc, job asc;

--emp 테이블에서 부서번호 및 직책(job) 별 평균급여 , 부서번호 내림차순, 높은 급여 순으로 출력
select deptno, job , avg(sal)
from emp
group by deptno, job
order by deptno , avg(sal) desc;
