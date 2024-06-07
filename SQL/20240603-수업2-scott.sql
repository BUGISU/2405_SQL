--p444
set SERVEROUTPUT on;
--1. ���� 1~10 ���� Ȧ�� ���
begin
    for  i  in 1..10 loop
        if mod(i,2) =1 then
            dbms_output.put_line('���� i�� ��: ' || i);
        end if;
    end loop;
end;
/

begin
    for  k  in 1..10 loop
            CONTINUE when mod(k,2)=0;
            dbms_output.put_line('���� k�� ��: ' ||k);
    end loop;
end;
/
DECLARE
    v_num number :=1;
begin
    while v_num <10 loop
        if mod(v_num,2)=1 then
            dbms_output.put_line('���� v_num�� ��: ' ||v_num);
        end if;
        v_num := v_num+1;
    end loop;
end;
/
--2. dept ���̺��� deptno�� ���� �μ��� ���
select deptno from dept;
--v_deptno ���� ���
--10,20,30,40 �� �ƴϸ� n/a
declare
    v_deptno dept.deptno%type := 0;
begin
       case v_deptno
        when 10 then
            dbms_output.put_line('DNAME: ' ||v_deptno);
        when 20 then
            dbms_output.put_line('DNAME: ' ||v_deptno);
        when 30 then
            dbms_output.put_line('DNAME: ' ||v_deptno);
        when 40 then
            dbms_output.put_line('DNAME: ' ||v_deptno);
        else   dbms_output.put_line('DNAME: ' || 'n/a');
        end case;
end;
/
--------------------------------------------------------------------------------
-- ���� if
-- �μ���ȣ�� �Է� �޾Ƽ� �μ����� ���
--ACCEPT ���� �� prompt -> ������ ���� �ֱ� ���ؼ��� ���Ǿȿ� & �� �־��ش�

ACCEPT p_deptno prompt '�μ���ȣ �Է�: ';
DECLARE
    v_deptno dept.deptno%type := &p_detpno;
begin
    if v_deptno =10 then
        dbms_output.put_line('DNAME : ACCOUNTING');
    elsif 
        v_deptno =20 then
        dbms_output.put_line('DNAME : RESERARCH');
     elsif 
        v_deptno =30 then
        dbms_output.put_line('DNAME : SALES');
     elsif 
        v_deptno =40 then
        dbms_output.put_line('DNAME : OPERATOIONS');
    else  
        dbms_output.put_line('DNAME : N/A');
    end if;
end; 
/

ACCEPT p_deptno prompt ' select �μ���ȣ �Է�: ';
DECLARE
    v_deptno dept.deptno%type := &p_detpno;
    v_dname  dept.dname%type;
begin
    select dname into v_dname
    from dept
    where deptno = v_deptno;
    dbms_output.put_line('DNAME : ' || v_dname);
end; 
/
ACCEPT p_deptno prompt ' select �μ���ȣ �Է�: ';
DECLARE
    v_deptno dept.deptno%type := &p_detpno;
    v_dname  dept.dname%type;
begin
    select dname into v_dname
    from dept
    where deptno = v_deptno;
    dbms_output.put_line('DNAME : ' || v_dname);
      if dname is null then
          dbms_output.put_line('DNAME : �ش� ��ȣ ����');
    else
          dbms_output.put_line('DNAME : ' || v_dname);
    end if;
end; 
/
--2*9 =18
begin
    for i in 1..9 loop
        dbms_output.put_line( '2*'||i||'='||2*i);
    end loop;
end;
/
declare
 total number(2);
begin
    for i in 1..9 loop
        total :=3*i;
        dbms_output.put_line('3*'||i||'='||total);
    end loop;
end;
/
ACCEPT p_dan prompt '��� �� �Է�: ';
declare
    v_num number := &p_dan;
begin
    for i in 1..9 loop
        dbms_output.put_line(v_num||'�� :' ||v_num|| '*' ||i||'='||v_num*i);
    end loop;
end;
/
begin
    for i in 1..9 loop
        if mod(i,2)=0 then
         dbms_output.put_line('¦��---------------------------------------');
        for j in 1..9 loop
            dbms_output.put_line(i||'�� :' ||i||'*'||j||'='||i*j);
        end loop;
        end if;
    end loop;
end;
/
--dept ���̺� �̿�
select * from dept;
--�μ���ȣ�� �Է¹޾� �μ���� ������ ����ϱ�
accept p_no PROMPT '�μ����� �Է��ϼ���!' 
declare
    v_no dept.deptno%type := &p_no ;
    v_name dept.dname%type;
    v_loc dept.loc%type;
begin 
    select dname, loc into v_name, v_loc
    from dept
    where deptno = v_no;
        dbms_output.put_line('�μ��� :'||v_name||'���� :'||v_loc);
end; 
/
accept p_no PROMPT '�μ����� �Է��ϼ���!' 
declare
    v_no dept.deptno%type := &p_no ;
    v_name dept.dname%type;
    v_loc dept.loc%type;
begin 
    select dname, loc into v_name, v_loc
    from dept
    where deptno = v_no;
        dbms_output.put_line('�μ��� :'||v_name||'���� :'||v_loc);
--���� ó�� exception when no_data_found then
exception
    when no_data_found then
        dbms_output.put_line('�� ����');
end; 
/
create table A(
a1 number, a2 number, a3 number);

accept pDan Prompt '������ �Է� : ';
declare
 vDan number := &pDan;
 total number(2);
begin
    for i in 1..9 loop
        total := vDan*i;
        dbms_output.put_line(vDan||'�� : '||vDan||'*'||i||'='||total);
        insert into a values(vDan, i, total);
    end loop;
end; 
/
select * from a;
/
--�μ���ȣ�� �Է¹޾� �μ���� ������ ����ϰ� dept_temp ���̺��� ���� insert �ϱ�
create table dept_tmp(
 num number,
 dname varchar2(40),
 loc varchar2(40)
);
-- num �� �������� �߰��ϱ� dept_tmp_seq
create sequence dep_tmp_seq
INCREMENT by 1
start with 1
minvalue 1
nocycle
nocache;
/
accept p_no prompt '�μ��� �Է� : '
DECLARE
    v_no  dept.deptno%type := &p_no;
    v_dname dept.dname%type;
    v_loc dept.loc%type;
begin
    select dname, loc into v_dname, v_loc
    from dept
    where deptno = v_no;
    insert into dept_tmp values(dep_tmp_seq.nextval,v_dname,v_loc);
EXCEPTION when no_data_found then dbms_output.put_line('�� ����');
end;
/
select *from  dept_tmp;
--------------------------------------------------------------------------------
-- 17�� record (p446) - java ������ Ŭ���� ��� �Ҹ�
create table dept_record as select * from dept;
select * from dept_record;
--
declare
    type REC_DEPT is record(
    deptno number (2) not null := 99,
    dname dept.dname%type,
    loc dept.loc%type
    );
    dept_rec REC_DEPT;
begin
    dept_rec.deptno:= 99;
    dept_rec.dname := 'DATABASE';
    dept_rec.loc :='SEOUL';
    insert into dept_record values dept_rec;
end;
/

--dept_record ���̺��� 10�� �μ� ���� ���(record �� �̿�)
declare
 v_dept dept%rowtype;
begin
    select * into v_dept
    from dept_record
    where deptno = 10;
    dbms_output.put_line('deptno: ' || v_dept.deptno);
    dbms_output.put_line('dname: ' || v_dept.dname);
    dbms_output.put_line('loc: ' || v_dept.loc);
end;
/
declare
 type RECdp is record(
    deptno dept.deptno%type,
    dname dept.dname%type,
    loc dept.loc%type
 ); rec RECdp;
begin
    select * into rec
    from dept_record
    where deptno = 10;
    
    dbms_output.put_line('deptno: ' || rec.deptno);
    dbms_output.put_line('dname: ' || rec.dname);
    dbms_output.put_line('loc: ' || rec.loc);
end;
/
--------------------------------------------------------------------------------
--�μ���ȣ�� �Է¹޾� �μ���ȣ, �μ���, ���� ��� �ϴµ� ���ڵ� ���� ���
accept p_no prompt '�μ� ��ȣ �Է�:'
DECLARE
    type REC_TYPE_GET is record(
    deptno dept.deptno%type,
    dname dept.dname%type,
    loc dept.loc%type
    ); rec REC_TYPE_GET;
begin
    select * into rec
    from dept_record
    where deptno = &p_no;
    
    dbms_output.put_line('deptno: ' || rec.deptno);
    dbms_output.put_line('dname: ' || rec.dname);
    dbms_output.put_line('loc: ' || rec.loc);
end; 
/
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
DECLARE
    type REC_TABLE is record(
        deptno dept.deptno%type,
        dname dept.dname%type,
        loc dept.loc%type,
        empno emp.empno%type,
        ename emp.ename%type
    );
    emp_rec REC_TABLE;
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
--------------------------------------------------------------------------------