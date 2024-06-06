--1. 테이블 전체 검색
select * from emp;
--2. 
select empno, ename, sal from emp
where deptno = 10;
--3.
select hiredate , ename , deptno  from emp
where empno = 7369;

select *
from emp
where ename like 'ALL%';

select *
from emp
where ENAME in upper('a');

select ename, sal, deptno
from emp
where hiredate = '1980/12/17';

--6. 직업이 MANAGER 인 사람의 모든 정보 출력
select *
from emp
where job in upper('manager');

--7. 직업이 MANAGER 가 아닌 사람의 모든 정보 출력
select *
from emp
where job != 'MANAGER';

SELECT * FROM emp WHERE job <> 'MANAGER';

--8. 입사일이 81/04/02 이후에 입사한 사원의 정보 출력
SELECT * FROM emp WHERE hiredate > '81/04/052';


desc emp;

--9. 급여가 1000이상인 사람의 이름, 급여, 부서 번호 출력
select ename, sal, deptno from emp where sal >= 1000; 
SELECT * from emp where sal>=1000;

--10. 급여가 1000 이상인 사람의 이름, 급여, 부서번호를 급여가 높은 순으로 출력
SELECT ename, sal, deptno
from emp
where sal>=1000
--order by sal asc; -- 기본값 : 오름차순, asc : 내림차순 
order by sal desc, ename asc; -- 값이 같다면 ename을 기준으로 내림차순 

--11. 이름이K 로 시작하는 사람보다 높은 이름을 가진 사람의 모든 정보 출력
SELECT ename 
from emp 
where ename>'K' 
order by ename asc;

--12. emp 테이블에서 부서 번호 10인 사원번호, 이름, 급여 , 부서번호
select empno, ename, deptno from emp where deptno =10;
select empno, ename, deptno from emp where deptno =20;

--집합 연산자 
--합집합
select empno, ename, sal, deptno from emp
UNION 
select empno, ename, sal, deptno from emp where deptno =20;

--차집합
select empno, ename, sal, deptno from emp
MINUS 
select empno, ename, sal, deptno from emp where deptno =20;

--교집합
select empno, ename, sal, deptno from emp
INTERSECT
select empno, ename, sal, deptno from emp where deptno =20;

-- 12. 부서 번호가 10이거나 20인 사원의 정보 출력
SELECT *
from emp
where deptno =10 or deptno =20;

select *
from emp
where deptno in(10,20); 

--14. 사원 이름이 s로 끝나는 사원의 모든 데이터 출력
select *
from emp
where ename LIKE '%S';

--15. 30번 부서에서 근무하는 사원 중 직업이 job SALESMAN 인 
--사원의 번호, 이름, 직책, 급여, 부서번호 출력
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN'; 

--16. 30번 부서에서 근무하는 사원 중 직업이 job SALESMAN 인
--사원의 번호, 이름, 직책, 급여, 부서번호 출력
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN'
order by sal desc;-- 급여가 많은 순으로 

--17. 30번 부서에서 근무하는 사원 중 직업이 job SALESMAN 인
--사원의 번호, 이름, 직책, 급여, 부서번호 출력
-- 급여가 많은 순으로 
--급여가 같다면 사원번호가 작은 것 부터 출력
select empno, ename, job, sal, deptno
from emp
where deptno = 30 and job = 'SALESMAN'
order by sal desc, empno asc;

--18. 20,30번 부서에 근무하는 사원중 (집합 연산자 사용)
--급여가 2000 초과한 사우너의 사원번호, 이름, 급여, 부서번호 출력
SELECT empno, ename, sal, deptno
from emp 
where  deptno = 20 and sal> 2000
union
SELECT empno, ename, sal, deptno
from emp 
where  deptno = 30 and sal> 2000;

--19. 집합 연산자 사용하지 말고
SELECT empno, ename, sal, deptno
from emp
--20. 급여가 2000이상 3000이하 범위인 사원의 정보 출력
--where  deptno in (20, 30) and sal >= 2000 and sal <=3000;
where (deptno =20 or deptno =30) and (sal>=2000 and sal <=3000);

SELECT *
from emp
where sal BETWEEN 2000 and 3000;

--급여가 2000이상 3000이하 범위 이외의 사원의 정보 출력
SELECT *
from emp
where sal <=2000 or sal>=3000;

SELECT *
from emp
where sal not BETWEEN 2000 and 3000;

--구분자가 있으면 띄어쓰기 가능하지만 없으면 from 을 일깆 못함
select ename as "사원이름", empno as "사원번호", sal 급여, deptno "부서 번호"
from emp;

--사원 이름에 E가 포함되어있는 30번 부서의 사원중,
--급여가 1000~2000 사이가 아닌 사원이름, 사원 번호, 급여, 부서 번호
--한글 컴럼이름으로 출력

SELECT ename 이름 , empno "사원 번호", sal 급여, deptno "부서 번호"
from emp
--where deptno = 30 and ename LIKE '%E%' and sal not BETWEEN 1000 and 2000;
where deptno = 30 and ename LIKE '%E%' and (sal < 1000 or sal > 2000);

--24. 주가수당(comm)이 존재 하지 않는 사람의 정보를 출력
SELECT * from emp; --전체 출력

SELECT *
from emp
where comm is null;

--25. 주가수당(comm)이 존재 하는 사람의 정보를 출력
SELECT *
from emp
where comm is not null;

--25. 주가수당(comm)이 존재 하는 사람의 정보를 출력
SELECT *
from emp
where comm is not null and comm <>0;


--26. 주가수당이 존재 하지 않고 상급자(mgr)가 있고 직급이 MANAGER, CLERK 인
--사원 중에서 사원이름의 두번째 글자가 L 이 아닌 사원정보 출력
SELECT *
from emp
where comm is null 
    and mgr is not null 
    and(job in ('MANAGER','CLERK')) 
    and (ename like '_L%');
    
-- 내장함수
--1. emp 테이블에서 이름만 출력
select *FROM emp; --전체
select ename from emp;

--대문자/ 소문자 /첫글자 대문자 만들기 
SELECT ename , upper(ename)대문자, lower(ename)소문자 , initcap(ename) 첫글자대문자
from emp;

--2. ename, 이름길이 (문자수) 출력
SELECT ename,length(ename)이름길이
from emp;
--사원의 이름이 5글자 이상만 출력
SELECT * from emp
where length(ename)>=5;

--이름 호출(2자만 출력)
SELECT ename, substr(ename,2,2), substr(ename, 3, 2),substr(ename, 1, 2),substr(ename, 0, 2)
from emp;

-- 글자의 위치 값
SELECT instr('CORPORATE FLOOR', 'OR',1,1),instr('CORPORATE FLOOR', 'OR',1,2)
from dual;
-- (-)끝에서 시작해도 위치값은 고정됨
SELECT instr('CORPORATE FLOOR', 'OR',-3,1),instr('CORPORATE FLOOR', 'OR',-3,2)
from dual;

-- 문자가 ABCDEF 에서 D의 위치값 출력
SELECT instr('ABCDDEF','D'),  instr('ABCDDEF','D',-1,1)
from dual;

-- emp테이블에서 ename 중에서 s가 있는 위치 출력
select ename,instr(lower(ename),'s'),instr(upper(ename),'S'),instr(ename,'S')
from emp;
select ename,instr(ename,'S',-1)
from emp;

--사원 이름에 s가 들어가는 것만 출력
select ename
from emp
where instr(ename,'S')>0;

select ename
from emp
where ename like '%S%';

--ename 에서 처음부터 2글자만 추출해서 소문자로 출력
select ename, substr(lower(ename),1,2),lower(substr(ename,1,2))
from emp;

--Replace
SELECT '010-1234-5678' as rep_before,
replace('010-1234-5678','-',' ') ref_after
from dual;
--ename에서 대문자 S를 s로 변경하여 출력
SELECT ename, replace(ename,'S','s')
from emp;

--lengthb 는 byte 를 의미한다 한글은 한글자에 3byte 필요
SELECT length('한글'),lengthb('한글')
from dual;

select 'Oracle' ,length('Oracle'),lengthb('Oracle')
from dual;

SELECT 'Oracle',LPAD('Oracle',10,'#')LPAD1,
                RPAD('Oracle',10,'#')RPAD1,
                LPAD('Oracle',10)LPAD2,
                RPAD('Oracle',10)RPAD2
from dual;
