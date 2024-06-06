--연결 : concat
select concat(ename, job)
from emp;
select concat(ename, ':') from emp;
--1.  concat 사용하여  ename : job  예)SMITH:CLERK
select concat(concat(ename, ':'), job) 
from emp;

select concat(ename, concat(':', job))
from emp;
--  문자열 연결 ||
select ename || ':' || job 이름_직업
from emp;
--2.사원번호(empno)를 앞 2자리만 표현하고 뒤 2자리는 *표로 출력 
select empno,substr(empno, 1,2),rpad(substr(empno, 1,2),4,'*')
from emp;

select rpad(substr(empno, 1,2),4,'*') 사원번호
from emp;

select rpad(substr(empno, 1,2),length(empno),'*') 사원번호
from emp;
-- 공백제거
select trim('   oracle   ') as str, length(trim('   oracle   ')) 길이,
       Ltrim('   oracle   ') as Lstr,length(Ltrim('   oracle   ')) L길이,
       Rtrim('   oracle   ') as Rstr,length(Rtrim('   oracle   ')) R길이
from dual;

--숫자
--round(반올림)
select 123.567, round(123.567,1),round(123.567,2),
                round(123.567,-1),round(123.567)
from dual;
--trunc(버림)
select trunc(15.79,1),trunc(15.793,2),trunc(15.793,-1),trunc(15.793)
from dual;
--ceil, floor 가장 가까운 큰수, 작은 정수 반환
select ceil(3.14), floor(3.14),ceil(-3.14),floor(-3.14),
        trunc(-3.14),trunc(3.14)
from dual;
select power(2,3) from dual;
--나머지
select mod(15,6)
from dual;

-- 날짜
select sysdate 오늘, sysdate+1 내일, sysdate-1 어제, sysdate+3
from dual;
-- 3개월 뒤
select sysdate, add_months(sysdate, 3)
from dual;

select sysdate, add_months('22/05/15', 3)
from dual;
-- emp 테이블에서 사원번호, 이름, 입사일, 입사 10년 날짜 출력
select empno, ename, hiredate, add_months(hiredate, 120)입사10년
from emp;
-- 근무 개월수 소수점 이하는 버림으로 구하기
select empno, ename, hiredate,
    months_between(hiredate, sysdate) as month1,
    months_between(sysdate, hiredate) as month2,
    trunc(months_between(sysdate, hiredate)) as 근무개월수
from emp;

select empno, ename, hiredate, trunc(months_between(sysdate, hiredate)) 근무개월
from emp;

select empno, ename, hiredate, 
   trunc(months_between(sysdate, hiredate))||'개월' 근무개월
from emp;
--concat 이용
select empno, ename, hiredate, 
    concat(trunc(months_between(sysdate, hiredate)),'개월') 근무개월수
from emp;
---
select sysdate, next_day(sysdate,'월요일'),
       last_day(sysdate),last_day('23/04/01')
from dual;
-- 사원번호가 짝수인 사원번호, 이름 ,직급 출력
select empno, ename, job
from emp
where mod(empno, 2)=0;
--급여(sal)가 1500에서 3000사이의 사원은 그 급여의 15%를 회비로 지불
-- 이름, 급여, 회비(반올림) 출력
 select  ename, sal 급여, sal*0.15, round(sal*0.15) 회비
 from emp
 where sal >=1500 and sal<=3000;
--p157 형변환함수
-- 숫자+문자(500==>숫자)
select empno, ename, empno+'500'
from emp
where ename = 'SMITH';
-- 오류발생
--select empno, 'ABCD'+empno
--from emp
--where ename = 'SMITH';

 select to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') 현재날짜시간
 from dual;
 
 select to_char(sysdate, 'MM') 월 from dual ;
 select to_char(sysdate, 'DD') 일 from dual ;
 --시
  select to_char(sysdate, 'HH') 시 from dual ;
  select to_char(sysdate, 'HH24') 시 from dual ;
 --분
 select to_char(sysdate, 'MI') 분 from dual ;
 --초
 select to_char(sysdate, 'SS') 초 from dual ; 
 select to_char(sysdate,'MON') from dual;
 select to_char(sysdate,'MONTH') from dual;
 select to_char(sysdate,'day') from dual;
 select to_char(sysdate,'DAY') from dual;
 -- 입사일이 1,2,3월인 사원의 번호, 이름, 입사일 출력
select empno, ename, hiredate
from emp
where to_char(hiredate, 'MM') in ('01','02','03');

select empno, ename, hiredate
from emp
where to_char(hiredate, 'MM') between '01' and '03';
------
select sal, to_char(sal,'$999,999') sal_$,
        to_char(sal,'L999,999') sal_L,
        to_char(sal,'000,999') sal_0
from emp;

select to_char(123456,'$99,999') ,to_char(123456,'$999,999')
from dual;

select to_number('1,300','999,999')-to_number('1,500','999,999')
from dual;

--p164
select to_date('20100704','YYYY-MM-DD') as strdate
from dual;
-- 80/12/17  일 이후로 입사한 사람 출력
select empno, ename, hiredate
from emp
where hiredate > '80/12/17';

desc emp;

select empno, ename, hiredate
from emp
where hiredate >to_date('1980/12/17','YYYY/MM/DD');

select empno, ename, hiredate
from emp
where hiredate >to_date('80/12/17','YYYY/MM/DD');
 
--   사번, 이름, 급여, 커미션, 급여+커미션 출력 (nvl)
select empno, ename,sal, comm,nvl(comm, 0), sal+nvl(comm, 0)
from emp;
-- comm 받으면  O, 받지않으면 X  => nvl2(값, null 아닐때, null)
select empno, comm, nvl2(comm, 'O', 'X')
from emp;
-- 연봉 (1년치 급여+comm  sal*12)
-- 번호, 이름, 연봉
select empno, ename, sal*12+nvl(comm,0) 연봉
from emp;
--nvl2 사용
select to_char(nvl2(comm, sal*12+comm, sal*12),'999,999') 연봉1,
       to_char(sal*12+nvl2(comm, comm, 0),'999,999') 연봉2
from emp;

select mgr from emp;
-- mgr 이 null 이면 'CEO' 출력  empno, ename, mgr
select empno, ename, nvl(to_char(mgr), 'CEO')
from emp;

select empno, ename, nvl(to_char(mgr), 'CEO')
from emp
where mgr is null;

-- p170
-- job 에 따라 급여 인상률을 다르게 설정
-- MANAGER 1.5  /    SALESMAN 1.2 / ANALST 1.05  / 1.04
--decode
select empno, ename, job, sal,
      decode(job, 'MANAGER', sal*1.5,
                  'SALESMAN', sal*1.2,
                  'ANALST', sal*1.05,
                  sal*1.04) upsal
from emp;
--case when end
select empno, ename, job, sal,
    case job
        when 'MANAGER' then sal*1.5
        when 'SALESMAN' then sal*1.2
        when 'ANALST' then sal*1.05
        else  sal*1.04
    end as 인상급여
from emp;
-- comm 이 null  이면 해당사항 없음, comm =0 이면 수당없음
-- comm 이 있으면 수당:  (예: comm이 50 이면 수당:50)
-- empno, ename, comm, comm_text 출력
-- case when
select empno, ename, comm,
    case 
        when comm is null then '해당사항없음'
        when comm = 0 then '수당없음'
        when comm > 0 then '수당 :'||comm
    end as comm_text
from emp;
-- decode
select empno, ename, comm,
        decode(comm, null , '해당사항없음',
                    0, '수당없음',
                    '수당 :'||comm
        ) comm_text
from emp;
--------------------
--professor 테이블 이용
--1. professor 테이블에서 교수명(name)과 학과번호(deptno), 학과명 출력
-- 학과번호가 101은 컴퓨터공학과 101이 아닌 학과는 학과명에
-- 아무것도 출력하지 마세요
select name, deptno, 
 case when deptno=101 then '컴퓨터공학과'
 end 학과명
from professor;

select name, deptno, 
     decode(deptno, 101 , '컴퓨터공학과' ) 학과명
from professor;

--2. professor 테이블에서 교수명(name)과 학과번호(deptno), 학과명 출력
 -- 학과번호가 101은 컴퓨터공학과 101이 아닌 학과는 기타로 출력
select name, deptno, 
 case when deptno=101 then '컴퓨터공학과'
 else '기타'
 end 학과명
from professor;

select name, deptno, 
 case deptno  when 101 then '컴퓨터공학과'
 else '기타'
 end 학과명
from professor;

select name, deptno, 
       decode(deptno, 101, '컴퓨터공학과','기타') 학과명
from professor;

----3. 학과번호가 
-- 101은 학과명은 컴퓨터공학과
-- 102번은  멀티미디어공학과 
-- 201 소프트웨어 공학 
-- 나머지 기타
 select name, deptno, 
   decode(deptno, 101, '컴퓨터공학과',
          102, '멀티미디어공학과',
          201, '소프트웨어 공학',
          '기타' )  학과명
from professor;

select name, deptno,
    case deptno 
        when 101 then '컴퓨터공학과'
        when 102 then '멀티미디어공학과'
        when 201 then '소프트웨어 공학'
        else '기타'
    end 학과명
from professor;

select name, deptno,
    case  
        when deptno = 101 then '컴퓨터공학과'
        when deptno = 102 then '멀티미디어공학과'
        when deptno = 201 then '소프트웨어 공학'
        else '기타'
    end 학과명
from professor;

--student 테이블
--학생을 3개 팀으로 분류하기 위해 학번을 3으로 나누어
--나머지가 0이면 A팀 1이면 B팀, 2이면 C팀으로 
--분류하여 학생번호, 이름, 학과 번호(deptno1), 팀이름 출력
select studno,name, deptno1,
       decode(mod(studno,3), 0 ,'A팀',
                              1, 'B팀',
                              2,'C팀'  )팀이름     
from student;
--학생테이블에서 jumin번호에서 1이면 남자, 2여자
--학번, 이름, 성별 출력
select studno, name, jumin , 
    decode(substr(jumin,7,1),'1','남자','2','여자')   성별
from student;

select studno, name, jumin , 
    case substr(jumin,7,1)
    when '1' then'남자'
    when '2' then '여자'
    end 성별
from student;

select studno, name, jumin, case
    when jumin like '______1%' then '남자'
    else '여자'
    end 성별
from student;

select tel from student;
--tel의 지역번호에서 02 서울, 051 부산, 052 울산, 053 대구 
--나머지는 기타로 출력
--이름, 전화번호, 지역 출력
select tel, instr(tel,')'), substr(tel,1,instr(tel,')')-1)
from student;

select name, tel, 
        decode(substr(tel,1,instr(tel,')')-1),'02','서울',
                                               '051','부산',
                                               '052','울산',
                                               '053','대구',
                                               '기타')  지역
from student;

--p174~175 



 
 
 





