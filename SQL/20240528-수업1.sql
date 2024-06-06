select * from sal_history;
--1. sal_history(empid, hiredate,sal) ���̺� employees �̿�
create table sal_history as select * from employees;
create table sal_history as select employee_id, hire_date, salary from employees;
drop table sal_history;

--2.sal_history(empid, hiredate,sal) ���̺� employees �̿� ������ ����
create table sal_history2(id,hire,sal) as select * from employees where 1<>1;
drop table sal_history2;

--2.1
create table  sal_history
as select employee_id as empid, hire_date as hiredate, salary as sal
from employees
where 1=2;
select * from sal_history;

-- employee_id �� 200���� ū �����͸� sal_history �� ������ �ֱ�
select * from employees;
insert into sal_history(employee_id) 
select employee_id empid, hire_date hiredate, salary sal 
from employees where employee_id >200;
select * from sal_history;
rollback;
--
select * from sal_history;
--2. mgr_histroy(empid, mgr, sal) ���̺��� ����µ� employees �̿��Ͽ� ������ ����
create table mgr_histroy
as select employee_id as empid, manager_id as mgr , salary as sal 
from employees
where 1=2;

--3. employee_id �� 200���� ū �����͸� 
--���� sal_history , mgr_history �� ������ �ֱ� 
--���� ���� insert
insert all 
into sal_history values(empid, hiredate, sal)
into mgr_histroy values(empid, mgr, sal)
select employee_id empid, hire_date hiredate, salary sal, manager_id mgr
from employees
where employee_id>200;

--sal_history , mgr_history ������ ���� 
delete from sal_history; 
delete from mgr_history; 

--4. employee_id �� 200���� ū ������ �߿��� sal�� 10000���� ũ�� sal_history
--mgr�� 200���� ũ�� mgr_history �� ������ �ֱ�
--���� �ִ� insert(conditional insert)
insert all
when sal >10000 then
        into sal_history values(empid, hiredate , sal)
when mgr >200 then
        into mgr_history values(empid, mgr, sal)
select employee_id empid , hire_date hiredate, salary sal, manager_id mgr
from employees
where employee_id >200;

drop table sal_history; 
drop table mgr_history; 

--------------------------------------------------------------------
-- dept2 ���̺��� dcode�� 1000, 1001, 1002 �� �����ͷ� ������
-- dept6 ���̺� ����( decode, dname ,area ����)
select *from dept2;
select *from dept6;
drop table dept6;

create table dept6 as 
select dcode, dname, area from dept2 
where dcode in (1000 , 1001,1002) ;

select *from dept6;
--1.  location (ũ�� 200) �÷� �߰� 
alter table dept6 
add(location VARCHAR2(200));

--2. dcode 1000�� location �� �λ� ����
update dept6 set location='�λ�' where dcode=1000;
commit;

--3. (2000,TEAM, BUSAN, �λ�) -->dept6 �߰�
insert into dept6 values (2000,'TEAM','BUSAN','�λ�');

--4. decode�� 2000�� ����
delete dept6 where dcode =2000;

--5. location ũ�� (70) ���� ����
alter table dept6
modify(location varchar2(70));
desc dept6;

--6. locaiotn �÷� �̸��� loc�� ����
alter table dept6
rename COLUMN location to loc;
commit;

--7. loc �÷��� ����
alter table dept6
drop column loc;

--8. dept6 ���̺� ���� 
drop table dept6;

----------------------------------------------------------------------

