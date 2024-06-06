-- 문자열 연결 : concat
SELECT concat(ename, job)
from emp;

SELECT concat(ename,':') from emp;

--1. concat 사용하여 ename :job 예)SMITH:CLERK
SELECT concat(concat(ename,':'),job)
from emp;

SELECT concat(ename, concat(':', job))
from emp;

--문자열 연결 || 
SELECT ename || ':' || job 이름_직업
from emp;

--2. 사원번호 (empno)를 앞 2자리만 표현하고 뒤2자리는 *로 표로 출력
SELECT empno, substr(empno,1,2), rpad(substr(empno,1,2),4,'*') 사원번호 
from emp;

SELECT empno, substr(empno,1,2), rpad(substr(empno,1,2),length(empno),'*') 사원번호
from emp;

--공백제거 
SELECT '    oracle   ', length(( '    oracle   '))길이,
            trim( '    oracle   ')str , length(trim( '    oracle   '))길이,
            Ltrim('    oracle   ')Lstr, length(Ltrim('    oracle   '))Lstr_길이,
            Rtrim('    oracle   ')Rstr, length(Rtrim('    oracle   '))Rstr_길이
from dual;

--숫자
--round (반올림 ,소수점 자리) 생략시,정수까지 표현
SELECT 123.567 ,round(123.567,1) ,round(123.567,2) 
        ,round(123.567,-1),round(123.567)
from dual;

--trunc(버림)
select trunc(15.79,1), trunc(15.793,2), trunc(15.793,-1), trunc(15.79)
from dual;

-- ceil, floor 가장 가까운 큰수, 작은 정수 반환
select ceil(3.14) ,floor(3.14), ceil(-3.14) , floor(-3.14)
        ,trunc(-3.14),trunc(3.14)
from dual; 
--2의 3승
select power(2,3) from dual;

--나머지 
select mod(15,6)
from dual;

--날짜 
SELECT sysdate 오늘 , sysdate +1 내일,sysdate -1 어제
        ,sysdate +3
from dual;
--3개월 뒤
SELECT sysdate, add_months(sysdate,3) 오늘_3개월후, add_months('22/05/15',3)
from dual;

--emp 테이블에서 사원번호, 이름, 입사일, 입사 10년 후 날짜 출력
SELECT  empno,ename,add_months(hiredate,120)
from emp;

--근무 개월수, 소수점 버림
select empno, ename, hiredate , months_between(hiredate, sysdate) as month1,
months_between(sysdate, hiredate) as month2, 
trunc(months_between(sysdate, hiredate)) as 근무개월수
from emp;

select empno, ename, hiredate
,concat(trunc(months_between(sysdate, hiredate)),' 개월')
,trunc(months_between(sysdate, hiredate))||' 개월'
from emp;

--다음 주 월요일 출력 /이번달 마지막 날
SELECT sysdate, next_day(sysdate,'월요일')다음주월요일 ,last_day(sysdate)이번달마지막
   ,last_day('22/05/15') 기준일_마지막_날
from dual;

--사원번호가 짝수인 사원번호, 이름, 직급 출력
SELECT empno, ename, job
from emp
where mod(empno,2)=0; --나머지는 mod()

--급여(sal)가 1500에서 3000 사이의 사원은 그 급여의 15%를 회비로 지불
--이름, 급여, 회비 (반올림) 출력
SELECT ename, sal,sal*0.15,round(sal*0.15)회비
from emp
where sal Between 1500 and 3000;

--숫자 +문자 
SELECT empno, ename, empno+'500'
from emp
where ename ='SMITH';

--ERROR 숫자랑 문자는 더할 수 없다
SELECT empno,'ABCD'+empno
from emp
where ename ='SMITH';

--포멧 형식 지정
select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')현재날짜_시간_포멧설정
from dual;

select (to_char(sysdate, 'mm') || '월') 월 from dual;
select to_char(sysdate, 'dd')|| '일' 일 from dual;
select to_char(sysdate, 'hh')|| '시' 시 from dual;
select to_char(sysdate, 'mi')|| '분'분 from dual;
select to_char(sysdate, 'ss') || '초'초 from dual;

SELECT to_char(sysdate,'Mon') from dual; --달
SELECT to_char(sysdate,'day') from dual; --요일
SELECT to_char(sysdate,'day') from dual;

--입사일이 1,2,3 월인 사원의 번호, 이름, 입사일 출력
--1
SELECT empno, ename, hiredate
from emp
where to_char(hiredate,'MM') in (1,2,3);
--2
SELECT empno, ename, hiredate
from emp
where to_char(hiredate,'MM') in ('01','02','03');
--3
SELECT empno, ename, hiredate
from emp
where to_char(hiredate,'MM') between '01' and '03';

--숫자 표기법, 패턴 만들기
select sal, to_char(sal, '$999,999')sal_$ --달러표시
        ,to_char(sal, 'L999,999')sal_L --원
        ,to_char(sal, '000,999')sal_0 --자리를 차지함
from emp; 

SELECT to_char(123456,'$99,999'), to_char(123456,'$999,999')
from dual;

--to_number()
SELECT to_number('1,300', '999,999'),to_number('1,500', '999,999')
        ,to_number('1,300', '999,999')-to_number('1,500', '999,999')
from dual;
--to_date()문자를 날자 형식으로 바꿔준다
select to_date('20100704','YYYY-MM-DD') as Strdate
from dual;

--80/12/17 일 이후로 입사한 사람 출력 
SELECT empno, ename,hiredate
from emp 
where hiredate >'80/12/17';

desc emp;--데이터 형 확인

SELECT empno, ename,hiredate
from emp 
where hiredate >to_date('80/12/17','YYYY-MM-DD');

SELECT empno, ename,hiredate
from emp 
where hiredate >to_date('1980/12/17','YYYY-MM-DD');

-- 사번, 이름, 급여, 커미션(comm), 급여 +커미션 출력
--nvl()널 일 때의 값을 지정가능
SELECT empno, ename, sal, comm, nvl(comm,0),sal+nvl(comm,0)
from emp ;
--comm 받으면 0 ,받지 않으면 X => nvl2(값, 널X, 널O)
SELECT empno, nvl2(comm,'O','X')
from emp;

--연봉(1년치 급여 sal*12) ,번호, 이름, 연봉 출력
--nvl사용
SELECT empno, ename, sal*12+nvl(comm,0) 연봉
from emp;
--nvl2사용
SELECT empno, ename, to_char(sal*12+nvl2(comm,comm,0),'999,999') 연봉
from emp;

SELECT empno, ename, to_char(nvl2(comm,sal*12+comm,sal*12),'999,999') 연봉
from emp;

SELECT mgr from emp;

-- mgr 이 null 이면 'CEO'출력 empno, ename, mgr
SELECT  empno, ename, nvl(to_char(mgr),'CEO')
from emp;

SELECT  empno, ename, nvl(to_char(mgr),'CEO')
from emp
where mgr is null;

--p170
--job 에 따라 급여 인상률을 다르게 설정
--decode()
-- MANAGER 1.5 SALESEMAN 1.2 ANALST 1.05 
SELECT empno, ename, job, sal
,decode(job , 'MANAGER', sal*1.5
        , 'SALESEMAN', sal*1.2
          , 'ANALST', sal*1.05,
          sal*1.04) upsal
from emp;
--case when end
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.5
        when 'SALESEMAN' then sal*1.2
        when 'ANALST' then sal*1.05
        else   sal*1.04
    end as 인상급여
from emp;

-- comm 이 null 이면 해당사항 없음, comm =0 이면 수당 없음
-- 있으면 수당 : (예) comm 이 50 이면 수당: 50 
--empno, ename, comm, comm_text 출력
--case when . decode  사용
SELECT empno, ename, comm,
case 
    when comm is NUll then '해당사항 없음'
    when comm =0 then '수당 없음'
    when comm>0 then  '수당 : '|| comm
end as comm_text
from emp;

SELECT empno, ename, comm,
decode(comm, null,'해당사항 없음'
        ,0,'수당없음',
        '수당 : '|| comm
)comm_text
from emp;

---------------------------------------------------------
--professor 테이블 이용
SELECT * from professor;
--1. professer 테이블에서 교수명(name)과 학과번호(deptno),학과명 출력
--학과번호가 101은 컴퓨터공학과 101이 아닌 학과는 학과명에
--아무것도 출력하지 마시오
select name, decode(deptno, 101, '컴퓨터공학과',' ')학과명
from professor;

select name,
case when
    deptno =101 then '컴퓨터공학과'
end 학과명
from professor;

--professor 테이블에서 교수명(name)과 학과 번호 (deptno), 학과명 출력 
--학과번호가 101은 컴퓨터공학과 101이 아닌 학과는 기타로 출력
--01.
SELECT name, deptno, decode(deptno, 101,'컴퓨터공학과','기타')학과명
from professor;
--02.
select name,
case when
    deptno =101 then '컴퓨터공학과'
    else '기타'
end 학과명
from professor;

--03.
select name,
case deptno when
    101 then '컴퓨터공학과'
    else '기타'
end 학과명
from professor;

--학과 번호가 101이면 학과명 컴퓨터공학과 
--102번 멀티미디어공학과
--201 소프트웨어 공학
-- 나머지 기타

SELECT name, deptno, decode(deptno,
101,'컴퓨터공학과'
,102,'멀티미디어공학과'
,201,'소프트웨어공학과'
,'기타')학과명
from professor;

SELECT name,deptno,
case  deptno 
when 101 then '컴퓨터공학과'
when 102 then '멀티미디어공학과'
when 201 then '소프트웨어공학과'
else '기타'
end 학과명
from professor;

--student 테이블
--학생을 3개 팀으로 부류하기 위해 학번을 3으로 나누어 
--나머지가 0이면 A팀 1이면 B팀,2이면 C팀으로 
--분류하여 학생번호, 이름, 학과 번호(deptno1), 팀으로 출력
SELECT * from student;

SELECT studno, name, deptno1,
case when mod(studno,3)=0 then 'A 팀'
     when mod(studno,3)=1 then 'B 팀'
     when mod(studno,3)=2 then 'C 팀'
end 팀
from student;

--학생테이블에서 jumin 번호에서 1이면 남자, 2여자
--학번, 이름, 성별 출력
select studno, name,jumin
,case substr(jumin,7,1)
when to_char(1) then'남'
when to_char(2) then'여'
end 성별
from student;

select studno, name, jumin, case
when jumin like '______1%' then '남자'
else '여자'
end 성별
from student;

--02 서울, 051부산,052 울산,053대구 ,나머지는 기타 
--이름,전화번호, 지역 출력
select name,tel, substr(tel,1,instr(tel,')')-1) 지역_변수
,case substr(tel,1,instr(tel,')')-1)
                        when '02' then '서울'
                        when '052' then '울산'
                        when '051' then '부산'
                        when '053' then '대구'
                        else '기타'
end 지역

--,decode(substr(tel,0,3),051,'부산',02,'서울',052,'울산',053,'대구','기타')지역
from student;

