-----function p497
-- function  ����
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

--function  ȣ��  1
DECLARE
    aftertax number;
begin
    aftertax := func_aftertax(3000);
    DBMS_OUTPUT.PUT_LINE('after-tax income : ' || aftertax);
end;
/
--function  ȣ�� 2
VARIABLE x number;
EXECUTE  :x := func_aftertax(5000);
print x;

select func_aftertax(3000) from dual;
select empno, ename, sal, func_aftertax(sal) as AFTERTAX
from emp;

drop function func_aftertax;
------------------
-- function ����  ���ʽ� = sal *200
create or REPLACE function cal_bonus(
    p_empno in emp.empno%type    -- in ��  ��������
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
-- function  ȣ��1
VARIABLE bonus number;
EXECUTE  :bonus :=cal_bonus(7369);
print bonus;
-- function  ȣ��2
DECLARE
    b number;
begin
      b := cal_bonus(7369);
      DBMS_OUTPUT.PUT_LINE('���ʽ� : ' ||  b);
end;
/
----------------
--function ����
create or REPLACE function cal_bonus2(
    p_empno  emp.empno%type    -- in ��  ��������
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


--function ȣ��
ACCEPT empno prompt '�����ȣ �Է� :';
DECLARE
    bonus2 number;
begin
      bonus2 := cal_bonus2(&empno);
      DBMS_OUTPUT.PUT_LINE('���ʽ�2 : ' ||  bonus2);
EXCEPTION
    when no_data_found then
     DBMS_OUTPUT.PUT_LINE('���� �����ȣ�Դϴ�');
end;
/
---------------------
-- function ����  ���ʽ� = sal *200
create or REPLACE function cal_bonus55(
    p_empno in emp.empno%type    -- in ��  ��������
)
return varchar2
is
 v_sal number;
begin
    select sal into v_sal
    from emp
    where empno = p_empno;
    return to_char(v_sal*200)||'�Դϴ�.';
EXCEPTION
  when no_data_found then
    return '���� �����ȣ�Դϴ�';
end cal_bonus55;
/
--function ȣ��
ACCEPT empno prompt '�����ȣ �Է� :';
DECLARE
    bonus5 varchar2(100);
begin
      bonus5 := cal_bonus55(&empno);
      DBMS_OUTPUT.PUT_LINE('���ʽ�5 : ' ||  bonus5);
end;
/
------------------------
------p518 ��������
--1


--2
-- �Լ�  func_date_kor ==> YYYY��MM��DD�� ���·� ���
create or REPLACE FUNCTION func_date_kor(
     in_date DATE
)
return varchar2
is
begin
    return to_char(in_date, 'YYYY"��"MM"��"DD"��"');
end;
/

select ename, func_date_kor(hiredate) as hiredate
from emp
where empno = 7369;








