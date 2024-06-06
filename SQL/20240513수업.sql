--1. ���̺� ��ü �˻�
select * from emp;
--2. 
select empno, ename, sal from emp
where deptno = 10;
--3.
select hiredate , ename , deptno  from emp
where empno = 7369;

select *
from emp
where ename like 'ALL%';

select *
from emp
where ENAME in upper('a');

select ename, sal, deptno
from emp
where hiredate = '1980/12/17';

--6. ������ MANAGER �� ����� ��� ���� ���
select *
from emp
where job in upper('manager');

--7. ������ MANAGER �� �ƴ� ����� ��� ���� ���
select *
from emp
where job != 'MANAGER';

SELECT * FROM emp WHERE job <> 'MANAGER';

--8. �Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ���� ���
SELECT * FROM emp WHERE hiredate > '81/04/052';


desc emp;

--9. �޿��� 1000�̻��� ����� �̸�, �޿�, �μ� ��ȣ ���
select ename, sal, deptno from emp where sal >= 1000; 
SELECT * from emp where sal>=1000;

--10. �޿��� 1000 �̻��� ����� �̸�, �޿�, �μ���ȣ�� �޿��� ���� ������ ���
SELECT ename, sal, deptno
from emp
where sal>=1000
--order by sal asc; -- �⺻�� : ��������, asc : �������� 
order by sal desc, ename asc; -- ���� ���ٸ� ename�� �������� �������� 

--11. �̸���K �� �����ϴ� ������� ���� �̸��� ���� ����� ��� ���� ���
SELECT ename 
from emp 
where ename>'K' 
order by ename asc;

--12. emp ���̺��� �μ� ��ȣ 10�� �����ȣ, �̸�, �޿� , �μ���ȣ
select empno, ename, deptno from emp where deptno =10;
select empno, ename, deptno from emp where deptno =20;

--���� ������ 
--������
select empno, ename, sal, deptno from emp
UNION 
select empno, ename, sal, deptno from emp where deptno =20;

--������
select empno, ename, sal, deptno from emp
MINUS 
select empno, ename, sal, deptno from emp where deptno =20;

--������
select empno, ename, sal, deptno from emp
INTERSECT
select empno, ename, sal, deptno from emp where deptno =20;

-- 12. �μ� ��ȣ�� 10�̰ų� 20�� ����� ���� ���
SELECT *
from emp
where deptno =10 or deptno =20;

select *
from emp
where deptno in(10,20); 

--14. ��� �̸��� s�� ������ ����� ��� ������ ���
select *
from emp
where ename LIKE '%S';

--15. 30�� �μ����� �ٹ��ϴ� ��� �� ������ job SALESMAN �� 
--����� ��ȣ, �̸�, ��å, �޿�, �μ���ȣ ���
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN'; 

--16. 30�� �μ����� �ٹ��ϴ� ��� �� ������ job SALESMAN ��
--����� ��ȣ, �̸�, ��å, �޿�, �μ���ȣ ���
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN'
order by sal desc;-- �޿��� ���� ������ 

--17. 30�� �μ����� �ٹ��ϴ� ��� �� ������ job SALESMAN ��
--����� ��ȣ, �̸�, ��å, �޿�, �μ���ȣ ���
-- �޿��� ���� ������ 
--�޿��� ���ٸ� �����ȣ�� ���� �� ���� ���
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN'
order by sal desc, empno asc;

--18. 20,30�� �μ��� �ٹ��ϴ� ����� (���� ������ ���)
--�޿��� 2000 �ʰ��� ������ �����ȣ, �̸�, �޿�, �μ���ȣ ���
SELECT empno, ename, sal, deptno
from emp 
where  deptno = 20 and sal> 2000
union
SELECT empno, ename, sal, deptno
from emp 
where  deptno = 30 and sal> 2000;

--19. ���� ������ ������� ����
SELECT empno, ename, sal, deptno
from emp
--20. �޿��� 2000�̻� 3000���� ������ ����� ���� ���
--where  deptno in (20, 30) and sal >= 2000 and sal <=3000;
where (deptno =20 or deptno =30) and (sal>=2000 and sal <=3000);

SELECT *
from emp
where sal BETWEEN 2000 and 3000;

--�޿��� 2000�̻� 3000���� ���� �̿��� ����� ���� ���
SELECT *
from emp
where sal <=2000 or sal>=3000;

SELECT *
from emp
where sal not BETWEEN 2000 and 3000;

--�����ڰ� ������ ���� ���������� ������ from �� �ϱ� ����
select ename as "����̸�", empno as "�����ȣ", sal �޿�, deptno "�μ� ��ȣ"
from emp;

--��� �̸��� E�� ���ԵǾ��ִ� 30�� �μ��� �����,
--�޿��� 1000~2000 ���̰� �ƴ� ����̸�, ��� ��ȣ, �޿�, �μ� ��ȣ
--�ѱ� �ķ��̸����� ���

SELECT ename �̸� , empno "��� ��ȣ", sal �޿�, deptno "�μ� ��ȣ"
from emp
--where deptno = 30 and ename LIKE '%E%' and sal not BETWEEN 1000 and 2000;
where deptno = 30 and ename LIKE '%E%' and (sal < 1000 or sal > 2000);

--24. �ְ�����(comm)�� ���� ���� �ʴ� ����� ������ ���
SELECT * from emp; --��ü ���

SELECT *
from emp
where comm is null;

--25. �ְ�����(comm)�� ���� �ϴ� ����� ������ ���
SELECT *
from emp
where comm is not null;

--25. �ְ�����(comm)�� ���� �ϴ� ����� ������ ���
SELECT *
from emp
where comm is not null and comm <>0;


--26. �ְ������� ���� ���� �ʰ� �����(mgr)�� �ְ� ������ MANAGER, CLERK ��
--��� �߿��� ����̸��� �ι�° ���ڰ� L �� �ƴ� ������� ���
SELECT *
from emp
where comm is null 
    and mgr is not null 
    and(job in ('MANAGER','CLERK')) 
    and (ename like '_L%');
    
-- �����Լ�
--1. emp ���̺��� �̸��� ���
select *FROM emp; --��ü
select ename from emp;

--�빮��/ �ҹ��� /ù���� �빮�� ����� 
SELECT ename , upper(ename)�빮��, lower(ename)�ҹ��� , initcap(ename) ù���ڴ빮��
from emp;

--2. ename, �̸����� (���ڼ�) ���
SELECT ename,length(ename)�̸�����
from emp;
--����� �̸��� 5���� �̻� ���
SELECT * from emp
where length(ename)>=5;

--�̸� ȣ��(2�ڸ� ���)
SELECT ename, substr(ename,2,2), substr(ename, 3, 2),substr(ename, 1, 2),substr(ename, 0, 2)
from emp;

-- ������ ��ġ ��
SELECT instr('CORPORATE FLOOR', 'OR',1,1),instr('CORPORATE FLOOR', 'OR',1,2)
from dual;
-- (-)������ �����ص� ��ġ���� ������
SELECT instr('CORPORATE FLOOR', 'OR',-3,1),instr('CORPORATE FLOOR', 'OR',-3,2)
from dual;

-- ���ڰ� ABCDEF ���� D�� ��ġ�� ���
SELECT instr('ABCDDEF','D'),  instr('ABCDDEF','D',-1,1)
from dual;

-- emp���̺��� ename �߿��� s�� �ִ� ��ġ ���
select ename,instr(lower(ename),'s'),instr(upper(ename),'S'),instr(ename,'S')
from emp;
select ename,instr(ename,'S',-1)
from emp;

--��� �̸��� s�� ���� �͸� ���
select ename
from emp
where instr(ename,'S')>0;

select ename
from emp
where ename like '%S%';

--ename ���� ó������ 2���ڸ� �����ؼ� �ҹ��ڷ� ���
select ename, substr(lower(ename),1,2),lower(substr(ename,1,2))
from emp;

--Replace
SELECT '010-1234-5678' as rep_before,
replace('010-1234-5678','-',' ') ref_after
from dual;
--ename���� �빮�� S�� s�� �����Ͽ� ���
SELECT ename, replace(ename,'S','s')
from emp;

--lengthb �� byte �� �ǹ��Ѵ� �ѱ��� �ѱ��ڿ� 3byte �ʿ�
SELECT length('�ѱ�'),lengthb('�ѱ�')
from dual;

select 'Oracle' ,length('Oracle'),lengthb('Oracle')
from dual;

SELECT 'Oracle',LPAD('Oracle',10,'#')LPAD1,
                RPAD('Oracle',10,'#')RPAD1,
                LPAD('Oracle',10)LPAD2,
                RPAD('Oracle',10)RPAD2
from dual;
