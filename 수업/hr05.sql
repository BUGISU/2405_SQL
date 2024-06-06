-- (professor,  department)  테이블
-- 각 학과별 입사일 가장 오래된 교수의 교수번호, 이름 ,학과명 출력
-- 단 입사일은 오름차순   (professor,  department)
select * from professor;
select * from department;
select deptno, min(hiredate)
from professor
group by deptno;

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p, department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by p.hiredate ;

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p, department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by p.deptno ;

select p.profno, p.name, p.deptno, d.dname, p.hiredate
from professor p, department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                from professor
                                group by deptno)
order by 3 ; -- 3 은 select 된 컬럼 순서

--공유폴더 hr_table.sql 을 복사해서 departments, employees 생성
--employees
--( employee_id : 사원아이디, manager_id :매니저 아이디,first_name:firstname )
select * from employees;
--1. 부서번호가 80보다 큰 부서의 사원아이디, firstname, 매니저 아이디 출력
select  employee_id 사원아이디, first_name 사원이름,  manager_id 매니저아이디
from employees
where department_id > 80;
--2. 부서번호가 80보다 큰 부서의 사원아이디, firstname, 매니저 이름 출력
--셀프조인
select e1.employee_id 사원아이디 , e1.first_name 사원이름, 
    e2.first_name 매니저이름
from employees e1, employees e2
where e1.manager_id = e2.employee_id and e1.department_id > 80;

--3. Donald 같은 연봉을 받는 사람의 아이디, 이름, 연봉 출력
select salary
from employees
where first_name = 'Donald';

select employee_id, first_name, salary
from employees
where salary = 2600;

select employee_id, first_name, salary
from employees
where salary = (select salary
                from employees
                where first_name = 'Donald');

--4.Donald 입사일이 동일하거나 늦게 입사한 사람의 아이디, 급여, 입사일 출력
select hire_date
from employees
where first_name ='Donald';

select employee_id, salary, hire_date
from employees
where hire_date >= '17/06/21';

select employee_id, salary, hire_date
from employees
where hire_date >= (select hire_date
                    from employees
                    where first_name ='Donald');
--5. 부서번호가 100인 부서의 평균 급여보다 많은 급여를 받는 사원의 이름과 급여 출력
select avg(salary) from   employees where department_id = 100;
select first_name, salary
from employees
where department_id = 100;

select first_name, salary
from employees
where salary  > (select avg(salary) 
                from   employees
                where department_id = 100) ;             






