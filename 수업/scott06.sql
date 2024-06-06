--p291 11장 트랜잭션
-- 트랜잭션 : 더 이상 분할 할 수 없는 최소 수행 단위로
--           한번에 수행하여 작업 완료하거나 모두 수행하지 않거나(작업취소)
--           ALL or Nothing(commit / rollback)
--           TCL

-- 트랜잭션(ACID)
-- A : 원자성( Atomicity )
-- C : 일관성(Consistency) - 일관적으로  DB 상태 유지
-- I : 격리성(Isolation)
  --  -  트랜잭션 수행 시 다른 트랜잭션의 작업이 끼어들지 못하도록 보장하는 것
-- D : 영속성 ( Durability) - 성공적으로 수행된 트랜잭션은 영원히 반영이 되는 것

--p298 읽기일관성
-- 격리수준 
 --  Oracle :  Read Commited
 --  MySQL  :  Repeatable  Commited
 
 --11장 연습문제(p309)
create table dept_hw
as select * from dept;
select * from dept_hw;

update dept_hw
set dname ='DATABASE', loc='SEOUL'
where deptno=30;

rollback;
select * from dept_hw;
--12장 연습문제 p324
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
 --2. emp_hw테이블에 bigo 컬럼 추가
 alter table emp_hw
 add bigo varchar2(20);
 
 select * from emp_hw;
 --3. bigo 크기 30으로 변경
alter table emp_hw
modify bigo varchar2(30);

desc emp_hw;
--4. bigo  컬럼여  remark 로 수정
alter table emp_hw
rename column bigo to remark;

select * from emp_hw;
--5. emp 테이블을 통해 emp_hw 테이블에 데이터 넣기
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

--6. emp_hw 삭제
drop table emp_hw;
-------
-- 13장  p327
--데이터사전
  --USER_    / ALL_   / DBA_
--인덱스
--View(뷰) - 가상의 테이블(편의성, 보안성)

select * from dictionary;
--scott 계정이 가지고 있는 모든 테이블 조회
select table_name from user_tables;
--scott 계정이 가지고 있는 모든 객체 정보 조회
select owner, table_name from all_tables;

--p336 인덱스 생성
create index idx_emp_sal
on emp(sal);
--인덱스 삭제
drop index idx_emp_sal;

--p341
--뷰(view) - 가상의 테이블(편의성, 보안성)
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
--emp 테이블 전체 내용을  v_emp1  뷰 생성  
create or replace view v_emp1
as select * from emp;

select * from v_emp1;
-- v_emp1 (3000, '홍길동', sysdate) 추가
insert into v_emp1(empno, ename, hiredate)
values(3000, '홍길동', sysdate);
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
with read only; -- 읽기만

select * from v_emp1;
insert into v_emp1(empno, ename, hiredate)
values(3000,'홍길동',  sysdate);  --오류발생

-- 부서별 최대 급여를 받는 살마의 부서번호, 부서명, 급여 출력
select * from emp; -- 12행
select * from dept; -- 4행

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
-- 인라인뷰
select e.deptno, d.dname, e.sal
from (select deptno, max(sal) sal
      from emp
      group by deptno)e, dept d
where e.deptno = d.deptno;  

--p346
select * from emp order by ename desc;
--위에서 3개만 출력
select * from emp;
--rownum
select  rownum rn , e.* 
from (select *
      from emp
      order by ename desc) e
where rownum <=3;
--with 사용(p259)
with e as (select * from emp order by ename)
select rownum, e.*
from e
where rownum <=3;
--p340 시퀀스
create table dept_sequence
as select *
from dept
where 1<>1;

select * from dept_sequence;
--시퀀스 생성
create sequence seq_dept_sequence
increment by 10
start with  10
maxvalue 90
minvalue 0
nocycle
nocache;
select * from user_sequences;
select * from dept_sequence;
-- 'DATABASE' 'SEOUL' 값 추가
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
--시퀀스
drop sequence seq_dept_sequence;
--dept_sequence 삭제
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
------p357 13장 연습문제
--1-1. emp 테이블과 같은 구조의 EMPIDX 테이블 생성
create table EMPIDX
as select * 
from emp;

select * from EMPIDX;
--1-2 EMPIDX 테이블에  EMPNO 열에  IDX_EMPIDX_EMPNO 인덱스 생성
create index IDX_EMPIDX_EMPNO
on EMPIDX(EMPNO);
--1-3  데이터 사전 뷰를 통해 생성된 인덱스 확인
select *
from user_indexes
where index_name = 'IDX_EMPIDX_EMPNO';

--2-1.  급여가 1500 초과인 사원들만의  EMPIDX_OVER15K 뷰 생성
-- 추가수당이 존재하면 O  아니면 X
create or replace view EMPIDX_OVER15K
as (select empno, ename, job, deptno, sal, comm,
    nvl2(comm, 'O','X') comm2
    from EMPIDX
    where sal > 1500
);    -- with read only
select * from EMPIDX_OVER15K;

--3-1 dept 테이블 구조의  DEPTSEQ 테이블 생성
create table DEPTSEQ
as select * from dept;
--3-2 시퀀스 SEQ_DEPTSEQ 생성
create SEQUENCE SEQ_DEPTSEQ
    INCREMENT by 1
    start with 1
    maxvalue 99
    minvalue 1
    nocycle
    nocache;
--3-3 데이터 추가
insert into DEPTSEQ(deptno, dname, loc)
values(SEQ_DEPTSEQ.nextval,'DATABASE','SEOUL');

insert into DEPTSEQ(deptno, dname, loc)
values(SEQ_DEPTSEQ.nextval,'DATABASE1','SEOUL1');

insert into DEPTSEQ(deptno, dname, loc)
values(SEQ_DEPTSEQ.nextval,'DATABASE2','SEOUL2');
commit;
select * from DEPTSEQ;

--p360 14장 제약조건 ==>데이터무결성
--not null
--unique
--primary key(기본키) ==> not null / unique
--foreign key(외래키)
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
values('4444','010-4444-5555'); --오류발생 not null

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
values('bb','2222'); -- 오류발생  tel  이  not null 이므로

--table_notnull2 에서  login_id에 unique 제약조건 부여
alter table table_notnull2
modify(login_id constraint tbl_nn2_unique_loginID unique);
select * from table_notnull2;
delete from table_notnull2;
commit;
insert into table_notnull2 values('aa','1111','010-1111-2222');
commit;

--오류발생 (SCOTT.TBL_NN2_UNIQUE_LOGINID)에 위배
insert into table_notnull2 values('aa','1111','010-1111-2222');
 --제약 조건 tbl_nn2_tel 삭제
alter table table_notnull2
drop constraint tbl_nn2_tel;
 --제약 조건 tbl_nn2_tel not null 추가 ==> 툴에서 삭제 
alter table table_notnull2
MODIFY (tel CONSTRAINT tbl_nn2_tel not null);
---
create table table_unique(
    login_id varchar2(20) constraint tbl_unique_loginID unique,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
insert into table_unique values('aa','1111','010-1111-2222');
-- 오류발생
insert into table_unique values('aa','1111','010-1111-2222');
insert into table_unique values(null,'1111','010-1111-2222');
insert into table_unique values(null,'3333','010-1111-3333');
select * from table_unique;
--제약조건 조회
select owner, constraint_name
from user_constraints;

--테이블 삭제
drop table table_unique;
drop table table_notnull;
drop table table_notnull2;
-------
create table table_pk(
    login_id varchar2(20) primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);
-- 오류발생 login_id 기본키이므로  not null / unique 해야 함
insert into table_pk(login_pwd, tel) values('111','010-1111-2222');
drop table table_pk;
--------
--1) 시퀀스 및 테이블 생성
-- board(num, title, writer, content, regdate)
--      number,                      date(기본값 : sysdate)
-- num : 기본키
-- 시퀀스 생성 : board_seq  1/1/1/ no
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

--2) 데이터 추가
 -- (1, board1, 홍길동, 1번 게시글, 24/05/28),
 -- (2, board2, 강감찬, 2번 게시글, 24/05/28)  
 insert into board(num, title, writer, content)
 values(board_seq.nextval, 'board1','홍길동','1번 게시글');
 commit;
 select * from board;
 
 insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board21','강감찬','2번 게시글',sysdate);
 --2번 있으므로 무결성 제약 조건 오류 발생
 --insert into board(num, title, writer, content, regdate)
 --values(2, 'board21','강감찬','2번 게시글',sysdate);
 commit;
 select * from board;
 insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board3','강감찬','3번 게시글',sysdate);
  insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board4','강감찬4','4번 게시글',sysdate);
  insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board5','강감찬5','5번 게시글',sysdate);
  insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board6','강감찬6','6번 게시글',sysdate);
  insert into board(num, title, writer, content, regdate)
 values(board_seq.nextval, 'board7','강감찬7','7번 게시글',sysdate);
commit;
select * from board;
--board테이블   num 내림차순으로 해서 위에서 3개만 출력
  select rownum rn ,b.*
  from (select * from board order by num desc) b
  where rownum <=3;

--board테이블   num 내림차순으로 해서 3~5사이 출력  
  select * 
  from  (select rownum rn ,b.*
         from (select * from board order by num desc) b
         where rownum <=5)
  where rn >=3 ;
 drop sequence board_seq;
 drop table board;
  
  
  
  