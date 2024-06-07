--15
create table dept(
    deptno char(3),
    dname varchar2(20)
);

insert into dept(deptno, dname) values('101','경영학과');
insert into dept(deptno, dname) values('102','컴퓨터공학과');
insert into dept(deptno, dname) values('103','영문학과');
select *from dept;

alter table dept add primary key(deptno);
--16
create table student(
    studno number primary key,
    name varchar2(10) not null unique,
    deptno char(3) references dept(deptno), --외래키
    grade number(1) check(grade>=1 and grade<=4),
    profno number
);
insert into student(studno, name,grade,deptno, profno)  values(101,'김기현',1,'101', 1001);
insert into student(studno, name,grade,deptno, profno) values(102,'김민영',2,'101', 1003);
insert into student(studno, name,grade,deptno, profno) values(103,'김정환',3,'101', 1001);
insert into student(studno, name,grade,deptno, profno) values(104,'김준태',4,'101', 1003);
insert into student(studno, name,grade,deptno, profno) values(105,'김지용',1,'102', 1002);
insert into student(studno, name,grade,deptno ) values(106,'김진',2,'102');
insert into student(studno, name,grade,deptno, profno) values(107,'김찬권',3,'102', 1002);
insert into student(studno, name,grade,deptno, profno) values(108,'김옥규',1,'103', 1004);
insert into student(studno, name,grade,deptno, profno) values(109,'박원영',2,'103', 1006);
insert into student(studno, name,grade,deptno) values(110,'박의종',3,'103');

select * from student;

create table professor (
    profno number primary key,
    name varchar2(10),
    deptno char(3),
    FOREIGN key(deptno)references dept(deptno),
    position varchar2(20),
    pay number
);
insert into professor values(1001,'홍길동','101','정교수',450);
insert into professor values(1002,'김연아','102','정교수',400);
insert into professor values(1003,'박지성','101','부교수',350);
insert into professor values(1004,'김태근','103','정교수',410);
insert into professor values(1005,'서찬수','101','전임강사',250);
insert into professor values(1006,'김수현','103','부교수',350);
insert into professor values(1007,'정동진','102','전임강사',320);
insert into professor values(1008,'임진영','103','전임강사',200);
 
select * from professor;
select * from dept;

--18
select d.deptno, d.dname,p.pay 
from professor p, dept d
where p.deptno = d.deptno and (d.dname, p.pay ) 
in (select  d.dname, max(p.pay)
    from professor p , dept d
    where p.deptno = d.deptno 
    group by d.dname);
--
select  d.deptno, d.dname, p1.pay 
from (select deptno, max(pay) max_pay
from professor
group by deptno) p, dept d, professor p1
where p.deptno  =d.deptno and p.deptno=p1.deptno
and p1.pay = p.max_pay;

select * from student;
--19
update student
set name = '이기현'
where student.studno='101';

--20
grant select on guest.student to scott;
revoke select on guest.student from scott;