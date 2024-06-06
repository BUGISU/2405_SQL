--emp 모든 정보 조회
select * from emp;
--dept 모든 정보 조회
select * from dept;
--1.부서번호가 10번 출력
select * from emp where deptno = 10;
--2. 부서번호가 10번인 사람 중 사원번호, 이름, 월급만 출력
select empno, ename, sal from emp where deptno=10;
--3.사원번호가 7369 인 사람의 이름, 입사일, 부서번호 출력
select ename, hiredate, deptno from emp where empno=7369;
--4. 이름이 ALLEN 인 사람의 모든 정보 출력
select * from emp where ename = 'ALLEN';
SELECT * FROM EMP WHERE ENAME = 'ALLEN';
select * from emp where ename = 'allen';

select * from emp;
--5. 입사일이 1980/12/17 인 사원의 이름, 부서번호, 월급 출력
select ename, deptno, sal from emp where hiredate = '1980/12/17';
--6. 직업이 MANAGER 인 사람의 모든 정보 출력
select * from emp where job = 'MANAGER';
--7. 직업이 MANAGER가 아닌 사람의 모든 정보 출력
select * from emp where job != 'MANAGER';
select * from emp where job <> 'MANAGER';
--8. 입사일이 81/04/02 이후에 입사한 사원의 정보 출력
select * from emp where hiredate > '81/04/02';
desc emp;
--9.급여가 1000 이상인 사람의 이름, 급여, 부서번호 출력
select ename, sal, deptno from emp where sal >= 1000;
select * from emp where sal >=1000;
--10. 급여가 1000 이상인 사람의 이름, 급여, 부서번호를 급여가 높은 순으로 출력
select ename, sal, deptno
from emp
where sal >= 1000
order by sal desc;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal asc;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal ;

select ename, sal, deptno
from emp
where sal >= 1000
order by sal desc, ename asc;
--11. 이름이 K로 시작하는 사람보다 높은 이름을 가진 사람의 모든 정보 출력
select * 
from emp
where ename > 'K';

-- 집합연산자
-- emp테이블에서 부서번호 10인 사원번호, 이름, 급여, 부서번호
-- emp테이블에서 부서번호 20인 사원번호, 이름, 급여, 부서번호
select empno, ename, deptno from emp where deptno = 10
UNION
select empno, ename, deptno from emp where deptno = 20;

--
select empno, ename, sal, deptno from emp
union
select empno, ename, sal, deptno from emp where deptno =20;
---
select empno, ename, sal, deptno from emp
MINUS
select empno, ename, sal, deptno from emp where deptno =20;
---
select empno, ename, sal, deptno from emp
INTERSECT
select empno, ename, sal, deptno from emp where deptno =20;

-- 12. 부서번호가 10이거나 20인 사원의 정보출력
select *
from emp
where deptno=10 or deptno =20;

select * 
from emp
where deptno in (10, 20);

--14 사원이름이 S로 끝나는 사원의 모든 데이터 출력
select *
from emp
where ename like '%S';
--15. 30번 부서에서 근무하는 사원 중 job이 SALESMAN 인 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno) 출력
select empno, ename, job, sal, deptno 
from emp
where deptno=30 and job ='SALESMAN';

--16. 30번 부서에서 근무하는 사원 중 job이 SALESMAN 인 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno)
-- 급여가 많은 순으로 출력
select empno, ename, job, sal, deptno 
from emp
where deptno=30 and job ='SALESMAN'
order by sal desc;

--17. 30번 부서에서 근무하는 사원 중 job이 SALESMAN 인 사원의
-- 사원번호(empno), 이름(ename), 직책(job), 급여(sal), 부서번호(deptno)
-- 급여가 많은 순으로 출력, 급여가 같다면 사원번호가 작은 거 부터 출력
select empno, ename, job, sal, deptno 
from emp
where deptno=30 and job ='SALESMAN'
order by sal desc, empno asc;
--18.집합연산자 사용
-- 20번 , 30번 부서에 근무하는 사원 중 
--급여가 2000초과한 사원의 사원번호, 이름,급여, 부서번호 출력
select  empno, ename, sal, deptno
from emp
where deptno =20 and sal > 2000
union
select  empno, ename, sal, deptno
from emp
where deptno =30 and sal > 2000;
--19. 집합연사자 사용하지 말고
select  empno, ename, sal, deptno
from emp
where deptno in (20,30) and sal > 2000;
--20. 급여가 2000 이상 3000 이하 범위인 사원의 정보 출력
select *
from emp
where sal >= 2000 and sal <=3000;

select *
from emp
where sal BETWEEN 2000 and 3000;

--21. 급여가 2000 이상 3000 이하 범위 이외의 사원의 정보 출력
select *
from emp
where sal < 2000 or sal >3000;

select *
from emp
where sal NOT BETWEEN 2000 and 3000;
--22.사원이름, 사원번호, 급여, 부서번호 출력
select ename as "사원이름", empno 사원번호, sal as 급여, deptno "부서 번호"
from emp;

select ename 사원이름, empno 사원번호, sal 급여, deptno 부서_번호
from emp;

--23. 사원이름에 E 가 포함되어 있는 30번 부서의 사원 중
-- 급여가 1000~2000 사이가 아닌 사원이름, 사원 번호, 급여, 부서 번호 
-- 한글 컬럼이름으로 출력
select ename 사원이름 , empno "사원 번호", sal 급여, deptno "부서 번호"
from emp
where ename like '%E%' 
      and deptno =30 
      and sal not BETWEEN 1000 and 2000;
      
 select ename 사원이름 , empno "사원 번호", sal 급여, deptno "부서 번호"
from emp
where ename like '%E%' 
      and deptno =30 
      and (sal <1000 or sal > 2000);
      
--24. 주가수당(comm) 이 존재하지 않는 사람의 정보 출력    
select * from emp;

select *
from emp
where comm is null;

select *
from emp
where comm is not null;

select *
from emp
where comm is not null and comm <> 0;
--25.주가수당이 존재하지 않고 상급자(mgr)가 있고 직급이   MANAGER, CLERK 인 
-- 사원 중에서 사원이름의 두번째 글자가 L이 아닌 사원정보 출력
select *
from emp
where comm is null
  and mgr is not null
  and job in ('MANAGER','CLERK')
  and ename not like '_L%';
  
-- 내장함수
--1.emp  테이블에서  이름만 출력
select * from emp;
select ename from emp;

select ename, upper(ename)as 대문자, lower(ename) 소문자, initcap(ename)
from emp;

--2. ename, 이름길이(문자수)  출력
 select ename, length(ename) 이름길이
 from emp;
 -- 사원의 이름이 5글자 이상만 출력
 select ename, length(ename) 이름길이
 from emp
 where length(ename) >=5;
 --이름 추출(2자만) 출력
select ename, substr(ename, 2,2),substr(ename, 3,2)
from emp;
-- 
select  instr('CORPORATE FLOOR', 'OR',1,1)
from dual;

select  instr('CORPORATE FLOOR', 'OR')
from dual;

select  instr('CORPORATE FLOOR', 'OR',1,2)
from dual;

select  instr('CORPORATE FLOOR', 'OR',-3,1)
from dual;

select INSTR('CORPORATE FLOOR','OR',-3,2)
from dual;
--문자열  ABCDDEF 에서  D의 위치값 출력 (instr)
select instr('ABCDDEF','D'), instr('ABCDDEF','D',-1)
from dual;
-- emp 테이블에서 ename 중  S 가 있는 위치 출력
select instr(ename, 'S'),instr(ename, 'S', -1),instr(ename, 'S', 3)
from emp;

-- 사원이름에  S 가 들어가는 것만 출력 (INSTR 사용)
select ename
from emp
where instr(ename, 'S')>0;

select ename
from emp
where ename like '%S%';

-- ename 에서 처음부터 2글자만 추출하여 소문자로 출력
select lower(ename)
from emp;

select substr(ename, 1,2)
from emp;

select ename, lower(substr(ename, 1,2)) 소문자
from emp;

--REPLACE
select '010-1234-5678' as rep_before,
   replace('010-1234-5678','-',' ') ref_after
from dual;

-- ename 에서 S 를 s 로 변경하여 출력
select ename , replace(ename, 'S','s')
from emp;

---
select length('한글'), lengthb('한글')
from dual;

select 'Oracle' ,length('Oracle'), lengthb('Oracle')
from dual;

select 'Oracle', LPAD('Oracle',10, '#') LPAD1,
                 RPAD('Oracle',10, '#') RPAD1,
                 LPAD('Oracle',10) LPAD2,
                 RPAD('Oracle',10) RPAD2
from dual;











