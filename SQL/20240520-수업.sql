--p177
--�޿� �հ�(sum)�� comm �հ�
select sum(sal), sum(comm)
from emp;
select comm
fromm emp;

--����(count) Ȯ���ϱ�
select sal from emp;
-- ���� ������ ������
select count(sal) from emp;
--distinct �ߺ����� ī��Ʈ ���� �ʴ´�
select count(distinct(sal)) from emp;
select *from emp;
select count(*) from emp;
--�μ���ȣ�� 30�� ��� ��
select count(empno)
from emp
where deptno = 30;

--comm �� null�� �ƴ� ���� 
select count(comm)
from emp
where comm is not null;

select count(sal), count(distinct(sal)), count(all sal)
from emp;

select sal from  emp;
--�ִ밪
select max(sal) from emp;
--�ּҰ�
select min(sal) from emp;
select max(sal), min(sal) from emp;
-- ���,�ݿø��ؼ�(�Ҽ� ù°���� ���)
select round(avg(sal),1) from emp;

--�μ� ��ȣ�� 20�� ����� �Ի��� �� ���� �ֱ� �Ի��� ���
select max(hiredate)
from emp
where deptno= 20;
--professor ���̺��� 

--1. �� ���� �� ���
select count(name), from professor; 

--2. ���� �޿� �հ�
select sum(pay) from professor;
--3. �޿� ���
select count(name),  from professor; 
--4. ������ �޿��� ����� �Ҽ��� ù°�ڸ����� �ݿø�
select round(avg(pay)) from professor; 
--5. �ְ� �޿�
select round(max(pay)) from professor; 
--6. ���� �޿�
select round(min(pay)) from professor; 
--7. ���� �� �ְ� �޿��� �޴� ����� �̸��� �޿� ���
select name, pay
from professor
where pay = 570;
-- -- 10�� �μ��� ��� �޿�
select avg(sal) from emp where deptno =10;
-- 20�� �μ��� ��� �޿� 
select avg(sal) from emp where deptno =20;
-- 30�� �μ��� ��� �޿�
select avg(sal) from emp where deptno =30;
--
select avg(sal) from emp where deptno =10
union
select avg(sal) from emp where deptno =20
union
select avg(sal) from emp where deptno =30;

--�μ��� ���� ��� �޿� ���(�μ���ȣ, ��� �޿�) �μ��� �������� ���
select deptno, round(avg(sal))
from emp
group by deptno
order by deptno;
--�μ���ȣ �� ��å (job) �� ��ձ޿�, �μ���ȣ ��������, job ��������
select deptno,job,avg(sal) 
from emp
group by deptno, job
order by deptno desc, job asc;

--emp ���̺��� �μ���ȣ �� ��å(job) �� ��ձ޿� , �μ���ȣ ��������, ���� �޿� ������ ���
select deptno, job , avg(sal)
from emp
group by deptno, job
order by deptno , avg(sal) desc;
