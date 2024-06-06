--Roll
connect
resource
----
제약조건 --> 데이터무결성
not null
unique
primary key(기본키) - not null / unique
foreign key(외래키)
check
---
SQL
1. select
2.DML(조작어) - insert, update, delete
3.DDL(정의어) - create, alter, drop, truncate
4.TCL(트랜잭션) - commit, rollback
5.DCL(제어어) - grant , revoke

--- 
트랜잭션(ACID)
1. 원자성(Atomicity)
2. 일관성(Consistency) :일관적인 DB상태를 유지
3. 격리성(Isolation)
 : 트랜잭션 수행시 다른 트랜잭션의 작업이 끼어들지 못하도록 보장하는 것
4. 지속성(Durability)
  :성공적으로 수행된 트랜잭션은 영원히 반영이 되는 것

---
데이터사전  :  USER_   ALL_  등
인덱스
시퀀스
View(뷰) - 가상의 테이블(편의성 , 보안성)
---
조인 : inner join  / outer join
natural~ join
join ~ using
join ~ on
---
인라인뷰
다중서브쿼리 ( in / any/ all / exists )
그룹함수 (sum, avg, max, min)
group by  having
CTAS








