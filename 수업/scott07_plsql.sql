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
    v_deptno1 dept.deptno%type :=5; --참조형
BEGIN
    v_ename := 'SMITH';
    v_empno := 7788;
    dbms_output.put_line('v_ename : ' || v_ename); -- v_ename : SMITH
    dbms_output.put_line('v_empno : ' || v_empno); -- v_empno : 7788
    v_empno := 9900;
    dbms_output.put_line('v_empno : ' || v_empno); -- v_empno : 9900
    dbms_output.put_line('v_tax : ' || v_tax);--  v_tax : 3
    --v_tax := 5;  오류발생 
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
         dbms_output.put_line(v_number || '홀수입니다.');
    else
         dbms_output.put_line(v_number || '짝수입니다.');
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

-- p434 학점출력(A/B/C/D/F 학점)
DECLARE
    v_score number := 55;
BEGIN
    if v_score >= 90 then
        dbms_output.put_line('A학점');
    elsif v_score >= 80 then
        dbms_output.put_line('B학점');
    elsif v_score >= 70 then
        dbms_output.put_line('C학점');
    elsif v_score >= 60 then
        dbms_output.put_line('D학점');   
    else
        dbms_output.put_line('F학점');   
    end if;
    
    
    case trunc(v_score/10)
        when 10 then dbms_output.put_line('A학점!!');
        when 9 then dbms_output.put_line('A학점!!');
        when 8 then dbms_output.put_line('B학점!!');
        when 7 then dbms_output.put_line('C학점!!');
        when 6 then dbms_output.put_line('D학점!!');
        else  dbms_output.put_line('F학점!!');
    end case;
    
     case 
        when v_score >=90  then dbms_output.put_line('A학점!');
        when v_score >=80 then dbms_output.put_line('B학점!');
        when v_score >=70 then dbms_output.put_line('C학점!');
        when v_score >=60 then dbms_output.put_line('D학점!');
        else  dbms_output.put_line('F학점!');
    end case;
end;
/
--반복문 p439
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
        dbms_output.put_line('현재 while v_num : ' || v_num);
        v_num := v_num + 1; 
    end loop;
    ---
    for i  in 0..4  loop
        dbms_output.put_line('현재 for i : ' || i);
    end loop;
    --
    for i  in REVERSE 0..4  loop
        dbms_output.put_line('현재 for REVERSE i : ' || i);
    end loop;
end;
/
--p442
--짝수만 출력
begin
    for i in 0..4 loop  -- i ==> 0,1,2,3,4
        if mod(i,2) =0 then  
            DBMS_OUTPUT.PUT_LINE('현재 i 의 값 ' || i);
        end if; 
    end loop;
end;
/

begin
    for i in 0..4 loop  -- i ==> 0,1,2,3,4
        continue when mod(i,2)=1;
        DBMS_OUTPUT.PUT_LINE('현재 i 의 값 ' || i);
    end loop;
end;
/














