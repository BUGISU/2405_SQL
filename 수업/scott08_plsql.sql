--p444  16�� ��������
set SERVEROUTPUT on;
--1.���� 1���� 10 ���� Ȧ�� ���
begin
    for i in 1..10 loop
        if mod(i,2)=1  then
            dbms_output.put_line('���� i�� �� : '|| i);
        end if;
    end loop;
end;
/

begin
    for k in 1..10 loop
        CONTINUE when mod(k,2)=0;
        dbms_output.put_line('���� k�� �� : '|| k);
    end loop;
end;
/
DECLARE
    v_num number := 1;  
begin
    while v_num < 10 loop
        dbms_output.put_line('���� v_num�� �� : '|| v_num);
        v_num := v_num + 2;
    end loop;
end;
/

--2.dept ���̺��� deptno�� ���� �μ��� ���
select * from dept;
 --v_deptno ���� ���
 --10,20,30,40 �� �ƴϸ�  N/A
 DECLARE
    v_deptno dept.deptno%type;
 begin
    case v_deptno
        when  10 then  dbms_output.put_line('DNAME : ACCOUNTING');
        when  20 then  dbms_output.put_line('DNAME : RESEARCH');
        when  30 then  dbms_output.put_line('DNAME : SALES');
        when  40 then  dbms_output.put_line('DNAME : OPERATIONS');
        else dbms_output.put_line('DNAME : N/A');
    end case;    
end;
 /
 
 --���� if
 --�μ���ȣ�� �Է¹޾� �μ��� ���
ACCEPT p_deptno   prompt '�μ���ȣ �Է� :' ;
DECLARE
    v_deptno  dept.deptno%type := &p_deptno; 
begin
    if v_deptno = 10 then
     dbms_output.put_line('DNAME : ACCOUNTING');
    elsif v_deptno = 20 then
     dbms_output.put_line('DNAME : RESEARCH');
    elsif v_deptno = 30 then
     dbms_output.put_line('DNAME : SALES');
    elsif v_deptno = 40 then
     dbms_output.put_line('DNAME : OPERATIONS');
    else
      dbms_output.put_line('DNAME : N/A');
    end if;
end;
/

select dname from dept;
----
ACCEPT p_deptno1  prompt 'select �μ���ȣ �Է� :' ;
DECLARE
 v_deptno dept.deptno%type := &p_deptno1;
 v_dname  dept.dname%type;
begin
    select dname into v_dname
    from dept
    where deptno = v_deptno;
    dbms_output.put_line('DNAME111 : '||v_dname);
end;
/
------------------
--2�� ���
-- 2*1 =2
-- 2*2 =4

-- 2* 9 =18
begin
    for i in 1..9 loop
        dbms_output.put_line('2*'||i||'='||2*i);
    end loop;
end;
/
---
DECLARE
 total number(2);
begin
    for i in 1..9 loop
        total := 3*i;
        dbms_output.put_line('3*'||i||'='||total);
    end loop;
end;
/
---
ACCEPT p_dan PROMPT '��� �� �Է� : ';
declare
    v_dan number(2) := &p_dan;
begin
    for i in 1..9 loop
        dbms_output.put_line(v_dan||'*'||i||'='||v_dan*i);
    end loop;
end;
/
----
--dept ���̺� �̿�
-- �μ���ȣ�� �Է¹޾� �μ���� ������ ����ϱ�
accept p_deptno PROMPT '�μ���ȣ �Է� :';
declare
    v_deptno dept.deptno%type := &p_deptno;
    v_dname  dept.dname%type;
    v_loc    dept.loc%type;
BEGIN
    select dname, loc into v_dname, v_loc
    from dept
    where deptno = v_deptno;
    dbms_output.put_line('DNAME :' || v_dname);
    dbms_output.put_line('LOC :' || v_loc) ;
EXCEPTION
    when no_data_found then
        dbms_output.put_line('N/A');
end;
/

-----
create table A(
    A1 number,
    A2 number,
    A3 number
);
select * from a;
accept pdan PROMPT '�������Է� :';
declare
    v_dan number(2) := &pdan;
    tot number(2);
begin   
   for i in 1..9 loop
        tot :=  v_dan*i;
        dbms_output.put_line(v_dan ||'*'|| i || '=' ||tot);
        insert into a values(v_dan, i, tot);
   end loop;
end;
/

create table det_tmp(
    num number,
    dname varchar2(40),
    loc varchar2(40)
);
-- num �� �������� �߰��ϱ�
-- dept_tmp_seq
create sequence dept_tmp_seq
increment by 1
start with 1
minvalue 1
nocycle
NOCACHE;
--�μ���ȣ�� �Է¹޾� �μ���� ������ ����ϰ�
--dept_tmp ���̺� �����Ͽ� insert  �ϱ�
ACCEPT p_deptno2 PROMPT '!!!!!�μ���ȣ �Է� :' ;
declare
    v_deptno  dept.deptno%type :=&p_deptno2;
    v_dname   dept.dname%type;
    v_loc     dept.loc%type;
begin
    select dname, loc into v_dname, v_loc
    from dept
    where deptno=v_deptno;
    insert into det_tmp values(dept_tmp_seq.nextval,v_dname,v_loc);
    commit;
    dbms_output.put_line('DNAME :' || v_dname);
    dbms_output.put_line('LOC :' || v_loc) ;
EXCEPTION 
    when no_data_found then
    dbms_output.put_line('�˻� ����� �����ϴ�');
end;
/
select * from det_tmp;
--p446 record
--ctas ������� dept_record ����
create table dept_record
as 
select * from dept;

select * from dept_record;
---
DECLARE
    type REC_DEPT  is record(
        deptno number(2) not null :=99,
        dname  dept.dname%type,
        loc    dept.loc%type
     );
     dept_rec  REC_DEPT;
begin
    dept_rec.deptno := 99;
    dept_rec.dname  := 'DATABASE';
    dept_rec.loc    := 'SEOUL';
    insert into dept_record values dept_rec;
end;
/
select * from dept_record;
---------------
---dept_record ���̺��� 10�� �μ� ���� ���
-- �������(3��)
DECLARE
    v_deptno dept.deptno%type;
    v_dname dept.dname%type;
    v_loc dept.loc%type;
begin
    select * into v_deptno, v_dname, v_loc
    from dept_record
    where deptno = 10;
    dbms_output.put_line('deptno : ' || v_deptno);
    dbms_output.put_line('dname : ' || v_dname);
    dbms_output.put_line('loc : ' || v_loc);
end;
/
-----
--rowtype ���
DECLARE
    v_dept dept%rowtype;
begin
    select * into v_dept
    from dept_record
    where deptno = 20;
    dbms_output.put_line('deptno : ' || v_dept.deptno);
    dbms_output.put_line('dname : ' || v_dept.dname);
    dbms_output.put_line('loc : ' || v_dept.loc);
end;
/
--
--record �� ���
DECLARE
   type RECORD_DEPT is record(
        deptno dept.deptno%type,
        dname dept.dname%type,
        loc  dept.loc%type
    );
    rec  RECORD_DEPT;
begin
    select * into rec
    from dept_record
    where deptno = 30;
    dbms_output.put_line('deptno : ' || rec.deptno);
    dbms_output.put_line('dname : ' || rec.dname);
    dbms_output.put_line('loc : ' || rec.loc);
end;
/
----
--�μ���ȣ �Է¹޾� �μ���ȣ, �μ���, ���� ����ϴµ� ���ڵ� �� �̿�
accept pdeptno PROMPT '�μ���ȣ�Է�~~~~ : '
declare
    type  RECORD_DEPT1 is record(
        deptno number(2),
        dname varchar2(40),
        loc varchar2(40)
    );
    rec RECORD_DEPT1;
begin
    select * into rec
    from dept_record
    where deptno = &pdeptno;
    dbms_output.put_line('deptno : ' || rec.deptno);
    dbms_output.put_line('dname : ' || rec.dname);
    dbms_output.put_line('loc : ' || rec.loc);
end;
/
--p450
select e.empno, e.ename, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and e.empno=7369;

DECLARE
    type REC_DEPT is record(
        deptno dept.deptno%type,
        dname dept.dname%type,
        loc dept.loc%type
    );
    type REC_EMP is record(
        empno emp.empno%type,
        ename emp.ename%type,
        dinfo REC_DEPT
    );
    emp_rec REC_EMP;
BEGIN
    select e.empno, e.ename, d.deptno, d.dname, d.loc
    into emp_rec.empno, emp_rec.ename,
         emp_rec.dinfo.deptno, emp_rec.dinfo.dname, 
         emp_rec.dinfo.loc
    from emp e, dept d
    where e.deptno = d.deptno
    and e.empno=7369;
    dbms_output.put_line('empno : ' ||emp_rec.empno);
    dbms_output.put_line('ename : ' ||emp_rec.ename);
    dbms_output.put_line('deptno : '||emp_rec.dinfo.deptno);
    dbms_output.put_line('dname : '||emp_rec.dinfo.dname);
    dbms_output.put_line('loc : '||emp_rec.dinfo.loc);
end;
/
------
DECLARE
    type REC_TABLE is record(
        deptno dept.deptno%type,
        dname dept.dname%type,
        loc dept.loc%type,
        empno emp.empno%type,
        ename emp.ename%type
    );
   emp_rec  REC_TABLE;
BEGIN
    select e.empno, e.ename, d.deptno, d.dname, d.loc
    into emp_rec.empno, emp_rec.ename,
         emp_rec.deptno, emp_rec.dname, 
         emp_rec.loc
    from emp e, dept d
    where e.deptno = d.deptno
    and e.empno=7499;
    dbms_output.put_line('empno : ' ||emp_rec.empno);
    dbms_output.put_line('ename : ' ||emp_rec.ename);
    dbms_output.put_line('deptno : '||emp_rec.deptno);
    dbms_output.put_line('dname : '||emp_rec.dname);
    dbms_output.put_line('loc : '||emp_rec.loc);
end;
/


















 
 
 
 
