--p460 cursor
--select 문 또는 데이터조작어 같은  sql 문 실행했을때
--해당  sql 문을 처리하는 정보를 저장한 메모리 공간

--cursor  open fetch close ===> for loop end
select * from emp where deptno=20;

DECLARE
   -- vemp emp%rowtype;  -- 생략가능
    cursor c1 is
    select empno, ename, sal
    from emp
    where deptno=20;
BEGIN
    DBMS_OUTPUT.PUT_LINE('번호  이름 급여');
    for vemp  in c1  loop
    exit when c1%notfound;
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.sal);
    end loop;
end;
/
----emp 테이블의 모든 사원 이름과 급여 출력하고 회원들의 급여 합도 출력
select ename, sal from emp;
select sum(sal) from emp;

DECLARE
    total number :=0;
    CURSOR emp_cursor is
    select ename, sal
    from emp;
BEGIN
    for cur_var in emp_cursor loop
    exit when emp_cursor%notfound;
         total := total + cur_var.sal;
         dbms_output.put_line(cur_var.ename||' ' ||cur_var.sal);
    end loop;
    dbms_output.put_line('총합 : '||to_char(total,'999,999'));
end;
/
--------
select ename, sal from emp order by sal desc;
--사원별 급여현황 급여의 내림차순으로 출력
--이름 별표(100 에 별표하나) <- 반올림(sal)
-- 예) JAMES(950)  :  JAMES **********(950)
DECLARE
    CURSOR star_cursor is
    select ename, sal
    from emp
    order by sal desc;
    
    cnt number := 0; --별 갯수
    star varchar2(100);

BEGIN
    dbms_output.put_line('--사원별 급여 현황 ----');
    
    for cur_var in star_cursor loop  
        cnt := round(cur_var.sal/100);   
        star := null;
        for i in 1..cnt loop --별표 출력   
            star := star ||'*';
        end loop;
        dbms_output.put_line(cur_var.ename||' '||star||' ('||cur_var.sal||')');
    end loop;
end;
/

-- 급여가 2000이상인 것만 출력
DECLARE
    CURSOR star_cursor is
    select ename, sal
    from emp
    where sal > 2000
    order by sal desc;
    
    cnt number := 0; --별 갯수
    star varchar2(100);

BEGIN
    dbms_output.put_line('--사원별 급여 현황 ----');
    
    for cur_var in star_cursor loop  
        cnt := round(cur_var.sal/100);   
        star := null;
        for i in 1..cnt loop --별표 출력   
            star := star ||'*';
        end loop;
        dbms_output.put_line(cur_var.ename||' '||star||' ('||cur_var.sal||')');
    end loop;
end;
/
----
DECLARE
    CURSOR star_cursor is
    select ename, sal
    from emp
    order by sal desc;
    
    cnt number := 0; --별 갯수
    star varchar2(100);

BEGIN
    dbms_output.put_line('--사원별 급여 현황 ----');
    
    for cur_var in star_cursor loop  
        if cur_var.sal > 2000 then
            cnt := round(cur_var.sal/100);   
            star := null;
            for i in 1..cnt loop --별표 출력   
                star := star ||'*';
            end loop;
            dbms_output.put_line(cur_var.ename||' '||star||' ('||cur_var.sal||')');
        end if;
    end loop;
end;
/
---p462  하나의 데이터를 저장하는 커서 사용
DECLARE
    -- 커서 데이터를 입력할 변수 선언
    v_dept_row dept%rowtype;
    -- 명시적 커서 선언
    cursor c1 is
    select deptno, dname, loc
    from dept
    where deptno =40;
BEGIN
    --커서 열기(open)
    open c1;
    --커서로 부터 읽어온 데이터 사용(fetch)
    FETCH c1 into v_dept_row;
    DBMS_OUTPUT.PUT_LINE('deptno :'||v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('dname :'||v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('loc :'||v_dept_row.loc);
    --커서 닫기(close)
    close c1;
end;
/
--cursor for loop 사용
DECLARE
    cursor c1 is
    select deptno, dname, loc
    from dept
    where deptno=40;

BEGIN
    for i in c1 loop
        DBMS_OUTPUT.PUT_LINE('deptno :'||i.deptno);
        DBMS_OUTPUT.PUT_LINE('dname :'||i.dname);
        DBMS_OUTPUT.PUT_LINE('loc :'||i.loc);
    end loop;
end;
/
--- cursor  사용하지 않고
DECLARE
    v_dept_row dept%rowtype;
begin
    select deptno, dname, loc into v_dept_row
    from dept
    where deptno=40;
    
    DBMS_OUTPUT.PUT_LINE('deptno :'||v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('dname :'||v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('loc :'||v_dept_row.loc);
end;
/
--p468 커서에 사용할 파라미터 입력받기
DECLARE
    v_deptno  dept.deptno%type;
    cursor c1(p_deptno dept.deptno%type)  is
      select deptno, dname, loc
      from dept
      where deptno = p_deptno;
BEGIN
   --INPUT_DEPTNO 에 부서번호를 입력받고 v_deptno에 대입
    v_deptno :=&INPUT_DEPTNO;
    for c1_rec in c1(v_deptno) loop
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || c1_rec.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || c1_rec.LOC);
    end loop;
end;
/

----
DECLARE
    v_deptno  dept.deptno%type;
    cursor c1(p_deptno dept.deptno%type,
              p_dname dept.dname%type)
      is
      select deptno, dname, loc
      from dept
      where deptno = p_deptno or dname = p_dname;
BEGIN
   --INPUT_DEPTNO 에 부서번호를 입력받고 v_deptno에 대입
   -- INPUT_DEPTNO 이거나 부서명이 SALES 사원 정보 출력
    v_deptno :=&INPUT_DEPTNO;
    for c1_rec in c1(v_deptno,'SALES') loop
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || c1_rec.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || c1_rec.LOC);
    end loop;
end;
/
















