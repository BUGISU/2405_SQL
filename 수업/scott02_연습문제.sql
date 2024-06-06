--p174연습문제
--1.
select empno,rpad(substr(empno,1,2),length(empno),'*')MASKING_EMPNO,
    ename, rpad(substr(ename,1,1),length(ename),'*') MASKING_ENAME
from emp;

select empno,rpad(substr(empno,1,2),length(empno),'*')MASKING_EMPNO,
    ename, rpad(substr(ename,1,1),length(ename),'*') MASKING_ENAME
from emp
where length(ename) >=5 and length(ename) < 6;

select empno,rpad(substr(empno,1,2),length(empno),'*')MASKING_EMPNO,
    ename, rpad(substr(ename,1,1),length(ename),'*') MASKING_ENAME
from emp
where length(ename) =5 ;
--2.
select empno, ename, sal,
    trunc(sal/21.5) day_pay,
    round(sal/21.5/8) time_pay
from emp;
-- 소수 세번째 자리에서 버림 /두번째 소수점에서 반올림
select empno, ename, sal,
    trunc(sal/21.5, 2) day_pay,
    round(sal/21.5/8, 1) time_pay
from emp;
--3.
select empno, ename, hiredate,
      add_months(hiredate,3), next_day(add_months(hiredate,3),'월요일') R_JOB
from emp;

select empno, ename, hiredate,
       to_char(next_day(add_months(hiredate,3),'월요일'), 'YYYY-MM-DD') R_JOB,
       nvl(to_char(comm),'N/A') COMM
from emp;
--4
select empno, ename, mgr
from emp;
--case
select empno, ename, mgr,
case
    when mgr is null then '0000'
    when substr(mgr,1,2) = '75' then '5555'
    when substr(mgr,1,2) = '76' then '6666'
    when substr(mgr,1,2) = '77' then '7777'
    when substr(mgr,1,2) = '78' then '8888'
    else to_char(mgr)
 end as  CHG_MGR
from emp;
--decode
select empno, ename, mgr,
    decode(substr(mgr,1,2), null, '0000',
                            '75','5555',
                            '76','6666',
                            '77','7777',
                            '78','8888',
                            to_char(mgr)
    ) as CHG_MGR
from emp;    
    
 











