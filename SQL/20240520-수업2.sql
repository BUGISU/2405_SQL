-- prefessor 테이블 사용
--1. 학과별(deptno) 교수들의 평균 급여
SELECT * from professor;
--2. 학과별 교수들의 합계 급여
SELECT deptno, avg(pay)
from professor
group by deptno;
--3. 학과별 직급별(postion)교수들의 평균 급여
SELECT deptno, sum(pay), count(*)
from professor
group by deptno, position;
-- 4.교수 중에서 급여(pay)와 보직수당 (bonus)를 합친 금액이 가장 많은 경우와 가장적은 경우 출력
-- 단, bonus 이 없는 교수의 급여는 0으로 계산, 급여는 소수점 둘째 자리에서 반올림
SELECT pay, bonus, nvl(pay+bonus,0)
from professor;
--
SELECT round(max(pay+nvl(pay+bonus,0)),1)
from professor;
--
SELECT round(max(pay+nvl(pay+bonus,0)),1)최대값,
round(min(pay+nvl(pay+bonus,0)),1)최소값
from professor;

select round(max(nvl(pay+bonus,0)),1) 최대값,
round(min(nvl(pay+bonus,0)),1) 최소값
from professor;

-- 직급별 평균 급여가 300보다 크면 '우수' 작거나 같으면 '보통'
-- 직급별 (posiotion), 평균급여, 비고 출력
SELECT position, round(avg(pay),1),
case 
    when avg(pay) >300 then '우수'
    when avg(pay) <= 300 then '보통'
end 비고
from professor
group by position;

--emp 테이블에서 입사일 년도별 인원수
--total 1980 1981 1982
--12    1    10   1
SELECT hiredate from emp;
select count(*) total, sum(decode(to_char(hiredate,'YYYY'),1980,1,0))"1980년도",
sum(decode(to_char(hiredate,'YYYY'),1980,1,0))"1981년도",
sum(decode(to_char(hiredate,'YYYY'),1980,1,0))"1982년도"
from emp;

--emp 테이블에서 1000 이상의 급여를 가지고 있는 사람들에 대해서만
--부서별 평균을 구하되, 부서별 평균의 2000이상인 부서번호, 부서별 평균 급여 출력
SELECT deptno, round(avg(sal))
from emp 
where sal>=1000 ;

SELECT deptno, round(avg(sal))
from emp
where sal>=1000
group by deptno
having avg(sal) >= 2000;

--professor 테이블에서 
--1. 학과별로 소속 교수들의 평균 급여, 최소급여, 최대 급여를 출력하여라 
--단, 평균 급여가 300이 넘는 것만 출력

SELECT *
from professor;

SELECT deptno,round(avg(pay)), min(pay),max(pay)
from professor
group by deptno
having round(avg(pay))>= 300;

-- 학과별 직급별 교수들의 평균 급여 중에서 평균 급여가 400이상인거 출력
--학과번호 직급 평균 급여

SELECT deptno,positon, round(avg(pay))
from professor
group by deptno, position
having avg(pay)>= 400;


--student 테이블에서 학생수가 4명 이상인 학년에 대해서 학년, 학생수, 평균키, 평균 몸무게를 출력
--단, 평균 키와 평균 몸무게는 소숫점 첫 번쨰 자리에ㅓㅅ 반올림하고, 
--출력순서는 평균키가 높은 순서부터 내림차순으로 출력

SELECT * from student;

-- 문제를 해결할때 실행순서를 잘 생각해서 명령문을 작성해야함 
--FROM 절 (+ Join)
--WHERE 절
--GROUP BY
--HAVING 절
--SELECT 절
--ORDER BY 절
--LIMIT 절

SELECT grade, count(*), round(avg(height),0) as height, round(avg(weight),0)
from student
group by grade
having count(*) >=4
order by height DESC;

--196p
SELECT deptno, job, count(*), max(sal), sum(sal), min(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job; 

--rollup각 부서에 대한 소계가 나옴
--rollup(A,B) A,B / A에 대한 것 출력, 각 부서에 대한 소계가 나옴
--rollup(A,B,C) A,B,C/ A,B/ A에 대한 것 출력, 각 부서에 대한 소계가 나옴

SELECT deptno, job, count(*), max(sal), sum(sal), min(sal), round(avg(sal))
from emp
group by rollup(deptno, job)
order by deptno, job; 

-- cube(a,b) a,b / a/ b 에 대한것 출력
-- cube(a,b,c) a,b,c/ a,b/ a,c/ b,c/ a/b/c 에 대해 출력
SELECT deptno, job, count(*), max(sal), sum(sal), min(sal), round(avg(sal))
from emp
group by cube(deptno, job)
order by deptno, job; 
-- 부서와 직업별, 평균 급여 및 사원수, 부서별 평균급여와 사원수,
--전체사원의 평균급여와 사원수
SELECT round(avg(sal)), count(*)
from emp
group by job, deptno;

SELECT deptno, job, round(avg(sal))as 평균급여, count(*)
from emp
group by rollup(job, deptno)
order by 평균급여 ;

SELECT deptno, job, round(avg(sal))as 평균급여, count(*)
from emp
group by cube(job, deptno)
order by 평균급여 ;

-- p215
-- 조인(join)
select *from emp; --12개
SELECT *from dept; -- 4개
--사원번호(empno), 사원이름(ename),job, 부서명(dname), loc
SELECT * from emp, dept; --48개

--join , 같은 열,deptno 연결해줌
-- 등가 조인
select *
from emp e, dept d
where e.deptno = d.deptno;

select empno, ename, job, dname, loc , e.deptno
from emp e, dept d
where e.deptno = d.deptno;

select * from emp ;
select * from salgrade;
-- 비등가 조인
SELECT *
from emp e, salgrade s
where e.sal  between s.losal and s.hisal;
--
SELECT * from emp; 

--자신의 상사(mgr) 의 이름 출력
SELECT *
from emp em1, emp em2
where em1.mgr = em2.empno;

--자체(self)조인
SELECT em1.empno, em1.ename, em1.mgr, em2.empno 상사회원번호, em2.ename 상사이름
from emp em1, emp em2
where em1.mgr = em2.empno;
--nvl2
-- emp 테이블에서 deptno가 30인 사원 조회,
--comm 값이 있ㅇ르 경우  'Exist'를
--comm 값으 null 인 경우 'null'을 출력
select empno, ename, comm ,nvl2(comm,'Exist','Null') 비고
from emp
where deptno =30;

--급여가 2500 이하이고 사번이 9999이하인 사우너의 정보를 출력
--사원번호(empno) 이름(ename), 급여(sal), 부서번호(deptno), 부서명(dname),부서지역(loc)
select* from dept;
select* from emp;

select empno, ename, sal, e.deptno, dname 부서명 , loc 부서지역
from emp e, dept d
where e.deptno = d.deptno and (sal<=2500 and empno<=9999);

--이름이  'ALLEN'인 사원의 부서명 출력
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and ename='ALLEN';

-- 급여가 3000에서 5000 사이인 직원의 이름과 소속 부서명을 출력
select e.ename 직원이름, d.dname 부서명, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.sal between 3000 and 5000;
-- SQL-99 표준 문법
SELECT  e.ename, d.dname, e.sal
from emp e join dept d
on e.deptno = d.deptno
and e.sal between 3000 and 5000;

-- 직급이 MANAGER 인 사원의 이름, 부서명, 출력
select e.ename, d.dname, e.sal
from  emp e, dept d
where e.deptno = d.deptno and e.job ='MANAGER';
-- SQL-99 표준 문법
select e.ename, d.dname, e.sal
from  emp e join dept d
on e.deptno = d.deptno
where e.job ='MANAGER';

--조인
--1.ACCOUNTING 부서 소속 사원의 이름과 입사일을 출력
select e.ename, e.hiredate
from emp e, dept d
where e.deptno = d.deptno and d.dname = 'ACCOUNTING';
--join ~on
select e.ename, e.hiredate
from emp e join dept d
on e.deptno = d.deptno
where d.dname = 'ACCOUNTING';

-- 0보다 많은 comm 을 받는 사원 이름과 부서명 출력
select e.ename, d.dname,comm
from emp e, dept d
where e.deptno = d.deptno and comm>0;
--join ~on
select e.ename, d.dname, comm
from emp e join dept d
on e.deptno = d.deptno
where comm<>0 and e.comm is not null;

--SMITH 동료
select * from emp;
select ename from emp 
where deptno =20 
and ename <>'SMITH';
--
select ename from emp 
where deptno =(select deptno from emp where ename ='SMITH')
and ename <>'SMITH';
--샐프 조인
select  friend.ename as "SMITH의 동료" from emp e, emp friend 
where e.deptno = friend.deptno
and e.ename='SMITH' and friend.ename <> 'SMITH';
--join ~ on
select  f.ename as "SMITH의 동료"
from emp e join emp f
on  e.deptno = f.deptno
where e.ename='SMITH' and f.ename <> 'SMITH';

--매니저가 KING 인 사원들의 이름과 직급을 출력하라
select *from emp;
select e.ename, e.job from emp e, emp m
where e.mgr = m.empno and m.ename ='KING';

select ename, job
from emp
where mgr = (select empno
from emp
where ename ='KING');


--1.뉴욕에서 근무하는 사원의 이름과 급여를 출력하라
select *from dept;
select *from emp;

SELECT ename , sal , d.loc
from emp e , dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK'; 

--join ~ on

SELECT e.ename , e.sal , d.loc
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'NEW YORK'; 

-- 매니저가 KING인 사원들의 이름과 직급을 출력하라
select m.ename
from emp m
where mgr = (select empno from emp where ename='KING');

select s.ename, s.job
from emp s , emp m
where s.mgr = m.empno and m.ename ='KING';




