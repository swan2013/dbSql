CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1= 1;

idx1]
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;


SELECT *
FROM dept_test2;

idx3]
CREATE TABLE emp_test2 AS
SELECT *
FROM emp
WHERE 1= 1;

CREATE UNIQUE INDEX idx_u_emp_test2_01 ON emp_test2 (empno);
CREATE INDEX idx_emp_test2_02 ON emp_test2 (ename);
CREATE INDEX idx_emp_test2_03 ON emp_test2 (deptno, mgr);

DROP TABLE emp_test2;
1]
empno(=)
EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = :empno;

SELECT *
FROM TABLE(dbms_xplan.display);

2]
ename(=)
EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE ename = :ename;

SELECT *
FROM TABLE(dbms_xplan.display);
3]
deptno(=), empno(LIKE :empno || '%');

4]
deptno(=)
EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE sal BETWEEN :st_sal AND :ed_sal
  AND deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

5]
deptno(=)
empno(=)

6]
필요 없다.


실행계획

수업시간에 배운 조인
==> 논리적 조인 형태를 이야기 함, 기술적인 이야기가 아님
inner join : 조인에 성공하는 데이터만 조회하는 조인 기법
outer join : 조인에 실패해도 기준이 되는 테이블의 컬럼정보는 조회하는 조인 기법
cross join : 묻지마 조인(카티션 프로적트), 조인 조건을 기술하지 않아서
             연결 가능한 모든 경우의 수로 조인되는 조인 기법
self join  : 같은 테이블 끼리 조인 하는 형태

개발자가 DBMS에 SQL을 실행 요청하면 DBMS는 SQL을 분석해서
어떻게 두 테이블 연결할 지를 결정, 3가지 방식의조인 방식(물리적 조인 방식, 기술적인 이야기)
1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

OnLine Transaction Processing : 실시간 처리 
                                ==> 응답이 빨라야 하는 시스템(일반적인 웹 서비스)
                                
OnLine Analysis Processing : 일괄처리 ==> 전체 처리속도가 중요 한 경우
                                        (은행 이자 계산, 새벽 한번에 계산)
