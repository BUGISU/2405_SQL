set SERVEROUTPUT on;
select *from employees;

select * from employees where employee_id=200;
select employee_id, first_name from employees where employee_id =200;
--=employee_id ==200 인 회사원의 id 와 이름 출력
declare
     v_employee_id employees.employee_id%type := 200 ;
     v_first_name employees.first_name%type;
begin
    select employee_id , first_name  into  v_employee_id , v_first_name
    from employees
    where employee_id= 200;
    dbms_output.put_line('employee_id : '|| v_employee_id);
    dbms_output.put_line('first_name : '|| v_first_name);
end;
/
-- employee_id = 200인 사원인 id와 급여 출력
declare
    vno employees.employee_id%type;
    vaslary employees.salary%type;
begin 
    select employee_id, salary into vno, vaslary
    from employees
    where employee_id =200;
      dbms_output.put_line('employee_id : '|| vno || 'salary : '|| vaslary);

end; 
/
 select * from employees;
--employee_id=200 인 회사원의 모든 정보를 추출해서 아이디, 이름, 입사일 출력
declare
vemployee employees%rowtype;
begin
    select * into vemployee
    from employees
    where employee_id =200;
    dbms_output.put_line('아이디 : '|| vemployee.employee_id 
    || ' 이름 : '||  vemployee.first_name 
    || ' 입사일 : '||vemployee.hire_date);
end; 