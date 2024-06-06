---- roll
--connect
--resource
--
----제약조건 => 데이터 무결성
--not null 
--unique
--primary key(기본키) -not nul /unique
--foreign key(외래키)
--check
--== 
--sql
--
--1. select
--2. DML(조작어 ) - insert , update , delete
--3. DDL(정의어) -  create, alter, drop, truncate
--4. TCL(트랜잭션) - commit, rollback
--5. DCL(제어어) - grant , revoke

--트랜젝션(ACID)
--원자성(atomicity)
--일관성(consistency) : 일관적인 db 상태 유지 
--격리성(isolation) 
--지속성(Durability) : 영원히 반영되는 것
--데이터사전 USER_ ALL_ 등
--인덱스
--시퀀스
--뷰 : 가상의 테이블 (편의성, 보안성)

--조인 : inner join / outer join
--natural ~ join
--join ~ using 
--join ~ on

--인라인 뷰 
--다중서브쿼리 (in /any /all / exists)
--그룹 함수(sum, avg, max, min)
--group by having
--CTAS
------------------------------------------------------------------------------
--pl/ sql p420
--dbms_output.put_line() 출력
set serveroutput on;
begin
    dbms_output.put_line('HELLO');
end;
/
------------------------------------------------------------------------------
--p 421
-- DECLARE 변수의 자료 유형을 작성해줌
DECLARE
    v_ename varchar2(10);
    v_empno number(4);
    v_tax constant number(1) :=3;
    v_deptno number(2) not null default 10;
    v_deptno1 dept.deptno%TYPE := 5; --데이터 유형 참조 
begin
    v_ename := 'SMITH';
    v_empno := 7788;
    dbms_output.put_line('v_ename : ' ||  v_ename);
    dbms_output.put_line('v_empno1 : ' || v_empno);
    v_empno := 9900;
    dbms_output.put_line('v_empno2 : ' || v_empno);
    dbms_output.put_line('v_tax : ' || v_tax);
    //constant 는 값을 변하지 않음
    v_tax := 5; -- 오류 발생
    dbms_output.put_line('v_tax : ' || v_tax);
    dbms_output.put_line('v_deptno : ' || v_deptno);
    dbms_output.put_line('v_deptno1 참조형 : ' || v_deptno1);
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
        dbms_output.put_line('홀수 : '  || v_number);
    else 
        dbms_output.put_line('짝수 : '  || v_number);
    end  if;
    dbms_output.put_line('Number : '  || v_number);
    dbms_output.put_line('DEPTNO : '  || v_deptno_row.deptno);
    dbms_output.put_line('dname : '  || v_deptno_row.dname);
    dbms_output.put_line('loc : '  || v_deptno_row.loc);
end;
/

--p434 학점 출력(A,B,C,D,F 학점)
DECLARE
    v_score number:= 87;
BEGIN
    if v_score >=90 then
        dbms_output.put_line('A학점');
    elsif v_score>=80 then
         dbms_output.put_line('B학점');
    elsif v_score>=70 then
        dbms_output.put_line('C학점');
    elsif v_score>=60 then
         dbms_output.put_line('D학점');
    else
        dbms_output.put_line('F학점');
    end if;
END;
/
declare
    v_score number:= 87;
begin
    case trunc(v_score/10)
        when 10 then dbms_output.put_line('A학점');
        when 9 then dbms_output.put_line('A학점');
        when 8 then dbms_output.put_line('B학점');
        when 7 then dbms_output.put_line('C학점');
        when 6 then dbms_output.put_line('D학점');
        else  dbms_output.put_line('F학점');
    end case;
end; 
/
declare
    v_score number:= 87;
begin
    case
        when v_score >=90 then dbms_output.put_line('A학점');
        when v_score >=80 then dbms_output.put_line('B학점');
        when v_score >=70 then dbms_output.put_line('C학점');
        when v_score >=60 then dbms_output.put_line('D학점');
        else dbms_output.put_line('F학점');
    end case;
end; 
/
--p439 반복문
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

--p442 짝수만 출력
begin
    for i in 0..4 loop
        if mod(i,2)=0 and i !=0 then
            dbms_output.put_line('짝수 i 출력: ' || i);
        end if;
    end loop;
end; 
/
-- continue는 조건에 만족하는 경우, 다시 반복문으로 돌아감
begin
    for i in 0..4 loop
        continue when mod(i,2)=1;
        dbms_output.put_line('짝수 i 출력: ' || i);
    end loop;
end;
/