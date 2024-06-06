--system
alter session set "_oracle_script" = true;
-- �����ڰ� ����� ����
create user oraclestudy
identified by oracle;

-- create session ���� �ο� : �����ͺ��̽� ����
grant CREATE session to oraclestudy;
---���̺� ���� ���� 
grant create table to oraclestudy;
-- �� �ο� (connect, resource �ο�)
grant resource, connect to oraclestudy;
--1. �����: test_user ���: 1234
create user test_user
identified by 1234;
--2. �����ͺ��̽� ���� ���� �ο��ϱ� 
grant create session to test_user; 
---3. �������
alter user test_user identified by abcd;
--4. ���� ���� 
drop user test_user;
-- �� (role) 
-- connect:create session ����
-- resource ����

-- user ����
drop user oraclestudy cascade;
drop user test_user cascade;

----------------------------------
--1. test ���� ���� ��� test
create user test identified by test;
--2. test ���� ���� �ο� resource, connect, unlimited tablespace
grant resource, connect,unlimited tablespace to test;
--3. test �����Ͽ� dbtest ���̺� ���� 
    -- dbtest(num, id, job, regdate)
--   num: number(�⺻Ű) job �⺻�� : '���', regdate :date�� �⺻�� sysdate
-- 4. dbtest ���̺� ������ �߰�(num:1, id:'aa')�߰� 

---------------------------------------
---p416 15�� ���� ����
-- 1.prev_hw ���� ����(��� oracle) ���� �����ϵ��� ����
create user PREV_HW identified by oracle;
--2. scott �������� �����ؼ� 
--prev_hw�� emp, dept, salgrade ���̺��� select ���� �ο� 
grant resource, connect, unlimited tablespace to PREV_HW;

