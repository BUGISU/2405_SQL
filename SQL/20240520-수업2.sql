-- prefessor ���̺� ���
--1. �а���(deptno) �������� ��� �޿�
SELECT * from professor;
--2. �а��� �������� �հ� �޿�
SELECT deptno, avg(pay)
from professor
group by deptno;
--3. �а��� ���޺�(postion)�������� ��� �޿�
SELECT deptno, sum(pay), count(*)
from professor
group by deptno, position;
-- 4.���� �߿��� �޿�(pay)�� �������� (bonus)�� ��ģ �ݾ��� ���� ���� ���� �������� ��� ���
-- ��, bonus �� ���� ������ �޿��� 0���� ���, �޿��� �Ҽ��� ��° �ڸ����� �ݿø�
SELECT pay, bonus, nvl(pay+bonus,0)
from professor;
--
SELECT round(max(pay+nvl(pay+bonus,0)),1)
from professor;
--
SELECT round(max(pay+nvl(pay+bonus,0)),1)�ִ밪,
round(min(pay+nvl(pay+bonus,0)),1)�ּҰ�
from professor;

select round(max(nvl(pay+bonus,0)),1) �ִ밪,
round(min(nvl(pay+bonus,0)),1) �ּҰ�
from professor;

-- ���޺� ��� �޿��� 300���� ũ�� '���' �۰ų� ������ '����'
-- ���޺� (posiotion), ��ձ޿�, ��� ���
SELECT position, round(avg(pay),1),
case 
    when avg(pay) >300 then '���'
    when avg(pay) <= 300 then '����'
end ���
from professor
group by position;

--emp ���̺��� �Ի��� �⵵�� �ο���
--total 1980 1981 1982
--12    1    10   1
SELECT hiredate from emp;
select count(*) total, sum(decode(to_char(hiredate,'YYYY'),1980,1,0))"1980�⵵",
sum(decode(to_char(hiredate,'YYYY'),1980,1,0))"1981�⵵",
sum(decode(to_char(hiredate,'YYYY'),1980,1,0))"1982�⵵"
from emp;

--emp ���̺��� 1000 �̻��� �޿��� ������ �ִ� ����鿡 ���ؼ���
--�μ��� ����� ���ϵ�, �μ��� ����� 2000�̻��� �μ���ȣ, �μ��� ��� �޿� ���
SELECT deptno, round(avg(sal))
from emp 
where sal>=1000 ;

SELECT deptno, round(avg(sal))
from emp
where sal>=1000
group by deptno
having avg(sal) >= 2000;

--professor ���̺��� 
--1. �а����� �Ҽ� �������� ��� �޿�, �ּұ޿�, �ִ� �޿��� ����Ͽ��� 
--��, ��� �޿��� 300�� �Ѵ� �͸� ���

SELECT *
from professor;

SELECT deptno,round(avg(pay)), min(pay),max(pay)
from professor
group by deptno
having round(avg(pay))>= 300;

-- �а��� ���޺� �������� ��� �޿� �߿��� ��� �޿��� 400�̻��ΰ� ���
--�а���ȣ ���� ��� �޿�

SELECT deptno,positon, round(avg(pay))
from professor
group by deptno, position
having avg(pay)>= 400;


--student ���̺��� �л����� 4�� �̻��� �г⿡ ���ؼ� �г�, �л���, ���Ű, ��� �����Ը� ���
--��, ��� Ű�� ��� �����Դ� �Ҽ��� ù ���� �ڸ����ä� �ݿø��ϰ�, 
--��¼����� ���Ű�� ���� �������� ������������ ���

SELECT * from student;

-- ������ �ذ��Ҷ� ��������� �� �����ؼ� ��ɹ��� �ۼ��ؾ��� 
--FROM �� (+ Join)
--WHERE ��
--GROUP BY
--HAVING ��
--SELECT ��
--ORDER BY ��
--LIMIT ��

SELECT grade, count(*), round(avg(height),0) as height, round(avg(weight),0)
from student
group by grade
having count(*) >=4
order by height DESC;

--196p
SELECT deptno, job, count(*), max(sal), sum(sal), min(sal), avg(sal)
from emp
group by deptno, job
order by deptno, job; 

--rollup�� �μ��� ���� �Ұ谡 ����
--rollup(A,B) A,B / A�� ���� �� ���, �� �μ��� ���� �Ұ谡 ����
--rollup(A,B,C) A,B,C/ A,B/ A�� ���� �� ���, �� �μ��� ���� �Ұ谡 ����

SELECT deptno, job, count(*), max(sal), sum(sal), min(sal), round(avg(sal))
from emp
group by rollup(deptno, job)
order by deptno, job; 

-- cube(a,b) a,b / a/ b �� ���Ѱ� ���
-- cube(a,b,c) a,b,c/ a,b/ a,c/ b,c/ a/b/c �� ���� ���
SELECT deptno, job, count(*), max(sal), sum(sal), min(sal), round(avg(sal))
from emp
group by cube(deptno, job)
order by deptno, job; 
-- �μ��� ������, ��� �޿� �� �����, �μ��� ��ձ޿��� �����,
--��ü����� ��ձ޿��� �����
SELECT round(avg(sal)), count(*)
from emp
group by job, deptno;

SELECT deptno, job, round(avg(sal))as ��ձ޿�, count(*)
from emp
group by rollup(job, deptno)
order by ��ձ޿� ;

SELECT deptno, job, round(avg(sal))as ��ձ޿�, count(*)
from emp
group by cube(job, deptno)
order by ��ձ޿� ;

-- p215
-- ����(join)
select *from emp; --12��
SELECT *from dept; -- 4��
--�����ȣ(empno), ����̸�(ename),job, �μ���(dname), loc
SELECT * from emp, dept; --48��

--join , ���� ��,deptno ��������
-- � ����
select *
from emp e, dept d
where e.deptno = d.deptno;

select empno, ename, job, dname, loc , e.deptno
from emp e, dept d
where e.deptno = d.deptno;

select * from emp ;
select * from salgrade;
-- �� ����
SELECT *
from emp e, salgrade s
where e.sal  between s.losal and s.hisal;
--
SELECT * from emp; 

--�ڽ��� ���(mgr) �� �̸� ���
SELECT *
from emp em1, emp em2
where em1.mgr = em2.empno;

--��ü(self)����
SELECT em1.empno, em1.ename, em1.mgr, em2.empno ���ȸ����ȣ, em2.ename ����̸�
from emp em1, emp em2
where em1.mgr = em2.empno;
--nvl2
-- emp ���̺��� deptno�� 30�� ��� ��ȸ,
--comm ���� �֤��� ���  'Exist'��
--comm ���� null �� ��� 'null'�� ���
select empno, ename, comm ,nvl2(comm,'Exist','Null') ���
from emp
where deptno =30;

--�޿��� 2500 �����̰� ����� 9999������ ������ ������ ���
--�����ȣ(empno) �̸�(ename), �޿�(sal), �μ���ȣ(deptno), �μ���(dname),�μ�����(loc)
select* from dept;
select* from emp;

select empno, ename, sal, e.deptno, dname �μ��� , loc �μ�����
from emp e, dept d
where e.deptno = d.deptno and (sal<=2500 and empno<=9999);

--�̸���  'ALLEN'�� ����� �μ��� ���
select e.ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and ename='ALLEN';

-- �޿��� 3000���� 5000 ������ ������ �̸��� �Ҽ� �μ����� ���
select e.ename �����̸�, d.dname �μ���, e.sal
from emp e, dept d
where e.deptno = d.deptno and e.sal between 3000 and 5000;
-- SQL-99 ǥ�� ����
SELECT  e.ename, d.dname, e.sal
from emp e join dept d
on e.deptno = d.deptno
and e.sal between 3000 and 5000;

-- ������ MANAGER �� ����� �̸�, �μ���, ���
select e.ename, d.dname, e.sal
from  emp e, dept d
where e.deptno = d.deptno and e.job ='MANAGER';
-- SQL-99 ǥ�� ����
select e.ename, d.dname, e.sal
from  emp e join dept d
on e.deptno = d.deptno
where e.job ='MANAGER';

--����
--1.ACCOUNTING �μ� �Ҽ� ����� �̸��� �Ի����� ���
select e.ename, e.hiredate
from emp e, dept d
where e.deptno = d.deptno and d.dname = 'ACCOUNTING';
--join ~on
select e.ename, e.hiredate
from emp e join dept d
on e.deptno = d.deptno
where d.dname = 'ACCOUNTING';

-- 0���� ���� comm �� �޴� ��� �̸��� �μ��� ���
select e.ename, d.dname,comm
from emp e, dept d
where e.deptno = d.deptno and comm>0;
--join ~on
select e.ename, d.dname, comm
from emp e join dept d
on e.deptno = d.deptno
where comm<>0 and e.comm is not null;

--SMITH ����
select * from emp;
select ename from emp 
where deptno =20 
and ename <>'SMITH';
--
select ename from emp 
where deptno =(select deptno from emp where ename ='SMITH')
and ename <>'SMITH';
--���� ����
select  friend.ename as "SMITH�� ����" from emp e, emp friend 
where e.deptno = friend.deptno
and e.ename='SMITH' and friend.ename <> 'SMITH';
--join ~ on
select  f.ename as "SMITH�� ����"
from emp e join emp f
on  e.deptno = f.deptno
where e.ename='SMITH' and f.ename <> 'SMITH';

--�Ŵ����� KING �� ������� �̸��� ������ ����϶�
select *from emp;
select e.ename, e.job from emp e, emp m
where e.mgr = m.empno and m.ename ='KING';

select ename, job
from emp
where mgr = (select empno
from emp
where ename ='KING');


--1.���忡�� �ٹ��ϴ� ����� �̸��� �޿��� ����϶�
select *from dept;
select *from emp;

SELECT ename , sal , d.loc
from emp e , dept d
where e.deptno = d.deptno and d.loc = 'NEW YORK'; 

--join ~ on

SELECT e.ename , e.sal , d.loc
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'NEW YORK'; 

-- �Ŵ����� KING�� ������� �̸��� ������ ����϶�
select m.ename
from emp m
where mgr = (select empno from emp where ename='KING');

select s.ename, s.job
from emp s , emp m
where s.mgr = m.empno and m.ename ='KING';




