--174,175 연습 문제
--01.
select empno, RPAD(substr(empno,1,2),length(empno),'*') as MASKING_EMPNO,
ename, RPAD(substr(ename,1,1),length(ename),'*') as MASKING_ENAME
from emp
where length(ename) >=5 and length(ename) <6;

--02.
select empno, ename, sal, 
    trunc(sal/21.5,2) as DAY_PAY , 
    round((sal/21.5)/8,1) time_pay
from emp;

--03
select empno, ename,to_char(hiredate,'yyyy-mm-dd')HIREDATE ,
to_char(next_day(add_months(hiredate,3),'월요일'),'yyyy-mm-dd') R_JOB , 
nvl(to_char(comm),'N/A')COMM
from emp;

--04
SELECT empno, ename, nvl(to_char(mgr),' '),
case    when mgr is null then '0000' 
        when substr(mgr,1,2) = 75 then '5555' 
        when substr(mgr,1,2) = 76 then '6666' 
        when substr(mgr,1,2) = 77 then '7777' 
        when substr(mgr,1,2) = 78 then '8888'
        else to_char(mgr)
end CHG_MGR
from emp;
--decode
select empno, ename, mgr,
decode( substr(mgr,1,2),
null,'0000',
'75','5555',
'76','6666',
'77','7777',
'78','8888',
to_char(mgr)) as CHG_MGR
from emp;