alter session set "_oracle_script"=true;
-- �����ڰ� ����� ����
create user oraclestudy
IDENTIFIED by oracle;
-- create session  ���� �ο� : �����ͺ��̽� ���� 
grant create session to oraclestudy;
-- ���̺� ���� ����
grant create table to oraclestudy;
-- �� �ο� (connect, resource �ο�)
grant resource, connect to oraclestudy;
---------------------------
-- 1. ����� :  test_user  // ��� : 1234  
create user test_user
IDENTIFIED by 1234;

-- 2. �����ͺ��̽� ���� ���� �ο� 
grant create session to test_user;
--3. ��� ����
alter user test_user IDENTIFIED by abcd;
drop user test_user;
----- ��(role)
-- connect : create session ����
-- resource

--user ����
drop user oraclestudy cascade;
----------------------
--1. test ���� ���� ���  test
create user test identified by test;
--2. test ���� ���� �ο� resource, connect ,unlimited tablespace 
grant resource, connect, unlimited tablespace  to test;
--3. test �����Ͽ� dbtest ���̺� ����
  -- dbtest(num, id,       job,       regdate)
      number(�⺻Ű)  �⺻�� '���'  date �� �⺻�� sysdate
-- dbtest ���̺� ������(num : 1 , id :'aa') �߰�      
-----------
-----p416 15�忬������
-- 1. PREV_HW  �������� (���  oracle) ���� �����ϵ��� ���� ==> �����ڰ������� �۾�
create user PREV_HW identified by oracle;
grant resource, connect, unlimited tablespace  to PREV_HW; 






