--1. emp ���̺��� �����ȣ�� 7369 �� ��� �� �̸�, �Ի���, �μ���ȣ�� ����Ͻÿ�.
select ename �̸�, hiredate �Ի���, deptno �μ���ȣ
from emp
where empno = 7369;

select * from emp;
delete from emp where ename='ȫ�浿';

select deptno �μ���ȣ, Round(avg(sal)) ��ձ޿�, max(sal) �ְ�޿�, min(sal) �����޿� , COUNT(*)�����
from emp
group by deptno; 

select rpad(substr(empno, 1,2),length(empno),'*') �����ȣ
from emp;

select empno �����ȣ, ename ����̸�, nvl2(mgr,to_char(mgr),'CEO') ���
from emp;

select empno �����ȣ, ename, job, decode(job, 'MANAGER', sal*1.5,
'SALESMAN',SAL*1.2, 'ANALST',sal *1.05, sal*1.04)�λ�_�޿���
from emp;

select deptno, avg(sal)
from emp 
where sal>=1000
group by deptno
having avg(sal) >=2000;

select * from emp;
select * from dept;

select ename ����̸�
from emp
where deptno = (select deptno from emp where ename ='SMITH')and ename <> 'SMITH';

select e.ename ����̸� , e.deptno �μ���ȣ, d.dname �μ���
from emp  e, dept d
where e.deptno = d.deptno;

select deptno, max(sal)
from emp
group by deptno;

select *
from emp
where sal in (
select max(sal)
from emp
group by deptno
);

select decode(mod(empno,3),0,'A',
                    1,'B',
                    2,'C') teamName, ename, job, deptno
from emp;

select e.deptno �μ���ȣ, d.dname �μ��� ,e.ename ����̸�
from emp e, dept d
where e.deptno = d.deptno;

select empno �����ȣ, ename ����̸�, deptno �μ���ȣ
from emp
where deptno =30;

create view view_emp_dept30 as ( 
select empno �����ȣ, ename ����̸�, deptno �μ���ȣ
from emp
where deptno =30);

select * from view_emp_dept30;

