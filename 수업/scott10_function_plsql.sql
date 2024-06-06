-----function p497
-- function  생성
create or REPLACE FUNCTION func_aftertax(
    sal in number
)
return number
is
    tax number :=0.05;
begin
    return  round(sal-(sal*tax));
end func_aftertax;
/

--function  호출  1
DECLARE
    aftertax number;
begin
    aftertax := func_aftertax(3000);
    DBMS_OUTPUT.PUT_LINE('after-tax income : ' || aftertax);
end;
/
--function  호출 2
VARIABLE x number;
EXECUTE  :x := func_aftertax(5000);
print x;

select func_aftertax(3000) from dual;
select empno, ename, sal, func_aftertax(sal) as AFTERTAX
from emp;

drop function func_aftertax;
------------------
-- function 생성  보너스 = sal *200
create or REPLACE function cal_bonus(
    p_empno in emp.empno%type    -- in 은  생략가능
)
return number
is
 v_sal number;
begin
    select sal into v_sal
    from emp
    where empno = p_empno;
    return v_sal*200;
end cal_bonus;
/
-- function  호출1
VARIABLE bonus number;
EXECUTE  :bonus :=cal_bonus(7369);
print bonus;
-- function  호출2
DECLARE
    b number;
begin
      b := cal_bonus(7369);
      DBMS_OUTPUT.PUT_LINE('보너스 : ' ||  b);
end;
/
----------------
--function 생성
create or REPLACE function cal_bonus2(
    p_empno  emp.empno%type    -- in 은  생략가능
)
return number
is
 v_sal number;
begin
    select sal into v_sal
    from emp
    where empno = p_empno;
    return v_sal*200;
end cal_bonus2;
/


--function 호출
ACCEPT empno prompt '사원번호 입력 :';
DECLARE
    bonus2 number;
begin
      bonus2 := cal_bonus2(&empno);
      DBMS_OUTPUT.PUT_LINE('보너스2 : ' ||  bonus2);
EXCEPTION
    when no_data_found then
     DBMS_OUTPUT.PUT_LINE('없는 사원번호입니다');
end;
/
---------------------
-- function 생성  보너스 = sal *200
create or REPLACE function cal_bonus55(
    p_empno in emp.empno%type    -- in 은  생략가능
)
return varchar2
is
 v_sal number;
begin
    select sal into v_sal
    from emp
    where empno = p_empno;
    return to_char(v_sal*200)||'입니다.';
EXCEPTION
  when no_data_found then
    return '없는 사원번호입니다';
end cal_bonus55;
/
--function 호출
ACCEPT empno prompt '사원번호 입력 :';
DECLARE
    bonus5 varchar2(100);
begin
      bonus5 := cal_bonus55(&empno);
      DBMS_OUTPUT.PUT_LINE('보너스5 : ' ||  bonus5);
end;
/
------------------------
------p518 연습문제
--1


--2
-- 함수  func_date_kor ==> YYYY년MM월DD일 형태로 출력
create or REPLACE FUNCTION func_date_kor(
     in_date DATE
)
return varchar2
is
begin
    return to_char(in_date, 'YYYY"년"MM"월"DD"일"');
end;
/

select ename, func_date_kor(hiredate) as hiredate
from emp
where empno = 7369;








