--15
create table dept(
    deptno char(3),
    dname varchar2(20)
);

insert into dept(deptno, dname) values('101','�濵�а�');
insert into dept(deptno, dname) values('102','��ǻ�Ͱ��а�');
insert into dept(deptno, dname) values('103','�����а�');
select *from dept;

alter table dept add primary key(deptno);
--16
create table student(
    studno number primary key,
    name varchar2(10) not null unique,
    deptno char(3) references dept(deptno), --�ܷ�Ű
    grade number(1) check(grade>=1 and grade<=4),
    profno number
);
insert into student(studno, name,grade,deptno, profno)  values(101,'�����',1,'101', 1001);
insert into student(studno, name,grade,deptno, profno) values(102,'��ο�',2,'101', 1003);
insert into student(studno, name,grade,deptno, profno) values(103,'����ȯ',3,'101', 1001);
insert into student(studno, name,grade,deptno, profno) values(104,'������',4,'101', 1003);
insert into student(studno, name,grade,deptno, profno) values(105,'������',1,'102', 1002);
insert into student(studno, name,grade,deptno ) values(106,'����',2,'102');
insert into student(studno, name,grade,deptno, profno) values(107,'������',3,'102', 1002);
insert into student(studno, name,grade,deptno, profno) values(108,'�����',1,'103', 1004);
insert into student(studno, name,grade,deptno, profno) values(109,'�ڿ���',2,'103', 1006);
insert into student(studno, name,grade,deptno) values(110,'������',3,'103');

select * from student;

create table professor (
    profno number primary key,
    name varchar2(10),
    deptno char(3),
    FOREIGN key(deptno)references dept(deptno),
    position varchar2(20),
    pay number
);
insert into professor values(1001,'ȫ�浿','101','������',450);
insert into professor values(1002,'�迬��','102','������',400);
insert into professor values(1003,'������','101','�α���',350);
insert into professor values(1004,'���±�','103','������',410);
insert into professor values(1005,'������','101','���Ӱ���',250);
insert into professor values(1006,'�����','103','�α���',350);
insert into professor values(1007,'������','102','���Ӱ���',320);
insert into professor values(1008,'������','103','���Ӱ���',200);
 
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
set name = '�̱���'
where student.studno='101';

--20
grant select on guest.student to scott;
revoke select on guest.student from scott;