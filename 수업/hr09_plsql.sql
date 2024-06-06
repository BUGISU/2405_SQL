set serveroutput on;
/*
EMPLOYEES ���� DEPARTMENT_ID, FIRST_NAME,SALARY, PHONE_NUMBER,��Ÿ�� ����ϵ� 
�޿��� õ���� �и� ��ȣ ���
�޿��� 5000������ ��� ��Ÿ�� '���ӱ�', 5000~10000 '�����ӱ�',
10000 �ʰ� '���ӱ�'  
*/
select * from employees;
select department_id, FIRST_NAME,SALARY, PHONE_NUMBER from employees;

DECLARE
    CURSOR etc_cursor  is
    select department_id, FIRST_NAME,SALARY, PHONE_NUMBER 
    from employees;
    
    etc VARCHAR2(20);
BEGIN
    for i  in etc_cursor  loop
        if i.salary > 10000    then etc :='���ӱ�';
        ELSIF i.salary > 5000  then etc :='�����ӱ�';
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
    for i in etc_cursor loop
        case
        when i.salary > 10000 then etc:='���ӱ�';
        when i.salary > 5000  then etc:='�����ӱ�';
        when i.salary <= 5000 then etc:='���ӱ�';
        end case;
  
        dbms_output.put_line(i.department_id ||' '||i.FIRST_NAME||' '
         ||to_char(i.SALARY,'999,999')||' '||i.PHONE_NUMBER||' '||etc);
    end loop;
end;
/
----------------
/*
���, ����, �μ��ڵ�, �μ���, ��Ÿ�� ����ϵ�,
employee_id/ first_name /department_id/department_name
�μ��ڵ尡 80�̸� '�츮�μ�', �ƴϸ� 'Ÿ�μ�'�� ��Ÿ �ڸ��� ���.
EMPLOYEES   DEPARTMENTS
*/
DECLARE
    CURSOR c1 is
    select e.employee_id  ���, e.first_name ����,
           d.department_id �μ��ڵ� , d.department_name �μ���
    from employees e, departments d
    where e.department_id = d.department_id;
    depart VARCHAR2(20);
BEGIN
    for i in c1 loop
        if i.�μ��ڵ� = 80     then depart:='�츮�μ�';
        elsif i.�μ��ڵ� <> 80 then depart:='Ÿ�μ�';
        end if;
        dbms_output.put_line(i.���||' '||i.����||' '||
             i.�μ��ڵ�||' '||i.�μ���||' '||depart);
    end loop;
end;
/
-- join ~ on ���
DECLARE
     CURSOR c1 is
    select e.employee_id  ���, e.first_name ����,
           d.department_id �μ��ڵ� , d.department_name �μ���
    from employees e join departments d
    on e.department_id = d.department_id;
    depart VARCHAR2(20);
BEGIN
    for i in c1 loop
        if i.�μ��ڵ� = 80 then depart :='�츮�μ�';
        else depart :='Ÿ�μ�';
        end if;
        dbms_output.put_line(i.���||' '||i.����||' '||
             i.�μ��ڵ�||' '||i.�μ���||' '||depart);    
    end loop;
end;
/









