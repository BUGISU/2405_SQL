--����� Ȯ�� �Ҽ� ����
set serveroutput on;
/*
EMPLOYEES ���� DEPARTMENT_ID, FIRST_NAME,SALARY, PHONE_NUMBER,��Ÿ�� ����ϵ� 
�޿��� õ���� �и� ��ȣ ���
�޿��� 5000������ ��� ��Ÿ�� '���ӱ�', 5000~10000 '�����ӱ�',
10000 �ʰ� '���ӱ�'  
*/
select *from employees;
select department_id, first_name, phone_number
from employees;

select * from employees;
select department_id, FIRST_NAME,SALARY, PHONE_NUMBER from employees;

DECLARE
    CURSOR etc_cursor  is
    select department_id, FIRST_NAME,SALARY, PHONE_NUMBER 
    from employees;
    
    etc VARCHAR2(20);

BEGIN
    for i  in etc_cursor  loop
        if i.salary > 10000 then etc :='���ӱ�';
        ELSIF i.salary > 5000 then etc :='�����ӱ�';
        ELSIF i.salary <= 5000 then etc := '���ӱ�';
        end if;
        dbms_output.put_line(i.department_id ||' '||i.FIRST_NAME||' '
        ||to_char(i.SALARY,'999,999')||' '||i.PHONE_NUMBER||' '||etc);
     end loop;
end;
/
-- case when ���
DECLARE
    CURSOR etc_cursor  is
    select department_id, FIRST_NAME,SALARY, PHONE_NUMBER
    from employees;
    etc VARCHAR2(20);
BEGIN
    dbms_output.put_line('--EMPLOYEES �ӱ�����(case���)---');
    for i  in etc_cursor  loop
    case  
        when i.salary > 10000 then etc :='���ӱ�';
        when i.salary > 5000 then etc :='�����ӱ�'; 
        when  i.salary <= 5000 then etc :='���ӱ�'; 
            dbms_output.put_line(i.department_id ||' '||i.FIRST_NAME||' '
            ||to_char(i.SALARY,'999,999')||' '||i.PHONE_NUMBER||' '||etc);
    end case;
    end loop;
end;
/
-------------------------------------------------------------------------------
/*���, ����, �μ��ڵ�, �μ���, ��Ÿ�� ����ϵ�
employee_id / first_name / department_id / department_name
�μ��ڵ尡 80�̸� '�츮�μ�' �ƴϸ� 'Ÿ�μ�'��Ÿ�ڸ��� ���.
employees departments*/
select *from employees;
select *from departments;
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e,departments d
where e.department_id = d.department_id;
/
declare
    cursor c1 is
    select e.employee_id ���, e.first_name ����, e.department_id �μ��ڵ�, d.department_name �μ���
    from employees e,departments d
    where e.department_id = d.department_id;
    v_ect varchar2(20);
begin 
    for v in c1 loop
        if v.�μ��ڵ�  = 80 then
            v_ect :='�츮 �μ�';
        else  v_ect :='Ÿ �μ�';
        end if;
        dbms_output.put_line(v.��� ||' '||v.����||' '
            ||v.�μ��ڵ�||' '||v.�μ���||' '||v_ect);
    end loop;
end;
/
--join ~ on
declare
    cursor c1 is
    select e.employee_id ���, e.first_name ����, e.department_id �μ��ڵ�, d.department_name �μ���
    from employees e join departments d
    on e.department_id = d.department_id;
    v_ect varchar2(20);
begin 
    for v in c1 loop
        if v.�μ��ڵ�  = 80 then
            v_ect :='�츮 �μ�';
        else  v_ect :='Ÿ �μ�';
        end if;
        dbms_output.put_line(v.��� ||' '||v.����||' '
            ||v.�μ��ڵ�||' '||v.�μ���||' '||v_ect);
    end loop;
end;
/