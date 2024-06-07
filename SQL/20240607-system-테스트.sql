grant create session to scott;
grant create session to guest;

grant select on student to grant;
revoke select on guest.student from scott;