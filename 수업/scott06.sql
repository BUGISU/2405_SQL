--p291 11�� Ʈ�����
-- Ʈ����� : �� �̻� ���� �� �� ���� �ּ� ���� ������
--           �ѹ��� �����Ͽ� �۾� �Ϸ��ϰų� ��� �������� �ʰų�(�۾����)
--           ALL or Nothing(commit / rollback)
--           TCL

-- Ʈ�����(ACID)
-- A : ���ڼ�( Atomicity )
-- C : �ϰ���(Consistency) - �ϰ�������  DB ���� ����
-- I : �ݸ���(Isolation)
  --  -  Ʈ����� ���� �� �ٸ� Ʈ������� �۾��� ������� ���ϵ��� �����ϴ� ��
-- D : ���Ӽ� ( Durability) - ���������� ����� Ʈ������� ������ �ݿ��� �Ǵ� ��

--p298 �б��ϰ���
-- �ݸ����� 
 --  Oracle :  Read Commited
 --  MySQL  :  Repeatable  Commited
 
 --11�� ��������(p309)
create table dept_hw
as select * from dept;
select * from dept_hw;

update dept_hw
set dname ='DATABASE', loc='SEOUL'
where deptno=30;

rollback;
select * from dept_hw;
--12�� �������� p324
drop table emp_hw;
--1
create table emp_hw(
    empno NUMBER(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
 );
 --2. emp_hw���̺� bigo �÷� �߰�
 alter table emp_hw
 add bigo varchar2(20);
 
 select * from emp_hw;
 --3. bigo ũ�� 30���� ����
alter table emp_hw
modify bigo varchar2(30);

desc emp_hw;
--4. bigo  �÷���  remark �� ����
alter table emp_hw
rename column bigo to remark;

select * from emp_hw;
--5. emp ���̺��� ���� emp_hw ���̺� ������ �ֱ�
insert into emp_hw
select empno, ename, job, mgr, hiredate,sal, comm, deptno, null
from emp;
select * from emp_hw;

delete from emp_hw;
commit;
select * from emp_hw;

insert into emp_hw(empno, ename, job, mgr, hiredate,sal, comm, deptno)
select *
from emp;
select * from emp_hw;

--6. emp_hw ����
drop table emp_hw;
-------
-- 13��  p327
--�����ͻ���
  --USER_    / ALL_   / DBA_
--�ε���
--View(��) - ������ ���̺�(���Ǽ�, ���ȼ�)

select * from dictionary;
--scott ������ ������ �ִ� ��� ���̺� ��ȸ
select table_name from user_tables;
--scott ������ ������ �ִ� ��� ��ü ���� ��ȸ
select owner, table_name from all_tables;

--p336 �ε��� ����
create index idx_emp_sal
on emp(sal);
--�ε��� ����
drop index idx_emp_sal;

--p341
--��(view) - ������ ���̺�(���Ǽ�, ���ȼ�)
create view vw_emp20
as( select empno, ename, job, deptno
    from emp
    where deptno> 20);
select * from   vw_emp20;  
select * from user_views;

create or replace view vw_emp20
as( select empno, ename, job, deptno
    from emp
    where deptno> 20);
--emp ���̺� ��ü ������  v_emp1  �� ����  
create or replace view v_emp1
as select * from emp;

select * from v_emp1;
-- v_emp1 (3000, 'ȫ�浿', sysdate) �߰�
insert into v_emp1(empno, ename, hiredate)
values(3000, 'ȫ�浿', sysdate);
select * from v_emp1;
select * from emp;

delete from emp 
where empno =3000;
commit;
select * from emp;
select * from v_emp1;

drop view v_emp1;

create or replace  view v_emp1
as
select empno, ename, hiredate
from emp
with read only; -- �б⸸

select * from v_emp1;
insert into v_emp1(empno, ename, hiredate)
values(3000,'ȫ�浿',  sysdate);  --�����߻�

-- �μ��� �ִ� �޿��� �޴� �츶�� �μ���ȣ, �μ���, �޿� ���
select * from emp; -- 12��
select * from dept; -- 4��

select deptno, max(sal)
from emp
group by deptno;

select e.deptno, d.dname, e.sal
from emp e, dept d
where e.deptno = d.deptno 
and (e.deptno, sal)  in (select deptno, max(sal)
                        from emp
                        group by deptno) ;
-------------------
-- �ζ��κ�
select e.deptno, d.dname, e.sal
from (select deptno, max(sal) sal
      from emp
      group by deptno)e, dept d
where e.deptno = d.deptno;  

--p346
select * from emp order by ename desc;
--������ 3���� ���
select * from emp;
--rownum
select  rownum rn , e.* 
from (select *
      from emp
      order by ename desc) e
where rownum <=3;
--with ���(p259)
with e as (select * from emp order by ename)
select rownum, e.*
from e
where rownum <=3;
--p340 ������
create table dept_sequence
as select *
from dept
where 1<>1;

select * from dept_sequence;
--������ ����
create sequence seq_dept_sequence
increment by 10
start with  10
maxvalue 90
minvalue 0
nocycle
nocache;
select * from user_sequences;
select * from dept_sequence;
-- 'DATABASE' 'SEOUL' �� �߰�
insert into dept_sequence(dname, loc)
values('DATABASE' ,'SEOUL');

select * from dept_sequence;

insert into dept_sequence(deptno, dname, loc)
values(seq_dept_sequence.nextval, 'DATABASE' ,'SEOUL');
insert into dept_sequence(deptno, dname, loc)
values(seq_dept_sequence.nextval, 'DATABASE1' ,'SEOUL1');
insert into dept_sequence(deptno, dname, loc)
values(seq_dept_sequence.nextval, 'DATABASE2' ,'SEOUL2');
insert into dept_sequence(deptno, dname, loc)
values(seq_dept_sequence.nextval, 'DATABASE3' ,'SEOUL3');
commit;
select * from dept_sequence;
select seq_dept_sequence.currval
from dual;
--������
drop sequence seq_dept_sequence;
--dept_sequence ����
drop table dept_sequence;

create SEQUENCE emp_seq
increment by 1
start with 1
minvalue 1
NOCYCLE
nocache;
select emp_seq.nextval from dual;

alter sequence emp_seq
increment by 20
cycle;

select emp_seq.nextval from dual;
drop sequence emp_seq;

select * from emp;
------p357 13�� ��������
--1-1. emp ���̺�� ���� ������ EMPIDX ���̺� ����
create table EMPIDX
as select * 
from emp;

select * from EMPIDX;
--1-2 EMPIDX ���̺�  EMPNO ����  IDX_EMPIDX_EMPNO �ε��� ����
create index IDX_EMPIDX_EMPNO
on EMPIDX(EMPNO);
--1-3  ������ ���� �並 ���� ������ �ε��� Ȯ��
select *
from user_indexes
where index_name = 'IDX_EMPIDX_EMPNO';

--2-1.  �޿��� 1500 �ʰ��� ����鸸��  EMPIDX_OVER15K �� ����
-- �߰������� �����ϸ� O  �ƴϸ� X
create or replace view EMPIDX_OVER15K
as (select empno, ename, job, deptno, sal, comm,
    nvl2(comm, 'O','X') comm2
    from EMPIDX
    where sal > 1500
);    -- with read only
select * from EMPIDX_OVER15K;

--3-1 dept ���̺� ������  DEPTSEQ ���̺� ����
create table DEPTSEQ
as select * from dept;
--3-2 ������ SEQ_DEPTSEQ ����
create SEQUENCE SEQ_DEPTSEQ
    INCREMENT by 1
    start with 1
    maxvalue 99
    minvalue 1
    nocycle
    nocache;
--3-3 ������ �߰�
insert into DEPTSEQ(deptno, dname, loc)
values(SEQ_DEPTSEQ.nextval,'DATABASE','SEOUL');

insert into DEPTSEQ(deptno, dname, loc)
values(SEQ_DEPTSEQ.nextval,'DATABASE1','SEOUL1');

insert into DEPTSEQ(deptno, dname, loc)
values(SEQ_DEPTSEQ.nextval,'DATABASE2','SEOUL2');
commit;
select * from DEPTSEQ;

--p360 14�� �������� ==>�����͹��Ἲ
--not null
--unique
--primary key(�⺻Ű) ==> not null / unique
--foreign key(�ܷ�Ű)
--check

--p362
create table table_notnull(
  login_id VARCHAR2(20) not null,
  login_pwd VARCHAR2(20) not null,
  tel VARCHAR2(20)
);
insert into table_notnull(login_id,login_pwd, tel)
values('aa','1111','010-1111-2222');
commit;
select * from table_notnull;

insert into table_notnull(login_id,login_pwd, tel)
values('bb','2222','010-1111-2222');
commit;
select * from table_notnull;

insert into table_notnull(login_id,login_pwd)
values('cc','3333');
commit;
select * from table_notnull;

insert into table_notnull(login_pwd, tel)
values('4444','010-4444-5555'); --�����߻� not null

create table table_notnull2(
    login_id VARCHAR2(20) constraint tbl_nn2_loginID not null,
    login_pwd VARCHAR2(20) constraint tbl_nn2_loginPWD not null,
    tel VARCHAR2(20)
);
insert into table_notnull2 values('aa','1111','010-1111-2222');
insert into table_notnull2 values('aa','1111','010-1111-2222');
commit;
select * from table_notnull2;

alter table table_notnull2
modify(tel constraint  tbl_nn2_tel not null);


insert into table_notnull2(login_id, login_pwd)
values('bb','2222'); -- �����߻�  tel  ��  not null �̹Ƿ�

--table_notnull2 ����  login_id�� unique �������� �ο�
alter table table_notnull2
modify(login_id constraint tbl_nn2_unique_loginID unique);
select * from table_notnull2;
delete from table_notnull2;
commit;
insert into table_notnull2 values('aa','1111','010-1111-2222');
commit;

--�����߻� (SCOTT.TBL_NN2_UNIQUE_LOGINID)�� ����
insert into table_notnull2 values('aa','1111','010-1111-2222');
 --���� ���� tbl_nn2_tel ����
alter table table_notnull2
drop constraint tbl_nn2_tel;
 --���� ���� tbl_nn2_tel not null �߰� ==> ������ ���� 
alter table table_notnull2
MODIFY (tel CONSTRAINT tbl_nn2_tel not null);
---
create table table_unique(
    login_id varchar2(20) constraint tbl_unique_loginID unique,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
insert into table_unique values('aa','1111','010-1111-2222');
-- �����߻�
insert into table_unique values('aa','1111','010-1111-2222');
insert into table_unique values(null,'1111','010-1111-2222');
insert into table_unique values(null,'3333','010-1111-3333');
select * from table_unique;
--�������� ��ȸ
select owner, constraint_name
from user_constraints;

--���̺� ����
drop table table_unique;
drop table table_notnull;
drop table table_notnull2;
-------
create table table_pk(
    login_id varchar2(20) primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
-- �����߻� login_id �⺻Ű�̹Ƿ�  not null / unique �ؾ� ��
insert into table_pk(login_pwd, tel) values('111','010-1111-2222');
drop table table_pk;
--------
--1) ������ �� ���̺� ����
-- board(num, title, writer, content, regdate)
--      number,                      date(�⺻�� : sysdate)
-- num : �⺻Ű
-- ������ ���� : board_seq  1/1/1/ no
create table board(
    num number(3) primary key,
    title varchar2(30),
    writer varchar2(30),
    content varchar2(100),
    regdate date default sysdate
);
create sequence board_seq
    increment by 1
    start with 1
    minvalue 1
    nocycle
    nocache;

--2) ������ �߰�
 -- (1, board1, ȫ�浿, 1�� �Խñ�, 24/05/28),
 -- (2, board2, ������, 2�� �Խñ�, 24/05/28)  
 insert into board(num, title, writer, content)
 values(board_seq.nextval, 'board1','ȫ�浿','1�� �Խñ�');
 commit;
 select * from board;
 
 insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board21','������','2�� �Խñ�',sysdate);
 --2�� �����Ƿ� ���Ἲ ���� ���� ���� �߻�
 --insert into board(num, title, writer, content, regdate)
 --values(2, 'board21','������','2�� �Խñ�',sysdate);
 commit;
 select * from board;
 insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board3','������','3�� �Խñ�',sysdate);
  insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board4','������4','4�� �Խñ�',sysdate);
  insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board5','������5','5�� �Խñ�',sysdate);
  insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board6','������6','6�� �Խñ�',sysdate);
  insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board7','������7','7�� �Խñ�',sysdate);
commit;
select * from board;
--board���̺�   num ������������ �ؼ� ������ 3���� ���
  select rownum rn ,b.*
  from (select * from board order by num desc) b
  where rownum <=3;

--board���̺�   num ������������ �ؼ� 3~5���� ���  
  select * 
  from  (select rownum rn ,b.*
         from (select * from board order by num desc) b
         where rownum <=5)
  where rn >=3 ;
 drop sequence board_seq;
 drop table board;
  
  
  
  