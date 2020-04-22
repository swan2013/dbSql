
   
SELECT TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM'), 'YYYY/MM') PARAM, 
       TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD')DT
FROM dual;

SELECT *
FROM emp
ORDER BY mgr DESC;

SELECT 'TEST1' alias1,
       'TEST2' AS alias2,
       'TEST3' AS "alias3"
FROM dual;

SELECT 'TEST1' || dummy
FROM dual;

SELECT LAST_DAY(SYSDATE)
FROM dual;

SELECT TO_DATE(TO_CHAR(LAST_DAY(SYSDATE), 'YYYYMMDD'), 'YYYYMMDD')+55
FROM dual;



EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';


SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932
 실행계획을 보는 순서(id)
 * 들여쓰기 되어있으면 자식 오퍼ㅔ이션
 1. 위에서 아래로
    *단 자식 오퍼레이션이 있으면 자식 부터 읽는다.
    
    1 ==> 0
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
 
Note
-----
   - dynamic sampling used for this statement (level=2)
   
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;


NULL과 관련된 함수
NVL
NVL2
NULLIF
COALESCE;

왜 null 처리를 해야할까?
NULL에 대한 연산결과는 NULL이다

예를 들어서 emp 테이블에 존재하는 sal, comm 두개의 컬럼 값을 합한 값을 알고 싶어서
다음과 같이 SQL을 작성.

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1이 null이면 expr2값을 리턴하고
expr1이 null이 아니면 sxpr1을 리턴

SELECT empno, ename, sal, comm, sal+NVL(comm, 0) sal_pluse_comm
FROM emp;

REG_DT 컬럼이 NULL일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, reg_dt
FROM users;

SELECT userid, usernm, reg_dt, NVL(reg_dt, LAST_DAY(SYSDATE))
FROM users;