
sub_a2]
DROP TABLE dept_test;

--dept ���̺��� �̿��Ͽ� dept_test ���̺� ����
CREATE TABLE dept_test AS
SELECT *
FROM dept;

--dept_test ���̺� �ű� ������ 2�� �߰�
INSERT INTO dept_test VALUES (99, 'it1', 'daejeon');
INSERT INTO dept_test VALUES (98, 'it2', 'daejeon');

--emp���̺��� �������� ������ ���� �μ� ���� �����ϴ� ������ ���������� �̿��Ͽ� �ۼ��ϼ���.
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

���Ŀ��� �ƴ�����, �˻�-������ ���� ������ ǥ��
���������� ���� ���
1. Ȯ���� : ��ȣ���� �������� (EXXISTS)
           ==> ���� ���� ���� ���� ==> ���� ���� ����
2. ������ : ���������� ���� ����Ǽ� ���������� ���� ���� ���ִ� ����

13 : �Ŵ����� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IN (SELECT empno FROM emp);


�μ��� �޿������ ��ü �޿���պ��� ū �μ��� �μ���ȣ, �μ��� �޿���� ���ϱ�

�μ��� ��� �޿� (�Ҽ��� ��° �ڸ����� ��� �����)
SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno;

��ü �޿� ���
SELECT ROUND(AVG(sal), 2)
FROM emp;

�Ϲ����� �������� ����
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
                             
WITH �� : SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ�
          SQL ����� �ѹ��� �޸𸮿� �ε��� �ϰ� �ݺ������� ����� �� �޸� ������ �����͸�
          Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD
          ��, �ϳ��� SQL���� �ݺ����� SQL���� ������ ���� �߸� �ۼ��� SQL�� ���ɼ��� ���� ������ �ٸ� ���·� ������ �� �ִ���
          ���� �غ��� ���� ����
          
WITH  emp_avg_sal AS(SELECT ROUND(AVG(sal), 2)
                     FROM emp)
SELECT deptno, ROUND(AVG(sal), 2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT *
                             emp_avg_sal);
                             
���� ����
CONNET BY LEVEL : ���� �ݺ��ϰ� ���� ����ŭ ������ ���ִ� ���
��ġ : FROM(WHERE)�� ������ ���
DUAL ���̺�� ���� ���

���̺� ���� �Ѱ�, �޸𸮿��� ����
SELECT dual.*, LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����
5���̻��� �����ϴ� ���̺��� ���� ���� ����
���࿡ �츮�� ������ �����Ͱ� 10000���̸��� 10000�ǿ� ���� DISK I/O�� �߻�
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;

1. �츮���� �־��� ���ڿ� ��� : 202005
   �־��� ����� �ϼ��� ���Ͽ� �ϼ���ŭ ���� ����

SELECT TO_DATE('202005', 'yyyymm')+ (LEVEL-1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'yyyymm')), 'dd');

�޷��� �÷��� 7�� - �÷��� ������ ����  : Ư�����ڴ� �ϳ��� ���Ͽ� ����
--�Ͽ����̸� dt �÷�, �������̸� dt �÷�, ȭ�����̸� dt �÷�,.... ������̸� dt �÷�
�Ʒ� ������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ� ������ ���鿡��
�ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����.
SELECT DECODE(TO_CHAR(TO_DATE('202005', 'yyyymm')+ (LEVEL-1), 'd'), '1', TO_DATE('202005', 'yyyymm')+ (LEVEL-1)) sun
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'yyyymm')), 'dd');

//dt�� �������̸� dt, dt�� ȭ�����̸� dt.....7���� �÷��߿� �� �ϳ��� �÷����� dt���� ǥ���ȴ�.
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



--12�� �����غ���
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

