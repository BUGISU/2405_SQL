------------------ p229
SELECT * from emp;
select e1.empno, e1.ename, e1.mgr,
    e2.ename mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr = e2.empno;

--모든 사원 출력(외부(+)조인)
--NULL값까지 표현해주는 것을 외부조인이라고 한다
--NULL이 들어가는 쪽에 (+)를 붙여준다
select e1.empno, e1.ename, e1.mgr,
    e2.ename mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr = e2.empno(+);
--
select e1.empno, e1.ename, e1.mgr,
    e2.ename mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr(+) = e2.empno
order by e1.empno;

------------------- p232 표준 SQL-99 표준
select e.empno, e.ename, e.sal, e.mgr, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and  e.sal>200
order by deptno, e.empno;

--SQL-99 표준
select * from emp;
select *from dept;
--NATURAL join 연결고리가 하나 뿐이다 
-- deptno 연결고리에 암것도 붙이면 안됨 e.deptno(X)
select  e.empno, e.ename, e.sal, e.mgr, deptno, d.dname, d.loc
from emp e NATURAL join dept d
where e.sal>200
order by deptno, e.empno;
--join~using
select  e.empno, e.ename, e.sal, e.mgr, deptno, d.dname, d.loc
from emp e join dept d using(deptno)
where e.sal>200
order by deptno, e.empno;
--join~on :가장 많이 사용하는 방법
select  e.empno, e.ename, e.sal, e.mgr, e.deptno, d.dname, d.loc
from emp e join dept d 
on e.deptno =  d.deptno
where e.sal>200
order by deptno, e.empno;
-------------------------------------
select * from emp;
select * from dept;
--모든 부서 출력 사원이름, 부서번호, 부서명
select e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno
order by e.deptno;
-- right outer join /left outer join
-- 기준이 오른쪽인지 왼쪽인지에 따라서 명령어가 달라짐
select e.ename, e.deptno, d.dname
from emp e right outer join dept d
on e.deptno = d.deptno
order by e.deptno;

select e.ename, e.deptno, d.dname
from  dept d left outer join emp e
on e.deptno = d.deptno
order by e.deptno;

-------------------------------------
select * from emp;
select * from dept;
-- 모든 사원의 정보를 다 출력 => 사원이름, 부서번호, 부서명
select e.ename, e.deptno, d.dname
from emp e, dept d 
where e.deptno = d.deptno(+);

select e.ename, e.deptno, d.dname
from   emp e left outer join dept d
on e.deptno = d.deptno
order by e.deptno;

--p238
select * from emp;
select * from dept;
--emp ,dept 급여가 3000 이상이며 직송상관이 반드시 있어야함
--사원번호 , 이름, 직책(job), mgr, hiredate. sal, comm, deptno, dname, loc
select e.empno,e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno,d.loc
from emp e, dept d 
where e.deptno = d.deptno and e.sal >=3000 and e.mgr is not null;
--join using
select e.empno,e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno,d.loc
from emp e join dept d using(deptno) 
where e.sal >=3000 and e.mgr is not null;
--natural join
select e.empno,e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, deptno,d.loc
from emp e natural join dept d
where e.sal >=3000 and e.mgr is not null;
--join on
select e.empno,e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno,d.loc
from emp e join dept d
on e.deptno = d.deptno
where e.sal >=3000 and e.mgr is not null;

--p242 서브쿼리
--WARD 보다 월급이 많이 받는 사원 이름 출력
select sal from emp where ename ='WARD';
select ename from emp where sal>1250;
--두개의 구문 합치기 
select ename from emp 
where sal >(select sal from emp where ename ='WARD');

--ALLEN 의 직무(job)와 같은 사람의 이름(ename), 부서명(dname), 
-- 급여 (sal), 직무(job) 출력
select ename, d.dname, sal, job
from emp e, dept d
where e.deptno = d.deptno 
    and job = (
    select job from emp where ename = 'ALLEN'
    ) 
    and e.ename <> 'ALLEN';
--ALLEN 보다 일찍 입사한 사원의 정보
--81/02/20
select hiredate from emp where ename ='ALLEN';
select * 
from emp
where emp.hiredate >(select hiredate from emp where ename ='ALLEN')
order by emp.hiredate;
--전체 사원의 평균 임금보다 많은 사원의
--사원번호(empno), 이름(ename), 부서명(dname), 입사일(hiredate) 출력
select * from emp;

select  empno, ename, d.dname, hiredate
from emp e, dept d
where e.deptno = d.deptno and sal > (select avg(sal) from emp);

--p248
--전체 사원의 평균 급여보다 작거나 같은 급여 받고 있는 
--20번 부서의 사원 및 부서정보
--사원번호(empno), 이름(ename), 직무(job), 급여(sal)
--부서번호(deptno), 부서명(dname) , 부서지역(loc)
select empno, ename, job, sal, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
    and e.sal <= (select avg(sal) from emp)
    and d.deptno =20;

-- 각 부서별(deptno) 최고 급여와 동일한 급여를 받는 사원 정보 출력
select max(sal) from emp group by deptno;
select *
from emp  
where sal in (select max(sal) from emp group by deptno);
--where sal in (3000,5000,2850);



