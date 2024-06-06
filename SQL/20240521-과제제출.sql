--p239
select * from emp;
select * from dept;

--1.
select e.deptno, d.dname,e.empno, e.ename,e.sal
from emp e,dept d
where e.deptno  = d.deptno and sal>2000;
--
select e.deptno, d.dname,e.empno, e.ename,e.sal
from emp e join dept d
on  e.deptno  = d.deptno
where sal>2000;

--2.
select e.deptno, d.dname,round(avg(e.sal))AVG_SAL,max(e.sal)MAX_SAL, min(e.sal) MIN_SAL, count(e.deptno)CNT
from emp e,dept d
where e.deptno = d.deptno
group by e.deptno ,d.dname;

select e.deptno, d.dname,round(avg(e.sal))AVG_SAL,max(e.sal)MAX_SAL, min(e.sal) MIN_SAL, count(*)CNT
from emp e join dept d
on e.deptno = d.deptno
group by e.deptno ,d.dname;

--3
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e , dept d
where e.deptno(+) = d.deptno
order by e.deptno, e.ename;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e right OUTER join dept d
on e.deptno = d.deptno
order by e.deptno, e.ename;

--4
select * from emp;
select * from dept;
SELECT * from salgrade;

select d.deptno,d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno
    ,s.losal LOSAL, s.hisal HISAL,s.grade, e.empno MGR_EMPNO,e2.ename MGR_ENAME 
from emp e, dept d, salgrade s, emp e2
where e.deptno(+) = d.deptno 
    and e.sal between s.losal(+) and s.hisal(+)
    and e.mgr = e2.empno(+)
order by d.deptno, e.empno;

-- join~on
select d.deptno,d.dname, e.empno, e.ename, e.mgr, e.sal, e.deptno
    ,s.losal LOSAL, s.hisal HISAL,s.grade, e.empno MGR_EMPNO,e2.ename MGR_ENAME 
from emp e 
    right outer join dept d on e.deptno = d.deptno
    --full outer join salgrade s on e.sal between s.losal and s.hisal
    left outer join salgrade s on e.sal between s.losal and s.hisal
    left outer join emp e2 on e.mgr = e2.empno
order by d.deptno, e.empno;

