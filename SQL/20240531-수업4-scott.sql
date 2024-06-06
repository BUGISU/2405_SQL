---- roll
--connect
--resource
--
----�������� => ������ ���Ἲ
--not null 
--unique
--primary key(�⺻Ű) -not nul /unique
--foreign key(�ܷ�Ű)
--check
--== 
--sql
--
--1. select
--2. DML(���۾� ) - insert , update , delete
--3. DDL(���Ǿ�) -  create, alter, drop, truncate
--4. TCL(Ʈ�����) - commit, rollback
--5. DCL(�����) - grant , revoke

--Ʈ������(ACID)
--���ڼ�(atomicity)
--�ϰ���(consistency) : �ϰ����� db ���� ���� 
--�ݸ���(isolation) 
--���Ӽ�(Durability) : ������ �ݿ��Ǵ� ��
--�����ͻ��� USER_ ALL_ ��
--�ε���
--������
--�� : ������ ���̺� (���Ǽ�, ���ȼ�)

--���� : inner join / outer join
--natural ~ join
--join ~ using 
--join ~ on

--�ζ��� �� 
--���߼������� (in /any /all / exists)
--�׷� �Լ�(sum, avg, max, min)
--group by having
--CTAS
------------------------------------------------------------------------------
--pl/ sql p420
--dbms_output.put_line() ���
set serveroutput on;
begin
    dbms_output.put_line('HELLO');
end;
/
------------------------------------------------------------------------------
--p 421
-- DECLARE ������ �ڷ� ������ �ۼ�����
DECLARE
    v_ename varchar2(10);
    v_empno number(4);
    v_tax constant number(1) :=3;
    v_deptno number(2) not null default 10;
    v_deptno1 dept.deptno%TYPE := 5; --������ ���� ���� 
begin
    v_ename := 'SMITH';
    v_empno := 7788;
    dbms_output.put_line('v_ename : ' ||  v_ename);
    dbms_output.put_line('v_empno1 : ' || v_empno);
    v_empno := 9900;
    dbms_output.put_line('v_empno2 : ' || v_empno);
    dbms_output.put_line('v_tax : ' || v_tax);
    //constant �� ���� ������ ����
    v_tax := 5; -- ���� �߻�
    dbms_output.put_line('v_tax : ' || v_tax);
    dbms_output.put_line('v_deptno : ' || v_deptno);
    dbms_output.put_line('v_deptno1 ������ : ' || v_deptno1);
end;
/
------------------------------------------------------------------------------
--p429
--select *from dept;
--select deptno, dname, loc from dept where deptno=40;
------------------------------------------------------------------------------
DECLARE
    v_deptno_row varchar2(20);
begin
select deptno, dname, loc into v_deptno_row 
from dept
where deptno =40;
    dbms_output.put_line('DEPTNO : '  || v_deptno_row.deptno);
    dbms_output.put_line('dname : '  || v_deptno_row.dname);
    dbms_output.put_line('loc : '  || v_deptno_row.loc);
end;
/
------------------------------------------------------------------------------
DECLARE
    v_deptno varchar2(20);   
    v_dname varchar2(20);   
    v_loc varchar2(20);   

begin
select deptno, dname, loc into v_deptno ,v_dname, v_loc
from dept
where deptno =40;

dbms_output.put_line('DEPTNO : '  || v_deptno.deptno);
dbms_output.put_line('dname : '  || v_dname.dname);
dbms_output.put_line('loc : '  || v_loc.loc);
end;
/
------------------------------------------------------------------------------
DECLARE
    v_deptno_row dept%rowtype;
    v_number number :=30;
begin
    select deptno, dname, loc into v_deptno_row 
    from dept
    where deptno =40;
    if mod(v_number,2) = 1 then 
        dbms_output.put_line('Ȧ�� : '  || v_number);
    else 
        dbms_output.put_line('¦�� : '  || v_number);
    end  if;
    dbms_output.put_line('Number : '  || v_number);
    dbms_output.put_line('DEPTNO : '  || v_deptno_row.deptno);
    dbms_output.put_line('dname : '  || v_deptno_row.dname);
    dbms_output.put_line('loc : '  || v_deptno_row.loc);
end;
/

--p434 ���� ���(A,B,C,D,F ����)
DECLARE
    v_score number:= 87;
BEGIN
    if v_score >=90 then
        dbms_output.put_line('A����');
    elsif v_score>=80 then
         dbms_output.put_line('B����');
    elsif v_score>=70 then
        dbms_output.put_line('C����');
    elsif v_score>=60 then
         dbms_output.put_line('D����');
    else
        dbms_output.put_line('F����');
    end if;
END;
/
declare
    v_score number:= 87;
begin
    case trunc(v_score/10)
        when 10 then dbms_output.put_line('A����');
        when 9 then dbms_output.put_line('A����');
        when 8 then dbms_output.put_line('B����');
        when 7 then dbms_output.put_line('C����');
        when 6 then dbms_output.put_line('D����');
        else  dbms_output.put_line('F����');
    end case;
end; 
/
declare
    v_score number:= 87;
begin
    case
        when v_score >=90 then dbms_output.put_line('A����');
        when v_score >=80 then dbms_output.put_line('B����');
        when v_score >=70 then dbms_output.put_line('C����');
        when v_score >=60 then dbms_output.put_line('D����');
        else dbms_output.put_line('F����');
    end case;
end; 
/
--p439 �ݺ���
declare
    v_num number := 0;
begin
    loop 
        v_num := v_num+1;
        dbms_output.put_line('v_num: ' || v_num);
        if v_num>3 then
            exit;
        end if;
    end loop;
end; 
/
declare
    v_num number := 0;
begin
    while v_num <4 loop
        dbms_output.put_line('while: ' || v_num);
        v_num := v_num+1;
    end loop;
    --
    for i in 0..4 loop
        dbms_output.put_line('for: ' || i);
    end loop;
    --
     for i in reverse 0..4 loop
        dbms_output.put_line('for reverse: ' || i);
    end loop;
end;
/

--p442 ¦���� ���
begin
    for i in 0..4 loop
        if mod(i,2)=0 and i !=0 then
            dbms_output.put_line('¦�� i ���: ' || i);
        end if;
    end loop;
end; 
/
-- continue�� ���ǿ� �����ϴ� ���, �ٽ� �ݺ������� ���ư�
begin
    for i in 0..4 loop
        continue when mod(i,2)=1;
        dbms_output.put_line('¦�� i ���: ' || i);
    end loop;
end;
/