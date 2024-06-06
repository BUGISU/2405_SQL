--���� : concat
select concat(ename, job)
from emp;
select concat(ename, ':') from emp;
--1.  concat ����Ͽ�  ename : job  ��)SMITH:CLERK
select concat(concat(ename, ':'), job) 
from emp;

select concat(ename, concat(':', job))
from emp;
--  ���ڿ� ���� ||
select ename || ':' || job �̸�_����
from emp;
--2.�����ȣ(empno)�� �� 2�ڸ��� ǥ���ϰ� �� 2�ڸ��� *ǥ�� ��� 
select empno,substr(empno, 1,2),rpad(substr(empno, 1,2),4,'*')
from emp;

select rpad(substr(empno, 1,2),4,'*') �����ȣ
from emp;

select rpad(substr(empno, 1,2),length(empno),'*') �����ȣ
from emp;
-- ��������
select trim('   oracle   ') as str, length(trim('   oracle   ')) ����,
       Ltrim('   oracle   ') as Lstr,length(Ltrim('   oracle   ')) L����,
       Rtrim('   oracle   ') as Rstr,length(Rtrim('   oracle   ')) R����
from dual;

--����
--round(�ݿø�)
select 123.567, round(123.567,1),round(123.567,2),
                round(123.567,-1),round(123.567)
from dual;
--trunc(����)
select trunc(15.79,1),trunc(15.793,2),trunc(15.793,-1),trunc(15.793)
from dual;
--ceil, floor ���� ����� ū��, ���� ���� ��ȯ
select ceil(3.14), floor(3.14),ceil(-3.14),floor(-3.14),
        trunc(-3.14),trunc(3.14)
from dual;
select power(2,3) from dual;
--������
select mod(15,6)
from dual;

-- ��¥
select sysdate ����, sysdate+1 ����, sysdate-1 ����, sysdate+3
from dual;
-- 3���� ��
select sysdate, add_months(sysdate, 3)
from dual;

select sysdate, add_months('22/05/15', 3)
from dual;
-- emp ���̺��� �����ȣ, �̸�, �Ի���, �Ի� 10�� ��¥ ���
select empno, ename, hiredate, add_months(hiredate, 120)�Ի�10��
from emp;
-- �ٹ� ������ �Ҽ��� ���ϴ� �������� ���ϱ�
select empno, ename, hiredate,
    months_between(hiredate, sysdate) as month1,
    months_between(sysdate, hiredate) as month2,
    trunc(months_between(sysdate, hiredate)) as �ٹ�������
from emp;

select empno, ename, hiredate, trunc(months_between(sysdate, hiredate)) �ٹ�����
from emp;

select empno, ename, hiredate, 
   trunc(months_between(sysdate, hiredate))||'����' �ٹ�����
from emp;
--concat �̿�
select empno, ename, hiredate, 
    concat(trunc(months_between(sysdate, hiredate)),'����') �ٹ�������
from emp;
---
select sysdate, next_day(sysdate,'������'),
       last_day(sysdate),last_day('23/04/01')
from dual;
-- �����ȣ�� ¦���� �����ȣ, �̸� ,���� ���
select empno, ename, job
from emp
where mod(empno, 2)=0;
--�޿�(sal)�� 1500���� 3000������ ����� �� �޿��� 15%�� ȸ��� ����
-- �̸�, �޿�, ȸ��(�ݿø�) ���
 select  ename, sal �޿�, sal*0.15, round(sal*0.15) ȸ��
 from emp
 where sal >=1500 and sal<=3000;
--p157 ����ȯ�Լ�
-- ����+����(500==>����)
select empno, ename, empno+'500'
from emp
where ename = 'SMITH';
-- �����߻�
--select empno, 'ABCD'+empno
--from emp
--where ename = 'SMITH';

 select to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') ���糯¥�ð�
 from dual;
 
 select to_char(sysdate, 'MM') �� from dual ;
 select to_char(sysdate, 'DD') �� from dual ;
 --��
  select to_char(sysdate, 'HH') �� from dual ;
  select to_char(sysdate, 'HH24') �� from dual ;
 --��
 select to_char(sysdate, 'MI') �� from dual ;
 --��
 select to_char(sysdate, 'SS') �� from dual ; 
 select to_char(sysdate,'MON') from dual;
 select to_char(sysdate,'MONTH') from dual;
 select to_char(sysdate,'day') from dual;
 select to_char(sysdate,'DAY') from dual;
 -- �Ի����� 1,2,3���� ����� ��ȣ, �̸�, �Ի��� ���
select empno, ename, hiredate
from emp
where to_char(hiredate, 'MM') in ('01','02','03');

select empno, ename, hiredate
from emp
where to_char(hiredate, 'MM') between '01' and '03';
------
select sal, to_char(sal,'$999,999') sal_$,
        to_char(sal,'L999,999') sal_L,
        to_char(sal,'000,999') sal_0
from emp;

select to_char(123456,'$99,999') ,to_char(123456,'$999,999')
from dual;

select to_number('1,300','999,999')-to_number('1,500','999,999')
from dual;

--p164
select to_date('20100704','YYYY-MM-DD') as strdate
from dual;
-- 80/12/17  �� ���ķ� �Ի��� ��� ���
select empno, ename, hiredate
from emp
where hiredate > '80/12/17';

desc emp;

select empno, ename, hiredate
from emp
where hiredate >to_date('1980/12/17','YYYY/MM/DD');

select empno, ename, hiredate
from emp
where hiredate >to_date('80/12/17','YYYY/MM/DD');
 
--   ���, �̸�, �޿�, Ŀ�̼�, �޿�+Ŀ�̼� ��� (nvl)
select empno, ename,sal, comm,nvl(comm, 0), sal+nvl(comm, 0)
from emp;
-- comm ������  O, ���������� X  => nvl2(��, null �ƴҶ�, null)
select empno, comm, nvl2(comm, 'O', 'X')
from emp;
-- ���� (1��ġ �޿�+comm  sal*12)
-- ��ȣ, �̸�, ����
select empno, ename, sal*12+nvl(comm,0) ����
from emp;
--nvl2 ���
select to_char(nvl2(comm, sal*12+comm, sal*12),'999,999') ����1,
       to_char(sal*12+nvl2(comm, comm, 0),'999,999') ����2
from emp;

select mgr from emp;
-- mgr �� null �̸� 'CEO' ���  empno, ename, mgr
select empno, ename, nvl(to_char(mgr), 'CEO')
from emp;

select empno, ename, nvl(to_char(mgr), 'CEO')
from emp
where mgr is null;

-- p170
-- job �� ���� �޿� �λ���� �ٸ��� ����
-- MANAGER 1.5  /    SALESMAN 1.2 / ANALST 1.05  / 1.04
--decode
select empno, ename, job, sal,
      decode(job, 'MANAGER', sal*1.5,
                  'SALESMAN', sal*1.2,
                  'ANALST', sal*1.05,
                  sal*1.04) upsal
from emp;
--case when end
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.5
        when 'SALESMAN' then sal*1.2
        when 'ANALST' then sal*1.05
        else  sal*1.04
    end as �λ�޿�
from emp;
-- comm �� null  �̸� �ش���� ����, comm =0 �̸� �������
-- comm �� ������ ����:  (��: comm�� 50 �̸� ����:50)
-- empno, ename, comm, comm_text ���
-- case when
select empno, ename, comm,
    case 
        when comm is null then '�ش���׾���'
        when comm = 0 then '�������'
        when comm > 0 then '���� :'||comm
    end as comm_text
from emp;
-- decode
select empno, ename, comm,
        decode(comm, null , '�ش���׾���',
                    0, '�������',
                    '���� :'||comm
        ) comm_text
from emp;
--------------------
--professor ���̺� �̿�
--1. professor ���̺��� ������(name)�� �а���ȣ(deptno), �а��� ���
-- �а���ȣ�� 101�� ��ǻ�Ͱ��а� 101�� �ƴ� �а��� �а���
-- �ƹ��͵� ������� ������
select name, deptno, 
 case when deptno=101 then '��ǻ�Ͱ��а�'
 end �а���
from professor;

select name, deptno, 
     decode(deptno, 101 , '��ǻ�Ͱ��а�' ) �а���
from professor;

--2. professor ���̺��� ������(name)�� �а���ȣ(deptno), �а��� ���
 -- �а���ȣ�� 101�� ��ǻ�Ͱ��а� 101�� �ƴ� �а��� ��Ÿ�� ���
select name, deptno, 
 case when deptno=101 then '��ǻ�Ͱ��а�'
 else '��Ÿ'
 end �а���
from professor;

select name, deptno, 
 case deptno  when 101 then '��ǻ�Ͱ��а�'
 else '��Ÿ'
 end �а���
from professor;

select name, deptno, 
       decode(deptno, 101, '��ǻ�Ͱ��а�','��Ÿ') �а���
from professor;

----3. �а���ȣ�� 
-- 101�� �а����� ��ǻ�Ͱ��а�
-- 102����  ��Ƽ�̵����а� 
-- 201 ����Ʈ���� ���� 
-- ������ ��Ÿ
 select name, deptno, 
   decode(deptno, 101, '��ǻ�Ͱ��а�',
          102, '��Ƽ�̵����а�',
          201, '����Ʈ���� ����',
          '��Ÿ' )  �а���
from professor;

select name, deptno,
    case deptno 
        when 101 then '��ǻ�Ͱ��а�'
        when 102 then '��Ƽ�̵����а�'
        when 201 then '����Ʈ���� ����'
        else '��Ÿ'
    end �а���
from professor;

select name, deptno,
    case  
        when deptno = 101 then '��ǻ�Ͱ��а�'
        when deptno = 102 then '��Ƽ�̵����а�'
        when deptno = 201 then '����Ʈ���� ����'
        else '��Ÿ'
    end �а���
from professor;

--student ���̺�
--�л��� 3�� ������ �з��ϱ� ���� �й��� 3���� ������
--�������� 0�̸� A�� 1�̸� B��, 2�̸� C������ 
--�з��Ͽ� �л���ȣ, �̸�, �а� ��ȣ(deptno1), ���̸� ���
select studno,name, deptno1,
       decode(mod(studno,3), 0 ,'A��',
                              1, 'B��',
                              2,'C��'  )���̸�     
from student;
--�л����̺��� jumin��ȣ���� 1�̸� ����, 2����
--�й�, �̸�, ���� ���
select studno, name, jumin , 
    decode(substr(jumin,7,1),'1','����','2','����')   ����
from student;

select studno, name, jumin , 
    case substr(jumin,7,1)
    when '1' then'����'
    when '2' then '����'
    end ����
from student;

select studno, name, jumin, case
    when jumin like '______1%' then '����'
    else '����'
    end ����
from student;

select tel from student;
--tel�� ������ȣ���� 02 ����, 051 �λ�, 052 ���, 053 �뱸 
--�������� ��Ÿ�� ���
--�̸�, ��ȭ��ȣ, ���� ���
select tel, instr(tel,')'), substr(tel,1,instr(tel,')')-1)
from student;

select name, tel, 
        decode(substr(tel,1,instr(tel,')')-1),'02','����',
                                               '051','�λ�',
                                               '052','���',
                                               '053','�뱸',
                                               '��Ÿ')  ����
from student;

--p174~175 



 
 
 





