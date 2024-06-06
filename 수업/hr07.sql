--1. Professor 테이블과  department 테이블을 조인하여 
--교수번호와 교수이름, 소속학과이름을 조회하는  view 생성 (v_prof_dept2)
select * from professor;
select * from department;

create or replace view v_prof_dept2
as
select  p.profno  교수번호, p.name 교수이름, d.dname 소속학과이름
from professor p, department d
where p.deptno = d.deptno;


--2. 1 번 뷰를 읽기전용으로  v_prof_dept3
create or replace view v_prof_dept3
as
select  p.profno  교수번호, p.name 교수이름, d.dname 소속학과이름
from professor p, department d
where p.deptno = d.deptno
with read only;

--3. student , department 사용하여 
--학과별로 학생들의 최대키와 최대 몸무게, 학과 이름을 출력
--(DNAME      MAX_HEIGHT    MAX_WEIGHT)
select deptno1, max(height), max(weight)
from student
group by deptno1;
--인라인 뷰
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

--4.학과이름, 학과별 최대키, 학과별로 가장 키가 큰 학생들의 이름과 키를
--인라인 뷰를 이용하여 출력
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


--5. student 학생의 키가 동일 학년의 평균 키보다 큰 학생의 학년과 이름과
--키, 해당 학년의 평균키 출력 (인라인뷰 이용, 학년으로 오름차순)
select grade, avg(height)
from student
group by grade;

select stu.grade, stu.name, stu.height, s.avg_height
from (select grade, avg(height) avg_height
        from student
        group by grade)s , student stu
where  s.grade = stu.grade and stu.height >s.avg_height
order by stu.grade;        



