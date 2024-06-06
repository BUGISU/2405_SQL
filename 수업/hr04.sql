--professor 테이블
select * from professor;
--1. 학과별로 소속 교수들의 평균급여, 최소급여, 최대급여 출력
--단, 평균급여가 300 넘는 것만 출력
select  deptno, round(avg(pay)) 평균급여, min(pay) 최소급여, max(pay) 최대급여
from professor
group by deptno
having avg(pay)>300
order by avg(pay) desc;

--2.student 테이블
--학생 수가 4명 이상인 학년에 대해서 학년, 학생 수, 평균 키, 평균 몸무게를 출력
--단, 평균 키와 평균 몸무게는 소숫점 첫 번째 자리에서 반올림하고,
--출력순서는 평균 키가 높은 순부터 내림차순으로 출력하여라.
select grade,count(*), round(avg(height)) "평균 키" ,
         round(avg(weight)) "평균 몸무게"
from student
group by grade
having count(*) >=4
order by avg(height) desc ;


--3. 학생이름(name), 지도교수(name) 이름 출력
select * from student;
select * from professor;

select s.name 학생이름, p.name 지도교수
from student s, professor p
where s.profno = p.profno;

select s.name 학생이름, p.name 지도교수
from student s join professor p
on s.profno = p.profno;

--gift, customer 테이블
select * from gift;
select * from customer;
--4. 고객이름(gname),  포인트(point), 선물(gname)
select c.gname 고객이름, c.point 포인트, g.gname 선물
from gift g, customer c
where c.point between g.g_start  and g_end;

select c.gname 고객이름, c.point 포인트, g.gname 선물
from gift g join customer c
on c.point between g.g_start  and g_end;
---
select * from student;
select * from score;
select * from hakjum;
-- 학생들의 이름(name), 점수(total) 학점(grade) 출력
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
-- 학생이름과 지도교수 이름 출력하되 지도교수가 정해지지 않은 학생 이름도 출력
-- 15명
select s.name  학생이름 , p.name 지도교수
from student s, professor p
where s.profno = p.profno;
--20명
select s.name 학생이름, p.name 지도교수
from student s, professor p
where s.profno = p.profno(+);
--표준
select s.name 학생이름, p.name 지도교수
from student s left outer join professor p
on s.profno = p.profno;

select s.name 학생이름, p.name 지도교수
from   professor p right outer join   student s
on s.profno = p.profno;
----------------
-- 101(deptno1) 번 학과에 소속
-- 단, 지도교수가 없는 학생도 출력(학과번호, 학생이름, 지도교수이름 출력)
select deptno1, name, profno
from student
where deptno1  = 101;

select s.name 학생, p.name 지도교수 , deptno1
from student s, professor p
where s.profno = p.profno(+) and s.deptno1 = 101;

select s.name 학생, p.name 지도교수 , deptno1
from student s left outer join professor p
                on s.profno = p.profno 
where s.deptno1 = 101;
-----------------
select * from dept2;
select * from emp2;
-- dept2에서 area가 Seoul Branch Office 인
--사원의 사원번호, 이름, 부서번호 출력
-- 조인
select empno, name, deptno
from emp2 e, dept2 d
where e.deptno = d.dcode and area = 'Seoul Branch Office';
-----
--서브쿼리
select empno, name, deptno 
from emp2
where deptno in (select dcode
                from dept2
                where area = 'Seoul Branch Office');
--4개 행 조회
select * 
from dept2
where area = 'Seoul Branch Office';
--student  테이블
select * from student;
-- student 테이블에서 각 학년별 최대 몸무게를 가진 학생의 학년, 이름, 몸무게 출력
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
               














