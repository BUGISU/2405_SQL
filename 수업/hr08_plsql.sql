set serveroutput on;
select * from employees;
select * from employees where employee_id=200;
----employee_id = 200 �� ȸ����� id�� �̸� ���
select employee_id, first_name from employees where employee_id=200;
----
DECLARE
    vid  number(4);
    vname VARCHAR2(10);
begin
    select employee_id,first_name  into vid, vname
    from employees
    where employee_id=200;
    dbms_output.put_line(vid || '  ' ||vname);
end;
/
----
--employee_id = 200 �� ȸ����� id�� �޿� ���
DECLARE
    vno       employees.employee_id%type;
    vsalary   employees.salary%type;
begin
    select employee_id,salary  into vno, vsalary
    from employees
    where employee_id=200;
    dbms_output.put_line('���̵�   �޿�');
    dbms_output.put_line(vno || '  ' ||vsalary);
end;
/
-----employee_id = 200 �� ȸ����� ��� ���� �����ؼ� ���̵�, �̸�, �Ի��� ���
select * from employees where employee_id = 200;
DECLARE
    vemployee employees%rowType;
BEGIN
    select *  into vemployee
    from employees
    where employee_id = 200;
    dbms_output.put_line('���̵� �̸� �Ի���');
    dbms_output.put_line(vemployee.employee_id ||' '||
           vemployee.first_name||' '||vemployee.hire_date);
end;
/






