--p125~126
--1.����̸� S�� ������
select * 
from emp
where ename like '%S';

--2. 30�� �μ� �� ��å SALESMAN �� �����ȣ, �̸� , ��å, �޿�, �μ���ȣ
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN';


--3. 20�� �μ� 30���μ��� �ٹ�, �޿��� 2000�ʰ� �����ȣ, �̸�, �޿�, �μ���ȣ
-- ���տ����� �̻��
select empno, ename, sal, deptno 
from emp
where deptno in (20,30) and sal > 2000;

-- ���տ����� ���
select empno, ename, sal, deptno 
from emp
where deptno = 20 and sal > 2000
union
select empno, ename, sal, deptno 
from emp
where deptno = 30 and sal > 2000;

--4.�޿��� 2000�̻� 3000���� ���� �̿� not between a and b ������� ����
select *
from emp
where sal <2000 or sal >3000;

--5. 
select ename, empno, sal, deptno
from emp
where deptno = 30 
  and ename like '%E%'
  and sal not between 1000 and 2000;
--6. �߰����� ���� ���� �ʰ� ����� �ְ� MANAGER CLERK �߿��� 
--����̸��� �ι� ° ���� L �ƴ� ���� ���
select *
from emp
where comm is null
  and mgr is not null
  and job in ('MANAGER','CLERK')
  and ename not like '_L%';

