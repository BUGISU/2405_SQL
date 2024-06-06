-- p291 11장 트랜잭션
-- 트랜젝션 : 더 이상 분할 할 수 없는 최소 수행 단위로 
-- 한번에 수행해서 작업을 완료 하거나 모두 수행하지 않거나(작업취소)
-- ALL or Nothing(commit / rollback)

-- TCL : 트랜젝션 컨트롤 랭귀지 (제어) 
-- 트랜잭션 특징(ACID)
-- A(원자성:atomicity)
-- C(일관성: Consistency): 일관적으로 DB 상태 유지
-- I(격리성: Isolation) : 트랜잭션 수행시 다른 트랜잭션이 작업이 끼어들지 못한다 
-- D(영속성 :Durability) : 성공적으로 수행된 트랜잭션은 영원히 반영이 되는 것

-- p298 읽기 일관성
-- 격리수준 : 
-- 오라클 : Read Commited
-- MySQL : Reperatable Commited

--11장 연습문제 309
--1
create table dept_hw
as select *from dept;

select *from dept_hw;

update dept_hw
set dname='DATABASE',loc='SEOUL'
where deptno =30;

rollback;
--12장 연습문제 p324
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
-- 13장 p327
-- 데이터사전
-- user_ /ALL_ /DBA_
-- 인덱스 
-- (VIEW)뷰 : 물리적인 테이블이 아닌 가상의 테이블(편의성, 보안성) 을 위해서 만듬

select *from dictionary;
-- scott 게정이 가지고 있는 모든 테이블을 조회
select table_name from user_tables;
-- scott 계정이 가지고있는 모든 객체 정보 조회
select owner, table_name from all_tables;

-- p336 인덱스 생성
create index idx_emp_sal 
on emp(sal);
--인덱스 삭제 
drop index idx_emp_sal;

--p341
-- 뷰(VIEW) 가상의 테이블(편의성, 보안성)
create view vw_emp20
as ( select empno, ename, job, deptno from emp where deptno >20 );

select * from vw_emp20;
--생성된 뷰 확인하기
select *from user_views;

-- 이미 존재하는 view 인 경우, 다음으로 수정해라 
create or replace view vw_emp20
as ( select empno, ename, job, deptno from emp where deptno >20 );

--emp 테이블 전체 내용을 v_emp1 뷰 생성
create or replace view v_emp1
as (select *from emp);

select *from v_emp1;

--v_emp1 (3000,'홍길동',sysdate) 추가 
insert into v_emp1(empno, ename, hiredate) values(3000,'홍길동',sysdate);
--뷰는 어떤 테이블을 기반으로 만들기 때문에 기반이 되는 테이블이 변경되면 같이 변경됨
-- 가능한 뷰는 읽는 권한만 제공한다 
drop view v_emp1;

------------------------
create or replace view v_emp1
as
select empno, ename, hiredate
from emp
with read only; -- 읽기 전용, 삽입 삭제 불가능

select *from v_emp1;

insert into v_emp1(empno, ename, hiredate)
values(3000,'홍길동',sysdate); --오류 발생, 읽기 권한 밖에 없음

-- 부서별 최대 급여를 받는 사람의 부서번호, 부서명, 급여 출력
select * from emp; --12행
select * from  dept; --4행

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
-- 인라인 뷰 p344
select e.deptno, d.dname, e.sal
from (select deptno, max(sal) sal
        from emp
        group by deptno) e, dept d
where e.deptno =d.deptno;

-- p346 
select *from emp order by ename desc;
-- 위에서 3개만 출력
-- rownum
select rownum rn, e.*
from (select * 
    from emp
    order by ename desc) e
where rownum <=3;

--with 사용(p259)
with e as (select *from emp order by ename)
select rownum, e.*
from e
where rownum <=3;

-- p340 ,시퀀스
create table dept_sequence
as select *
from dept
where 1<>1;

select * from dept_sequence;
--시퀀스 생성 
create SEQUENCE seq_dept_sequence
INCREMENT BY 10
start with 10 
maxvalue 90
minvalue 0
nocycle
nocache;

select *from user_sequences;
select *from dept_sequence;
--'DATABASE' 'SEOUL' 값 추가
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

--sequence 삭제 
drop sequence seq_dept_sequence;
-- dept_sequence table 삭제 
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

--14장 제약조건 , 기본키 
select *from emp;

---------------------------------------------------------------p357 13장 연습문제
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


--p360 14장 제약조건 ==> 데이터무결성
-- not null 
--unique 유일
--primary key (기본키) => not null + unique 
--foreign key( 외래키) 
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
values('1111','010-5555-2222'); --오류 발생, not null 
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
--오류  발생 tel =not null
insert into table_notnull2(login_id, login_pwd) values('bb','2222'); 

--table_notnull2 에서 login_id에 unique 제약조건 부여
alter table table_notnull2
modify(login_id constraint tbl_nn2_unique_loginID unique);

select *from table_notnull2;
delete from table_notnull2;
commit;

insert into table_notnull2 values('aa','1111','010-1111-2222');
commit;
-- 오류 발생(SCOTT.TBL_NN2_UNIQUE_LOGINID) unique 하므로 중복 허용안됨
insert into table_notnull2 values('aa','1111','010-1111-2222');
-- 제약 조건 삭제[table_nn2_tel]
alter table table_notnull2
drop constraint table_nn2_tel;
-- 제약 조건 부여[table_nn2_tel] ==> 툴에서 삭제하는 방법도 있음
alter table table_notnull2
modify(tel constraint table_nn2_tel unique);

-- 새로운 테이블 생성
create table table_unique(
login_id varchar2(20) constraint tbl_unique_loginID unique
,login_pwd varchar2(20) not null,
tel varchar2(20));
insert into table_unique values('aa','1111','010-1111-2222');
insert into table_unique values(null,'1111','010-1111-2222');
insert into table_unique values(null,'1111','010-1111-2222');
select *from table_unique;
-- 제약조건 조회
select owner, constraint_name
from user_constraints;

--테이블 삭제 
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
-- 오류발생 (login_id 는 기본키 이므로 not null/unique 해야함)
insert into table_pk(login_pwd, tel) values('111','010-1111-2222');
drop table table_pk;
--
--1. 시퀀스 및 테이블 생성
--board(num(number), title, writer, content, regdate) date(기본값: sysdate)
-- num : 기본키 시퀀스 생성;: board_aeq 1/1/1 no

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

--2 데이터 추가 
-- (1,'boad1', '홍길동','1번 게시글','24/05/28'),
-- (2,'boad2', '강감찬','2번 게시글','24/05/28')
insert into board(num, title, writer, content) 
    values(board_seq.nextval,'boad1', '홍길동','1번 게시글');
insert into board(num, title, writer, content,regdate) 
    values(board_seq.nextval,'boad2', '강감찬','2번 게시글','24/05/20');
    --오류: 2번이 이미 존재 무결성 제약으로 안됨
insert into board(num, title, writer, content,regdate) 
    values(2,'boad2', '강감찬','2번 게시글','24/05/20');
insert into board(num, title, writer, content,regdate) 
    values(board_seq.nextval,'boad3', '강감찬','3번 게시글','24/05/20');
    insert into board(num, title, writer, content,regdate) 
    values(board_seq.nextval,'boad4', '강감찬','4번 게시글','24/05/20');
    insert into board(num, title, writer, content,regdate) 
    values(board_seq.nextval,'boad5', '강감찬','5번 게시글','24/05/20');
    commit;
select * from board;

--board 테이블 num 내림차순으로 해서 위에서 3개만 출력
select rownum rn , d.*
from (select * from board order by num desc)d
where rownum <= 3;

--board 테이블 num 내림차순으로 해서 위에서 3~5 사이 출력
select *
from 
    (select rownum rn , d.*
    from (select * from board order by num desc)d 
    where rownum <=5)
where rn>=3;
drop  sequence borard_seq;
drop table board;

-----------------------------------------------------------------------



