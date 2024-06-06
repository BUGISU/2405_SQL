--1.���忡�� �ٹ��ϴ� ����� �̸��� �޿��� ����϶�
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

-- �Ŵ����� KING�� ������� �̸��� ������ ����϶�
select * from emp;
select ename, job
from emp
where mgr = (select empno from emp where ename = 'KING');
-- ��������
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
--��� ��� ��� (�ܺ�����)
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
-- SQL-99 ǥ��
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
--p234(join~on : ���� ���� ����ϴ� ���)
select e.empno, e.ename, e.sal, e.mgr, e.deptno, d.dname,d.loc
from emp e join dept d
            on e.deptno = d.deptno
where e.sal>200
order by deptno, e.empno;
-------
--��� �μ� ��� ==> ����̸�, �μ���ȣ �μ���
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
-- ��� ����� ������ ��� ==> ����̸�, �μ���ȣ, �μ���
select e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+)
order by e.deptno;

select e.ename, d.deptno, d.dname
from emp e left outer join dept d
            on e.deptno = d.deptno
order by e.deptno;

------p238
-- emp, dept �޿��� 3000�̻��̸� ���ӻ���� �ݵ�� �־����
-- �����ȣ, �̸� , ��å(job), mgr, hiredate, sal, comm, deptno, dname, loc
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

-- p242  ��������
--WARD ���� ������ ���� ���� ��� �̸� ���
select sal from emp where ename ='WARD';
select ename from emp where sal > 1250;

select ename 
from emp
where sal > (select sal
             from emp 
             where ename ='WARD');
--'ALLEN' �� ����(job)�� ���� ����� �̸�(enmae),�μ���(dname),
--                                �޿�(sal),����(job) ���             

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
-- ALLEN ���� ���� �Ի��� ����� ����  
select hiredate  from emp where ename = 'ALLEN';
select * from emp where hiredate < '81/02/20';

select * from emp
where hiredate < (select hiredate 
                    from emp
                    where ename = 'ALLEN');
  
  
-- ��ü ����� ��� �ӱݺ��� ���� ����� 
--�����ȣ(empno), �̸�(ename), �μ���(dname), �Ի���(hiredate) ���
select avg(sal) from emp;

select e.empno, e.ename, d.dname, e.hiredate, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.sal > (select avg(sal) from emp);
--p248
--��ü ����� ��� �޿����� �۰ų� ���� �޿��� �ް� �ִ�
-- 20�� �μ��� ��� �� �μ�����
--�����ȣ(empno), �̸�(ename), ����(job), �޿�(sal), 
--�μ���ȣ(deptno), �μ���(dname) ,�μ�����(loc)
select avg(sal) from emp;

select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname,d.loc
from emp e, dept d
where e.deptno = d.deptno
      and d.deptno=20
      and e.sal <= (select avg(sal) from emp);
      
-- �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ���
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
 --- 8�� �������� p239~240
 --1. �޿�(sal)�� 2000�ʰ��� ������� �μ�����, �������
--deptno, dname, empno, ename, sal(2���� ���)
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
--2.�μ���(�μ���ȣ, �μ���) ��� �޿�, �ִ�޿�, �ּұ޿�, ����� ���
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

--3. �μ���ȣ, ����̸� ������ ��� �μ������� ��� ���
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
--4.��� �μ�����, �������, �޿� �������, �� ����� ���� ����� ������ 
--�μ���ȣ, ��� ��ȣ ������ �����Ͽ� ���
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























