--�� �а��� �Ի��� ���� ������ ������ ������ȣ, �̸�, �а��� ���
-- �� �Ի����� ��������(professor,department)
select * from professor; 
select * from department; 

select deptno, min(hiredate)
from professor
group by detpno;

select p.profno, p.name, p.deptno, d.dname,p.hiredate
from professor p , department d
where p.deptno = d.deptno and (p.deptno, p.hiredate)
in (
    select deptno, min(hiredate)
    from professor
    group by deptno)
order by p.hiredate; --3 �� select �� �÷� ����

--employees
select * from employees; 
-- employee_id = ��� ���̵�, manager_id : �Ŵ��� ���̵�, first_name:firstname
--1. �μ���ȣ�� 80���� ū �μ��� ������̵�, firstname, �Ŵ��� ���̵� ���
select employee_id ������̵�,first_name ����̸�, manager_id �Ŵ������̵�
from employees
where department_id >= 80;

--2. �μ���ȣ�� 80���� ū �μ��� ������̵�, firstname, �Ŵ��� �̸� ���
-- ��������
select e.employee_id ������̵�, e.first_name ����̸�, m.first_name �Ŵ����̸�
from employees e , employees m
where e.manager_id = m.employee_id 
and e.department_id > 80;

--3. Donald ���� ������ �޴� ����� ���̵�, �̸�, �������
select employee_id, first_name, salary 
from employees
where first_name = 'Donald';

select employee_id, first_name, salary
from employees
where salary =(select salary 
from employees
where first_name = 'Donald');

--4. Donald �Ի����� �����ϰų� �ʰ� �Ի��� ����� ���̵�, �޿�, �Ի��� ���
select employee_id, salary , hire_date
from employees
where hire_date >= (select hire_date from employees where first_name = 'Donald'); 

select * from employees; 
--5. �μ���ȣ�� 100�� �μ��� ��� �޿����� ���� �޿��� �޴� ����� �̸��� �޿� ���
select first_name, salary
from employees
where salary > (select avg(salary) from employees where department_id =100);

