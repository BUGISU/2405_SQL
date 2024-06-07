--01. emp 테이블에서 사원번호가 7369 인 사람 중 이름, 입사일, 부서번호를 출력하시오.
select ename 이름, hiredate 입사일, deptno 부서번호
from emp
where empno = 7369;
--02
select deptno 부서번호,trunc(avg(sal)) 평균급여, 
max(sal) 최고급여, min(sal) 최저급여 , COUNT(*)사원수
from emp
group by deptno; 

select rpad(substr(empno, 1,2),4,'*') 사원번호
from emp;

select empno 사원번호, ename 사원이름, nvl(to_char(mgr),'CEO') 상사
from emp;

--05
--decode
select empno 사원번호, ename, job,
decode(job,'MANAGER', sal*1.5,
        'SALESMAN',SAL*1.2,
        'ANALYST',sal *1.05, sal*1.04)인상_급여률
from emp;

--case when
select empno 사원번호, ename, job,
    case job
    when 'MANAGER' then sal*1.5
    when 'SALESMAN' then SAL*1.2
    when 'ANALYST' then sal *1.05
    else sal*1.04
    end as 인상_급여률
from emp;
--06
select deptno, round(avg(sal))
from emp 
where sal>=1000
group by deptno
having avg(sal) >=2000;

select * from emp;
select * from dept;
--07
select ename 사원이름
from emp
where deptno = (select deptno from emp where ename ='SMITH') and ename <> 'SMITH';
--셀프 조인
select f.ename as  "SMITH 동료"
from emp e1, emp f
where e1.deptno = f.deptno and e1.ename='SMITH'
and f.ename <> 'SMITH';
--join ~ on
select f.ename as  "SMITH 동료"
from emp  e join emp f
on e.deptno = f.deptno
and e.ename = 'SMITH' and f.ename <> 'SMITH';

--08
select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;

select e.ename, d.deptno, d.dname
from emp e right outer join dept d
on e.deptno =d.deptno;

select e.ename, d.deptno, d.dname
from dept d left outer join emp e
on e.deptno =d.deptno;
-- 09
select *
from emp
where sal in ( select max(sal)
                from emp
                group by deptno );

--10
--decode
select decode( mod(empno,3),0,'A 팀',
                    1,'B 팀',
                    2,'C 팀') teamName, ename, job, deptno
from emp;
--case when
select
case mod(empno,3)
when 0 then 'A 팀'
when 1 then 'B 팀'
when 2 then 'C 팀'
end teamName, ename, job, deptno
from emp;

--11
select e.deptno 부서번호, d.dname 부서명 ,e.ename 사원이름
from emp e, dept d
where e.deptno = d.deptno;

--12
create or replace view view_emp_dept30 as ( 
select empno 사원번호, ename 사원이름, deptno 부서번호
from emp
where deptno =30);

select * from view_emp_dept30;

