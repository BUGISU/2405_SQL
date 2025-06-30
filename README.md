# SQL Study Lab

SQL Study Lab는 Oracle 데이터베이스 기반의 SQL 실습 프로젝트로, 데이터 정의어(DDL), 데이터 조작어(DML), 트랜잭션(TCL), 권한(DCL), 함수, 뷰, 시퀀스, 프로시저, 함수, 커서, 트리거 등 다양한 SQL 주제를 포함합니다. 이 프로젝트는 SQL에 대한 실질적인 이해와 실습 능력 향상을 목표로 합니다.

## 🗂️ 프로젝트 구조

```

.
├── DDL\_DML\_TCL\_DCL/
├── SELECT\_Queries/
├── Subqueries\_Views/
├── PL\_SQL/
│   ├── Procedure/
│   ├── Function/
│   ├── Cursor/
│   └── Trigger/
├── Practice\_Scripts/
└── Sample\_Data/

````

## 📌 주요 학습 내용

### 📍 SQL 기본
- SELECT, INSERT, UPDATE, DELETE
- WHERE, ORDER BY, GROUP BY, HAVING
- JOIN (INNER, OUTER, SELF), SET 연산자 (UNION, INTERSECT, MINUS)
- 서브쿼리, 인라인뷰, 다중행 함수

### 📍 데이터 정의/제어
- CREATE, ALTER, DROP
- PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE, NOT NULL 제약조건
- SEQUENCE, VIEW, INDEX 관리
- 트랜잭션 제어(COMMIT, ROLLBACK)

### 📍 PL/SQL 프로그래밍
- 기본 블록 구조 (DECLARE, BEGIN, EXCEPTION)
- 변수 및 RECORD, ROWTYPE 사용
- 조건문 (IF, CASE), 반복문 (LOOP, WHILE, FOR)
- 커서(Cursor) 기반의 반복 처리
- 프로시저(Procedure), 함수(Function)
- IN / OUT / IN OUT 매개변수 사용
- 트리거(Trigger) 기본 예제

## 🧪 예제 샘플

```sql
-- 트랜잭션 테스트
BEGIN
  UPDATE emp SET sal = sal * 1.1 WHERE deptno = 30;
  COMMIT;
END;
````

```sql
-- IN OUT 프로시저 예제
CREATE OR REPLACE PROCEDURE double_value(val IN OUT NUMBER) IS
BEGIN
  val := val * 2;
END;
```

## 💾 사용 테이블 예시

* `emp`, `dept`, `professor`, `student`, `employees`, `departments`, `score`, `hakjum` 등
* 다양한 조인과 통계용 데이터를 포함한 관계형 구조

## 🛠️ 사용 환경

* Oracle Database 11g 이상
* SQL Developer 또는 SQL\*Plus
* `set serveroutput on` 권장

## 📚 참고 문서

* Oracle 공식 문서: [https://docs.oracle.com/](https://docs.oracle.com/)
* SQL 문법 요약: `SQL Quick Reference`
* PL/SQL 프로그래밍 가이드


