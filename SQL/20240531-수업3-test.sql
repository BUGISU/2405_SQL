--3. test �����Ͽ� dbtest ���̺� ���� 
    -- dbtest(num, id, job, regdate)
--   num: number(�⺻Ű) job �⺻�� : '���', regdate :date�� �⺻�� sysdate
create table dbtest(
num number(20) primary key,
id varchar2(20),
job varchar2(20) default '���',
regdate date default sysdate
);
-- 4. dbtest ���̺� ������ �߰�(num:1, id:'aa')�߰� 
insert into dbtest(num,id) values(1,'aa');
