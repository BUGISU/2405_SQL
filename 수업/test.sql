 -- dbtest(num, id,       job,       regdate)
    --  number(기본키)  기본값 '사원'  date 형 기본값 sysdate
create table dbtest(
    num number(4) primary key,
    id varchar2(10),
    job varchar2(40) default '사원',
    regdate date default sysdate
);
-- dbtest 테이블에 데이터(num : 1 , id :'aa') 추가  
insert into dbtest(num, id) values(1, 'aa');
commit;
select * from dbtest;
