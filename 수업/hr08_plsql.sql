set serveroutput on;
select * from employees;
select * from employees where employee_id=200;
----employee_id = 200 인 회사원의 id와 이름 출력
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
--employee_id = 200 인 회사원의 id와 급여 출력
DECLARE
    vno       employees.employee_id%type;
    vsalary   employees.salary%type;
begin
    select employee_id,salary  into vno, vsalary
    from employees
    where employee_id=200;
    dbms_output.put_line('아이디   급여');
    dbms_output.put_line(vno || '  ' ||vsalary);
end;
/
-----employee_id = 200 인 회사원의 모든 정보 추출해서 아이디, 이름, 입사일 출력
select * from employees where employee_id = 200;
DECLARE
    vemployee employees%rowType;
BEGIN
    select *  into vemployee
    from employees
    where employee_id = 200;
    dbms_output.put_line('아이디 이름 입사일');
    dbms_output.put_line(vemployee.employee_id ||' '||
           vemployee.first_name||' '||vemployee.hire_date);
end;
/






