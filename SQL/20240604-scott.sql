set SERVEROUTPUT on;
--프로시져-----------------------------------------------------------------------
create table emp_mon
as
select * from emp;

select * from emp_mon;
-- 4000,'홍길동','사원',5000,800 추가
insert into emp_mon(empno, ename, job, mgr, sal) 
values (4000,'홍길동','사원',5000,800);
-- 4001,'홍길동1','사원1',5000, 900 추가
insert into emp_mon(empno, ename, job, mgr, sal)
values (4001,'홍길동1','사원1',5000,900);

--프로시저 생성(만들기)
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
execute emp_prece(4000,'홍길동','사원',5000,800);
execute emp_prece(4001,'홍길동1','사원1',5000,900);
select * from emp_mon;
/

-- 부서명 , 인원수, 급여합계를 구하는 프로시저(sumProcess) 작성
select d.dname 부서명 , count (e.empno) 인원수, sum(e.sal) 급여_합계
from emp e, dept d
where e.deptno = d.deptno
group by d.dname;
/
create or replace PROCEDURE sumProcess
is
cursor sum_cur is
    select d.dname 부서명 , count(e.empno) 인원수, sum(e.sal) 총합 
    from emp e, dept d
    where e.deptno = d.deptno
    group by d.dname;
begin
    for i in sum_cur loop
        dbms_output.put_line('sum : '||i.부서명|| ' ' ||i.인원수||' '||i.총합);
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
-- in defalt 값으로 생략이 가능하다
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
-- v3:3(정의) v4:4(디폴드)
execute pro_param_in(1,2);
--오류 발생
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
-- 프로시저 호출(실행)
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
-- 프로시저 호출
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
--emp, dept 테이블을 사용하여 사원번호를 입력받으면
--사원번호, 이름 , 부서명, 급여, 상여금을 출력하는 프로시저 작성
create or replace PROCEDURE pro_emp(
 p_num number
)
is
cursor p is 
    select e.empno 사원번호, e.ename 이름, d.dname 부서명, e.sal 급여, e.comm 상여금
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = p_num;
begin 
    for emp in p loop
        dbms_output.put_line(emp.사원번호 ||' '|| emp.이름 ||' '||  
        emp.부서명 ||' '||  emp.급여 ||' '||  emp.상여금);
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
    select e.empno 사원번호, e.ename 이름, d.dname 부서명, e.sal 급여, e.comm 상여금 
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
    select e.ename 이름, d.dname 부서명, e.sal 급여, e.comm 상여금 
    into v_ename, v_dname, v_sal, v_comm
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = sempno;
    dbms_output.put_line(sempno ||' '||v_ename ||' '||v_dname ||' '||v_sal ||' '||v_comm);
    exception when no_data_found then
       dbms_output.put_line('없는사원');
end; 
/
accept sempno prompt '사원번호 입력: ';
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
 select e.ename 이름, d.dname 부서명, e.sal 급여, e.comm 상여금 
    into rec
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = sempno;
    dbms_output.put_line(sempno ||' '||rec.v_ename ||' '||rec.v_dname 
    ||' '||rec.v_sal ||' '||rec.v_comm);
    exception when no_data_found then dbms_output.put_line('없는사원');
end;
/
accept sempno prompt '사원번호 입력: ';
declare
    v_empno emp.empno%type := &sempno;
begin
    pro_emp2(v_empno);
end;
/
--------------------------------------------------------------------------------
--p478 18장 연습 문제 
--1.명시적 커서를 사용하여 emp 테이블의 전체 데어터를 조회한 후 
--커서안의 데이터를 empno, ename, job, sal, deptno 출력
DECLARE
    v_emp_row emp%rowtype;
    cursor c1 is 
    select *from emp;
begin
-- 커서 열기 
    open c1;
    loop 
    --커서로 부터 읽어온 데이터 사용(fetch)
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
-- 프로시저 실행 방법 1 => return 있을 때
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
    dbms_output.put_line('교수이름 '||p_name||' 교수급여 '||p_pay);
    EXCEPTION when no_data_found then dbms_output.put_line('데이터 없음');
end;
/
declare
v_name professor.name%type;
v_pay professor.pay%type;
begin
    info_prof(1002,v_name, v_pay);
end;
/
-- 프로시저 실행 방법 2 => return 있을 때 ----------------------------------------
variable name varchar2(10);
variable pay number;
execute info_prof(1001,:name, :pay)
print name pay;
-------------------------------------------------------------------------------
--function
--p497
--function 생성
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

----
--function 생성 : 보너스 = sal*200
create or replace function cal_bonus(
    p_empno in emp.empno%type -- in은 생략가능
) return number
is
    v_sal number;
begin
    select sal into v_sal from emp where empno= p_empno ;
    return v_sal *200;
end cal_bonus;
/
--function 호출 1
variable bonus  number;
execute :bonus :=cal_bonus(7369);
print bonus;

--function 호출 2
declare
b number;
begin
   b:= cal_bonus(7369);
   DBMS_OUTPUT.PUT_LINE('보너스 : ' || b);
end;
/
-------------------------------------------------------------------------------
-- function  생성
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
-- function 호출
accept empno prompt '사원번호 입력: '
declare
bonus2 number;
begin
    bonus2:= cal_bonus2(&empno);
    DBMS_OUTPUT.PUT_LINE('보너스2 : ' || bonus2);
    EXCEPTION when no_data_found then DBMS_OUTPUT.PUT_LINE('데이터 없음');
end;
/
-------------------------------------------------------------------------------
-- p518 19장 연습문제
--1 

--2
-- 함수 func_date_kor ==> YYYY년 MM월 DD 일 형태로 출력
create or replace function func_data_kor (
    p_hire in varchar2
) 
return varchar2
is
    c_year varchar2(20);
    c_month varchar2(20);
    c_day varchar2(20);
begin
    select to_char(hiredate,'yyyy')년,to_char(hiredate,'mm')월,to_char(hiredate,'dd')일
    into c_year,c_month,c_day
    from emp
    where hiredate = p_hire;
    return c_year||'년'||c_month||'월'||c_day||'일';
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
  return to_char(p_hire,'yyyy"년"mm"월"dd"일"');
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
    select deptno 부서_번호, dname 부서_이름, loc 지역
    into v_deptno,v_dname,v_loc
    from dept
    where deptno = p_dept;
    
    dbms_output.put_line('부서번호: '|| v_deptno);
    dbms_output.put_line('부서_이름: '|| v_dname);
    dbms_output.put_line('지역: '|| v_loc);
end pro_dept_in;
/
accept input_dept prompt '부서번호 입력'
declare
    v_dept dept.deptno%type := &input_dept;
begin
    pro_dept_in(v_dept);
end;