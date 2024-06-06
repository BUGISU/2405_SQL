set SERVEROUTPUT on;
--���ν���
create table emp_mon
as
select * 
from emp;
select * from emp_mon;
-- (empno, ename, job, mgr,sal)
-- 4000,'ȫ�浿','���',5000,800 �߰�
-- 4001,'ȫ�浿1','���1',5000,900 �߰�
create or replace PROCEDURE  emp_prece(
    v_empno emp.empno%type,
    v_ename emp.ename%type,
    v_job emp.job%type,
    v_mgr emp.mgr%type,
    v_sal emp.sal%type)
is
begin
    insert into emp_mon(empno, ename,job, mgr, sal)
    values(v_empno,v_ename,v_job,v_mgr,v_sal);
    commit;
end;
/
EXECUTE emp_prece(4000,'ȫ�浿','���',5000,800);
EXECUTE emp_prece(4001,'ȫ�浿1','���1',5000,900);
select * from emp_mon;

---- �μ���, �ο���, �޿��հ踦 ���ϴ� ���ν���(sumProcess) �ۼ�
select d.dname �μ���,  count(e.empno) �ο���,  sum(e.sal) �޿��հ�
from emp e, dept d
where e.deptno = d.deptno
group by d.dname;
----------
-- �μ���  //  �ο�  // �޿��հ�
create or replace PROCEDURE sumProcess
is
    cursor sum_cur is
    select d.dname �μ���,  count(e.empno) �ο���,  sum(e.sal) �޿��հ�
    from emp e, dept d
    where e.deptno = d.deptno
    group by d.dname;
begin
    for i in sum_cur loop
        dbms_output.put_line('�μ��� : '|| i.�μ���);
        dbms_output.put_line('�ο��� : '|| i.�ο���);
        dbms_output.put_line('�޿��հ� : '|| i.�޿��հ�);
    end loop;
end;
/
EXECUTE sumProcess;
---p484
create or REPLACE PROCEDURE  pro_noparam
is
v_empno number(4) := 7788;
v_ename varchar2(10);
begin
    v_ename :='SCOTT';
    dbms_output.put_line('v_empno :' || v_empno);
    dbms_output.put_line('v_ename :' || v_ename);
end;
/
EXECUTE pro_noparam;

----
create or REPLACE PROCEDURE pro_param(
  p_empno number,
  p_ename varchar2
)
is
begin
 dbms_output.put_line('p_empno :' || p_empno);
 dbms_output.put_line('p_ename :' || p_ename);
end;
/
EXECUTE pro_param(5566,'ABCD');
EXECUTE pro_param(1122,'ffff');
EXECUTE pro_param(3333,'aaaa');
---p488
-- IN �� ����Ʈ ������ ��������
create or REPLACE PROCEDURE pro_param_in(
    param1 IN number,
    param2 number,
    param3 number := 3,
    param4 number default 4
)
is
begin
     dbms_output.put_line('param1 :' ||param1);
     dbms_output.put_line('param2 :' ||param2);
     dbms_output.put_line('param3 :' ||param3);
     dbms_output.put_line('param4 :' ||param4);
end;
/
EXECUTE pro_param_in(1,2,9,8);
EXECUTE pro_param_in(1,2);
--EXECUTE pro_param_in(1); --�����߻�
EXECUTE pro_param_in(param1=>10, param2=>20);
--p490 OUT
--���ν��� �ۼ�
create or REPLACE PROCEDURE pro_param_out(
    in_empno in emp.empno%type,
    out_name out emp.ename%type,
    out_sal out emp.sal%type
)
is
begin   
    select ename,sal into out_name,out_sal
    from emp
    where empno = in_empno;
end pro_param_out;
/

--���ν��� ȣ��(����)
declare
 v_ename emp.ename%type;
 v_sal emp.sal%type;
begin
     pro_param_out(7369, v_ename, v_sal);
     dbms_output.put_line('ename : '||v_ename);
     dbms_output.put_line('sal : '||v_sal);
end;
/
select * from emp where empno=7369;
-----------
--p491
create or REPLACE PROCEDURE pro_param_input(
    inout_no IN out number
)
is
begin
  inout_no := inout_no*2;
end pro_param_input;
/

-- ���ν��� ȣ��
DECLARE
    no number;
begin
    no := 5;
    pro_param_input(no);
    dbms_output.put_line('no :'|| no);
end;
/
-----
--emp, dept ���̺��� ����Ͽ� �����ȣ�� �Է¹�����
-- �����ȣ, �̸�, �μ���, �޿� ,�󿩱��� ����ϴ� ���ν��� �ۼ�
create or REPLACE PROCEDURE pro_emp(
   sempno emp.empno%type    --7900
)  
is
 v_empno  emp.empno%type;
 v_ename  emp.ename%type;
 v_dname  dept.dname%type;
 v_sal  emp.sal%type;
 v_comm  emp.comm%type;
begin
    select e.empno, e.ename, d.dname, e.sal, nvl(e.comm,0)
    into v_empno, v_ename, v_dname, v_sal, v_comm
    from emp e, dept d
    where e.deptno =d.deptno and e.empno = sempno;
    
    dbms_output.put_line('empno : '||v_empno);
    dbms_output.put_line('ename : '||v_ename);
    dbms_output.put_line('dname : '||v_dname);
    dbms_output.put_line('sal : '||v_sal);
    dbms_output.put_line('comm : '||v_comm);

end pro_emp;
/
exec pro_emp(7900);

---
create or REPLACE PROCEDURE pro_emp1(
   sempno emp.empno%type    --7369
)  
is
 v_ename  emp.ename%type;
 v_dname  dept.dname%type;
 v_sal  emp.sal%type;
 v_comm  emp.comm%type;
begin
    select  e.ename, d.dname, e.sal, nvl(e.comm,0)
    into  v_ename, v_dname, v_sal, v_comm
    from emp e, dept d
    where e.deptno =d.deptno and e.empno = sempno;
    
    dbms_output.put_line('empno : '||sempno);
    dbms_output.put_line('ename : '||v_ename);
    dbms_output.put_line('dname : '||v_dname);
    dbms_output.put_line('sal : '||v_sal);
    dbms_output.put_line('comm : '||v_comm);
EXCEPTION
    when no_data_found then
    dbms_output.put_line('���� �����ȣ�Դϴ�.');
end pro_emp1;
/
exec pro_emp1(7369);
---

ACCEPT sempno PROMPT '�����ȣ�Է� :';
begin
    pro_emp1(&sempno);
end;
/

--------
create or REPLACE PROCEDURE pro_emp2(
    sempno in emp.empno%type
)
is
   type RECORD_DEPT is record(
     v_ename  emp.ename%type,
     v_dname  dept.dname%type,
     v_sal  emp.sal%type,
     v_comm  emp.comm%type
    );
    rec RECORD_DEPT;
begin
    select  e.ename, d.dname, e.sal, nvl(e.comm,0)
    into  rec
    from emp e, dept d
    where e.deptno =d.deptno and e.empno = sempno;
    dbms_output.put_line('empno : '||sempno);
    dbms_output.put_line('ename : '||rec.v_ename);
    dbms_output.put_line('dname : '||rec.v_dname);
    dbms_output.put_line('sal : '||rec.v_sal);
    dbms_output.put_line('comm : '||rec.v_comm);
EXCEPTION
    when no_data_found then
    dbms_output.put_line('���� �����ȣ�Դϴ�.');    
end pro_emp2;
/

ACCEPT sempno PROMPT '�����ȣ�Է� :';
begin
    pro_emp2(&sempno);
end;
/
----p478 18�� ��������
--1.����� Ŀ���� ����Ͽ� emp ���̺��� ��ü �����͸� ��ȸ�� ��
--Ŀ�� ���� �����͸�  empno, ename, job, sla. deptno ���
-----1-1
DECLARE
    V_EMP_ROW emp%rowtype;
    CURSOR c1 is 
    select * from emp;
begin
-- Ŀ�� ���� (open)
  open c1;
  loop
  -- Ŀ���� ���� �о�� ������ ���(FETCH)
    FETCH c1  into V_EMP_ROW;
    EXIT WHEN c1%NOTFOUND;
    dbms_output.put_line('EMPNO : '|| V_EMP_ROW.empno );
    dbms_output.put_line('ENAME : '|| V_EMP_ROW.ename);
    dbms_output.put_line('JOB : '||V_EMP_ROW.job  );
    dbms_output.put_line('SAL : '||V_EMP_ROW.sal  );
    dbms_output.put_line('DEPTNO : '||V_EMP_ROW.deptno  );
    dbms_output.put_line('');
   end loop;
 close c1;
end;
/
-----1-2
DECLARE
    CURSOR c1 is
    select * from emp;
begin
 -- Ŀ�� FOR LOOP ���� (�ڵ� Open, Fetch, Close)
    for i  in c1 loop
        dbms_output.put_line('EMPNO : '|| i.empno );
        dbms_output.put_line('ENAME : '|| i.ename);
        dbms_output.put_line('JOB : '||i.job  );
        dbms_output.put_line('SAL : '||i.sal  );
        dbms_output.put_line('DEPTNO : '||i.deptno  );
        dbms_output.put_line('');
    end loop;
end;
/
---------
-- ������ȣ�� �־��� �� ������� �޿��� �˷��ִ� ���ν���
create or REPLACE PROCEDURE info_prof(
  p_profno in professor.profno%type,
  p_name out professor.name%type,
  p_pay out professor.pay%type
)
is
begin
    select name, pay into p_name,p_pay
    from professor
    where profno = p_profno;

end info_prof;
/
--[���ν��� ���� ���1==>return ���� ��]
DECLARE
 v_name professor.name%type;
 v_pay  professor.pay%type;
begin
    info_prof(1001, v_name, v_pay);
    DBMS_OUTPUT.PUT_LINE(v_name||'���� �޿� '||v_pay||'�Դϴ�') ;
end;
/
----[���ν��� ���� ���2==>return ���� ��]
VARIABLE name varchar2(10);
VARIABLE pay number;
EXECUTE info_prof(1001, :name, :pay);
print name pay;













