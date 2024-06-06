-- p291 11�� Ʈ�����
-- Ʈ������ : �� �̻� ���� �� �� ���� �ּ� ���� ������ 
-- �ѹ��� �����ؼ� �۾��� �Ϸ� �ϰų� ��� �������� �ʰų�(�۾����)
-- ALL or Nothing(commit / rollback)

-- TCL : Ʈ������ ��Ʈ�� ������ (����) 
-- Ʈ����� Ư¡(ACID)
-- A(���ڼ�:atomicity)
-- C(�ϰ���: Consistency): �ϰ������� DB ���� ����
-- I(�ݸ���: Isolation) : Ʈ����� ����� �ٸ� Ʈ������� �۾��� ������� ���Ѵ� 
-- D(���Ӽ� :Durability) : ���������� ����� Ʈ������� ������ �ݿ��� �Ǵ� ��

-- p298 �б� �ϰ���
-- �ݸ����� : 
-- ����Ŭ : Read Commited
-- MySQL : Reperatable Commited

--11�� �������� 309
--1
create table dept_hw
as select *from dept;

select *from dept_hw;

update dept_hw
set dname='DATABASE',loc='SEOUL'
where deptno =30;

rollback;
--12�� �������� p324
create table EMP_HW(empno number(4),ename varchar2(10), job varchar2(9),
mgr number(4), hiredate date, sal number(7,2) , comm number(7,2),
deptno number(2));
select *from EMP_HW;
--2
alter TABLE emp_hw
add( BINGO varchar2(20));
--3
alter table emp_hw
MODIFY(bingo varchar2(30));
--4
alter table emp_hw
rename column bingo to remark;
--5
insert into emp_hw
select empno, ename, job, mgr, hiredate, sal, comm, deptno , null
from emp;

--5.1
insert into emp_hw(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select *
from emp; 

rollback;
--6
drop table emp_hw;

------------------------------------------------------------------------
-- 13�� p327
-- �����ͻ���
-- user_ /ALL_ /DBA_
-- �ε��� 
-- (VIEW)�� : �������� ���̺��� �ƴ� ������ ���̺�(���Ǽ�, ���ȼ�) �� ���ؼ� ����

select *from dictionary;
-- scott ������ ������ �ִ� ��� ���̺��� ��ȸ
select table_name from user_tables;
-- scott ������ �������ִ� ��� ��ü ���� ��ȸ
select owner, table_name from all_tables;

-- p336 �ε��� ����
create index idx_emp_sal 
on emp(sal);
--�ε��� ���� 
drop index idx_emp_sal;

--p341
-- ��(VIEW) ������ ���̺�(���Ǽ�, ���ȼ�)
create view vw_emp20
as ( select empno, ename, job, deptno from emp where deptno >20 );

select * from vw_emp20;
--������ �� Ȯ���ϱ�
select *from user_views;

-- �̹� �����ϴ� view �� ���, �������� �����ض� 
create or replace view vw_emp20
as ( select empno, ename, job, deptno from emp where deptno >20 );

--emp ���̺� ��ü ������ v_emp1 �� ����
create or replace view v_emp1
as (select *from emp);

select *from v_emp1;

--v_emp1 (3000,'ȫ�浿',sysdate) �߰� 
insert into v_emp1(empno, ename, hiredate) values(3000,'ȫ�浿',sysdate);
--��� � ���̺��� ������� ����� ������ ����� �Ǵ� ���̺��� ����Ǹ� ���� �����
-- ������ ��� �д� ���Ѹ� �����Ѵ� 
drop view v_emp1;

------------------------
create or replace view v_emp1
as
select empno, ename, hiredate
from emp
with read only; -- �б� ����, ���� ���� �Ұ���

select *from v_emp1;

insert into v_emp1(empno, ename, hiredate)
values(3000,'ȫ�浿',sysdate); --���� �߻�, �б� ���� �ۿ� ����

-- �μ��� �ִ� �޿��� �޴� ����� �μ���ȣ, �μ���, �޿� ���
select * from emp; --12��
select * from  dept; --4��

select deptno, max(sal)
from emp
group by deptno;

select e.deptno, d.dname, e.sal
from emp e, dept d
where e.deptno =d.deptno
and (e.deptno, sal) in (select deptno, max(sal)
                        from emp
                        group by deptno);
-------------------------
-- �ζ��� �� p344
select e.deptno, d.dname, e.sal
from (select deptno, max(sal) sal
        from emp
        group by deptno) e, dept d
where e.deptno =d.deptno;

-- p346 
select *from emp order by ename desc;
-- ������ 3���� ���
-- rownum
select rownum rn, e.*
from (select * 
    from emp
    order by ename desc) e
where rownum <=3;

--with ���(p259)
with e as (select *from emp order by ename)
select rownum, e.*
from e
where rownum <=3;

-- p340 ,������
create table dept_sequence
as select *
from dept
where 1<>1;

select * from dept_sequence;
--������ ���� 
create SEQUENCE seq_dept_sequence
INCREMENT BY 10
start with 10 
maxvalue 90
minvalue 0
nocycle
nocache;

select *from user_sequences;
select *from dept_sequence;
--'DATABASE' 'SEOUL' �� �߰�
insert into dept_sequence (dname, loc)
values('DATABASE','SEOUL');

insert into dept_sequence (deptno, dname, loc)
values(seq_dept_sequence.nextval, 'DATABASE','SEOUL');
insert into dept_sequence (deptno, dname, loc)
values(seq_dept_sequence.nextval, 'DATABASE','SEOUL1');
insert into dept_sequence (deptno, dname, loc)
values(seq_dept_sequence.nextval, 'DATABASE','SEOUL2');
commit;

select *from dept_sequence;
select seq_dept_sequence.currval
from dual;

--sequence ���� 
drop sequence seq_dept_sequence;
-- dept_sequence table ���� 
drop table dept_sequence;

create SEQUENCE emp_seq
increment by 1
start with 1
MINVALUE 1
nocycle
nocache;

select emp_seq.nextval from dual;

alter SEQUENCE emp_seq
increment by 20 
cycle;

select emp_seq.nextval from dual;
drop sequence emp_seq;

--14�� �������� , �⺻Ű 
select *from emp;

---------------------------------------------------------------p357 13�� ��������
--01
create table empidx as select * from emp;
select * from empidx;
--01-02
create index idx_empidx_empno
on empidx(empno);

--alter table empidx
--add(idx_empidx_empno number);

--01-03
select * from user_indexes where index_name ='IDX_EMPIDX_EMPNO';

--02
create or replace view empoidx_over15k(empno, ename, job, deptno, sal, comm) 
as 
select empno, ename, job, deptno, sal, nvl2(comm,'O','X')
from empidx 
where sal >1500 ;
--with read only

select * from empoidx_over15k;

--3
drop table deptseq;
select * from deptseq;
--3-1
create table deptseq as select *from dept;
--3-2
create SEQUENCE seq_deptseq
increment by 1
start with 1
maxvalue 99
minvalue 1
nocycle
nocache;
--03-3
insert into deptseq(deptno,dname,loc) 
values(seq_deptseq.nextval,'DATABASE' ,'SEOUL');
insert into deptseq(deptno,dname,loc) 
values(seq_deptseq.nextval,'WEB' ,'BUSAN');
insert into deptseq(deptno,dname,loc) 
values(seq_deptseq.nextval,'MOBILE' ,'ILSAN');


--p360 14�� �������� ==> �����͹��Ἲ
-- not null 
--unique ����
--primary key (�⺻Ű) => not null + unique 
--foreign key( �ܷ�Ű) 
-- check  
--p362
create table table_notnull(
login_id varchar2(20) not null, 
login_pwd varchar2(20) not null,
tel varchar2(20)
);
insert into table_notnull(login_id, login_pwd,tel) 
values('aa','1111','010-5555-2222');
commit;


insert into table_notnull(login_id, login_pwd,tel) 
values('bb','2222','010-3339-9999');
commit;

insert into table_notnull(login_id, login_pwd) 
values('cc','2222');
commit;

insert into table_notnull(login_pwd,tel) 
values('1111','010-5555-2222'); --���� �߻�, not null 
select *from table_notnull;
create table table_notnull2(
login_id varchar2(20) constraint tbl_nn2_loginID not null,
login_pwd varchar2(20) constraint tb2_nn2_loginPWD not null,
tel varchar2(20)
);
insert into table_notnull2 values('aa','1111','010-1111-2222');
insert into table_notnull2 values('aa','1111','010-1111-2222');
commit;
select *from table_notnull2;

alter table table_notnull2
modify(tel constraint table_nn2_tel not null);
--����  �߻� tel =not null
insert into table_notnull2(login_id, login_pwd) values('bb','2222'); 

--table_notnull2 ���� login_id�� unique �������� �ο�
alter table table_notnull2
modify(login_id constraint tbl_nn2_unique_loginID unique);

select *from table_notnull2;
delete from table_notnull2;
commit;

insert into table_notnull2 values('aa','1111','010-1111-2222');
commit;
-- ���� �߻�(SCOTT.TBL_NN2_UNIQUE_LOGINID) unique �ϹǷ� �ߺ� ���ȵ�
insert into table_notnull2 values('aa','1111','010-1111-2222');
-- ���� ���� ����[table_nn2_tel]
alter table table_notnull2
drop constraint table_nn2_tel;
-- ���� ���� �ο�[table_nn2_tel] ==> ������ �����ϴ� ����� ����
alter table table_notnull2
modify(tel constraint table_nn2_tel unique);

-- ���ο� ���̺� ����
create table table_unique(
login_id varchar2(20) constraint tbl_unique_loginID unique
,login_pwd varchar2(20) not null,
tel varchar2(20));
insert into table_unique values('aa','1111','010-1111-2222');
insert into table_unique values(null,'1111','010-1111-2222');
insert into table_unique values(null,'1111','010-1111-2222');
select *from table_unique;
-- �������� ��ȸ
select owner, constraint_name
from user_constraints;

--���̺� ���� 
drop table table_unique;
drop table table_notnull;
drop table table_notnull2;

------
create table table_pk(
    login_id varchar2(20) primary key , 
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
select * from table_pk;
-- �����߻� (login_id �� �⺻Ű �̹Ƿ� not null/unique �ؾ���)
insert into table_pk(login_pwd, tel) values('111','010-1111-2222');
drop table table_pk;
--
--1. ������ �� ���̺� ����
--board(num(number), title, writer, content, regdate) date(�⺻��: sysdate)
-- num : �⺻Ű ������ ����;: board_aeq 1/1/1 no

--increment by 1
--start with 1
--maxvalue 99
--minvalue 1
--nocycle
--nocache;

create table board( num number(3) primary key, title varchar2(50)
    , writer varchar2(50), content varchar2(50), regdate date default sysdate);

create SEQUENCE board_seq 
increment by 1
start with 1
minvalue 1
nocycle
nocache;

--2 ������ �߰� 
-- (1,'boad1', 'ȫ�浿','1�� �Խñ�','24/05/28'),
-- (2,'boad2', '������','2�� �Խñ�','24/05/28')
insert into board(num, title, writer, content) 
    values(board_seq.nextval,'boad1', 'ȫ�浿','1�� �Խñ�');
insert into board(num, title, writer, content,regdate) 
    values(board_seq.nextval,'boad2', '������','2�� �Խñ�','24/05/20');
    --����: 2���� �̹� ���� ���Ἲ �������� �ȵ�
insert into board(num, title, writer, content,regdate) 
    values(2,'boad2', '������','2�� �Խñ�','24/05/20');
insert into board(num, title, writer, content,regdate) 
    values(board_seq.nextval,'boad3', '������','3�� �Խñ�','24/05/20');
    insert into board(num, title, writer, content,regdate) 
    values(board_seq.nextval,'boad4', '������','4�� �Խñ�','24/05/20');
    insert into board(num, title, writer, content,regdate) 
    values(board_seq.nextval,'boad5', '������','5�� �Խñ�','24/05/20');
    commit;
select * from board;

--board ���̺� num ������������ �ؼ� ������ 3���� ���
select rownum rn , d.*
from (select * from board order by num desc)d
where rownum <= 3;

--board ���̺� num ������������ �ؼ� ������ 3~5 ���� ���
select *
from 
    (select rownum rn , d.*
    from (select * from board order by num desc)d 
    where rownum <=5)
where rn>=3;
drop  sequence borard_seq;
drop table board;

-----------------------------------------------------------------------



