--pl/sql(p420)
set SERVEROUTPUT on;
BEGIN
    dbms_output.put_line('Hello');
end;
/
--p421
DECLARE
    v_ename VARCHAR2(10);
    v_empno number(4) ;
    v_tax CONSTANT number(1) := 3;
    v_deptno number(2) not null default 10;
    v_deptno1 dept.deptno%type :=5; --������
BEGIN
    v_ename := 'SMITH';
    v_empno := 7788;
    dbms_output.put_line('v_ename : ' || v_ename); -- v_ename : SMITH
    dbms_output.put_line('v_empno : ' || v_empno); -- v_empno : 7788
    v_empno := 9900;
    dbms_output.put_line('v_empno : ' || v_empno); -- v_empno : 9900
    dbms_output.put_line('v_tax : ' || v_tax);--  v_tax : 3
    --v_tax := 5;  �����߻� 
    dbms_output.put_line('v_tax : ' || v_tax);  --  v_tax :3
    dbms_output.put_line('v_deptno : ' || v_deptno);
    dbms_output.put_line('v_deptno1 : ' || v_deptno1);
end;
/
--p429
select * from dept;
select deptno, dname, loc from dept where deptno=40;

DECLARE
   v_deptno_row  dept%rowtype;
   v_number   number := 30;
BEGIN
    select deptno, dname, loc into v_deptno_row
    from dept
    where deptno=40;
    if  mod(v_number,2 ) = 1 then
         dbms_output.put_line(v_number || 'Ȧ���Դϴ�.');
    else
         dbms_output.put_line(v_number || '¦���Դϴ�.');
    end if;     
    dbms_output.put_line('v_number : ' || v_number);
    dbms_output.put_line('DEPTNO : ' || v_deptno_row.deptno);
    dbms_output.put_line('dname : '  || v_deptno_row.dname);
    dbms_output.put_line('loc : '    || v_deptno_row.loc);
end;
/
------
DECLARE
   v_deptno  VARCHAR2(20);
   v_dname  VARCHAR2(20);
   v_loc   VARCHAR2(20);
BEGIN
    select deptno, dname, loc into v_deptno,v_dname,v_loc
    from dept
    where deptno=40;
    
    dbms_output.put_line('DEPTNO11 : ' || v_deptno);
    dbms_output.put_line('dname11 : '  || v_dname);
    dbms_output.put_line('loc11 : '    || v_loc);
end;
/

-- p434 �������(A/B/C/D/F ����)
DECLARE
    v_score number := 55;
BEGIN
    if v_score >= 90 then
        dbms_output.put_line('A����');
    elsif v_score >= 80 then
        dbms_output.put_line('B����');
    elsif v_score >= 70 then
        dbms_output.put_line('C����');
    elsif v_score >= 60 then
        dbms_output.put_line('D����');   
    else
        dbms_output.put_line('F����');   
    end if;
    
    
    case trunc(v_score/10)
        when 10 then dbms_output.put_line('A����!!');
        when 9 then dbms_output.put_line('A����!!');
        when 8 then dbms_output.put_line('B����!!');
        when 7 then dbms_output.put_line('C����!!');
        when 6 then dbms_output.put_line('D����!!');
        else  dbms_output.put_line('F����!!');
    end case;
    
     case 
        when v_score >=90  then dbms_output.put_line('A����!');
        when v_score >=80 then dbms_output.put_line('B����!');
        when v_score >=70 then dbms_output.put_line('C����!');
        when v_score >=60 then dbms_output.put_line('D����!');
        else  dbms_output.put_line('F����!');
    end case;
end;
/
--�ݺ��� p439
DECLARE
    v_num number :=0 ;
begin
    loop
        dbms_output.put_line('v_num : ' || v_num);
        v_num := v_num +1;
        if v_num > 4 then
            exit;
        end if;
    end loop;    
end;
/
---
DECLARE
    v_num number := 0;
begin
    while v_num <4 loop
        dbms_output.put_line('���� while v_num : ' || v_num);
        v_num := v_num + 1; 
    end loop;
    ---
    for i  in 0..4  loop
        dbms_output.put_line('���� for i : ' || i);
    end loop;
    --
    for i  in REVERSE 0..4  loop
        dbms_output.put_line('���� for REVERSE i : ' || i);
    end loop;
end;
/
--p442
--¦���� ���
begin
    for i in 0..4 loop  -- i ==> 0,1,2,3,4
        if mod(i,2) =0 then  
            DBMS_OUTPUT.PUT_LINE('���� i �� �� ' || i);
        end if; 
    end loop;
end;
/

begin
    for i in 0..4 loop  -- i ==> 0,1,2,3,4
        continue when mod(i,2)=1;
        DBMS_OUTPUT.PUT_LINE('���� i �� �� ' || i);
    end loop;
end;
/














