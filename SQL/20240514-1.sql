--scott / emp
--1. �μ���ȣ�� 10���� �μ��� ��� �� �����ȣ, �̸�, ������ ����϶�
select *
from emp;

select empno, ename,sal
from emp
where deptno = 10; 

--2. �����ȣ�� 7369�� ��� �� �̸�, �Ի���, �μ���ȣ�� ����϶�.
select  ename,hiredate,deptno
from emp
where empno = 7369;

--3. �̸��� ALLEN�� ����� ��� ������ ����϶�.
SELECT *
from emp
where ename = 'ALLEN';
--4. �Ի����� 83/01/12�� ����� �̸�, �μ���ȣ, ������ ����϶�.
SELECT ename, deptno, sal
from emp
where hiredate = '83/01/12';

--5. ������ MANAGER�� �ƴ� ����� ��� ������ ����϶�.
SELECT *
from emp
where job not in 'MANAGER';

--6. �Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ������ ����϶�.
SELECT *
from emp
where hiredate > '81/04/02';

--7. �޿��� $800 �̻��� ����� �̸�, �޿�, �μ���ȣ�� ����϶�.
SELECT ename, sal, deptno
from emp
where sal >= 800;

--8. �μ���ȣ�� 20�� �̻��� ����� ��� ������ ����϶�.
SELECT *
from emp
where deptno >=20;

--9. �̸��� K�� �����ϴ� ������� ���� �̸��� ���� ����� ��� ������ ����϶�.
SELECT *
from emp
where ename > 'K%'
order by ename;

--10. ����̸���  S�� ������ ����� ��� ������ ���
SELECT *
from emp
where ename like '%S';

--11. 30�� �μ����� �ٹ��ϴ� ��� ��  job��  SALESMAN   ��
--  ����� �����ȣ, �̸�, ��å, �޿�, �μ� ��ȣ ���
SELECT empno, ename, job, sal, deptno
from emp
where deptno = 30
and job = 'SALESMAN';

--12. 20��, 30�� �μ��� �ٹ��ϴ� ��� �� 
--�޿��� 2000�ʰ��� ����� �����ȣ, �̸�, �޿�, �μ���ȣ ���
SELECT empno, ename, sal, deptno
from emp
where sal > 2000 and deptno in (20,30);

--13. NOT BETWEEN  a AND b  �����ڸ� ���� �ʰ� 
--�޿��� 2000 �̻� 3000 ���� ���� �̿��� ���� ���� ������ ��ȸ
SELECT *
from emp
where sal >=2000 and sal <=3000;

--14. ��� �̸� �� E�� ���� �Ǿ� �ִ� 30�� �μ��� ��� �� �޿��� 1000~2000 ���̰� �ƴ� 
--����̸�, ��� ��ȣ, �޿�, �μ� ��ȣ�� ���
SELECT ename, empno, sal, deptno
from emp
where ename like '%E%' 
and deptno =30
and sal NOT BETWEEN 1000 AND 2000;

--15.�߰� ������ �������� �ʰ� ����ڰ� �ְ� ������ MANAGER, CLERK �� ��� �߿��� 
--����̸��� �ι�° ���ڰ� L�� �ƴ� ����� ���� ���
SELECT *
from emp
where comm is NULL
and mgr is not NULL
and job in ('MANAGER', 'CLERK')
and ename not like('_L%');
