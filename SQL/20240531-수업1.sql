--1. professor ���̺�� department ���̺��� �����Ͽ� 
--������ȣ�� �����̸�, �Ҽ��а��̸��� ��ȸ�ϴ� view ����(v_prof_dept2)
SELECT
    *
FROM
    professor;

SELECT
    *
FROM
    department;

SELECT
    p.profno,
    p.name,
    d.dname
FROM
    professor  p,
    department d
WHERE
    p.deptno = d.deptno;

CREATE OR REPLACE VIEW v_prof_dept2 AS
    (
        SELECT
            p.profno,
            p.name,
            d.dname
        FROM
            professor  p,
            department d
        WHERE
            p.deptno = d.deptno
    );


--2. 1�� �並 �б��������� v_prof_dept2
CREATE OR REPLACE VIEW v_prof_dept2 AS
    (
        SELECT
            p.profno,
            p.deptno,
            d.dname
        FROM
            professor  p,
            department d
        WHERE
            p.deptno = d.deptno
    )
WITH READ ONLY;

--3.student, department ����Ͽ�
--�а����� �л����� �ִ�Ű�� �ִ� ������, �а� �̸��� ���
--DNAME MAX_HEIGHT MAX_WEIGH

SELECT
    *
FROM
    student;

SELECT
    *
FROM
    department;

--�ζ��� �� 
SELECT
    d.dname,
    s.deptno1,
    s.max_height,
    s.max_weigh
FROM
    (
        SELECT
            deptno1,
            MAX(weight) max_weigh,
            MAX(height) max_height
        FROM
            student s
        GROUP BY
            deptno1
    )          s,
    department d
WHERE
    s.deptno1 = d.deptno;


--4.student, department ����Ͽ�
--�а����� �л����� �ִ�Ű�� �ִ� ������, �а� �̸��� ���
--DNAME MAX_HEIGHT MAX_WEIGH NAME HEIGHT

SELECT
    deptno1,
    MAX(s.weight) max_weigh
FROM
    student s
GROUP BY
    deptno1;

SELECT
    d.dname,
    s.max_height,
    s1.name,
    s1.height
FROM
    (
        SELECT
            deptno1,
            MAX(height) max_height
        FROM
            student
        GROUP BY
            deptno1
    )          s,
    student    s1,
    department d
WHERE
        s.deptno1 = d.deptno
    AND s.deptno1 = d.deptno
    AND s.max_height = s1.height;
    
--- Join ~ on
--5. student �л��� Ű�� ���� �г��� ��� Ű���� ū �л��� �г�� �̸���
--Ű , �ش� �г��� ���Ű ���(�ζ��κ� �̿�, �г����� ��������)

--�г⺰ ���
select grade, avg(height)
from student
group by grade;

select stu.grade , stu.name, stu.height, s.avg_height
from (select grade, avg(height)avg_height
from student
group by grade)s, student stu
where s.grade = stu.grade and stu.height > avg_height
order by stu.grade;


