
sub_a2]
DROP TABLE dept_test;

--dept 테이블을 이용하여 dept_test 테이블 생성
CREATE TABLE dept_test AS
SELECT *
FROM dept;

--dept_test 테이블에 신규 데이터 2건 추가
INSERT INTO dept_test VALUES (99, 'it1', 'daejeon');
INSERT INTO dept_test VALUES (98, 'it2', 'daejeon');

--emp테이블의 직원들이 속하지 않은 부서 정보 삭제하는 쿼리를 서브쿼리를 이용하여 작성하세요.
DELETE FROM dept_test WHERE deptno NOT IN(SELECT deptno FROM emp GROUP BY deptno);

DELETE dept_test
WHERE EXIST (SELECT 'X'
             FROM emp
             WHERE deptno = dept_test.deptno);

SELECT *
FROM dept_test;

sub_a3]
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

UPDATE emp_test a
SET sal = sal+200
WHERE sal < (SELECT AVG(sal)
             FROM emp_test b
             WHERE a.deptno = b.deptno
             GROUP BY deptno);
             
SELECT *
FROM emp_test;

공식용어는 아니지만, 검색-도서에 자주 나오는 표현
서브쿼리의 사용된 방법
1. 확인자 : 상호연관 서브쿼리 (EXXISTS)
           ==> 메인 쿼리 부터 실행 ==> 서브 쿼리 실행
2. 공급자 : 서브쿼리가 먼저 실행되서 메인쿼리에 값을 공급 해주는 역할

13 : 매니저가 존재하는 직원을 조회
SELECT *
FROM emp
WHERE mgr IN (SELECT empno FROM emp);


부서별 급여평균이 전체 급여평균보다 큰 부서의 부서번호, 부서별 급여평균 구하기

부서별 평균 급여 (소수점 둘째 자리까지 결과 만들기)
SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno;

전체 급여 평균
SELECT ROUND(AVG(sal), 2)
FROM emp;

일반적인 서브쿼리 형태
SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT ROUND(AVG(sal), 2)
                             FROM emp);
                             
WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal), 2)
    FROM emp
)
SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT *
                             emp_avg_sal);
                             
WITH 절 : SQL에서 반복적으로 나오는 QUERY BLOCK(SUBQUERY)을 별도로 선언하여
          SQL 실행시 한번만 메모리에 로딩을 하고 반복적으로 상요할 때 메모리 공간의 데이터를
          활용하여 속도 개선을 할 수 있는 KEYWORD
          단, 하나의 SQL에서 반복적인 SQL블럭이 나오는 것은 잘못 작성한 SQL일 가능성이 높기 떄문에 다른 형태로 변경할 수 있는지
          검토 해보는 것을 추전
          
WITH  emp_avg_sal AS(SELECT ROUND(AVG(sal), 2)
                     FROM emp)
SELECT deptno, ROUND(AVG(sal), 2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT *
                             emp_avg_sal);
                             
계층 쿼리
CONNET BY LEVEL : 행을 반복하고 싶은 수만큼 복제를 해주는 기능
위치 : FROM(WHERE)절 다음에 기술
DUAL 테이블과 많이 사용

테이블 행이 한건, 메모리에서 복제
SELECT dual.*, LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

위의 쿼리 말고도 이미 배운 KEYWORD를 이용하여 작성 가능
5행이상이 존재하는 테이블을 갖고 행을 제한
만약에 우리가 복제할 데이터가 10000건이면은 10000건에 대한 DISK I/O가 발생
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;

1. 우리에게 주어진 문자열 년월 : 202005
   주어진 년월의 일수를 구하여 일수만큼 행을 생성

SELECT TO_DATE('202005', 'yyyymm')+ (LEVEL-1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'yyyymm')), 'dd');

달력의 컬럼은 7개 - 컬럼의 기준은 요일  : 특정일자는 하나의 요일에 포함
--일요일이면 dt 컬럼, 월요일이면 dt 컬럼, 화요일이면 dt 컬럼,.... 토요일이면 dt 컬럼
아래 방식으로 SQL을 작성해도 쿼리를 완성하는게 가능하나 가독성 측면에서
너무 복잡하여 인라인뷰를 이용하여 쿼리를 좀더 단순하게 만든다.
SELECT DECODE(TO_CHAR(TO_DATE('202005', 'yyyymm')+ (LEVEL-1), 'd'), '1', TO_DATE('202005', 'yyyymm')+ (LEVEL-1)) sun
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'yyyymm')), 'dd');

//dt가 월요일이면 dt, dt가 화요일이면 dt.....7개의 컬럼중에 딱 하나의 컬럼에만 dt값이 표현된다.
SELECT dt
FROM
(SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'yyyymm')), 'dd'));
 
SELECT DECODE(d, 1, iw+1, iw),
       MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, 
       MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wed, 
       MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri, 
       MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);



--12월 수정해보기
SELECT DECODE(d, 1, iw+1, iw),
       MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, 
       MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wed, 
       MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri, 
       MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
        
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);


SELECT *
FROM sales;

SELECT MIN(DECODE(TO_CHAR(dt, 'MM'), 01, dt)) sun
FROM sales;

SELECT SUM(jan)jan, SUM(feb)feb, SUM(mar)mar, SUM(apr)apr, SUM(may)may, SUM(jun)jun
FROM
    (SELECT DECODE(TO_CHAR(dt, 'MM'), '01', SUM(sales), 0) jan,
            DECODE(TO_CHAR(dt, 'MM'), '02', SUM(sales), 0) feb,
            DECODE(TO_CHAR(dt, 'MM'), '03', SUM(sales), 0) mar,
            DECODE(TO_CHAR(dt, 'MM'), '04', SUM(sales), 0) apr,
            DECODE(TO_CHAR(dt, 'MM'), '05', SUM(sales), 0) may,
            DECODE(TO_CHAR(dt, 'MM'), '06', SUM(sales), 0) jun
     FROM sales
     GROUP BY TO_CHAR(dt, 'MM')
     ORDER BY TO_CHAR(dt, 'MM'));

