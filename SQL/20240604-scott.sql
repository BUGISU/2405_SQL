set SERVEROUTPUT on;
--���ν���-----------------------------------------------------------------------
create table emp_mon
as
select * from emp;

select * from emp_mon;
-- 4000,'ȫ�浿','���',5000,800 �߰�
insert into emp_mon(empno, ename, job, mgr, sal) 
values (4000,'ȫ�浿','���',5000,800);
-- 4001,'ȫ�浿1','���1',5000, 900 �߰�
insert into emp_mon(empno, ename, job, mgr, sal)
values (4001,'ȫ�浿1','���1',5000,900);

--���ν��� ����(�����)
create or replace PROCEDURE emp_prece(
    v_empno emp.empno%type,
    v_ename emp.ename%type,
    v_job emp.job%type,
    v_mgr emp.mgr%type,
    v_sal emp.sal%type
)
is
begin
    insert into emp_mon(empno, ename, job, mgr, sal) values (v_empno,v_ename,v_job,v_mgr,v_sal);
    commit;
end;
/
execute emp_prece(4000,'ȫ�浿','���',5000,800);
execute emp_prece(4001,'ȫ�浿1','���1',5000,900);
select * from emp_mon;
/

-- �μ��� , �ο���, �޿��հ踦 ���ϴ� ���ν���(sumProcess) �ۼ�
select d.dname �μ��� , count (e.empno) �ο���, sum(e.sal) �޿�_�հ�
from emp e, dept d
where e.deptno = d.deptno
group by d.dname;
/
create or replace PROCEDURE sumProcess
is
cursor sum_cur is
    select d.dname �μ��� , count(e.empno) �ο���, sum(e.sal) ���� 
    from emp e, dept d
    where e.deptno = d.deptno
    group by d.dname;
begin
    for i in sum_cur loop
        dbms_output.put_line('sum : '||i.�μ���|| ' ' ||i.�ο���||' '||i.����);
    end loop;
end;
/
execute sumProcess();
/
--p484
create or replace PROCEDURE pro_noparam
is 
v_empno number(4)  :=7788;
v_ename varchar2(10);
begin
    v_ename := 'SCOTT';
    dbms_output.put_line('v_empno : ' || v_empno);
    dbms_output.put_line('v_ename : ' || v_ename);
end;
/
execute pro_noparam;
/
----
create or replace PROCEDURE pro_param(
    v_empno number,
    v_ename varchar2
)
is
begin
    dbms_output.put_line('v_empno : ' || v_empno);
    dbms_output.put_line('v_ename : ' || v_ename);
end; 
/
execute pro_param(5566,'ABCD');
execute pro_param(1122,'ffff');
/
-- in defalt ������ ������ �����ϴ�
create or replace procedure pro_param_in(
v1 in number,
v2 number,
v3 number :=3,
v4 number default 4
)
is
begin
    dbms_output.put_line('v1 : ' || v1);
    dbms_output.put_line('v2 : ' || v2);
    dbms_output.put_line('v3 : ' || v3);
    dbms_output.put_line('v4 : ' || v4);
end; 
/
execute pro_param_in(1,2,9,8);
-- v3:3(����) v4:4(������)
execute pro_param_in(1,2);
--���� �߻�
execute pro_param_in(1);
execute pro_param_in(v1 =>10, v2=>20);
--------------------------------------------------------------------------------
--p490 out
--procedure out(return)
create or replace PROCEDURE pro_param_out(
    in_empno in emp.empno%type,
    out_name out emp.ename%type,
    out_sal out emp.sal%type
)
is
begin
    select ename, sal into out_name, out_sal
    from emp
    where empno = in_empno;
end pro_param_out; 
/
-- ���ν��� ȣ��(����)
declare
v_ename emp.ename%type; 
v_sal emp.sal%type;
begin 
    pro_param_out(7369,v_ename,v_sal);
    dbms_output.put_line('v_ename : ' || v_ename);
    dbms_output.put_line('v_sal : ' || v_sal);
end;
/
select *from emp where empno=7369;
--------------------------------------------------------------------------------
-- p491
create or replace PROCEDURE pro_param_input(
    inout_no in out number
)
is
begin 
    inout_no := inout_no*2;
end pro_param_input;
/
-- ���ν��� ȣ��
declare
    no number;
begin
    no:=5;
    pro_param_input(no);
    dbms_output.put_line('no : ' || no);
end;
/
select * from emp;
select * from dept;
--emp, dept ���̺��� ����Ͽ� �����ȣ�� �Է¹�����
--�����ȣ, �̸� , �μ���, �޿�, �󿩱��� ����ϴ� ���ν��� �ۼ�
create or replace PROCEDURE pro_emp(
 p_num number
)
is
cursor p is 
    select e.empno �����ȣ, e.ename �̸�, d.dname �μ���, e.sal �޿�, e.comm �󿩱�
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = p_num;
begin 
    for emp in p loop
        dbms_output.put_line(emp.�����ȣ ||' '|| emp.�̸� ||' '||  
        emp.�μ��� ||' '||  emp.�޿� ||' '||  emp.�󿩱�);
    end loop;
end; 
/
create or replace PROCEDURE pro_emp(
    sempno emp.empno%type
)
is
    v_empno emp.empno%type;    
    v_ename emp.ename%type;
    v_dname dept.dname%type;
    v_sal emp.sal%type;    
    v_comm emp.comm%type;
begin
    select e.empno �����ȣ, e.ename �̸�, d.dname �μ���, e.sal �޿�, e.comm �󿩱� 
    into v_empno, v_ename, v_dname, v_sal, v_comm
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = sempno;
    dbms_output.put_line(v_empno ||' '||v_ename ||' '||v_dname ||' '||v_sal ||' '||v_comm);
end; 
/
EXECUTE pro_emp(7900);
/
create or replace PROCEDURE pro_emp1(
    sempno emp.empno%type
)
is 
    v_ename emp.ename%type;
    v_dname dept.dname%type;
    v_sal emp.sal%type;    
    v_comm emp.comm%type;
begin
    select e.ename �̸�, d.dname �μ���, e.sal �޿�, e.comm �󿩱� 
    into v_ename, v_dname, v_sal, v_comm
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = sempno;
    dbms_output.put_line(sempno ||' '||v_ename ||' '||v_dname ||' '||v_sal ||' '||v_comm);
    exception when no_data_found then
       dbms_output.put_line('���»��');
end; 
/
accept sempno prompt '�����ȣ �Է�: ';
declare
    v_empno emp.empno%type := &sempno;
begin
    pro_emp1(v_empno);
end;
/
--------------------------------------------------------------------------------
create or replace PROCEDURE pro_emp2(
sempno in emp.empno%type
)
is 
type record_dept is record(
    v_ename emp.ename%type,
    v_dname dept.dname%type,
    v_sal emp.sal%type,    
    v_comm emp.comm%type
);
rec record_dept;
begin 
 select e.ename �̸�, d.dname �μ���, e.sal �޿�, e.comm �󿩱� 
    into rec
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = sempno;
    dbms_output.put_line(sempno ||' '||rec.v_ename ||' '||rec.v_dname 
    ||' '||rec.v_sal ||' '||rec.v_comm);
    exception when no_data_found then dbms_output.put_line('���»��');
end;
/
accept sempno prompt '�����ȣ �Է�: ';
declare
    v_empno emp.empno%type := &sempno;
begin
    pro_emp2(v_empno);
end;
/
--------------------------------------------------------------------------------
--p478 18�� ���� ���� 
--1.����� Ŀ���� ����Ͽ� emp ���̺��� ��ü �����͸� ��ȸ�� �� 
--Ŀ������ �����͸� empno, ename, job, sal, deptno ���
DECLARE
    v_emp_row emp%rowtype;
    cursor c1 is 
    select *from emp;
begin
-- Ŀ�� ���� 
    open c1;
    loop 
    --Ŀ���� ���� �о�� ������ ���(fetch)
        fetch c1 into v_emp_row;
        EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line('empno :' ||v_emp_row.empno );
        dbms_output.put_line('ename :' ||v_emp_row.empno );
        dbms_output.put_line('job :' ||v_emp_row.job );
        dbms_output.put_line('sal :' ||v_emp_row.sal );
        dbms_output.put_line('deptno :' ||v_emp_row.deptno );
    end loop;
    close c1;
end;
/
-- 1-2
declare 
cursor c1 is
select *from emp;
begin
    for i in c1 loop
        dbms_output.put_line('empno :' ||i.empno );
        dbms_output.put_line('ename :' ||i.empno );
        dbms_output.put_line('job :' ||i.job );
        dbms_output.put_line('sal :' ||i.sal );
        dbms_output.put_line('deptno :' ||i.deptno );
    end loop;
end;
/
-------------------------------------------------------------------------------
-- ���ν��� ���� ��� 1 => return ���� ��
select *from professor;
create or replace PROCEDURE info_prof(
p_profno professor.profno%type,
p_name out  professor.name%type,
p_pay out  professor.pay%type
)
is
begin
    select name, pay into p_name, p_pay
    from professor
    where profno = p_profno;
    dbms_output.put_line('�����̸� '||p_name||' �����޿� '||p_pay);
    EXCEPTION when no_data_found then dbms_output.put_line('������ ����');
end;
/
declare
v_name professor.name%type;
v_pay professor.pay%type;
begin
    info_prof(1002,v_name, v_pay);
end;
/
-- ���ν��� ���� ��� 2 => return ���� �� ----------------------------------------
variable name varchar2(10);
variable pay number;
execute info_prof(1001,:name, :pay)
print name pay;
-------------------------------------------------------------------------------
--function
--p497
--function ����
create or replace function func_aftertax(
    sal in number
)
return number
is 
    tax number := 0.05;
begin
    return round(sal-(sal*tax));
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

----
--function ���� : ���ʽ� = sal*200
create or replace function cal_bonus(
    p_empno in emp.empno%type -- in�� ��������
) return number
is
    v_sal number;
begin
    select sal into v_sal from emp where empno= p_empno ;
    return v_sal *200;
end cal_bonus;
/
--function ȣ�� 1
variable bonus  number;
execute :bonus :=cal_bonus(7369);
print bonus;

--function ȣ�� 2
declare
b number;
begin
   b:= cal_bonus(7369);
   DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || b);
end;
/
-------------------------------------------------------------------------------
-- function  ����
create or replace function cal_bonus2(
    p_empno emp.empno%type
)return number
is
    v_sal emp.empno%type;
begin
    select sal into v_sal
    from emp
    where empno = p_empno;
    return v_sal *200;
 
end cal_bonus2;
/
-- function ȣ��
accept empno prompt '�����ȣ �Է�: '
declare
bonus2 number;
begin
    bonus2:= cal_bonus2(&empno);
    DBMS_OUTPUT.PUT_LINE('���ʽ�2 : ' || bonus2);
    EXCEPTION when no_data_found then DBMS_OUTPUT.PUT_LINE('������ ����');
end;
/
-------------------------------------------------------------------------------
-- p518 19�� ��������
--1 

--2
-- �Լ� func_date_kor ==> YYYY�� MM�� DD �� ���·� ���
create or replace function func_data_kor (
    p_hire in varchar2
) 
return varchar2
is
    c_year varchar2(20);
    c_month varchar2(20);
    c_day varchar2(20);
begin
    select to_char(hiredate,'yyyy')��,to_char(hiredate,'mm')��,to_char(hiredate,'dd')��
    into c_year,c_month,c_day
    from emp
    where hiredate = p_hire;
    return c_year||'��'||c_month||'��'||c_day||'��';
end func_data_kor;
/
select ename, func_data_kor(hiredate) as hiredate
from emp
where empno = 7369;
-----
create or replace function func_data_kor (
    p_hire in date
) 
return varchar2
is
begin
  return to_char(p_hire,'yyyy"��"mm"��"dd"��"');
end;
/
select ename, func_data_kor(hiredate) as hiredate
from emp
where empno = 7369;
--------------------------------------------------------------------------
create or replace procedure pro_dept_in(
    p_dept dept.deptno%type
)
is
    v_deptno dept.deptno%type;
    v_dname dept.dname%type;
    v_loc dept.loc%type;
begin
    select deptno �μ�_��ȣ, dname �μ�_�̸�, loc ����
    into v_deptno,v_dname,v_loc
    from dept
    where deptno = p_dept;
    
    dbms_output.put_line('�μ���ȣ: '|| v_deptno);
    dbms_output.put_line('�μ�_�̸�: '|| v_dname);
    dbms_output.put_line('����: '|| v_loc);
end pro_dept_in;
/
accept input_dept prompt '�μ���ȣ �Է�'
declare
    v_dept dept.deptno%type := &input_dept;
begin
    pro_dept_in(v_dept);
end;