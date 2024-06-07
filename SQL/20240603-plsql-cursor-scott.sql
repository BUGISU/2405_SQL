--p460 cursor
-- select  �� �Ǵ� ������ ���۾� ���� sql �� ���� ������ 
-- �ش� sql ���� ó���ϴ� ������ ������ �޸� ����

--cursor
--open fetch close ==> for loop end
select * from emp where deptno =20;

DECLARE
    cursor c1 is
    select empno, ename, sal
    from emp
    where deptno =20;
begin
     dbms_output.put_line('��ȣ �̸� �޿�');
     for  v_emp in c1 loop
        exit when c1%notfound; 
        dbms_output.put_line(v_emp.empno || ' ' || v_emp.ename || ' ' ||v_emp.sal );
     end loop;
end; 
/
-- emp ���̺��� ��� ��� �̸��� �޿� ����ϰ� ȸ������ �޿� �յ� ���
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
--����� �޿���Ȳ �޿��� �������� ���
--�̸� ��ǥ (100 �� ��ǥ �ϳ� ) <- �ݿø�(sal)
--(��) James (950) :James *********(950)
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

-- �޿��� 2000 �̻��� �͸� ���
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
-- p462 �ϳ��� �����͸� �����ϴ� Ŀ�� ���
declare
--  Ŀ�� �����͸� �Է��� ���� ����
    v_dept_row dept%rowtype;
    --����� Ŀ�� ����
    cursor c1 is
    select deptno, dname, loc
    from dept   
    where deptno =40;
begin
--  Ŀ�� ���� (open)
open c1; 
--  Ŀ���� ���� �о�� ������ ���(fetch)
fetch c1 into v_dept_row;
    dbms_output.put_line('detno :' || v_dept_row.deptno);
    dbms_output.put_line('dname :' || v_dept_row.dname);
    dbms_output.put_line('loc :' || v_dept_row.loc);
    close c1;
end; 
/
--cursor for loop ���
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
-- cursor ������� �ʰ� 
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
-- p468 Ŀ���� ����� �Ķ���� �Է� �ޱ�

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