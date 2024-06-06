--p177
--�޿��հ��  comm �հ�
select sum(sal),sum(comm)
from emp;

select sal from emp;
select distinct(sal) from emp;
select count(sal) from emp;
select count(distinct(sal)) from emp;
select * from emp;
select count(*) from emp;
--�μ���ȣ�� 30�� ��� ��
select * from emp where deptno = 30;
select count(*)
from emp
where deptno = 30;
--comm �� null �ƴ� ����
select count(comm), count(*)
from emp
where comm  is not null;

select count(sal), count(distinct(sal)),count(all sal)
from emp;
desc emp;
-- �ִ밪
select sal from emp;
select max(sal) from emp;
--�ּҰ�
select min(sal) from emp;
select max(sal), min(sal) from emp;
--���
select avg(sal) from emp;
--����� �ݿø��ؼ�(�Ҽ� ù��°���� ���)
select round(avg(sal), 1) from emp;
--�μ���ȣ�� 20�� ����� �Ի��� �� ���� �ֱ� �Ի��� ���
select max(hiredate)
from emp
where deptno=20;
--professor���̺��� 
select * from professor;
--1. �� ���� �� ���
select count(*) from professor;

--2. ���� �޿� �հ�
select sum(pay) from professor;

--3. ���� �޿� ���
select avg(pay) from professor;

--4. ������ �޿��� ����� �Ҽ��� ù° �ڸ����� �ݿø�
select round(avg(pay)) from professor;
--5. �ְ�޿�
select max(pay) from professor;

--6. �����޿�
select min(pay) from professor;

--7. ���� �� �ְ� �޿��� �޴� ����� �̸��� �޿� ���
select name, pay
from professor
where pay = 570;

select name, pay
from professor
where pay = (select max(pay) from professor);
--emp ���̺�
--1. 10�� �μ��� ��ձ޿�
select avg(sal) from emp where deptno=10;
-- 20�� �μ��� ��ձ޿�
select avg(sal) from emp where deptno=20;
-- 30�� �μ��� ��ձ޿�
select avg(sal) from emp where deptno=30;
---
select avg(sal) from emp where deptno=10
union
select avg(sal) from emp where deptno=20
union
select avg(sal) from emp where deptno=30;
--�μ��� ���� ��� �޿� ���(�μ���ȣ, ��ձ޿�)
select deptno, round(avg(sal)) "�μ��� ��ձ޿�"
from emp
group by deptno;
--�μ��� ���� ��� �޿� ���(�μ���ȣ, ��ձ޿�) �μ��� �������� ���
select deptno, round(avg(sal)) "�μ��� ��ձ޿�"
from emp
group by deptno
order by deptno;
-- �μ���ȣ �� ��å(job) �� ��ձ޿�, �μ���ȣ ��������, job�������� ���
select deptno,job, avg(sal)
from emp
group by deptno, job
order by deptno desc,job asc;

-- emp ���̺��� �μ���ȣ �� ��å(job) �� ��ձ޿�, �μ���ȣ ��������, ���� �޿� ������ ���
select deptno, job, avg(sal)
from emp
group by deptno, job
order by deptno desc, avg(sal) desc;

select deptno, job, avg(sal) avgsal
from emp
group by deptno, job
order by deptno desc, avgsal desc;
----professor ���̺� ���
select * from professor;
--1. �а���(deptno) �������� ��� �޿�
select deptno, round(avg(pay))
from professor
group by deptno; 

-- 2. �а��� ��������  �޿� �հ�
select deptno, sum(pay),count(*)
from professor
group by deptno; 

--3. �а��� ���޺�(posotion) �������� ��� �޿�
select deptno, position, round(avg(pay))
from professor
group by deptno, position
order by deptno;

--4. ���� �߿��� �޿�(pay)�� ��������(bonus)�� ��ģ �ݾ��� ���� ���� ����
-- ���� ���� ���  ���
-- ��,  bonus �� ���� ������ �޿�(bonus)�� 0���� ���, �޿��� �Ҽ��� ��° �ڸ����� �ݿø�
select pay, nvl(bonus,0), pay+nvl(bonus,0)
from professor;
--
select round(max(pay+nvl(bonus,0)),1)�ִ밪,
       round(min(pay+nvl(bonus,0)),1)�ּҰ�
from professor;
-------------------
select pay, bonus, nvl(pay+bonus,0)
from professor;

select round(max(nvl(pay+bonus,0)),1) �ִ밪,
        round(min(nvl(pay+bonus,0)),1) �ּҰ�
from professor;
--5.���޺� ��� �޿��� 300���� ũ�� '���' �۰ų� ������ '����'
  --- ���޺�(position), ��ձ޿�, ��� ���
select position, round(avg(pay),1),
    case 
        when avg(pay) > 300 then '���'
        when avg(pay) <= 300 then '����'
    end ���
from professor
group by position;
-----
--emp ���̺��� �Ի��� �⵵�� �ο� �� 
-- total 1980  1981   1982
--  12     1    10     1
select hiredate from emp;
select count(*) total, 
       sum(decode(to_char(hiredate,'YYYY'),1980,1,0)) "1980�⵵",
       sum(decode(to_char(hiredate,'YYYY'),1981,1,0)) "1981�⵵",
       sum(decode(to_char(hiredate,'YYYY'),1982,1,0)) "1982�⵵"
from emp;
--emp ���̺��� 1000 �̻��� �޿��� ������ �ִ� ����鿡 ���ؼ���
-- �μ��� ����� ���ϵ�, �μ��� ����� 2000 �̻��� �μ���ȣ, �μ��� ��ձ޿� ���
select *
from emp
where sal >=1000;

select deptno, round(avg(sal))
from emp
group by deptno;

select deptno, round(avg(sal))
from emp
where sal >=1000
group by deptno
having avg(sal) >=2000;

select deptno, round(avg(sal))
from emp
group by deptno
having avg(sal) >=2000;

select sal from emp where deptno = 30;
---
-- professor ���̺��� 
--1. �а����� �Ҽ� �������� ��� �޿�, �ּ� �޿�, �ִ� �޿��� ����Ͽ���.
-- ��, ��ձ޿��� 300�� �Ѵ� �͸� ���

select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by deptno;

select deptno, round(avg(pay)), min(pay), max(pay)
from professor
group by deptno
having  avg(pay) > 300;

--2. �а���(deptno) ���޺�(position) �������� ��� �޿� �߿��� ��� �޿��� 400�̻��ΰ� ���
-- �а���ȣ ���� ��ձ޿�
select deptno, position, round(avg(pay))
from professor
group by deptno, position;

select deptno, position, round(avg(pay))
from professor
group by deptno, position
having avg(pay) >=400;

--student ���̺��� 
--3. �л� ���� 4�� �̻��� �г⿡ ���ؼ� �г�, �л� ��, ��� Ű, ��� �����Ը� ���
--��, ��� Ű�� ��� �����Դ� �Ҽ��� ù ��° �ڸ����� �ݿø��ϰ�,
--��¼����� ��� Ű�� ���� ������ ������������ ����Ͽ���.
select * from student;
select grade, count(*), round(avg(height)) ���Ű, round(avg(weight)) ��ո�����
from student
group by grade
having  count(*)>=4
order by  ���Ű desc;
--p196
select deptno, job, count(*), max(sal), sum(sal), min(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job;

--rollup(A,B,C)  A,B,C / A,B/  A �� ���� �� ���
--rollup(A,B) A,B/ A �� ���� �� ���
select deptno, job, count(*), max(sal), sum(sal), min(sal), round(avg(sal))
from emp
group by rollup(deptno, job)
order by deptno, job;

--cube(A,B,C)  A,B,C/ A,B / A,C/ B,C/ A/B/C  �� ���� �� ���
--cube(A,B) A,B/ A / B �� ���� �� ���
select deptno, job, count(*), max(sal), sum(sal), min(sal), round(avg(sal))
from emp
group by cube(deptno, job)
order by deptno, job;
-- �μ��� ������ ��ձ޿� �� �����, �μ��� ��ձ޿��� ����� , ��ü����� ��ձ޿��� ��� ��
select deptno,job,round(avg(sal)), count(*)
from emp
group by deptno, job;

select deptno,job, round(avg(sal)), count(*)
from emp
group by rollup(deptno, job)
order by deptno;

-- ���� p215
select * from emp;
select * from dept;
-- �����ȣ(empno), ����̸�(ename), job, �μ���(dname), loc
select *
from emp, dept;

select *
from emp e, dept d
where e.deptno = d.deptno;

select empno, ename, job, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

----
select * from emp;
select * from salgrade;
--������
select *
from emp e, salgrade s
where e.sal between s.losal and s.hisal;
-----
select * from emp;
-- �ڽ��� ���(mgr)�� �̸� ���
select *
from emp e1, emp e2
where e1.mgr = e2.empno;

--��ü����(��������)
select e1.empno, e1.ename, e1.mgr, e2.empno  ���ȸ����ȣ, e2.ename ����̸�
from emp e1, emp e2
where e1.mgr = e2.empno;
--nvl2
-- emp ���̺��� deptno�� 30 ��� ��ȸ
--comm ���� ���� ��� 'Exist' ��
--comm ����  null ��� 'Null' ���
select empno, ename, comm,nvl2(comm, 'Exist' ,'Null') ���
from emp
where deptno=30;
--�޿��� 2500�����̰� ����� 9999 ������ ����� ������ ���
-- �����ȣ(empno), �̸�(ename), �޿�(sal), �μ���ȣ(deptno), �μ���(dname), �μ�����(loc)
select empno, ename, sal, e.deptno, dname, loc
from emp e, dept d
where e.deptno = d.deptno and sal<=2500 and  empno <=9999; 
-- �̸��� 'ALLEN' �� ����� �μ��� ���
select * from emp where ename ='ALLEN';
select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno and ename ='ALLEN';
-- 1. �޿��� 3000 ���� 5000������ ������ �̸��� �Ҽ� �μ����� ���
select e.ename, d.dname, e.sal
from emp e, dept d
where e.deptno = d.deptno 
    and e.sal between 3000 and 5000;
 --SQL-99 ǥ�ع���
select e.ename, d.dname, e.sal
from emp e join dept d 
           on e.deptno = d.deptno 
where e.sal  between 3000 and 5000;

select e.ename, d.dname, e.sal
from emp e join dept d
           on e.deptno = d.deptno 
and e.sal  between 3000 and 5000;
    
--2. ������ MANAGER�� ����� �̸�, �μ����� ����϶�
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.job ='MANAGER';
 --SQL-99 ǥ�ع���
 select e.ename, d.dname
 from emp e join dept d
            on e.deptno = d.deptno 
 where  e.job ='MANAGER';
 --7�� �������� p212~213
 --1. emp ���̺�/ �μ���ȣ, ��ձ޿�, �ְ�޿�, �����޿�, ����� ���
--��, ��ձ޿��� �Ҽ��� ����, �� �μ���ȣ�� ���
select deptno, round(avg(sal)),trunc(avg(sal)) avg_sal, 
       max(sal)max_sal, min(sal) min_sal, count(*) cnt
from emp
group by deptno;
--2, ���� ��å�� �����ϴ� ����� 3�� �̻��� ��å�� �ο���
select job, count(*)
from emp
group by job
having count(*) >=3;
--3. ������� �Ի翬���� �������� �μ����� ����� �Ի��ߴ��� ���
select to_char(hiredate, 'YYYY') HIRE_YEAR, deptno, count(*) CNT
from emp
group by  to_char(hiredate, 'YYYY'),deptno;
--4. �߰�����(comm)�޴� ��� ���� ���� �ʴ� ��� �� ���
select nvl2(comm, 'O','X') EXIST_COMM, count(*) CNT
from emp
group by nvl2(comm, 'O','X'); 
--5. �� �μ��� �Ի翬���� �����, �ְ�޿�, �޿� ��, ��� �޿� ����ϰ�
-- �� �μ��� �Ұ�� �Ѱ� ���
select deptno,  to_char(hiredate,'YYYY') HIRE_YEAR,
       count(*) CNT,
       max(sal) MAX_SAL,
       sum(sal) SUM_SAL,
       round(avg(sal),1) AVG_SAL
from emp
group by rollup(deptno, to_char(hiredate,'YYYY'))
order by deptno;

select deptno,  to_char(hiredate,'YYYY') HIRE_YEAR,
       count(*) CNT,
       max(sal) MAX_SAL,
       sum(sal) SUM_SAL,
       round(avg(sal),1) AVG_SAL
from emp
group by rollup(to_char(hiredate,'YYYY'),deptno)
order by HIRE_YEAR;
--����
--1. ACCOUNTING �μ� �Ҽ� ����� �̸��� �Ի����� ���
select ename, hiredate
from emp;
select dname from dept;
----
select ename, hiredate
from emp e, dept d
where e.deptno = d.deptno and d.dname ='ACCOUNTING';

--join~on
select ename, hiredate
from emp e join dept d on e.deptno = d.deptno
  where d.dname ='ACCOUNTING';


--2. 0���� ����  comm �� �޴� ��� �̸��� �μ��� ���
select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno and e.comm > 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno 
and e.comm is not null
and e.comm > 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno 
and e.comm is not null
and e.comm <> 0;

select ename, dname, comm
from emp e, dept d
where e.deptno = d.deptno 
and e.comm <> 0;

--join~on
select e.ename, d.dname
from emp e join dept d
 on e.deptno = d.deptno
 and e.comm is not null
 and e.comm > 0;
 
select e.ename, d.dname
from emp e join dept d
 on e.deptno = d.deptno
 where e.comm is not null
 and e.comm > 0;
-- SMITH ����
select * from emp;
select ename from emp 
where deptno=20 
and ename <> 'SMITH';
------
select ename from emp 
where deptno=(select deptno from emp where ename ='SMITH') 
and ename <> 'SMITH';
---��������
select friend.ename   as "SMITH ����"
from emp e, emp friend
where e.deptno = friend.deptno
and e.ename = 'SMITH' and friend.ename <> 'SMITH';
--join ~ on
select f.ename as "smith����"
from emp e join emp f
     on e.deptno = f.deptno
     where   e.ename = 'SMITH' and f.ename <> 'SMITH';
     
-- �Ŵ����� KING�� ������� �̸��� ������ ����϶�
select * from emp;

select e.ename, e.job, e.mgr
from emp e, emp m
where e.mgr = m.empno and m.ename = 'KING';

select ename, job
from emp
where mgr = (select empno
            from emp
            where ename ='KING');

 


 
 









    
    
















