 -- dbtest(num, id,       job,       regdate)
    --  number(�⺻Ű)  �⺻�� '���'  date �� �⺻�� sysdate
create table dbtest(
    num number(4) primary key,
    id varchar2(10),
    job varchar2(40) default '���',
    regdate date default sysdate
);
-- dbtest ���̺� ������(num : 1 , id :'aa') �߰�  
insert into dbtest(num, id) values(1, 'aa');
commit;
select * from dbtest;
