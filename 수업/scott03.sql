--p177
--급여합계와  comm 합계
select sum(sal),sum(comm)
from emp;

select sal from emp;
select distinct(sal) from emp;
select count(sal) from emp;
select count(distinct(sal)) from emp;
select * from emp;
select count(*) from emp;
--부서번호가 30인 사원 수
select * from emp where deptno = 30;
select count(*)
from emp
where deptno = 30;
--comm 이 null 아닌 개수
select count(comm), count(*)
from emp
where comm  is not null;

select count(sal), count(distinct(sal)),count(all sal)
from emp;
desc emp;
-- 최대값
select sal from emp;
select max(sal) from emp;
--최소값
select min(sal) from emp;
select max(sal), min(sal) from emp;
--평균
select avg(sal) from emp;
--평균을 반올림해서(소수 첫번째까지 출력)
select round(avg(sal), 1) from emp;
--부서번호가 20인 사원의 입사일 중 가장 최근 입사일 출근
select max(hiredate)
from emp
where deptno=20;
--professor테이블에서 
select * from professor;
--1. 총 교수 수 출력
select count(*) from professor;

--2. 교수 급여 합계
select sum(pay) from professor;

--3. 교수 급여 평균
select avg(pay) from professor;

--4. 교수들 급여의 평균을 소수점 첫째 자리에서 반올림
select round(avg(pay)) from professor;
--5. 최고급여
select max(pay) from professor;

--6. 최저급여
select min(pay) from professor;

--7. 교수 중 최고 급여를 받는 사람의 이름과 급여 출력
select name, pay
from professor
where pay = 570;

select name, pay
from professor
where pay = (select max(pay) from professor);
--emp 테이블
--1. 10번 부서의 평균급여
select avg(sal) from emp where deptno=10;
-- 20번 부서의 평균급여
select avg(sal) from emp where deptno=20;
-- 30번 부서의 평균급여
select avg(sal) from emp where deptno=30;
---
select avg(sal) from emp where deptno=10
union
select avg(sal) from emp where deptno=20
union
select avg(sal) from emp where deptno=30;
--부서별 직원 평균 급여 출력(부서번호, 평균급여)
select deptno, round(avg(sal)) "부서별 평균급여"
from emp
group by deptno;
--부서별 직원 평균 급여 출력(부서번호, 평균급여) 부서별 오름차순 출력
select deptno, round(avg(sal)) "부서별 평균급여"
from emp
group by deptno
order by deptno;
-- 부서번호 및 직책(job) 별 평균급여, 부서번호 내림차순, job오름차순 출력
select deptno,job, avg(sal)
from emp
group by deptno, job
order by deptno desc,job asc;

-- emp 테이블에서 부서번호 및 직책(job) 별 평균급여, 부서번호 내림차순, 높은 급여 순으로 출력
select deptno, job, avg(sal)
from emp
group by deptno, job
order by deptno desc, avg(sal) desc;

select deptno, job, avg(sal) avgsal
from emp
group by deptno, job
order by deptno desc, avgsal desc;
----professor 테이블 사용
select * from professor;
--1. 학과별(deptno) 교수들의 평균 급여
select deptno, round(avg(pay))
from professor
group by deptno; 

-- 2. 학과별 교수들의  급여 합계
select deptno, sum(pay),count(*)
from professor
group by deptno; 

--3. 학과별 직급별(posotion) 교수들의 평균 급여
select deptno, position, round(avg(pay))
from professor
group by deptno, position
order by deptno;

--4. 교수 중에서 급여(pay)와 보직수당(bonus)을 합친 금액이 가장 많은 경우와
-- 가장 적은 경우  출력
-- 단,  bonus 이 없는 교수의 급여(bonus)는 0으로 계산, 급여는 소수점 둘째 자리에서 반올림
select pay, nvl(bonus,0), pay+nvl(bonus,0)
from professor;
--
select round(max(pay+nvl(bonus,0)),1)최대값,
       round(min(pay+nvl(bonus,0)),1)최소값
from professor;
-------------------
select pay, bonus, nvl(pay+bonus,0)
from professor;

select round(max(nvl(pay+bonus,0)),1) 최대값,
        round(min(nvl(pay+bonus,0)),1) 최소값
from professor;
--5.직급별 평균 급여가 300보다 크면 '우수' 작거나 같으면 '보통'
  --- 직급별(position), 평균급여, 비고 출력
select position, round(avg(pay),1),
    case 
        when avg(pay) > 300 then '우수'
        when avg(pay) <= 300 then '보통'
    end 비고
from professor
group by position;
-----
--emp 테이블에서 입사일 년도별 인원 수 
-- total 1980  1981   1982
--  12     1    10     1
select hiredate from emp;
select count(*) total, 
       sum(decode(to_char(hiredate,'YYYY'),1980,1,0)) "1980년도",
       sum(decode(to_char(hiredate,'YYYY'),1981,1,0)) "1981년도",
       sum(decode(to_char(hiredate,'YYYY'),1982,1,0)) "1982년도"
from emp;
--emp 테이블에서 1000 이상의 급여를 가지고 있는 사람들에 대해서만
-- 부서별 평균을 구하되, 부서별 평균이 2000 이상인 부서번호, 부서별 평균급여 출력
select *
from emp
where sal >=1000;

select deptno, round(avg(sal))
from emp
group by deptno;

select deptno, round(avg(sal))
from emp
where sal >=1000
group by deptno
having avg(sal) >=2000;

select deptno, round(avg(sal))
from emp
group by deptno
having avg(sal) >=2000;

select sal from emp where deptno = 30;
---
-- professor 테이블에서 
--1. 학과별로 소속 교수들의 평균 급여, 최소 급여, 최대 급여를 출력하여라.
-- 단, 평균급여가 300인 넘는 것만 출력

select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by deptno;

select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by deptno
having  avg(pay) > 300;

--2. 학과별(deptno) 직급별(position) 교수들의 평균 급여 중에서 평균 급여가 400이상인거 출력
-- 학과번호 직급 평균급여
select deptno, position, round(avg(pay))
from professor
group by deptno, position;

select deptno, position, round(avg(pay))
from professor
group by deptno, position
having avg(pay) >=400;

--student 테이블에서 
--3. 학생 수가 4명 이상인 학년에 대해서 학년, 학생 수, 평균 키, 평균 몸무게를 출력
--단, 평균 키와 평균 몸무게는 소숫점 첫 번째 자리에서 반올림하고,
--출력순서는 평균 키가 높은 순부터 내림차순으로 출력하여라.
select * from student;
select grade, count(*), round(avg(height)) 평균키, round(avg(weight)) 평균몸무게
from student
group by grade
having  count(*)>=4
order by  평균키 desc;
--p196
select deptno, job, count(*), max(sal), sum(sal), min(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job;

--rollup(A,B,C)  A,B,C / A,B/  A 에 대한 거 출력
--rollup(A,B) A,B/ A 에 대한 거 출력
select deptno, job, count(*), max(sal), sum(sal), min(sal), round(avg(sal))
from emp
group by rollup(deptno, job)
order by deptno, job;

--cube(A,B,C)  A,B,C/ A,B / A,C/ B,C/ A/B/C  에 대한 거 출력
--cube(A,B) A,B/ A / B 에 대한 거 출력
select deptno, job, count(*), max(sal), sum(sal), min(sal), round(avg(sal))
from emp
group by cube(deptno, job)
order by deptno, job;
-- 부서와 직업별 평균급여 및 사원수, 부서별 평균급여와 사원수 , 전체사원의 평균급여와 사원 수
select deptno,job,round(avg(sal)), count(*)
from emp
group by deptno, job;

select deptno,job, round(avg(sal)), count(*)
from emp
group by rollup(deptno, job)
order by deptno;

-- 조인 p215
select * from emp;
select * from dept;
-- 사원번호(empno), 사원이름(ename), job, 부서명(dname), loc
select *
from emp, dept;

select *
from emp e, dept d
where e.deptno = d.deptno;

select empno, ename, job, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

----
select * from emp;
select * from salgrade;
--비등가조인
select *
from emp e, salgrade s
where e.sal between s.losal and s.hisal;
-----
select * from emp;
-- 자신의 상사(mgr)의 이름 출력
select *
from emp e1, emp e2
where e1.mgr = e2.empno;

--자체조인(셀프조인)
select e1.empno, e1.ename, e1.mgr, e2.empno  상사회원번호, e2.ename 상사이름
from emp e1, emp e2
where e1.mgr = e2.empno;
--nvl2
-- emp 테이블에서 deptno가 30 사원 조회
--comm 값이 있을 경우 'Exist' 을
--comm 값이  null 경우 'Null' 출력
select empno, ename, comm,nvl2(comm, 'Exist' ,'Null') 비고
from emp
where deptno=30;
--급여가 2500이하이고 사번이 9999 이하인 사원의 정보를 출력
-- 사원번호(empno), 이름(ename), 급여(sal), 부서번호(deptno), 부서명(dname), 부서지역(loc)
select empno, ename, sal, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno and sal<=2500 and  empno <=9999; 
-- 이름이 'ALLEN' 인 사원의 부서명 출력
select * from emp where ename ='ALLEN';
select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno and ename ='ALLEN';
-- 1. 급여가 3000 에서 5000사이인 직원의 이름과 소속 부서명을 출력
select e.ename, d.dname, e.sal
from emp e, dept d
where e.deptno = d.deptno 
    and e.sal between 3000 and 5000;
 --SQL-99 표준문법
select e.ename, d.dname, e.sal
from emp e join dept d 
           on e.deptno = d.deptno 
where e.sal  between 3000 and 5000;

select e.ename, d.dname, e.sal
from emp e join dept d
           on e.deptno = d.deptno 
and e.sal  between 3000 and 5000;
    
--2. 직급이 MANAGER인 사원의 이름, 부서명을 출력하라
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.job ='MANAGER';
 --SQL-99 표준문법
 select e.ename, d.dname
 from emp e join dept d
            on e.deptno = d.deptno 
 where  e.job ='MANAGER';
 --7장 연습문제 p212~213
 --1. emp 테이블/ 부서번호, 평균급여, 최고급여, 최저급여, 사원수 출력
--단, 평균급여는 소수점 제외, 각 부서번호별 출력
select deptno, round(avg(sal)),trunc(avg(sal)) avg_sal, 
       max(sal)max_sal, min(sal) min_sal, count(*) cnt
from emp
group by deptno;
--2, 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수
select job, count(*)
from emp
group by job
having count(*) >=3;
--3. 사원들의 입사연도를 기준으로 부서별로 몇명이 입사했는지 출력
select to_char(hiredate, 'YYYY') HIRE_YEAR, deptno, count(*) CNT
from emp
group by  to_char(hiredate, 'YYYY'),deptno;
--4. 추가수당(comm)받는 사원 수와 받지 않는 사원 수 출력
select nvl2(comm, 'O','X') EXIST_COMM, count(*) CNT
from emp
group by nvl2(comm, 'O','X'); 
--5. 각 부서의 입사연도별 사원수, 최고급여, 급여 합, 평균 급여 출력하고
-- 각 부서별 소계와 총계 출력
select deptno,  to_char(hiredate,'YYYY') HIRE_YEAR,
       count(*) CNT,
       max(sal) MAX_SAL,
       sum(sal) SUM_SAL,
       round(avg(sal),1) AVG_SAL
from emp
group by rollup(deptno, to_char(hiredate,'YYYY'))
order by deptno;

select deptno,  to_char(hiredate,'YYYY') HIRE_YEAR,
       count(*) CNT,
       max(sal) MAX_SAL,
       sum(sal) SUM_SAL,
       round(avg(sal),1) AVG_SAL
from emp
group by rollup(to_char(hiredate,'YYYY'),deptno)
order by HIRE_YEAR;
--조인
--1. ACCOUNTING 부서 소속 사원의 이름과 입사일을 출력
select ename, hiredate
from emp;
select dname from dept;
----
select ename, hiredate
from emp e, dept d
where e.deptno = d.deptno and d.dname ='ACCOUNTING';

--join~on
select ename, hiredate
from emp e join dept d on e.deptno = d.deptno
  where d.dname ='ACCOUNTING';


--2. 0보다 많은  comm 을 받는 사원 이름과 부서명 출력
select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno and e.comm > 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno 
and e.comm is not null
and e.comm > 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno 
and e.comm is not null
and e.comm <> 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno 
and e.comm <> 0;

--join~on
select e.ename, d.dname
from emp e join dept d
 on e.deptno = d.deptno
 and e.comm is not null
 and e.comm > 0;
 
select e.ename, d.dname
from emp e join dept d
 on e.deptno = d.deptno
 where e.comm is not null
 and e.comm > 0;
-- SMITH 동료
select * from emp;
select ename from emp 
where deptno=20 
and ename <> 'SMITH';
------
select ename from emp 
where deptno=(select deptno from emp where ename ='SMITH') 
and ename <> 'SMITH';
---셀프조인
select friend.ename   as "SMITH 동료"
from emp e, emp friend
where e.deptno = friend.deptno
and e.ename = 'SMITH' and friend.ename <> 'SMITH';
--join ~ on
select f.ename as "smith동료"
from emp e join emp f
     on e.deptno = f.deptno
     where   e.ename = 'SMITH' and f.ename <> 'SMITH';
     
-- 매니저가 KING인 사원들의 이름과 직급을 출력하라
select * from emp;

select e.ename, e.job, e.mgr
from emp e, emp m
where e.mgr = m.empno and m.ename = 'KING';

select ename, job
from emp
where mgr = (select empno
            from emp
            where ename ='KING');

 


 
 









    
    
















