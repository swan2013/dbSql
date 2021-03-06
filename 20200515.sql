ROLLUP ; 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가며 GROUP BY를 실행

아래 쿼리의 서브그룹
1. GROUP BY job, deptno
2. GROUP by job
3. GROUP BY ==> 전체

ROLLUP사용시 생성되는 서브그룹의 수는 : ROLLUP에 기술한 컬럼수 + 1;

GROUP_AD2]
SELECT DECODE(GROUPING(job), 
                0, job,
                1, '총계'), deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT CASE 
        WHEN GROUPING(job) = 0 THEN job
        ELSE '총계'
       END job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2_1]
SELECT 
    CASE 
        WHEN GROUPING(job) = 0 THEN job
        ELSE '총'
    END job, 
    CASE
        WHEN GROUPING(deptno) = 0 THEN TO_CHAR(deptno)
        WHEN GROUPING(job) = 0 THEN '소계'
        ELSE '계'
    END deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT DECODE(GROUPING(job), 
                0, job,
                1, '총계')job,
       DECODE(GROUPING(deptno) + GROUPING(job),
                0, TO_CHAR(deptno),
                1, '소계',
                2, '계')deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD3]
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job);

ROLLUP 절에 기술 된느 컬럼의 순서는 조회 결과에 영향을 미친다.
(***** 서브 그룹을 기술된 컬럼의 오른쪽부터 제거해 나가면서 생성)
GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);

GROUP_AD4]
SELECT dname, job, SUM(sal)
FROM emp LEFT OUTER JOIN dept ON(emp.deptno = dept.deptno)
GROUP BY ROLLUP(dname, job)
ORDER BY dname, job DESC;

GROUP_AD5]
SELECT DECODE(GROUPING(dname),0,dname,1,'총계')dname, job, SUM(sal)
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
GROUP BY ROLLUP(dname, job)
ORDER BY dname, job DESC;


2. GROUPING SETS
ROLLUP의 단점  : 관심없는 서브그룹도 생성 해야한다.
                ROLLUP절에 기술한 컬럼을 오른쪽에서 지워나가기 때문에
                만약 중간과정에 있는 서브그룹이 불필요 할 경우 낭비.
               
GROUPING SETS   : 개발자가 직접 생성할 서브그룹을 명시
                  ROLLUP과는 다르게 방향성이 없다.
사용법 : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col1, col2)
GROUP BY GROUPING SETS (col2, col1)

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

그룹기준을
1. job, deptno
2. mgr

GROUP BY GROUPING SETS ((job, deptno), mgr)

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);


3. CUBE
사용법 : GROUP BY CUBE (col1, col2)
기술된 컬럼의 가능한 모든 조합 (순서는 지킨다.)

GROUP BY CUBE (job, deptno, mgr);
  1      2       3
job    deptno   mgr 
job    dpetno   X   
job    x        mgr
job    x        x
x      deptno   mgr 
x      dpetno   X
x      x        mgr       
x      x        x


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


여러개의 REPORT GROUP 사용하기
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**발생 가능한 조합을 계산
1       2       3
job     deptno  mgr     ==>GROUP BY job, dpetno, mgr
job     X       mgr     ==>GROUP BY job, mgr
job     deptno  x       ==>GROUP BY job, deptno
job     X       x       ==>GROUP BY job

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0))sal
FROM emp
GROUP BY job, ROLLUP(job, deptno), cube(mgr);

1       2       3       4
job     job     deptno  mgr
job     job     X       mgr
job     x       x       mgr
job     job     deptno  x   
job     job     X       x
job     x       x       x




상호연관 서브쿼리 업데이트
1. emp테이블을 이용하여 emp_test 테이블 생성
    ==> 기존에 생성된 emp_test 테이블 삭제 먼저 진행
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp
WHERE 1=1;

SELECT *
FROM emp_test;

2. emp_test 테이블에 dname컬럼 추가 (dept 테이블 참고)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));


3. subquery를 이용하여 emp_test 테이블에 추가된 dname 컬럼을 업데이트 해주는 쿼리 작성
emp_test의 컬럼의 값을 dept 테이블의 dname컬럼으로 update
emp_test테이블의 deptno값을 확인해서 dept테이블의 deptno값이랑 일치하는 dname컬럼값을 가져와 update

emp_test테이블의 dname 컬럼을 dept 테이블 이용해서 dname값 조회하여 업데이트
update 대상이 된느 행 : 14 ==> WHERE 절 기술하지 않음

UPDATE emp_test
  SET dname = (SELECT dname FROM dept WHERE emp_test.deptno = deptno);

SELECT *
FROM emp_test;

sub_a1]
1. dept테이블을 이용하여 dept_test 테이블 생성
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

2. dept_test테이블에 empcnt (NUMBER) 컬럼 추가
DESC dept_test;

ALTER TABLE dept_test ADD empcnt NUMBER(2);

3. subquery를 이용하여 dept_test 테이블의 empcnt 컬럼에 해당 부서원 수를 update하는 쿼리를 작성하세요.
UPDATE dept_test
  SET empcnt = (SELECT COUNT(*) FROM emp WHERE dept_test.deptno = deptno);

SELECT 결과 전첼르 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라고 0값이 리턴

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을 경우 조회되는 행이 없다.
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;

SELECT *
FROM dept_test;

