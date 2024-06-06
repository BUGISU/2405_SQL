--p125~126
--1.사원이름 S로 끝나는
select * 
from emp
where ename like '%S';

--2. 30번 부서 중 직책 SALESMAN 인 사원번호, 이름 , 직책, 급여, 부서번호
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN';


--3. 20번 부서 30번부서에 근무, 급여가 2000초과 사원번호, 이름, 급여, 부서번호
-- 집합연산자 미사용
select empno, ename, sal, deptno 
from emp
where deptno in (20,30) and sal > 2000;

-- 집합연산자 사용
select empno, ename, sal, deptno 
from emp
where deptno = 20 and sal > 2000
union
select empno, ename, sal, deptno 
from emp
where deptno = 30 and sal > 2000;

--4.급여가 2000이상 3000이하 범위 이외 not between a and b 사용하지 말고
select *
from emp
where sal <2000 or sal >3000;

--5. 
select ename, empno, sal, deptno
from emp
where deptno = 30 
  and ename like '%E%'
  and sal not between 1000 and 2000;
--6. 추가수당 존재 하지 않고 상급자 있고 MANAGER CLERK 중에서 
--사원이름의 두번 째 글자 L 아닌 정보 출력
select *
from emp
where comm is null
  and mgr is not null
  and job in ('MANAGER','CLERK')
  and ename not like '_L%';

