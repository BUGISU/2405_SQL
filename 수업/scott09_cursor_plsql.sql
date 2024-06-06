--p460 cursor
--select �� �Ǵ� ���������۾� ����  sql �� ����������
--�ش�  sql ���� ó���ϴ� ������ ������ �޸� ����

--cursor  open fetch close ===> for loop end
select * from emp where deptno=20;

DECLARE
   -- vemp emp%rowtype;  -- ��������
    cursor c1 is
    select empno, ename, sal
    from emp
    where deptno=20;
BEGIN
    DBMS_OUTPUT.PUT_LINE('��ȣ  �̸� �޿�');
    for vemp  in c1  loop
    exit when c1%notfound;
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.sal);
    end loop;
end;
/
----emp ���̺��� ��� ��� �̸��� �޿� ����ϰ� ȸ������ �޿� �յ� ���
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
    dbms_output.put_line('���� : '||to_char(total,'999,999'));
end;
/
--------
select ename, sal from emp order by sal desc;
--����� �޿���Ȳ �޿��� ������������ ���
--�̸� ��ǥ(100 �� ��ǥ�ϳ�) <- �ݿø�(sal)
-- ��) JAMES(950)  :  JAMES **********(950)
DECLARE
    CURSOR star_cursor is
    select ename, sal
    from emp
    order by sal desc;
    
    cnt number := 0; --�� ����
    star varchar2(100);

BEGIN
    dbms_output.put_line('--����� �޿� ��Ȳ ----');
    
    for cur_var in star_cursor loop  
        cnt := round(cur_var.sal/100);   
        star := null;
        for i in 1..cnt loop --��ǥ ���   
            star := star ||'*';
        end loop;
        dbms_output.put_line(cur_var.ename||' '||star||' ('||cur_var.sal||')');
    end loop;
end;
/

-- �޿��� 2000�̻��� �͸� ���
DECLARE
    CURSOR star_cursor is
    select ename, sal
    from emp
    where sal > 2000
    order by sal desc;
    
    cnt number := 0; --�� ����
    star varchar2(100);

BEGIN
    dbms_output.put_line('--����� �޿� ��Ȳ ----');
    
    for cur_var in star_cursor loop  
        cnt := round(cur_var.sal/100);   
        star := null;
        for i in 1..cnt loop --��ǥ ���   
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
    
    cnt number := 0; --�� ����
    star varchar2(100);

BEGIN
    dbms_output.put_line('--����� �޿� ��Ȳ ----');
    
    for cur_var in star_cursor loop  
        if cur_var.sal > 2000 then
            cnt := round(cur_var.sal/100);   
            star := null;
            for i in 1..cnt loop --��ǥ ���   
                star := star ||'*';
            end loop;
            dbms_output.put_line(cur_var.ename||' '||star||' ('||cur_var.sal||')');
        end if;
    end loop;
end;
/
---p462  �ϳ��� �����͸� �����ϴ� Ŀ�� ���
DECLARE
    -- Ŀ�� �����͸� �Է��� ���� ����
    v_dept_row dept%rowtype;
    -- ����� Ŀ�� ����
    cursor c1 is
    select deptno, dname, loc
    from dept
    where deptno =40;
BEGIN
    --Ŀ�� ����(open)
    open c1;
    --Ŀ���� ���� �о�� ������ ���(fetch)
    FETCH c1 into v_dept_row;
    DBMS_OUTPUT.PUT_LINE('deptno :'||v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('dname :'||v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('loc :'||v_dept_row.loc);
    --Ŀ�� �ݱ�(close)
    close c1;
end;
/
--cursor for loop ���
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
--- cursor  ������� �ʰ�
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
--p468 Ŀ���� ����� �Ķ���� �Է¹ޱ�
DECLARE
    v_deptno  dept.deptno%type;
    cursor c1(p_deptno dept.deptno%type)  is
      select deptno, dname, loc
      from dept
      where deptno = p_deptno;
BEGIN
   --INPUT_DEPTNO �� �μ���ȣ�� �Է¹ް� v_deptno�� ����
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
   --INPUT_DEPTNO �� �μ���ȣ�� �Է¹ް� v_deptno�� ����
   -- INPUT_DEPTNO �̰ų� �μ����� SALES ��� ���� ���
    v_deptno :=&INPUT_DEPTNO;
    for c1_rec in c1(v_deptno,'SALES') loop
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || c1_rec.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || c1_rec.LOC);
    end loop;
end;
/
















