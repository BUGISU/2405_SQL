
create table table_name (
    col1 varchar2(20) constraint table_name_pk_col1 primary key,
    col2 varchar2(20) not null,
    col3 varchar2(20)
);
create table table_name2(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20),
    PRIMARY key(col1)
);
create table table_name3(
    col1 varchar2(20),
    col2 varchar2(20) not null,
    col3 varchar2(20),
    constraint  table_name3_pk_col1 PRIMARY key(col1)
);
drop table table_name;
drop table table_name2;
drop table table_name3;
-- 외래키
-- dept_fk(부서번호, 부서명 , 지역)
create table dept_fk(
    deptno number(2) constraint deptfk_deptno_pk primary key,
    dname VARCHAR2(20),
    loc varchar2(20)
);
--emp_fk(사원번호, 사원명, 직책, 부서번호)
create table emp_fk(
    empno number(2) constraint empfk_empno_pk primary key,
    ename VARCHAR2(20),
    job varchar2(20),
    deptno number(2)
);
insert into dept_fk values(10, '영업', '부산');
insert into dept_fk values(20, '영업2', '부산2');
insert into emp_fk values(1, '홍길동', '사원', 30);
commit;
select * from dept_fk;
select * from emp_fk;
drop table emp_fk;

create table emp_fk(
    empno number(2) constraint empfk_empno_pk primary key,
    ename VARCHAR2(20),
    job varchar2(20),
    deptno number(2) constraint empfk_deptno_fk 
    REFERENCES dept_fk(deptno)
);
-- 오류발생 dept_fk 테이블에 30번 부서가 없는데 30번 부서 추가하려고 해서 오류
--무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
--insert into emp_fk values(1, '홍길동', '사원', 30);
insert into emp_fk values(1, '홍길동', '사원', 20);
insert into emp_fk(empno, ename,job) values(2, '강감찬', '팀장');
commit;
select * from emp_fk;
delete from emp_fk where empno=1;
insert into emp_fk values(1, '홍길동', '사원', 20);
commit;

select * from dept_fk;
--20번 부서 삭제 ( 오류발생)
delete from dept_fk where deptno =20;
--오류발생
update emp_fk set deptno=30 where empno =1;
-- 외래키 제약조건을 삭제
alter table emp_fk
drop constraint empfk_deptno_fk;
-- 외래키 삭제로   insert
insert into emp_fk values(3, '강감찬', '팀장', 40);
select * from emp_fk;
delete from emp_fk where empno =3;
commit;

-- 삭제한 외래키 추가
--cascade 는 부모가 사라지면 자식도 사라짐
alter table emp_fk
add constraint empfk_deptno_fk foreign key (deptno)
references dept_fk(deptno)
on delete cascade; 

select * from emp_fk;
select * from dept_fk;
delete from dept_fk where deptno=20;
commit;
--------------------------------------------------------------------------------
-- check 제약 조건
create table table_check(
    login_id varchar2(20) constraint tb_check_id_pk primary key,
    login_pwd varchar2(20) constraint tb_check_pwd_ch check(length(login_pwd)>5), 
    tel varchar2(20)
);
--오류, 체크 제약조건(SCOTT.TB_CHECK_PWD_CH)이 위배
--insert into table_check values('aaa','123','010');
insert into table_check values('aaa','123456','010');
commit;

select *from table_check;
drop table table_check;
drop table dept_fk;
drop table emp_fk;

-- board(num ,title, userid, content, regdate): 기본키(num) =>pk_board1
create table board(
 num number(20) constraint pk_board1 primary key,
 title varchar2(30),
 userid number(3) constraint fk_board1 REFERENCES member(userid) ,
 content varchar2(100),
 regdate date default sysdate
);

insert into board values (10,3,'제우스','오','001');
drop table board;
-- comments(cnum, userid, msg, regdate, bnum): 
--기본키 (cnum):pk_comments 
--외래키(bnum) :fk_comments
create table comments(
cnum number(20)constraint pk_comments primary key,
userid number(3) constraint fk_comments references member(userid),
msg varchar2(100),
regdate date default sysdate,
bnum number(3) REFERENCES board(num)
on delete cascade
);
insert into comments values (10,3,'t1','001','20');
drop table comments;

-- member(userid, username, tel) 기본키 (userid) => pk_member1
create table member(
userid number(3) constraint pk_member1 primary key,
username varchar2(30),
tel varchar2(20)
);
insert into member values (10,'제우스','010-999');
drop table member;
-- 시퀀스 board_seq /comment_seq
create sequence board_seq
increment by 1
start with 1
minvalue 1
nocycle
nocache;

create sequence comment_seq
increment by 1
start with 1
minvalue 1
nocycle
nocache;

--erd 다이어그램으로 확인하기
--member(userid, username, tel)
insert into member values (10, '홍길동', '010-1111-2222');
commit;

--board(num ,title, userid, content, regdate)
insert into board(num ,title, userid, content)
values (board_seq.nextval, '제목',10 ,'board content1');

select *from member;
select *from board;
select *from comments;

--comments(cnum, userid, msg, regdate, bnum)
insert into comments(cnum, userid, msg, bnum)
values (comment_seq.nextval, 10, 'comment msg', 2);
commit;
--작업이 없음으로 설정되었기 때문에 삭제시 오류 발생
-- delete from member where userid =10;

desc USER_CONSTRAINTS;
select * FROM USER_CONSTRAINTS
WHERE TABLE_NAME =' BOARD'; 


-- p396 15장 사용자 , 권한, 롤 관리 
-- 사용자/ 객체 / 데이터베이스 스키마
-- 예) scott :사용자 
-- scott 이 생성한 테이블, 제약조건, 시퀀스 등 
-- 데이터베이스에서 scott이 만든 모든 객체를 시키마라고 함

-- p394 14장 연습 ---------------------------------------------------------------
--1. DEPT_CONST 생성
CREATE TABLE DEPT_CONST ( 
   DEPTNO NUMBER(2)    CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY, 
   DNAME  VARCHAR2(14) CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE, 
   LOC    VARCHAR2(13) CONSTRAINT DEPTCONST_LOC_NN NOT NULL 
);

--2. EMP_CONST 생성
CREATE TABLE EMP_CONST ( 
   EMPNO    NUMBER(4) CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY, 
   ENAME    VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL, 
   JOB      VARCHAR2(9), 
   TEL      VARCHAR2(20) CONSTRAINT EMPCONST_TEL_UNQ UNIQUE, 
   HIREDATE DATE, 
   SAL      NUMBER(7, 2) CONSTRAINT EMPCONST_SAL_CHK 
          CHECK (SAL BETWEEN 1000 AND 9999), 
   COMM     NUMBER(7, 2), 
   DEPTNO   NUMBER(2) CONSTRAINT EMPCONST_DEPTNO_FK 
   REFERENCES DEPT_CONST (DEPTNO) 
);
--3.
select TABLE_NAME,CONSTRAINT_NAME,CONSTRAINT_TYPE
from USER_CONSTRAINTS
where table_name in ('DEPT_CONST','EMP_CONST')
order by CONSTRAINT_NAME;

---p416 15장 연습 문제 ----------------------------------------------------------

--관리자 계정에서 작업
--1. prev_hw 계정 생성(비번 oracle) 접속 가능하도록 생성
--2. scott 계정으로 접속해서 prev_hw에 emp, dept, salgrade 테이블의 select 권한 부여 
grant select on emp to prev_hw;
grant select on dept to prev_hw;
grant select on salgrade to prev_hw;
--3. 2번에 부여한 권한 취소(revoke)
revoke select on emp from prev_hw;
revoke select on dept from prev_hw;
revoke select on salgrade from prev_hw;
