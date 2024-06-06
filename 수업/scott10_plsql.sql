set SERVEROUTPUT on;
--프로시져
create table emp_mon
as
select * 
from emp;
select * from emp_mon;
-- (empno, ename, job, mgr,sal)
-- 4000,'홍길동','사원',5000,800 추가
-- 4001,'홍길동1','사원1',5000,900 추가
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
EXECUTE emp_prece(4000,'홍길동','사원',5000,800);
EXECUTE emp_prece(4001,'홍길동1','사원1',5000,900);
select * from emp_mon;

---- 부서명, 인원수, 급여합계를 구하는 프로시저(sumProcess) 작성
select d.dname 부서명,  count(e.empno) 인원수,  sum(e.sal) 급여합계
from emp e, dept d
where e.deptno = d.deptno
group by d.dname;
----------
-- 부서명  //  인원  // 급여합계
create or replace PROCEDURE sumProcess
is
    cursor sum_cur is
    select d.dname 부서명,  count(e.empno) 인원수,  sum(e.sal) 급여합계
    from emp e, dept d
    where e.deptno = d.deptno
    group by d.dname;
begin
    for i in sum_cur loop
        dbms_output.put_line('부서명 : '|| i.부서명);
        dbms_output.put_line('인원수 : '|| i.인원수);
        dbms_output.put_line('급여합계 : '|| i.급여합계);
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
-- IN 은 디폴트 값으로 생략가능
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
--EXECUTE pro_param_in(1); --오류발생
EXECUTE pro_param_in(param1=>10, param2=>20);
--p490 OUT
--프로시저 작성
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

--프로시저 호출(실행)
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

-- 프로시저 호출
DECLARE
    no number;
begin
    no := 5;
    pro_param_input(no);
    dbms_output.put_line('no :'|| no);
end;
/
-----
--emp, dept 테이블을 사용하여 사원번호를 입력받으면
-- 사원번호, 이름, 부서명, 급여 ,상여금을 출력하는 프로시저 작성
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
    dbms_output.put_line('없는 사원번호입니다.');
end pro_emp1;
/
exec pro_emp1(7369);
---

ACCEPT sempno PROMPT '사원번호입력 :';
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
    dbms_output.put_line('없는 사원번호입니다.');    
end pro_emp2;
/

ACCEPT sempno PROMPT '사원번호입력 :';
begin
    pro_emp2(&sempno);
end;
/
----p478 18장 연습문제
--1.명시적 커서를 사용하여 emp 테이블의 전체 데이터를 조회한 후
--커서 안의 데이터를  empno, ename, job, sla. deptno 출력
-----1-1
DECLARE
    V_EMP_ROW emp%rowtype;
    CURSOR c1 is 
    select * from emp;
begin
-- 커서 열기 (open)
  open c1;
  loop
  -- 커서로 부터 읽어온 데이터 사용(FETCH)
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
 -- 커서 FOR LOOP 시작 (자동 Open, Fetch, Close)
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
-- 교수번호가 주어질 때 교수명과 급여를 알려주는 프로시져
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
--[프로시저 실행 방법1==>return 있을 때]
DECLARE
 v_name professor.name%type;
 v_pay  professor.pay%type;
begin
    info_prof(1001, v_name, v_pay);
    DBMS_OUTPUT.PUT_LINE(v_name||'교수 급여 '||v_pay||'입니다') ;
end;
/
----[프로시저 실행 방법2==>return 있을 때]
VARIABLE name varchar2(10);
VARIABLE pay number;
EXECUTE info_prof(1001, :name, :pay);
print name pay;













