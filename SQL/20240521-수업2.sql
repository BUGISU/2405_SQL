------------------ p229
SELECT * from emp;
select e1.empno, e1.ename, e1.mgr,
    e2.ename mgr_empno, e2.ename mgr_ename
from emp e1, emp e2
where e1.mgr = e2.empno;

--��� ��� ���(�ܺ�(+)����)
--NULL������ ǥ�����ִ� ���� �ܺ������̶�� �Ѵ�
--NULL�� ���� �ʿ� (+)�� �ٿ��ش�
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

------------------- p232 ǥ�� SQL-99 ǥ��
select e.empno, e.ename, e.sal, e.mgr, e.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
and  e.sal>200
order by deptno, e.empno;

--SQL-99 ǥ��
select * from emp;
select *from dept;
--NATURAL join ������� �ϳ� ���̴� 
-- deptno ������� �ϰ͵� ���̸� �ȵ� e.deptno(X)
select  e.empno, e.ename, e.sal, e.mgr, deptno, d.dname, d.loc
from emp e NATURAL join dept d
where e.sal>200
order by deptno, e.empno;
--join~using
select  e.empno, e.ename, e.sal, e.mgr, deptno, d.dname, d.loc
from emp e join dept d using(deptno)
where e.sal>200
order by deptno, e.empno;
--join~on :���� ���� ����ϴ� ���
select  e.empno, e.ename, e.sal, e.mgr, e.deptno, d.dname, d.loc
from emp e join dept d 
on e.deptno =  d.deptno
where e.sal>200
order by deptno, e.empno;
-------------------------------------
select * from emp;
select * from dept;
--��� �μ� ��� ����̸�, �μ���ȣ, �μ���
select e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno
order by e.deptno;
-- right outer join /left outer join
-- ������ ���������� ���������� ���� ��ɾ �޶���
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
-- ��� ����� ������ �� ��� => ����̸�, �μ���ȣ, �μ���
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
--emp ,dept �޿��� 3000 �̻��̸� ���ۻ���� �ݵ�� �־����
--�����ȣ , �̸�, ��å(job), mgr, hiredate. sal, comm, deptno, dname, loc
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

--p242 ��������
--WARD ���� ������ ���� �޴� ��� �̸� ���
select sal from emp where ename ='WARD';
select ename from emp where sal>1250;
--�ΰ��� ���� ��ġ�� 
select ename from emp 
where sal >(select sal from emp where ename ='WARD');

--ALLEN �� ����(job)�� ���� ����� �̸�(ename), �μ���(dname), 
-- �޿� (sal), ����(job) ���
select ename, d.dname, sal, job
from emp e, dept d
where e.deptno = d.deptno 
    and job = (
    select job from emp where ename = 'ALLEN'
    ) 
    and e.ename <> 'ALLEN';
--ALLEN ���� ���� �Ի��� ����� ����
--81/02/20
select hiredate from emp where ename ='ALLEN';
select * 
from emp
where emp.hiredate >(select hiredate from emp where ename ='ALLEN')
order by emp.hiredate;
--��ü ����� ��� �ӱݺ��� ���� �����
--�����ȣ(empno), �̸�(ename), �μ���(dname), �Ի���(hiredate) ���
select * from emp;

select  empno, ename, d.dname, hiredate
from emp e, dept d
where e.deptno = d.deptno and sal > (select avg(sal) from emp);

--p248
--��ü ����� ��� �޿����� �۰ų� ���� �޿� �ް� �ִ� 
--20�� �μ��� ��� �� �μ�����
--�����ȣ(empno), �̸�(ename), ����(job), �޿�(sal)
--�μ���ȣ(deptno), �μ���(dname) , �μ�����(loc)
select empno, ename, job, sal, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
    and e.sal <= (select avg(sal) from emp)
    and d.deptno =20;

-- �� �μ���(deptno) �ְ� �޿��� ������ �޿��� �޴� ��� ���� ���
select max(sal) from emp group by deptno;
select *
from emp  
where sal in (select max(sal) from emp group by deptno);
--where sal in (3000,5000,2850);



