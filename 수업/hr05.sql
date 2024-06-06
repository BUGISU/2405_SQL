-- (professor,  department)  ���̺�
-- �� �а��� �Ի��� ���� ������ ������ ������ȣ, �̸� ,�а��� ���
-- �� �Ի����� ��������   (professor,  department)
select * from professor;
select * from department;
select deptno, min(hiredate)
from professor
group by deptno;

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p, department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by p.hiredate ;

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p, department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by p.deptno ;

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p, department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by 3 ; -- 3 �� select �� �÷� ����

--�������� hr_table.sql �� �����ؼ� departments, employees ����
--employees
--( employee_id : ������̵�, manager_id :�Ŵ��� ���̵�,first_name:firstname )
select * from employees;
--1. �μ���ȣ�� 80���� ū �μ��� ������̵�, firstname, �Ŵ��� ���̵� ���
select  employee_id ������̵�, first_name ����̸�,  manager_id �Ŵ������̵�
from employees
where department_id > 80;
--2. �μ���ȣ�� 80���� ū �μ��� ������̵�, firstname, �Ŵ��� �̸� ���
--��������
select e1.employee_id ������̵� , e1.first_name ����̸�, 
    e2.first_name �Ŵ����̸�
from employees e1, employees e2
where e1.manager_id = e2.employee_id and e1.department_id > 80;

--3. Donald ���� ������ �޴� ����� ���̵�, �̸�, ���� ���
select salary
from employees
where first_name = 'Donald';

select employee_id, first_name, salary
from employees
where salary = 2600;

select employee_id, first_name, salary
from employees
where salary = (select salary
                from employees
                where first_name = 'Donald');

--4.Donald �Ի����� �����ϰų� �ʰ� �Ի��� ����� ���̵�, �޿�, �Ի��� ���
select hire_date
from employees
where first_name ='Donald';

select employee_id, salary, hire_date
from employees
where hire_date >= '17/06/21';

select employee_id, salary, hire_date
from employees
where hire_date >= (select hire_date
                    from employees
                    where first_name ='Donald');
--5. �μ���ȣ�� 100�� �μ��� ��� �޿����� ���� �޿��� �޴� ����� �̸��� �޿� ���
select avg(salary) from   employees where department_id = 100;
select first_name, salary
from employees
where department_id = 100;

select first_name, salary
from employees
where salary  > (select avg(salary) 
                from   employees
                where department_id = 100) ;             






