-- ���ڿ� ���� : concat
SELECT concat(ename, job)
from emp;

SELECT concat(ename,':') from emp;

--1. concat ����Ͽ� ename :job ��)SMITH:CLERK
SELECT concat(concat(ename,':'),job)
from emp;

SELECT concat(ename, concat(':', job))
from emp;

--���ڿ� ���� || 
SELECT ename || ':' || job �̸�_����
from emp;

--2. �����ȣ (empno)�� �� 2�ڸ��� ǥ���ϰ� ��2�ڸ��� *�� ǥ�� ���
SELECT empno, substr(empno,1,2), rpad(substr(empno,1,2),4,'*') �����ȣ 
from emp;

SELECT empno, substr(empno,1,2), rpad(substr(empno,1,2),length(empno),'*') �����ȣ
from emp;

--�������� 
SELECT '    oracle   ', length(( '    oracle   '))����,
            trim( '    oracle   ')str , length(trim( '    oracle   '))����,
            Ltrim('    oracle   ')Lstr, length(Ltrim('    oracle   '))Lstr_����,
            Rtrim('    oracle   ')Rstr, length(Rtrim('    oracle   '))Rstr_����
from dual;

--����
--round (�ݿø� ,�Ҽ��� �ڸ�) ������,�������� ǥ��
SELECT 123.567 ,round(123.567,1) ,round(123.567,2) 
        ,round(123.567,-1),round(123.567)
from dual;

--trunc(����)
select trunc(15.79,1), trunc(15.793,2), trunc(15.793,-1), trunc(15.79)
from dual;

-- ceil, floor ���� ����� ū��, ���� ���� ��ȯ
select ceil(3.14) ,floor(3.14), ceil(-3.14) , floor(-3.14)
        ,trunc(-3.14),trunc(3.14)
from dual; 
--2�� 3��
select power(2,3) from dual;

--������ 
select mod(15,6)
from dual;

--��¥ 
SELECT sysdate ���� , sysdate +1 ����,sysdate -1 ����
        ,sysdate +3
from dual;
--3���� ��
SELECT sysdate, add_months(sysdate,3) ����_3������, add_months('22/05/15',3)
from dual;

--emp ���̺��� �����ȣ, �̸�, �Ի���, �Ի� 10�� �� ��¥ ���
SELECT  empno,ename,add_months(hiredate,120)
from emp;

--�ٹ� ������, �Ҽ��� ����
select empno, ename, hiredate , months_between(hiredate, sysdate) as month1,
months_between(sysdate, hiredate) as month2, 
trunc(months_between(sysdate, hiredate)) as �ٹ�������
from emp;

select empno, ename, hiredate
,concat(trunc(months_between(sysdate, hiredate)),' ����')
,trunc(months_between(sysdate, hiredate))||' ����'
from emp;

--���� �� ������ ��� /�̹��� ������ ��
SELECT sysdate, next_day(sysdate,'������')�����ֿ����� ,last_day(sysdate)�̹��޸�����
   ,last_day('22/05/15') ������_������_��
from dual;

--�����ȣ�� ¦���� �����ȣ, �̸�, ���� ���
SELECT empno, ename, job
from emp
where mod(empno,2)=0; --�������� mod()

--�޿�(sal)�� 1500���� 3000 ������ ����� �� �޿��� 15%�� ȸ��� ����
--�̸�, �޿�, ȸ�� (�ݿø�) ���
SELECT ename, sal,sal*0.15,round(sal*0.15)ȸ��
from emp
where sal Between 1500 and 3000;

--���� +���� 
SELECT empno, ename, empno+'500'
from emp
where ename ='SMITH';

--ERROR ���ڶ� ���ڴ� ���� �� ����
SELECT empno,'ABCD'+empno
from emp
where ename ='SMITH';

--���� ���� ����
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')���糯¥_�ð�_���伳��
from dual;

select (to_char(sysdate, 'mm') || '��') �� from dual;
select to_char(sysdate, 'dd')|| '��' �� from dual;
select to_char(sysdate, 'hh')|| '��' �� from dual;
select to_char(sysdate, 'mi')|| '��'�� from dual;
select to_char(sysdate, 'ss') || '��'�� from dual;

SELECT to_char(sysdate,'Mon') from dual; --��
SELECT to_char(sysdate,'day') from dual; --����
SELECT to_char(sysdate,'day') from dual;

--�Ի����� 1,2,3 ���� ����� ��ȣ, �̸�, �Ի��� ���
--1
SELECT empno, ename, hiredate
from emp
where to_char(hiredate,'MM') in (1,2,3);
--2
SELECT empno, ename, hiredate
from emp
where to_char(hiredate,'MM') in ('01','02','03');
--3
SELECT empno, ename, hiredate
from emp
where to_char(hiredate,'MM') between '01' and '03';

--���� ǥ���, ���� �����
select sal, to_char(sal, '$999,999')sal_$ --�޷�ǥ��
        ,to_char(sal, 'L999,999')sal_L --��
        ,to_char(sal, '000,999')sal_0 --�ڸ��� ������
from emp; 

SELECT to_char(123456,'$99,999'), to_char(123456,'$999,999')
from dual;

--to_number()
SELECT to_number('1,300', '999,999'),to_number('1,500', '999,999')
        ,to_number('1,300', '999,999')-to_number('1,500', '999,999')
from dual;
--to_date()���ڸ� ���� �������� �ٲ��ش�
select to_date('20100704','YYYY-MM-DD') as Strdate
from dual;

--80/12/17 �� ���ķ� �Ի��� ��� ��� 
SELECT empno, ename,hiredate
from emp 
where hiredate >'80/12/17';

desc emp;--������ �� Ȯ��

SELECT empno, ename,hiredate
from emp 
where hiredate >to_date('80/12/17','YYYY-MM-DD');

SELECT empno, ename,hiredate
from emp 
where hiredate >to_date('1980/12/17','YYYY-MM-DD');

-- ���, �̸�, �޿�, Ŀ�̼�(comm), �޿� +Ŀ�̼� ���
--nvl()�� �� ���� ���� ��������
SELECT empno, ename, sal, comm, nvl(comm,0),sal+nvl(comm,0)
from emp ;
--comm ������ 0 ,���� ������ X => nvl2(��, ��X, ��O)
SELECT empno, nvl2(comm,'O','X')
from emp;

--����(1��ġ �޿� sal*12) ,��ȣ, �̸�, ���� ���
--nvl���
SELECT empno, ename, sal*12+nvl(comm,0) ����
from emp;
--nvl2���
SELECT empno, ename, to_char(sal*12+nvl2(comm,comm,0),'999,999') ����
from emp;

SELECT empno, ename, to_char(nvl2(comm,sal*12+comm,sal*12),'999,999') ����
from emp;

SELECT mgr from emp;

-- mgr �� null �̸� 'CEO'��� empno, ename, mgr
SELECT  empno, ename, nvl(to_char(mgr),'CEO')
from emp;

SELECT  empno, ename, nvl(to_char(mgr),'CEO')
from emp
where mgr is null;

--p170
--job �� ���� �޿� �λ���� �ٸ��� ����
--decode()
-- MANAGER 1.5 SALESEMAN 1.2 ANALST 1.05 
SELECT empno, ename, job, sal
,decode(job , 'MANAGER', sal*1.5
        , 'SALESEMAN', sal*1.2
          , 'ANALST', sal*1.05,
          sal*1.04) upsal
from emp;
--case when end
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.5
        when 'SALESEMAN' then sal*1.2
        when 'ANALST' then sal*1.05
        else   sal*1.04
    end as �λ�޿�
from emp;

-- comm �� null �̸� �ش���� ����, comm =0 �̸� ���� ����
-- ������ ���� : (��) comm �� 50 �̸� ����: 50 
--empno, ename, comm, comm_text ���
--case when . decode  ���
SELECT empno, ename, comm,
case 
    when comm is NUll then '�ش���� ����'
    when comm =0 then '���� ����'
    when comm>0 then  '���� : '|| comm
end as comm_text
from emp;

SELECT empno, ename, comm,
decode(comm, null,'�ش���� ����'
        ,0,'�������',
        '���� : '|| comm
)comm_text
from emp;

---------------------------------------------------------
--professor ���̺� �̿�
SELECT * from professor;
--1. professer ���̺��� ������(name)�� �а���ȣ(deptno),�а��� ���
--�а���ȣ�� 101�� ��ǻ�Ͱ��а� 101�� �ƴ� �а��� �а���
--�ƹ��͵� ������� ���ÿ�
select name, decode(deptno, 101, '��ǻ�Ͱ��а�',' ')�а���
from professor;

select name,
case when
    deptno =101 then '��ǻ�Ͱ��а�'
end �а���
from professor;

--professor ���̺��� ������(name)�� �а� ��ȣ (deptno), �а��� ��� 
--�а���ȣ�� 101�� ��ǻ�Ͱ��а� 101�� �ƴ� �а��� ��Ÿ�� ���
--01.
SELECT name, deptno, decode(deptno, 101,'��ǻ�Ͱ��а�','��Ÿ')�а���
from professor;
--02.
select name,
case when
    deptno =101 then '��ǻ�Ͱ��а�'
    else '��Ÿ'
end �а���
from professor;

--03.
select name,
case deptno when
    101 then '��ǻ�Ͱ��а�'
    else '��Ÿ'
end �а���
from professor;

--�а� ��ȣ�� 101�̸� �а��� ��ǻ�Ͱ��а� 
--102�� ��Ƽ�̵����а�
--201 ����Ʈ���� ����
-- ������ ��Ÿ

SELECT name, deptno, decode(deptno,
101,'��ǻ�Ͱ��а�'
,102,'��Ƽ�̵����а�'
,201,'����Ʈ������а�'
,'��Ÿ')�а���
from professor;

SELECT name,deptno,
case  deptno 
when 101 then '��ǻ�Ͱ��а�'
when 102 then '��Ƽ�̵����а�'
when 201 then '����Ʈ������а�'
else '��Ÿ'
end �а���
from professor;

--student ���̺�
--�л��� 3�� ������ �η��ϱ� ���� �й��� 3���� ������ 
--�������� 0�̸� A�� 1�̸� B��,2�̸� C������ 
--�з��Ͽ� �л���ȣ, �̸�, �а� ��ȣ(deptno1), ������ ���
SELECT * from student;

SELECT studno, name, deptno1,
case when mod(studno,3)=0 then 'A ��'
     when mod(studno,3)=1 then 'B ��'
     when mod(studno,3)=2 then 'C ��'
end ��
from student;

--�л����̺��� jumin ��ȣ���� 1�̸� ����, 2����
--�й�, �̸�, ���� ���
select studno, name,jumin
,case substr(jumin,7,1)
when to_char(1) then'��'
when to_char(2) then'��'
end ����
from student;

select studno, name, jumin, case
when jumin like '______1%' then '����'
else '����'
end ����
from student;

--02 ����, 051�λ�,052 ���,053�뱸 ,�������� ��Ÿ 
--�̸�,��ȭ��ȣ, ���� ���
select name,tel, substr(tel,1,instr(tel,')')-1) ����_����
,case substr(tel,1,instr(tel,')')-1)
                        when '02' then '����'
                        when '052' then '���'
                        when '051' then '�λ�'
                        when '053' then '�뱸'
                        else '��Ÿ'
end ����

--,decode(substr(tel,0,3),051,'�λ�',02,'����',052,'���',053,'�뱸','��Ÿ')����
from student;

