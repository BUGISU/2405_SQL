--p460 cursor
-- select  문 또는 데이터 조작어 같은 sql 문 실행 했을때 
-- 해당 sql 문을 처리하는 정보를 저장한 메모리 공간

--cursor
--open fetch close ==> for loop end
select * from emp where deptno =20;

DECLARE
    cursor c1 is
    select empno, ename, sal
    from emp
    where deptno =20;
begin
     dbms_output.put_line('번호 이름 급여');
     for  v_emp in c1 loop
        exit when c1%notfound; 
        dbms_output.put_line(v_emp.empno || ' ' || v_emp.ename || ' ' ||v_emp.sal );
     end loop;
end; 
/
-- emp 테이블의 모든 사원 이름과 급여 출력하고 회원들의 급여 합도 출력
select ename, sal from emp;
select sum(sal) from emp;

DECLARE
    total number := 0;
    cursor emp_cursor is
    select ename, sal
    from emp;
begin
    for cur_var in emp_cursor loop
      exit when emp_cursor%notfound;
        dbms_output.put_line(cur_var.ename ||' '|| cur_var.sal);        
        total := total + cur_var.sal;
    end loop;
    dbms_output.put_line('total: '|| to_char(total,'L999,999'));
end;
/
select ename, sal from emp order  by sal desc; 
--사원별 급여현황 급여의 내림차순 출력
--이름 별표 (100 에 별표 하나 ) <- 반올림(sal)
--(예) James (950) :James *********(950)
DECLARE
star VARCHAR2(500) := 0; 
cnt number(20) := 0; 
cursor emp_sal is
select ename,sal
from emp
order by sal
desc;
begin
    for v_sal in emp_sal loop
        cnt := round(v_sal.sal/100);
        star := null;
        for i in 1..cnt loop
            star := star ||'*';
        end loop;
            dbms_output.put_line(v_sal.ename ||' '||star||'('|| v_sal.sal||')');
    end loop;
end; 
/

-- 급여가 2000 이상인 것만 출력
DECLARE
star VARCHAR2(500) := 0; 
cnt number(20) := 0; 
cursor emp_sal is
select ename,sal
from emp
where sal>2000
order by sal
desc;
begin
    for v_sal in emp_sal loop
        cnt := round(v_sal.sal/100);
        star := null;
        for i in 1..cnt loop
            star := star ||'*';
        end loop;
            dbms_output.put_line(v_sal.ename ||' '||star||'('|| v_sal.sal||')');
    end loop;
end; 
/
DECLARE
star VARCHAR2(500) := 0; 
cnt number(20) := 0; 
cursor emp_sal is
select ename,sal
from emp
order by sal
desc;
begin
    for v_sal in emp_sal loop
    if v_sal.sal>2000 then
        cnt := round(v_sal.sal/100);
        star := null;
        for i in 1..cnt loop
            star := star ||'*';
        end loop;
            dbms_output.put_line(v_sal.ename ||' '||star||'('|| v_sal.sal||')');
     end if;
    end loop;
end; 
/
-- p462 하나의 데이터를 저장하는 커서 사용
declare
--  커서 데이터를 입력할 변수 선언
    v_dept_row dept%rowtype;
    --명시적 커서 선언
    cursor c1 is
    select deptno, dname, loc
    from dept   
    where deptno =40;
begin
--  커서 열기 (open)
open c1; 
--  커서로 부터 읽어온 데이터 사용(fetch)
fetch c1 into v_dept_row;
    dbms_output.put_line('detno :' || v_dept_row.deptno);
    dbms_output.put_line('dname :' || v_dept_row.dname);
    dbms_output.put_line('loc :' || v_dept_row.loc);
    close c1;
end; 
/
--cursor for loop 사용
declare
    cursor c1 is 
    select deptno, dname,loc
    from dept
    where deptno=40;
begin 
    for i in c1 loop
        dbms_output.put_line('detno :' || i.deptno);
        dbms_output.put_line('dname :' || i.dname);
        dbms_output.put_line('loc :' || i.loc);
    end loop;
end;
/
-- cursor 사용하지 않고 
declare
    v_dept_row dept%rowtype;
begin 
select 
    deptno, dname,loc into v_dept_row
    from dept
    where deptno=40;
     dbms_output.put_line('detno :' || v_dept_row.deptno);
    dbms_output.put_line('dname :' || v_dept_row.dname);
    dbms_output.put_line('loc :' || v_dept_row.loc);
end;
/
-- p468 커서에 사용할 파라미터 입력 받기

select *from dept;
declare
    v_deptno dept.deptno%type;
    cursor cl(p_deptno dept.deptno%type , p_dname dept.dname%type ) is
    select deptno, dname, loc
    from dept
    where deptno =p_deptno or dname = p_dname;
begin 
    v_deptno := &input_deptno ;
    for c1_rec  in cl(v_deptno,'SALES') loop
        dbms_output.put_line('detno :' || c1_rec.deptno);
        dbms_output.put_line('dname :' || c1_rec.dname);
        dbms_output.put_line('loc :' || c1_rec.loc);
    end loop;
end;