 select * from employees;
 --1. sal_history(empid, hiredate,sal) ���̺� employees �̿�
 create table  sal_history
 as select employee_id, hire_date, salary
 from employees;
 select * from sal_history;
 
 
 --2. sal_history2(empid, hiredate,sal) ���̺� employees �̿� ������
 create table  sal_history2
 as select employee_id, hire_date, salary
 from employees
 where 1=2;
 select * from sal_history2;
 
 create table  sal_history3(id,hire, sal) 
 as select employee_id, hire_date, salary
 from employees
 where 1=2;
 select * from sal_history3;
 drop table sal_history;
 drop table sal_history2;
 drop table sal_history3;
 -- 1.sal_history ������ ����
 create table sal_history
 as select employee_id as empid, hire_date as hiredate, salary as sal
 from employees
 where 1=2;
 select * from sal_history;
 --employees ���̺��� employee_id �� 200���� ū �����͸� 
 --sal_history �� ������ �ֱ�
 insert into sal_history 
 select employee_id empid, hire_date hiredate, salary sal
 from employees
 where employee_id > 200;

 --���
rollback;
select * from sal_history;
--2.mgr_history(empid,  mgr,sal) ���̺� ����µ� employees �̿��Ͽ� ������ ���� 
 create table mgr_history
 as select employee_id as empid, manager_id as mgr, salary as sal
 from employees
 where 1=2; 
 select * from mgr_history;
 -- 3.employee_id �� 200���� ū �����͸� 
 -- ���� sal_history, mgr_history �� ������ �ֱ�
 -- ���Ǿ��� insert(unconditional insert)
 insert all
 into sal_history values(empid, hiredate,sal)
 into mgr_history values(empid, mgr,sal)
 select employee_id empid, hire_date hiredate, salary sal, manager_id mgr
 from employees
 where employee_id > 200;
 
 select * from sal_history;
 select * from mgr_history;
 --  sal_history,mgr_history ������ ����
 delete from sal_history;
 delete from mgr_history;
 commit;
 
 --4.employee_id �� 200���� ū ������ �߿��� sal �� 10000���� ũ�� sal_history
 -- mgr �� 200���� ũ�� mgr_history �� ������ �ֱ�
 --�����ִ� insert(conditional insert)
 insert all
 when  sal > 10000 then
                   into sal_history values(empid, hiredate,sal)
 when  mgr > 200 then into mgr_history values(empid, mgr, sal)
 select employee_id empid, hire_date hiredate,salary sal, manager_id mgr
 from employees 
 where employee_id >200;
 commit;
 
 select * from sal_history;
 select * from mgr_history;
  
 --���̺� ���� sal_history,mgr_history
 drop table sal_history;
 drop table mgr_history;
 ---------------
--dept2 ���̺���  dcode�� 1000,1001,1002�� �����ͷ� ������
--dept6 ���̺� ����(dcode, dname, area ����)
select dcode, dname, area
from dept2
where dcode in (1000,1001,1002);

create table dept6
as select dcode, dname, area
from dept2
where dcode in (1000,1001,1002);
select * from dept6;

--1. location(ũ�� 200) �÷� �߰�
alter table dept6
add(location varchar2(200));

--2. dcode 1000 �� location �� �λ� ����
update dept6
set location='�λ�'
where dcode=1000;
commit;

--3. (2000, TEAM , BUSAN,  �λ�) --> dept6 �߰�
insert into dept6(dcode, dname, area,location)
values(2000, 'TEAM' , 'BUSAN',  '�λ�');
commit;

insert into dept6
values(2001, 'TEAM1' , 'BUSAN1',  '�λ�1');
commit;
select * from dept6;
--4.dcode�� 2000 �� ����
delete from dept6
where dcode = 2000;
commit;
select * from dept6;
-- 5.location �÷� ũ�⸦ 70 ���� ����
alter table dept6
modify(location varchar2(70));
desc dept6;

--6.location �÷��̸���  loc  ����
alter table dept6
rename column location to loc;
select * from dept6;
--7. loc   �÷� ����
alter table dept6
drop column loc;
--8. dept6 ���̺� ����
drop table dept6;


 
 
 
 
 
 
 
 
 
 