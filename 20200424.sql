NULL처리 하는 방법 (4가지 중에 본인 편한걸로 하나 이상은 기억)
NVL, NVL2..

DESC emp;

SELECT NVL(empno, 0), ename, NVL(sal, 0), NVL(comm, 0)
FROM emp;

condition : CASE, DECODE

실행계획 : 실행계획이 먼지
          보는 순서
          

emp 테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 SALESMAN일 경우 SAL에서 5% 인상된 금액을 보너스로 지급 (ex: sal 100->105)

해당 직원의 job이 MANAGER이면서 deptno가 10이면 SAL에서 30% 인상된 금액을 보너스로 지급
                            그 외의 부서에 속하는 사람은 10% 인상된 금액을 보너스로 지급

해당 직원의 job이 PRESIDENT일 경우 SAL에서 20% 인상된 금액을 보너소로 지급
그외 직원들은 sal만큼만 지급
DECODE만 사용 (case 절 사용 금지)
SELECT DECODE(job,
                'SALESMAN', sal*1.05,
                'MANAGER', DECODE(deptno,
                                        10, sal*1.3, sal*1.1
                                 ),
                'PRESIDENT', sal*1.2, sal
             ) bonus
FROM emp;


집합 A = (10, 15, 18, 23, 24, 25, 29, 30, 35, 37)
소수 : (23, 29, 37) : COUNT-3, MAX-37, MIN-23, AVG-29.66, SUM-89
비소수 : (10, 15, 18, 25, 30, 35);

10 - 3
20 - 5
30 - 6
SELECT *
FROM emp
ORDER BY deptno;


GROUP FUNCTION
여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
여러행을 입력받아 하나의 행으로 결과가 묶인다.
EX : 부서별 급여 평균
    emp 테이블에는 14명의 직원이 있고, 14명의 직원은 3개의 부서(10, 20, 30)에 속해 있다.
    부서별 급여 평균은 3개의 행으로 결과가 반환된다.

GROUP BY 적용시 주의 사항 : SELECT 기술할 수 있는 컬럼이 제한됨

SELECT 그룹핑 기준 컬럼, 그룹함수
FORM 테이블명
GROUP BY 그룹핑 기준 컬럼
[ORDER BY];


부서별로 가장 높은 급여
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno,
        MAX(sal),   -- 부서별로 가장 높은 급여 값
        MIN(sal),   -- 부서별로 가장 낮은 급여 값
        AVG(sal),   -- 부서별 급여 평균
        SUM(sal),   -- 부서별 급여 함
        COUNT(sal),  -- 부서별 급여 건수(sal 컬럼의 값이 null이 아닌 수)
        COUNT(*)    -- 부서의 행의 수
FROM emp
GROUP BY deptno;

* 그룹 함수를 통해 부서번호 별 가장 높은 급여를 구할 수는 있지만
  가장 높은 급열르 받는 사람의 이름을 알 수는 없다.
  --> 추구 WINDOM/분석 RUNCTION을 통해 해결 가능
  
  emp 테이블의 그룹 기준을 부서받호
SELECT deptno,
        MAX(sal),   -- 부서별로 가장 높은 급여 값
        MIN(sal),   -- 부서별로 가장 낮은 급여 값
        AVG(sal),   -- 부서별 급여 평균
        SUM(sal),   -- 부서별 급여 함
        COUNT(sal), -- 부서별 급여 건수(sal 컬럼의 값이 null이 아닌 수)
        COUNT(*),   -- 부서의 행의 수
        COUNT(mgr)
FROM emp
GROUP BY deptno;

2020.04.27일 발표 때 정답 확인
GROUP BY 절에 기술된 컬럼이
    SELECT 절에 나오지 않으면 ???
    출력 컬럼이 없음
    
GROUP BY 절에 기술되지 않은 컬럼이
    SELECT 절에 나오면 ???

그룹화와 관련 없는 문자열, 상수 등은 SELECT 절에 표현 될 수 있다.(에러 아님);
SELECT deptno, 'TEST', 1,
        MAX(sal),   -- 부서별로 가장 높은 급여 값
        MIN(sal),   -- 부서별로 가장 낮은 급여 값
        AVG(sal),   -- 부서별 급여 평균
        SUM(sal),   -- 부서별 급여 함
        COUNT(sal), -- 부서별 급여 건수(sal 컬럼의 값이 null이 아닌 수)
        COUNT(*),   -- 부서의 행의 수
        COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP 함수 연산시 NULL 값은 제외가 된다.
30번 부서에는 NULL값을 갖는 행이 있지만 SUM(COMM)의 값이 정상적으로 계산된 걸 확인 할 수 있다.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10, 20번 부서의 SUM(comm) 컬럼이 NULL이 아니라 0이 나오도록 NULL처리
* 특별한 사유가 아니면 그룹함수 계산결과에 NULL처리를 하는 것이 성능상 유리

NVL(SUM(comm), 0) : COMM커럼에 SUM 그룹함수를 적용하고 최공 결과에 NVL을 적용(1회 호출)
SUM(NVL(comm, 0)) : 모든 comm컬럼에 NVL 함수를 적용 후(해당 그룹의 ROW수 만큼 호출) SUM 그룹함수 적용

SELECT deptno, NVL(SUM(comm), 0), SUM(NVL(comm,0))
FROM emp
GROUP BY deptno;

single row 함수는 where절에 기술할 수 있지만
multi row 함수(group 함수)는 where절에 기술할 수 없고
GROUP BY 절 이후 HAVING 절에 별도로 기술

single row 함수는 WHERE 절에서 사용 가능
* 정상 출력 되지만 WHERE절의 좌측은 가공하지 말자
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

부서별 급여 합이 5000이 넘는 부서만 조회
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 5000
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


group function 실습 grp1]
SELECT
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp;

group function 실습 grp2]
SELECT deptno,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp
GROUP BY deptno;

SELECT *
FROM emp;

SELECT *
FROM dept;

group function 실습 grp3]*참고
SELECT DECODE(deptno,
                10, 'ACCOUNTING',
                20, 'RESEARCH',
                30, 'SALES'
             )DNAME,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

group function 실습 grp4]
SELECT hire_yyyymm,
        COUNT(hire_yyyymm)cnt
FROM 
    (SELECT TO_CHAR(hiredate, 'YYYYMM')hire_yyyymm
    FROM emp)
GROUP BY hire_yyyymm;

SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm,
        COUNT(hiredate)cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');
    
group function 실습 grp5]
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyy,
        COUNT(hiredate)cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

group function 실습 grp6]
SELECT
        COUNT(deptno)cnt
FROM dept;

SELECT *
FROM dept;

group function 실습 grp7]
SELECT
    COUNT(deptno)cnt
FROM
    (SELECT deptno
    FROM emp
    GROUP BY deptno);
