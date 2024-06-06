--1. professor 테이블과 department 테이블을 조인하여 
--교수번호와 교수이름, 소속학과이름을 조회하는 view 생성(v_prof_dept2)
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


--2. 1번 뷰를 읽기전용으로 v_prof_dept2
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

--3.student, department 사용하여
--학과별로 학생들의 최대키와 최대 몸무게, 학과 이름을 출력
--DNAME MAX_HEIGHT MAX_WEIGH

SELECT
    *
FROM
    student;

SELECT
    *
FROM
    department;

--인라인 뷰 
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


--4.student, department 사용하여
--학과별로 학생들의 최대키와 최대 몸무게, 학과 이름을 출력
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
--5. student 학생의 키가 동일 학년의 평균 키보다 큰 학생의 학년과 이름과
--키 , 해당 학년의 평균키 출력(인라인뷰 이용, 학년으로 오름차순)

--학년별 평균
select grade, avg(height)
from student
group by grade;

select stu.grade , stu.name, stu.height, s.avg_height
from (select grade, avg(height)avg_height
from student
group by grade)s, student stu
where s.grade = stu.grade and stu.height > avg_height
order by stu.grade;


