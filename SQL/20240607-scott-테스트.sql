--01. emp ���̺��� �����ȣ�� 7369 �� ��� �� �̸�, �Ի���, �μ���ȣ�� ����Ͻÿ�.
select ename �̸�, hiredate �Ի���, deptno �μ���ȣ
from emp
where empno = 7369;
--02
select deptno �μ���ȣ,trunc(avg(sal)) ��ձ޿�, 
max(sal) �ְ�޿�, min(sal) �����޿� , COUNT(*)�����
from emp
group by deptno; 

select rpad(substr(empno, 1,2),4,'*') �����ȣ
from emp;

select empno �����ȣ, ename ����̸�, nvl(to_char(mgr),'CEO') ���
from emp;

--05
--decode
select empno �����ȣ, ename, job,
decode(job,'MANAGER', sal*1.5,
        'SALESMAN',SAL*1.2,
        'ANALYST',sal *1.05, sal*1.04)�λ�_�޿���
from emp;

--case when
select empno �����ȣ, ename, job,
    case job
    when 'MANAGER' then sal*1.5
    when 'SALESMAN' then SAL*1.2
    when 'ANALYST' then sal *1.05
    else sal*1.04
    end as �λ�_�޿���
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
select ename ����̸�
from emp
where deptno = (select deptno from emp where ename ='SMITH') and ename <> 'SMITH';
--���� ����
select f.ename as  "SMITH ����"
from emp e1, emp f
where e1.deptno = f.deptno and e1.ename='SMITH'
and f.ename <> 'SMITH';
--join ~ on
select f.ename as  "SMITH ����"
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
select decode( mod(empno,3),0,'A ��',
                    1,'B ��',
                    2,'C ��') teamName, ename, job, deptno
from emp;
--case when
select
case mod(empno,3)
when 0 then 'A ��'
when 1 then 'B ��'
when 2 then 'C ��'
end teamName, ename, job, deptno
from emp;

--11
select e.deptno �μ���ȣ, d.dname �μ��� ,e.ename ����̸�
from emp e, dept d
where e.deptno = d.deptno;

--12
create or replace view view_emp_dept30 as ( 
select empno �����ȣ, ename ����̸�, deptno �μ���ȣ
from emp
where deptno =30);

select * from view_emp_dept30;

