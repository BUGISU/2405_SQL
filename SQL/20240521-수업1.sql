--professor 테이블
select *from  professor;
--학과별로 소속 교수들의 평균급여, 최소급여, 최대급여 출력
-- 단, 평균급여가 300 넘는 것만 출력
SELECT  avg(pay), min(pay), max(pay)
from professor
group by deptno
HAVING avg(pay)>=300;

--2. student 테이블
--학생수가 4명 이상인 학년에 대해서 학년, 학생수, 평균키, 평균 몸무게를 출력
--단, 평균키와 평균 몸무게는 소숫점 첫번쨰 자리에서 반올림하고,
--출력순서는 평균키가 높은 순서부터 내림차순으로 출력하라 
select *from  student;
select grade, count(*),round(avg(height)) "평균키", round(avg(weight))"평균 몸무게"
from student
group by grade
having count(*) >=4
order by avg(height);

--3. 학생이름(name), 지도교수(name) 이름 출력
select *from  professor;
select *from  student;

select s.name 학생이름, p.name 지도교수
from professor p, student s
where s.profno = p.profno;

--gift, customer 테이블
--4. 고객이름(gname), 포인트(point), 선물(gname)
select *from  gift;
select *from  customer;

--비등가 조인
select  c.gname 고객이름, c.point 포인트, g.gname 선물
from gift g, customer c
where c.point between g.g_start and  g.g_end;

select  c.gname 고객이름, c.point 포인트, g.gname 선물
from gift g join customer c
on c.point between g.g_start and  g.g_end;
--
select *from student;
select *from score;
select *from hakjum;

--학생들의 이름, 점수(total) 학점 출력
-- 방법 1
select st.name, sc.total, hj.grade
from  student st, score sc , hakjum hj
where st.studno = sc.studno 
and sc.total between hj.min_point and hj.max_point;  
-- 방법 2
select st.name, sc.total, hj.grade
from  student st, score sc , hakjum hj
where st.studno = sc.studno 
and sc.total >= hj.min_point and sc.total <= hj.max_point;
--join ~ on 방법
select st.name, sc.total, hj.grade
from  student st join score sc
    on st.studno = sc.studno 
    join hakjum hj
    on  sc.total >= hj.min_point and sc.total <= hj.max_point;

------------
select * from student;
select * from professor;
-- student, professor
--학생이름과 지도교수 이름 출력하되 지도교수가 정해지지 않은 학생 이름도 출력
select s.name 학생이름, p.name 지도교수
from student s, professor p
where s.profno = p.profno(+);

--SQL-99 표준
select s.name 학생이름, p.name 지도교수
from student s left OUTER join professor p
on s.profno = p.profno;

--101(deptno1)번 학과에 소속된 지도교수 이름 출력
-- 단, 지도교수가 없는 학생도 출력(학생이름, 지도교수 이름 출력)
select s.deptno1 학과번호, s.name 학생이름, p.name 지도교수
from student s, professor p
where s.profno= p.profno(+) and s.deptno1 =101;
--SQL-99 표준
select s.deptno1 학과번호, s.name 학생이름, p.name 지도교수
from student s left outer join professor p
on s.profno= p.profno
where s.deptno1 =101;

--------------------------------
select * from dept2;
select * from emp2;
--dept2 에서 area가 Seoul Branch Office 인 
--사원의 사원번호, 이름, 부서번호 출력
select dcode from dept2 where area ='Seoul Branch Office';
select e.empno, e.name, e.deptno
from dept2 d , emp2 e
where d.dcode = e.deptno and d.area ='Seoul Branch Office';

--서브쿼리 
select e.empno, e.name, e.deptno
from emp2 e
where e.deptno in (select dcode from dept2 where area ='Seoul Branch Office');

--
select * from student;
-- student테이블에서 각 학년 별 최대 몸무게를 가진 학생의 학년, 이름, 몸무게 출력

select max(weight)
from student
group by grade;

select grade, name, weight
from student
where (grade,weight) in
    ( select grade, max(weight) from student group by grade) ;
