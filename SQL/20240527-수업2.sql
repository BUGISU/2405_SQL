--각 학과별 입살일 가장 오래된 교수의 교수번호, 이름, 학과명 출력
-- 단 입사일은 오름차순(professor,department)
select * from professor; 
select * from department; 

select deptno, min(hiredate)
from professor
group by detpno;

select p.profno, p.name, p.deptno, d.dname,p.hiredate
from professor p , department d
where p.deptno = d.deptno and (p.deptno, p.hiredate)
in (
    select deptno, min(hiredate)
    from professor
    group by deptno)
order by p.hiredate; --3 은 select 된 컬럼 순서

--employees
select * from employees; 
-- employee_id = 사원 아이디, manager_id : 매니저 아이디, first_name:firstname
--1. 부서번호가 80보다 큰 부서의 사원아이디, firstname, 매니저 아이디 출력
select employee_id 사원아이디,first_name 사원이름, manager_id 매니저아이디
from employees
where department_id >= 80;

--2. 부서번호가 80보다 큰 부서의 사원아이디, firstname, 매니저 이름 출력
-- 셀프조인
select e.employee_id 사원아이디, e.first_name 사원이름, m.first_name 매니저이름
from employees e , employees m
where e.manager_id = m.employee_id 
and e.department_id > 80;

--3. Donald 같은 연봉을 받는 사람의 아이디, 이름, 연봉출력
select employee_id, first_name, salary 
from employees
where first_name = 'Donald';

select employee_id, first_name, salary
from employees
where salary =(select salary 
from employees
where first_name = 'Donald');

--4. Donald 입사일이 동일하거나 늦게 입사한 사람의 아이디, 급여, 입사일 출력
select employee_id, salary , hire_date
from employees
where hire_date >= (select hire_date from employees where first_name = 'Donald'); 

select * from employees; 
--5. 부서번호가 100인 부서의 평균 급여보다 많은 급여를 받는 사원의 이름과 급여 출력
select first_name, salary
from employees
where salary > (select avg(salary) from employees where department_id =100);

