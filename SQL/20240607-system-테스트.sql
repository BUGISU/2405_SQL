alter session set "_oracle_script" = true;
create user guest identified by 1234;
--13
grant connect, resource, unlimited tablespace to guest;


grant select on student to grant;
revoke select on guest.student from scott;