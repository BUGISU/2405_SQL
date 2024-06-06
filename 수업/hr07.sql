--1. Professor ���̺��  department ���̺��� �����Ͽ� 
--������ȣ�� �����̸�, �Ҽ��а��̸��� ��ȸ�ϴ�  view ���� (v_prof_dept2)
select * from professor;
select * from department;

create or replace view v_prof_dept2
as
select  p.profno  ������ȣ, p.name �����̸�, d.dname �Ҽ��а��̸�
from professor p, department d
where p.deptno = d.deptno;


--2. 1 �� �並 �б���������  v_prof_dept3
create or replace view v_prof_dept3
as
select  p.profno  ������ȣ, p.name �����̸�, d.dname �Ҽ��а��̸�
from professor p, department d
where p.deptno = d.deptno
with read only;

--3. student , department ����Ͽ� 
--�а����� �л����� �ִ�Ű�� �ִ� ������, �а� �̸��� ���
--(DNAME      MAX_HEIGHT    MAX_WEIGHT)
select deptno1, max(height), max(weight)
from student
group by deptno1;
--�ζ��� ��
select d.dname, s.deptno1, s.MAX_HEIGHT, s.MAX_WEIGHT
from  (select deptno1, max(height) MAX_HEIGHT, max(weight) MAX_WEIGHT
       from student
       group by deptno1)s, department d
where s.deptno1 = d.deptno;

----
select  d.dname, s.deptno1, s.height, s.weight
from student s, department d
where s.deptno1 = d.deptno
and (s.deptno1, s.height, s.weight)
           in (select deptno1, max(height), max(weight)
                from student
                group by deptno1);

--4.�а��̸�, �а��� �ִ�Ű, �а����� ���� Ű�� ū �л����� �̸��� Ű��
--�ζ��� �並 �̿��Ͽ� ���
--DNAME     MAX_HEIGHT   NAME     HEIGHT

select deptno1, max(height) MAX_HEIGHT
from student 
group by deptno1;
---
select d.dname, s.MAX_HEIGHT, s1.name, s1.height
from (select deptno1, max(height) MAX_HEIGHT
      from student 
      group by deptno1) s, student s1, department d
where s.deptno1 = s1.deptno1 and  s.deptno1= d.deptno 
and s.MAX_HEIGHT = s1.height;   
-- join ~ on
select d.dname, s.MAX_HEIGHT, s1.name, s1.height
from (select deptno1, max(height) MAX_HEIGHT
      from student 
      group by deptno1) s join student s1
                          on s.deptno1 = s1.deptno1
                          join department d
                          on s1.deptno1 = d.deptno
where s.deptno1 = s1.deptno1 and  s.deptno1= d.deptno 
and s.MAX_HEIGHT = s1.height;


--5. student �л��� Ű�� ���� �г��� ��� Ű���� ū �л��� �г�� �̸���
--Ű, �ش� �г��� ���Ű ��� (�ζ��κ� �̿�, �г����� ��������)
select grade, avg(height)
from student
group by grade;

select stu.grade, stu.name, stu.height, s.avg_height
from (select grade, avg(height) avg_height
        from student
        group by grade)s , student stu
where  s.grade = stu.grade and stu.height >s.avg_height
order by stu.grade;        



