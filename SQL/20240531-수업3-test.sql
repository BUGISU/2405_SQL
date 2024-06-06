--3. test 접속하여 dbtest 테이블 생성 
    -- dbtest(num, id, job, regdate)
--   num: number(기본키) job 기본값 : '사원', regdate :date형 기본값 sysdate
create table dbtest(
num number(20) primary key,
id varchar2(20),
job varchar2(20) default '사원',
regdate date default sysdate
);
-- 4. dbtest 테이블에 데이터 추가(num:1, id:'aa')추가 
insert into dbtest(num,id) values(1,'aa');
