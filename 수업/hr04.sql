--professor ���̺�
select * from professor;
--1. �а����� �Ҽ� �������� ��ձ޿�, �ּұ޿�, �ִ�޿� ���
--��, ��ձ޿��� 300 �Ѵ� �͸� ���
select  deptno, round(avg(pay)) ��ձ޿�, min(pay) �ּұ޿�, max(pay) �ִ�޿�
from professor
group by deptno
having avg(pay)>300
order by avg(pay) desc;

--2.student ���̺�
--�л� ���� 4�� �̻��� �г⿡ ���ؼ� �г�, �л� ��, ��� Ű, ��� �����Ը� ���
--��, ��� Ű�� ��� �����Դ� �Ҽ��� ù ��° �ڸ����� �ݿø��ϰ�,
--��¼����� ��� Ű�� ���� ������ ������������ ����Ͽ���.
select grade,count(*), round(avg(height)) "��� Ű" ,
         round(avg(weight)) "��� ������"
from student
group by grade
having count(*) >=4
order by avg(height) desc ;


--3. �л��̸�(name), ��������(name) �̸� ���
select * from student;
select * from professor;

select s.name �л��̸�, p.name ��������
from student s, professor p
where s.profno = p.profno;

select s.name �л��̸�, p.name ��������
from student s join professor p
on s.profno = p.profno;

--gift, customer ���̺�
select * from gift;
select * from customer;
--4. ���̸�(gname),  ����Ʈ(point), ����(gname)
select c.gname ���̸�, c.point ����Ʈ, g.gname ����
from gift g, customer c
where c.point between g.g_start  and g_end;

select c.gname ���̸�, c.point ����Ʈ, g.gname ����
from gift g join customer c
on c.point between g.g_start  and g_end;
---
select * from student;
select * from score;
select * from hakjum;
-- �л����� �̸�(name), ����(total) ����(grade) ���
select s.name, s1.total, h.grade
from student s, score s1 , hakjum h
where s.studno = s1.studno 
     and s1.total between h.min_point and h.max_point;
     
select s.name, s1.total, h.grade
from student s, score s1 , hakjum h
where s.studno = s1.studno 
     and s1.total >= h.min_point 
     and s1.total <= h.max_point;
    
-- join ~ on
select s.name, s1.total, h.grade
from student s join score s1
               on s.studno = s1.studno
               join hakjum h
               on s1.total >= h.min_point
               and s1.total <= h.max_point;
---------------------
select * from student;
select * from professor;
--   student ,     professor 
-- �л��̸��� �������� �̸� ����ϵ� ���������� �������� ���� �л� �̸��� ���
-- 15��
select s.name  �л��̸� , p.name ��������
from student s, professor p
where s.profno = p.profno;
--20��
select s.name �л��̸�, p.name ��������
from student s, professor p
where s.profno = p.profno(+);
--ǥ��
select s.name �л��̸�, p.name ��������
from student s left outer join professor p
on s.profno = p.profno;

select s.name �л��̸�, p.name ��������
from   professor p right outer join   student s
on s.profno = p.profno;
----------------
-- 101(deptno1) �� �а��� �Ҽ�
-- ��, ���������� ���� �л��� ���(�а���ȣ, �л��̸�, ���������̸� ���)
select deptno1, name, profno
from student
where deptno1  = 101;

select s.name �л�, p.name �������� , deptno1
from student s, professor p
where s.profno = p.profno(+) and s.deptno1 = 101;

select s.name �л�, p.name �������� , deptno1
from student s left outer join professor p
                on s.profno = p.profno 
where s.deptno1 = 101;
-----------------
select * from dept2;
select * from emp2;
-- dept2���� area�� Seoul Branch Office ��
--����� �����ȣ, �̸�, �μ���ȣ ���
-- ����
select empno, name, deptno
from emp2 e, dept2 d
where e.deptno = d.dcode and area = 'Seoul Branch Office';
-----
--��������
select empno, name, deptno 
from emp2
where deptno in (select dcode
                from dept2
                where area = 'Seoul Branch Office');
--4�� �� ��ȸ
select * 
from dept2
where area = 'Seoul Branch Office';
--student  ���̺�
select * from student;
-- student ���̺��� �� �г⺰ �ִ� �����Ը� ���� �л��� �г�, �̸�, ������ ���
select grade,  max(weight)
from student
group by grade;
------
select grade, name, weight
from student
where (grade,weight) in (
                select grade, max(weight)
                from student
                group by grade
               ); 
select grade, name, weight
from student
where (weight) in (
                select  max(weight)
                from student
                group by grade
               );  
               
select grade, name, weight
from student 
where weight in (83,58,82,81);                
               














