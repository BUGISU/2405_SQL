--1.뉴욕에서 근무하는 사원의 이름과 급여를 출력하라
-- deptno10, dname/ACCOUNTING/ loc/ NEW YORK
select e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno
and d.loc = 'NEW YORK';

--join ~ on
select e.ename, e.sal
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'NEW YORK';

-- 매니저가 KING인 사원들의 이름과 직급을 출력하라
select * from emp;
select ename, job
from emp
where mgr = (select empno from emp where ename = 'KING');
-- 셀프조인
select e.ename, e.job
from emp e, emp m
where e.mgr = m.empno and m.ename = 'KING';
--join ~ on
select e.ename, e.job
from emp e join emp m
on e.mgr = m.empno and m.ename = 'KING';

--p229
select * from emp;
select e1.empno, e1.ename, e1.mgr, 
       e2.empno mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr = e2.empno;
--모든 사원 출력 (외부조인)
select e1.empno, e1.ename, e1.mgr, 
       e2.empno mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr = e2.empno(+);

select e1.empno, e1.ename, e1.mgr, 
       e2.empno mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr(+) = e2.empno
order by e1.empno;

--p232
select e.empno, e.ename, e.sal, e.mgr, e.deptno, d.dname,d.loc
from emp e, dept d
where e.deptno = d.deptno
     and e.sal>200
order by deptno, e.empno;
-- SQL-99 표준
select * from emp;
select * from dept;
----
select e.empno, e.ename, e.sal, e.mgr, deptno, d.dname,d.loc
from emp e NATURAL join dept d
where e.sal>200
order by deptno, e.empno;
--
select e.empno, e.ename, e.sal, e.mgr, deptno, d.dname,d.loc
from emp e join dept d USING(deptno)
where e.sal>200
order by deptno, e.empno;
--p234(join~on : 가장 많이 사용하는 방법)
select e.empno, e.ename, e.sal, e.mgr, e.deptno, d.dname,d.loc
from emp e join dept d
            on e.deptno = d.deptno
where e.sal>200
order by deptno, e.empno;
-------
--모든 부서 출력 ==> 사원이름, 부서번호 부서명
select * from dept;
select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno
order by e.deptno;

select e.ename, d.deptno, d.dname
from emp e right outer join dept d
            on e.deptno = d.deptno
order by e.deptno;

select e.ename, d.deptno, d.dname
from  dept d left outer join emp e
            on e.deptno = d.deptno
order by e.deptno;
------
-- 모든 사원의 정보를 출력 ==> 사원이름, 부서번호, 부서명
select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+)
order by e.deptno;

select e.ename, d.deptno, d.dname
from emp e left outer join dept d
            on e.deptno = d.deptno
order by e.deptno;

------p238
-- emp, dept 급여가 3000이상이며 직속상관이 반드시 있어야함
-- 사원번호, 이름 , 직책(job), mgr, hiredate, sal, comm, deptno, dname, loc
--join~using
select e.empno, e.ename, e.job ,e.mgr, e.hiredate, e.sal, e.comm, deptno,
       d.dname, d.loc
from emp e join dept d using(deptno)
where e.sal>=3000 and e.mgr is not null;

--natural join
select e.empno, e.ename, e.job ,e.mgr, e.hiredate, e.sal, e.comm, deptno,
       d.dname, d.loc
from emp e NATURAL join dept d 
where e.sal>=3000 and e.mgr is not null;

--join ~ on
select e.empno, e.ename, e.job ,e.mgr, e.hiredate, e.sal, e.comm, e.deptno,
       d.dname, d.loc
from emp e  join dept d
            on e.deptno = d.deptno
where e.sal>=3000 and e.mgr is not null;

-- p242  서브쿼리
--WARD 보다 월급이 많이 받은 사원 이름 출력
select sal from emp where ename ='WARD';
select ename from emp where sal > 1250;

select ename 
from emp
where sal > (select sal
             from emp 
             where ename ='WARD');
--'ALLEN' 의 직무(job)와 같은 사람의 이름(enmae),부서명(dname),
--                                급여(sal),직무(job) 출력             

select job
from emp
where ename ='ALLEN';

select e.ename, d.dname,  e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno and job = 'SALESMAN';

select e.ename, d.dname,  e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno
  and job =(
            select job
            from emp
            where ename ='ALLEN'
        );
        
select e.ename, d.dname,  e.sal, e.job
from emp e, dept d
where e.deptno = d.deptno
  and job =(
            select job
            from emp
            where ename ='ALLEN'
        )
  and e.ename <> 'ALLEN'   ; 
-- ALLEN 보다 일찍 입사한 사원의 정보  
select hiredate  from emp where ename = 'ALLEN';
select * from emp where hiredate < '81/02/20';

select * from emp
where hiredate < (select hiredate 
                    from emp
                    where ename = 'ALLEN');
  
  
-- 전체 사원의 평균 임금보다 많은 사원의 
--사원번호(empno), 이름(ename), 부서명(dname), 입사일(hiredate) 출력
select avg(sal) from emp;

select e.empno, e.ename, d.dname, e.hiredate, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.sal > (select avg(sal) from emp);
--p248
--전체 사원의 평균 급여보다 작거나 같은 급여를 받고 있는
-- 20번 부서의 사원 및 부서정보
--사원번호(empno), 이름(ename), 직무(job), 급여(sal), 
--부서번호(deptno), 부서명(dname) ,부서지역(loc)
select avg(sal) from emp;

select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname,d.loc
from emp e, dept d
where e.deptno = d.deptno
      and d.deptno=20
      and e.sal <= (select avg(sal) from emp);
      
-- 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
select deptno, max(sal)
from emp
group by deptno;

select *
from emp
where sal in (3000, 2850, 5000);

select *
from emp
where sal in (select max(sal)
                from emp
                group by deptno);
 --- 8장 연습문제 p239~240
 --1. 급여(sal)가 2000초과인 사원들의 부서정보, 사원정보
--deptno, dname, empno, ename, sal(2가지 방법)
select d.deptno,d.dname, e.empno, e.ename, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.sal>2000;

--natural ~ join 
select deptno,d.dname, e.empno, e.ename, e.sal
from emp e NATURAL join dept d
where e.sal > 2000;
--join~on
select d.deptno,d.dname, e.empno, e.ename, e.sal
from emp e  join dept d
            on e.deptno = d.deptno
where e.sal > 2000;
--2.부서별(부서번호, 부서명) 평균 급여, 최대급여, 최소급여, 사원수 출력
select  e.deptno, d.dname, 
        trunc(avg(sal)) as avg_sal,
        max(sal) as max_sal,
        min(sal) as min_sal , count(*) as cnt
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, d.dname;
--join~ using
select  deptno, d.dname, 
        trunc(avg(sal)) as avg_sal,
        max(sal) as max_sal,
        min(sal) as min_sal , count(*) as cnt
from emp e join dept d using(deptno)
group by deptno, d.dname;
--join~on
select  e.deptno, d.dname, 
        trunc(avg(sal)) as avg_sal,
        max(sal) as max_sal,
        min(sal) as min_sal , count(*) as cnt
from emp e join dept d
            on e.deptno = d.deptno
group by e.deptno, d.dname;

--3. 부서번호, 사원이름 순으로 출력 부서정보는 모두 출력
--+
select d.deptno, d.dname, e.empno, e.ename,e.job, e.sal
from emp e ,dept d
where e.deptno(+) = d.deptno
order by d.deptno, e.ename;
-- left  outer join
select d.deptno, d.dname, e.empno, e.ename,e.job, e.sal
from dept d left outer join  emp e 
            on e.deptno = d.deptno
order by d.deptno, e.ename;
--right outer join
select d.deptno, d.dname, e.empno, e.ename,e.job, e.sal
from emp e right outer join  dept d 
            on e.deptno = d.deptno
order by d.deptno, e.ename;
--4.모든 부서정보, 사원정보, 급여 등급정보, 각 사원의 직속 상관의 정보를 
--부서번호, 사원 번호 순서로 정렬하여 출력
--deptno, dname, empno, ename, mgr, sal, dptno_1, losal,hisal,
--grade, mgr_empno, mgr_ename
select *  from emp;
select * from dept;
select * from salgrade;

select d.deptno, d.dname, 
       e.empno, e.ename, e.mgr, e.sal, e.deptno,
       s.losal, s.hisal, s.grade,
       e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e, dept d, salgrade s, emp e2
where e.deptno(+) = d.deptno
      and e.sal between s.losal(+) and s.hisal(+)
      and e.mgr = e2.empno(+)
order by d.deptno, e.empno;
--join~on
select d.deptno, d.dname, 
       e.empno, e.ename, e.mgr, e.sal, e.deptno,
       s.losal, s.hisal, s.grade,
       e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e  right outer join  dept d on (e.deptno = d.deptno)
            left outer join salgrade s on (e.sal between s.losal and s.hisal)
            left outer join emp e2 on(e.mgr = e2.empno)
order by d.deptno, e.empno;























