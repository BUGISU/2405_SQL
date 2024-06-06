--emp ��� ���� ��ȸ
select * from emp;
--dept ��� ���� ��ȸ
select * from dept;
--1.�μ���ȣ�� 10�� ���
select * from emp where deptno = 10;
--2. �μ���ȣ�� 10���� ��� �� �����ȣ, �̸�, ���޸� ���
select empno, ename, sal from emp where deptno=10;
--3.�����ȣ�� 7369 �� ����� �̸�, �Ի���, �μ���ȣ ���
select ename, hiredate, deptno from emp where empno=7369;
--4. �̸��� ALLEN �� ����� ��� ���� ���
select * from emp where ename = 'ALLEN';
SELECT * FROM EMP WHERE ENAME = 'ALLEN';
select * from emp where ename = 'allen';

select * from emp;
--5. �Ի����� 1980/12/17 �� ����� �̸�, �μ���ȣ, ���� ���
select ename, deptno, sal from emp where hiredate = '1980/12/17';
--6. ������ MANAGER �� ����� ��� ���� ���
select * from emp where job = 'MANAGER';
--7. ������ MANAGER�� �ƴ� ����� ��� ���� ���
select * from emp where job != 'MANAGER';
select * from emp where job <> 'MANAGER';
--8. �Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ���� ���
select * from emp where hiredate > '81/04/02';
desc emp;
--9.�޿��� 1000 �̻��� ����� �̸�, �޿�, �μ���ȣ ���
select ename, sal, deptno from emp where sal >= 1000;
select * from emp where sal >=1000;
--10. �޿��� 1000 �̻��� ����� �̸�, �޿�, �μ���ȣ�� �޿��� ���� ������ ���
select ename, sal, deptno
from emp
where sal >= 1000
order by sal desc;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal asc;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal ;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal desc, ename asc;
--11. �̸��� K�� �����ϴ� ������� ���� �̸��� ���� ����� ��� ���� ���
select * 
from emp
where ename > 'K';

-- ���տ�����
-- emp���̺��� �μ���ȣ 10�� �����ȣ, �̸�, �޿�, �μ���ȣ
-- emp���̺��� �μ���ȣ 20�� �����ȣ, �̸�, �޿�, �μ���ȣ
select empno, ename, deptno from emp where deptno = 10
UNION
select empno, ename, deptno from emp where deptno = 20;

--
select empno, ename, sal, deptno from emp
union
select empno, ename, sal, deptno from emp where deptno =20;
---
select empno, ename, sal, deptno from emp
MINUS
select empno, ename, sal, deptno from emp where deptno =20;
---
select empno, ename, sal, deptno from emp
INTERSECT
select empno, ename, sal, deptno from emp where deptno =20;

-- 12. �μ���ȣ�� 10�̰ų� 20�� ����� �������
select *
from emp
where deptno=10 or deptno =20;

select * 
from emp
where deptno in (10, 20);

--14 ����̸��� S�� ������ ����� ��� ������ ���
select *
from emp
where ename like '%S';
--15. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESMAN �� �����
-- �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal), �μ���ȣ(deptno) ���
select empno, ename, job, sal, deptno 
from emp
where deptno=30 and job ='SALESMAN';

--16. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESMAN �� �����
-- �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal), �μ���ȣ(deptno)
-- �޿��� ���� ������ ���
select empno, ename, job, sal, deptno 
from emp
where deptno=30 and job ='SALESMAN'
order by sal desc;

--17. 30�� �μ����� �ٹ��ϴ� ��� �� job�� SALESMAN �� �����
-- �����ȣ(empno), �̸�(ename), ��å(job), �޿�(sal), �μ���ȣ(deptno)
-- �޿��� ���� ������ ���, �޿��� ���ٸ� �����ȣ�� ���� �� ���� ���
select empno, ename, job, sal, deptno 
from emp
where deptno=30 and job ='SALESMAN'
order by sal desc, empno asc;
--18.���տ����� ���
-- 20�� , 30�� �μ��� �ٹ��ϴ� ��� �� 
--�޿��� 2000�ʰ��� ����� �����ȣ, �̸�,�޿�, �μ���ȣ ���
select  empno, ename, sal, deptno
from emp
where deptno =20 and sal > 2000
union
select  empno, ename, sal, deptno
from emp
where deptno =30 and sal > 2000;
--19. ���տ����� ������� ����
select  empno, ename, sal, deptno
from emp
where deptno in (20,30) and sal > 2000;
--20. �޿��� 2000 �̻� 3000 ���� ������ ����� ���� ���
select *
from emp
where sal >= 2000 and sal <=3000;

select *
from emp
where sal BETWEEN 2000 and 3000;

--21. �޿��� 2000 �̻� 3000 ���� ���� �̿��� ����� ���� ���
select *
from emp
where sal < 2000 or sal >3000;

select *
from emp
where sal NOT BETWEEN 2000 and 3000;
--22.����̸�, �����ȣ, �޿�, �μ���ȣ ���
select ename as "����̸�", empno �����ȣ, sal as �޿�, deptno "�μ� ��ȣ"
from emp;

select ename ����̸�, empno �����ȣ, sal �޿�, deptno �μ�_��ȣ
from emp;

--23. ����̸��� E �� ���ԵǾ� �ִ� 30�� �μ��� ��� ��
-- �޿��� 1000~2000 ���̰� �ƴ� ����̸�, ��� ��ȣ, �޿�, �μ� ��ȣ 
-- �ѱ� �÷��̸����� ���
select ename ����̸� , empno "��� ��ȣ", sal �޿�, deptno "�μ� ��ȣ"
from emp
where ename like '%E%' 
      and deptno =30 
      and sal not BETWEEN 1000 and 2000;
      
 select ename ����̸� , empno "��� ��ȣ", sal �޿�, deptno "�μ� ��ȣ"
from emp
where ename like '%E%' 
      and deptno =30 
      and (sal <1000 or sal > 2000);
      
--24. �ְ�����(comm) �� �������� �ʴ� ����� ���� ���    
select * from emp;

select *
from emp
where comm is null;

select *
from emp
where comm is not null;

select *
from emp
where comm is not null and comm <> 0;
--25.�ְ������� �������� �ʰ� �����(mgr)�� �ְ� ������   MANAGER, CLERK �� 
-- ��� �߿��� ����̸��� �ι�° ���ڰ� L�� �ƴ� ������� ���
select *
from emp
where comm is null
  and mgr is not null
  and job in ('MANAGER','CLERK')
  and ename not like '_L%';
  
-- �����Լ�
--1.emp  ���̺���  �̸��� ���
select * from emp;
select ename from emp;

select ename, upper(ename)as �빮��, lower(ename) �ҹ���, initcap(ename)
from emp;

--2. ename, �̸�����(���ڼ�)  ���
 select ename, length(ename) �̸�����
 from emp;
 -- ����� �̸��� 5���� �̻� ���
 select ename, length(ename) �̸�����
 from emp
 where length(ename) >=5;
 --�̸� ����(2�ڸ�) ���
select ename, substr(ename, 2,2),substr(ename, 3,2)
from emp;
-- 
select  instr('CORPORATE FLOOR', 'OR',1,1)
from dual;

select  instr('CORPORATE FLOOR', 'OR')
from dual;

select  instr('CORPORATE FLOOR', 'OR',1,2)
from dual;

select  instr('CORPORATE FLOOR', 'OR',-3,1)
from dual;

select INSTR('CORPORATE FLOOR','OR',-3,2)
from dual;
--���ڿ�  ABCDDEF ����  D�� ��ġ�� ��� (instr)
select instr('ABCDDEF','D'), instr('ABCDDEF','D',-1)
from dual;
-- emp ���̺��� ename ��  S �� �ִ� ��ġ ���
select instr(ename, 'S'),instr(ename, 'S', -1),instr(ename, 'S', 3)
from emp;

-- ����̸���  S �� ���� �͸� ��� (INSTR ���)
select ename
from emp
where instr(ename, 'S')>0;

select ename
from emp
where ename like '%S%';

-- ename ���� ó������ 2���ڸ� �����Ͽ� �ҹ��ڷ� ���
select lower(ename)
from emp;

select substr(ename, 1,2)
from emp;

select ename, lower(substr(ename, 1,2)) �ҹ���
from emp;

--REPLACE
select '010-1234-5678' as rep_before,
   replace('010-1234-5678','-',' ') ref_after
from dual;

-- ename ���� S �� s �� �����Ͽ� ���
select ename , replace(ename, 'S','s')
from emp;

---
select length('�ѱ�'), lengthb('�ѱ�')
from dual;

select 'Oracle' ,length('Oracle'), lengthb('Oracle')
from dual;

select 'Oracle', LPAD('Oracle',10, '#') LPAD1,
                 RPAD('Oracle',10, '#') RPAD1,
                 LPAD('Oracle',10) LPAD2,
                 RPAD('Oracle',10) RPAD2
from dual;











