--p251 ( ������ ��������)
select ename, sal
from emp
where sal < any(select sal 
        from emp    
        where job = 'SALESMAN');
        
select ename, sal from emp; 
select sal
from emp 
where job = 'SALESMAN';

select ename, sal
from emp
where sal < ALL(select sal 
        from emp    
        where job = 'SALESMAN');
        
-- 30�� �μ����� �ִ�޿����� ���� �޿��� �޴� ��� ���(all, any ���)
select ename , sal
from emp
where sal < any(select sal from emp where deptno=30);

select * from dept;
select *
from dept
where EXISTS (select deptno
from dept
where deptno = 20);

-----------------------------------------------------------------------------
--p266
--DML (data manipulation language ���۾�) :�����͸� �߰�, ����, ������ ������ ���۾�
--DDL (data definition language):��ü�� ����, ����, �����ϴ� ������ ���Ǿ�(p311)

--test1(no, name, address, tel)
  --number(5), ���ڿ�(20), ���ڿ�(50), ���ڿ�(20)
--���̺� �����ϴ� Create Table
create table test1(
no number(5),
name varchar2(20),
address VARCHAR2(50),
tel varchar2(20)
);

select * from test1;
---�� �߰�
--(1,'aaa') �߰� (no, name)
insert into test1(no, name) values(1,'aaa');
--(2,'bbb','�λ�', '010-111-2222') �߰�
insert into test1(no, name, address, tel) values(2,'bbb','�λ�', '010-111-2222');
--(3,'ccc','����', '010-333-4444') �߰�
--��� �÷��� ���, ������ �����ϴ�
insert into test1 values(3,'ccc','����', '010-333-4444');

insert into test1 values(4,'ccc','��õ'); -- ����(���� ���� ������� ����)
insert into  test1(no, name, address) values(4,'ccc','��õ');

commit; -- �Ϸᰡ �ǵ��� ���� , Ŀ������ ������ ���������Ʈ �ȿ����� Ȯ���� �Ұ����ϴ�

insert into test1 values(3,'ccc','����1', '010-3344-4455');
select * from test1;

rollback; -- ���� ���·� �ٽ� �ǵ�����

-- ����(����)
-- no 2���� ����� �̸��� ȫ�浿���� ����
update test1 set name  ='ȫ�浿' where no =2;
commit;

-- no r�� 4�� name�� test /adress ����� ����
update test1 
set name ='test',address ='����' 
where no=4;
--���� 
-- test1 ���� no 1�� ���� 
delete test1 where no =1;
delete from test1 where no=2;

delete from test1; -- ��ü ����
select *from test1;
rollback;


--test ���̺� ����( no, name, hiredate) default �� ����ϱ� -----------------------
create table test(
no number(3) default 0,
name VARCHAR2(20) default 'NO NAME',
hiredate date default sysdate
);
select * from test;
--test (1, ȫ�浿) �߰� 
INSERT into test(no,name) values(1,'ȫ�浿'); 
--test�� ��¥ 24/5/20 �߰�
INSERT into test(hiredate) values('24/5/20'); 

-- test���� ��ȣ�� 1���� ����� �̸��� ���������� ����
update test set name='������' where no =1;
-- test���� ��ȣ�� 0�ΰ��� �����ϰ� ��ȣ�� 2�� �����͸� �߰�
delete from test where no=0;
insert into test(no) values(2);
commit;
--CRUD (create, select, update, delete)
--p266(CTAS : create table as select) : select�� ���� ���� ������ ���̺��� ������
create table dept_temp as select * from dept;
select * from dept_temp;

--dept_temp ���̺� 50, DATABASE, SEOUL �߰� 
insert into dept_temp(deptno, dname, loc) values( 50, 'DATABASE', 'SEOUL');
commit;
-- ���̺� ������ ����
create table emp_temp
as select *from emp
where 1<>1; -- false������ ���̺� ������ ������ �´�
desc emp_temp;

select * from emp_temp;
-- emp_temp ; empno, ename, job, mgr, hiredate,sal, comm, deptno
-- 2111, '�̼���' , 'MANAGER', 9999,'07/01/2019', 4000,NULL,20 �߰�

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(2111,'�̼���','MANAGER',9999,to_date('07/01/2019','DD/MM/YYYY'),4000, NULL ,20);
-- ��� ������ ����
insert into emp_temp
values(2111,'�̼���2','MANAGER',9999,to_date('07/01/2019','DD/MM/YYYY'),4000, NULL ,20);

-- 3111,'������','MANAGER',9999,4000,NULL,20 �Ի����� ���ó��ڷ� �߰�
insert into emp_temp
values(3111,'������','MANAGER',9999,sysdate,4000,NULL,20);

--emp_temp ��� ��� ����
delete from emp_temp;
commit;

--p262 9�� ���� ���� 
--1
select e.job, e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e , dept d
where e.deptno = d.deptno and job = (select job from emp where ename='ALLEN');

--2
select * from emp;
select * from dept;
select * from salgrade;

select empno, ename, d.dname, e.hiredate, d.loc, e.sal,s.grade
from emp e, dept d , salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal 
and e.sal>(select avg(sal) from emp)
order by sal desc , e.empno asc;

--3 
select e.empno,e.ename,e.job,e.deptno,d.dname,d.loc
from emp e, dept d
where e.deptno = d.deptno 
and e.deptno =10 
and job not in(select job from emp where deptno =30) ;

--4
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal 
and e.sal > (select max(sal) from emp where job='SALESMAN')
order by empno asc;

select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal 
and e.sal > all(select(sal) from emp where job='SALESMAN')
order by empno asc;
------------------------
--p275 ���������� �̿��ؼ� �ѹ��� ���� ������ �߰�(valuse ������� �ʴ´�)
-- �޿� ���(salgrade)�� 1�� ����� emp_temp�� �߰� 
select *from emp_temp;
select *from salgrade;
select *from emp where sal between 700 and 1200;

insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp
where sal between 700 and 1200;
commit;
select * from emp_temp ;

delete from emp_temp;

--������ ���
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal and s.grade =1;
commit;
--dept ���̺��� �����ؼ� dept_temp2 ���̺��� �����ϰ� 
--40 �� �μ����� DATABASE ���� SEOUL ����
--
create table dept_temp2 as select * from dept;

--drop table dept_temp2;

update dept_temp2 set loc ='SEOUL' ,dname='DATABASE' where deptno=40;
select *from dept_temp2;
commit;

--
select *from emp_temp;
--7900�� ��� �̸��� ���������� �����ϰ� ���� Ȯ�� �� ���� ���
update emp_temp set ename = '������' where empno = 7900;
rollback;
-- dept_temp2 ���̺� 40�� ���� �����ϱ�
select * from dept_temp2;
select * from dept;
-- dept ���̺��� 40���� ������ �μ���� �������� �����ϱ�
--1
update dept_temp2 set dname = 'OPERATIONS',loc='BOSTON' where deptno=40;
--2
update dept_temp2 set dname =( select dname from dept where deptno =40),
loc =( select loc from dept where deptno =40)
where deptno=40;
--3
update dept_temp2
set(dname, loc) = (select dname, loc
                    from dept
                    where deptno =40)
where deptno =40;

rollback;
commit;

-- dept_temp2
delete from  dept_temp2;
select * from dept_temp2;-- ���̺��� ����
--���̺� ���� 
drop table dept_temp2;

-- dept ���̺� �̿��ؼ� dept_tmp ���̺� ����
create table dept_tmp
as select * from dept;

select *from dept_tmp;
--dept_tmp ���̺� LOCATION �÷� �߰�
alter table dept_tmp
add (LOCATION varchar2(50));
-- 10�� �μ��� location�� �������� ����
update dept_tmp set location='����' where deptno =10;
commit;

--dept_tmp ���̺� LOCATION �÷� ����  varchar2(70)
alter table dept_tmp 
modify(location varchar2(70));
desc dept_tmp;

-- location �÷� ���� 
alter table dept_tmp
drop column location;

-- �÷��� loc �� location ���� ����
alter table dept_tmp
rename column loc to location;
select *from dept_tmp;

--���̺� �� ����
rename dept_tmp to dept_tmptmp;
select *from dept_tmptmp;

--��� ������ ���� 
delete from dept_tmptmp;
rollback;
-- ��� ������ ���� (truncate)(DDL:��ɾ�): �ѹ��ص� �����Ͱ� ���ƿ��� ����, �����ȵ�
truncate table dept_tmptmp;
--���̺� ���� 
drop table dept_tmptmp;
-- p 287
create table chap10hw_emp as select *from emp;
create table chap10hw_dept as select *from dept;
create table chap10hw_salgrade as select *from salgrade;

select *  from chap10hw_dept;
--01
insert into chap10hw_dept(deptno, dname,loc) values(50,'ORACLE','BUSAN');
insert into chap10hw_dept(deptno, dname,loc) values(60,'SQL','ILSAN');
insert into chap10hw_dept(deptno, dname,loc) values(70,'SELECT','INCHEON');
insert into chap10hw_dept(deptno, dname,loc) values(80,'DML','BUNDANG');
commit;
--02
select *  from chap10hw_emp;
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7201,'TEST_USER1','MANAGER',7788,to_date('2016-01-02'),4500,50);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7202,'TEST_USER2','ClERK',7201,to_date('2016-02-21'),1800,50);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7203,'TEST_USER3','ANALYST',7201,to_date('2016-04-11'),3400,60);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate,sal,comm, deptno)
values(7204,'TEST_USER4','SALESMAN',7201,to_date('2016-05-31'),2700,300,60);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7205,'TEST_USER5','ClERK',7201,to_date('2016-07-20'),2600,60);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7206,'TEST_USER6','ClERK',7201,to_date('2016-09-08'),2600,70);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7207,'TEST_USER7','LECTURER',7201,to_date('2016-10-28'),2300,80);
insert into chap10hw_emp (empno,ename, job, mgr, hiredate, sal, deptno)
values(7208,'TEST_USER8','LECTURER',7201,to_date('2018-03-09'),1200,80);

--03
select *  from chap10hw_emp;
update chap10hw_emp set deptno = 70 where sal > (select avg(sal) from chap10hw_emp where deptno=50);
commit;
--04
update chap10hw_emp set deptno =80 , sal = sal*1.1
where hiredate >(select min(hiredate) from chap10hw_emp where deptno=60);
commit;
--05
delete from chap10hw_emp where empno in (select empno from chap10hw_emp e, chap10hw_salgrade s 
where e.sal between s.losal and s.hisal and s.grade = 5); 
