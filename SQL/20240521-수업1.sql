--professor ���̺�
select *from  professor;
--�а����� �Ҽ� �������� ��ձ޿�, �ּұ޿�, �ִ�޿� ���
-- ��, ��ձ޿��� 300 �Ѵ� �͸� ���
SELECT  avg(pay), min(pay), max(pay)
from professor
group by deptno
HAVING avg(pay)>=300;

--2. student ���̺�
--�л����� 4�� �̻��� �г⿡ ���ؼ� �г�, �л���, ���Ű, ��� �����Ը� ���
--��, ���Ű�� ��� �����Դ� �Ҽ��� ù���� �ڸ����� �ݿø��ϰ�,
--��¼����� ���Ű�� ���� �������� ������������ ����϶� 
select *from  student;
select grade, count(*),round(avg(height)) "���Ű", round(avg(weight))"��� ������"
from student
group by grade
having count(*) >=4
order by avg(height);

--3. �л��̸�(name), ��������(name) �̸� ���
select *from  professor;
select *from  student;

select s.name �л��̸�, p.name ��������
from professor p, student s
where s.profno = p.profno;

--gift, customer ���̺�
--4. ���̸�(gname), ����Ʈ(point), ����(gname)
select *from  gift;
select *from  customer;

--�� ����
select  c.gname ���̸�, c.point ����Ʈ, g.gname ����
from gift g, customer c
where c.point between g.g_start and  g.g_end;

select  c.gname ���̸�, c.point ����Ʈ, g.gname ����
from gift g join customer c
on c.point between g.g_start and  g.g_end;
--
select *from student;
select *from score;
select *from hakjum;

--�л����� �̸�, ����(total) ���� ���
-- ��� 1
select st.name, sc.total, hj.grade
from  student st, score sc , hakjum hj
where st.studno = sc.studno 
and sc.total between hj.min_point and hj.max_point;  
-- ��� 2
select st.name, sc.total, hj.grade
from  student st, score sc , hakjum hj
where st.studno = sc.studno 
and sc.total >= hj.min_point and sc.total <= hj.max_point;
--join ~ on ���
select st.name, sc.total, hj.grade
from  student st join score sc
    on st.studno = sc.studno 
    join hakjum hj
    on  sc.total >= hj.min_point and sc.total <= hj.max_point;

------------
select * from student;
select * from professor;
-- student, professor
--�л��̸��� �������� �̸� ����ϵ� ���������� �������� ���� �л� �̸��� ���
select s.name �л��̸�, p.name ��������
from student s, professor p
where s.profno = p.profno(+);

--SQL-99 ǥ��
select s.name �л��̸�, p.name ��������
from student s left OUTER join professor p
on s.profno = p.profno;

--101(deptno1)�� �а��� �Ҽӵ� �������� �̸� ���
-- ��, ���������� ���� �л��� ���(�л��̸�, �������� �̸� ���)
select s.deptno1 �а���ȣ, s.name �л��̸�, p.name ��������
from student s, professor p
where s.profno= p.profno(+) and s.deptno1 =101;
--SQL-99 ǥ��
select s.deptno1 �а���ȣ, s.name �л��̸�, p.name ��������
from student s left outer join professor p
on s.profno= p.profno
where s.deptno1 =101;

--------------------------------
select * from dept2;
select * from emp2;
--dept2 ���� area�� Seoul Branch Office �� 
--����� �����ȣ, �̸�, �μ���ȣ ���
select dcode from dept2 where area ='Seoul Branch Office';
select e.empno, e.name, e.deptno
from dept2 d , emp2 e
where d.dcode = e.deptno and d.area ='Seoul Branch Office';

--�������� 
select e.empno, e.name, e.deptno
from emp2 e
where e.deptno in (select dcode from dept2 where area ='Seoul Branch Office');

--
select * from student;
-- student���̺��� �� �г� �� �ִ� �����Ը� ���� �л��� �г�, �̸�, ������ ���

select max(weight)
from student
group by grade;

select grade, name, weight
from student
where (grade,weight) in
    ( select grade, max(weight) from student group by grade) ;
