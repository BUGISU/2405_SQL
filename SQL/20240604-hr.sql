--결과를 확인 할수 있음
set serveroutput on;
/*
EMPLOYEES 에서 DEPARTMENT_ID, FIRST_NAME,SALARY, PHONE_NUMBER,기타를 출력하되 
급여는 천단위 분리 기호 사용
급여가 5000이하인 경우 기타에 '저임금', 5000~10000 '보통임금',
10000 초과 '고임금'  
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
        if i.salary > 10000 then etc :='고임금';
        ELSIF i.salary > 5000 then etc :='보통임금';
        ELSIF i.salary <= 5000 then etc := '저임금';
        end if;
        dbms_output.put_line(i.department_id ||' '||i.FIRST_NAME||' '
        ||to_char(i.SALARY,'999,999')||' '||i.PHONE_NUMBER||' '||etc);
     end loop;
end;
/
-- case when 사용
DECLARE
    CURSOR etc_cursor  is
    select department_id, FIRST_NAME,SALARY, PHONE_NUMBER
    from employees;
    etc VARCHAR2(20);
BEGIN
    dbms_output.put_line('--EMPLOYEES 임금정보(case사용)---');
    for i  in etc_cursor  loop
    case  
        when i.salary > 10000 then etc :='고임금';
        when i.salary > 5000 then etc :='보통임금'; 
        when  i.salary <= 5000 then etc :='저임금'; 
            dbms_output.put_line(i.department_id ||' '||i.FIRST_NAME||' '
            ||to_char(i.SALARY,'999,999')||' '||i.PHONE_NUMBER||' '||etc);
    end case;
    end loop;
end;
/
-------------------------------------------------------------------------------
/*사번, 성명, 부서코드, 부서명, 기타를 출력하되
employee_id / first_name / department_id / department_name
부서코드가 80이면 '우리부서' 아니면 '타부서'기타자리에 출력.
employees departments*/
select *from employees;
select *from departments;
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e,departments d
where e.department_id = d.department_id;
/
declare
    cursor c1 is
    select e.employee_id 사번, e.first_name 성명, e.department_id 부서코드, d.department_name 부서명
    from employees e,departments d
    where e.department_id = d.department_id;
    v_ect varchar2(20);
begin 
    for v in c1 loop
        if v.부서코드  = 80 then
            v_ect :='우리 부서';
        else  v_ect :='타 부서';
        end if;
        dbms_output.put_line(v.사번 ||' '||v.성명||' '
            ||v.부서코드||' '||v.부서명||' '||v_ect);
    end loop;
end;
/
--join ~ on
declare
    cursor c1 is
    select e.employee_id 사번, e.first_name 성명, e.department_id 부서코드, d.department_name 부서명
    from employees e join departments d
    on e.department_id = d.department_id;
    v_ect varchar2(20);
begin 
    for v in c1 loop
        if v.부서코드  = 80 then
            v_ect :='우리 부서';
        else  v_ect :='타 부서';
        end if;
        dbms_output.put_line(v.사번 ||' '||v.성명||' '
            ||v.부서코드||' '||v.부서명||' '||v_ect);
    end loop;
end;
/