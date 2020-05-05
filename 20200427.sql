group function 실습 grp7]
SELECT
    COUNT(deptno)cnt
FROM
    (SELECT deptno
    FROM emp
    GROUP BY deptno);
    
    
DBMS : DATABASE Management System
==> db
RDMS : Relational DataBase Managerment System
==> 관계형 데이터베이스 관리 시스템

JOIN 문법의 종류
ANSI - 표준
벤더사의 문법(ORACLE)

JOIN의 경우 다른 테이블의 컬럼을 사용할 수 있기 때문에
SELECT 할 수 있는 컬럼의 개수가 많아진다.(가로 확장)

집한연산 ==> 세로 확장(행이 많아진다.)

NATRAL JOIN
    . 조인하려는 두 테이블의 연결고리 컬럼의 이름 같은 경우
    . emp, dept 테이블에는 deptno라는 공통된(동일한 이름, 타입도 동일) 연결고리 컬림이 존재
    . 다른 ANSI-SQL 문법을 통해서 대체가 가능하고, 조인 테이블들의 컬럼명이 동일하지 않으면
      사용이 불가능하기 때문에 사용빈도는 다소 낮다.

두 테이블의 이름이 동일한 컬럼으로 연결한다.
==>deptno

조인 하려고하는 컬럼을 별도 기술하지 않음
SELECT *
FROM emp NATURAL JOIN dept;

ORACLE 조인 문법을 ANSI 문법처럼 세분화 하지 않음
오라클 조인 문법
1. 조인할 테이블 목록을 FROM 절에 기술하며 구분자는 (,)
2. 연결고리 조건을 WHERE절에 기술하면 된다. (ex : WHERE emp.deptno = dept.deptno)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno가 10번인 직원들만 조회
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
    AND emp.deptno = 10;
    
ANSI-SQL : JOIN with USING
    . join 하려는 테이블간 이름이 같은 컬럼이 2개 이상일 때
    . 개발자가 하나의 컬럼으로만 조인하고 싶을 때 조인 컬럼명을 기술
    
SELECT *
FROM emp JOIN dept USING (deptno);

ANSI-SQL : JOIN with ON
    . 조인 하려는 두 테이블간 컬럼명이 다를 때
    . ON절에 연결고리 조건을 기술
;
SELECT *
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

ORACLE 문법으로 위 SQL을 작성
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

JOIN의 논리적인 구분
SELF JOIN : 조인하려는 테이블이 서로 같을 때
EMP 테이블의 한행은 직원의 정보를 나타내고 직원의 정보중 mgr 컬럼은 해당 직원의 관리자 사번을 관리
해당 직원의 관리자의 이름을 알고싶을 때

ANSI-SQL로 SQL 조인 : 
조인하려고 하는 테이블 EMP(직원), EMP(직원의 관리자)
              연결고리 컬럼 : 직원.MGR = 관리자.EMPTNO
               ==> 조인 컬럼 이름이 다르다(MGR, EMPNO)
                    ==> NATURAL, JOIN, JOIN WITH USING은 사용이 불가능한 형태
                        ==> JOIN with ON
                
ANSI-SQL로 작성
(오라클)
SELECT *
FROM emp e, emp m
WHERE e.mgr = m.empno;
(ANSI)
SELECT *
FROM emp e JOIN emp m  ON(e.mgr = m.empno);

NONEUQU1 JOIN : 연결고리 조건이 =이 아닐때

그동안 WHERE에서 사용한 연산자 :   =, !=, <>, <=, <, >, >=
                                AND, OR, NOT
                                LIKE %, _
                                OR - IN
                                BETWEEN AND ==> >=, <=

SELECT *
FROM emp;

SELEcT *
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

==> ORACLE 조인 문법으로 변경
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

데이터 결합 실습join0]
emp, dept 테이블을 이용하여 다음고 같이 조회되도록 쿼리를 작성하세요

오라클
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY dept.deptno;

ANSI
SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e JOIN dept d ON(e.deptno = d.deptno)
ORDER BY d.deptno;

ANSI-SQL : JOIN with USING
SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING (deptno)
ORDER BY deptno;

데이터 결합 실습 join0_1]
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
    AND emp.deptno IN(10, 30);
    
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.deptno IN(10, 30);

SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING (deptno)
WHERE deptno IN(10, 30);

데이터 결합 실습 join0_2]
SELECT empno, ename, sal, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.sal  > 2500;
  
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal> 2500;

SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500;

데이터 결합 실습 join0_3]과제
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500 AND empno > 7600;

데이터 결합 실습 join0_4]과제
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500 AND empno > 7600 AND dname = 'RESEARCH';

생각해보기
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;


데이터 결합 실습 join1]
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);

SELECT prod_lgu, lprod_nm, prod_id, prod_name
FROM prod JOIN (SELECT lprod_gu prod_lgu, lprod_id, lprod_nm FROM lprod) lprod USING(prod_lgu);

중복 삭제
DELETE FROM dept a
WHERE ROWID > (SELECT MIN(ROWID) FROM dept b
  WHERE b.deptno = a.deptno);
