table���� ��ȸ/���� ������ ����.
==> ORDER BY �÷��� ���Ĺ��, ....

����*
ORDER BY �÷����� ��ȣ
==> SELECT �÷��� ������ �ٲ�ų�, �÷� �߰��� �Ǹ� �����ǵ���� �������� ���� ���ɼ��� ����


;
SELECT�� 3��° �÷��� �������� ����
SELECT *
FROM emp
ORDER BY 3;

��Ī���� ����
�÷����ٰ� ������ ���� ���ο� �÷��� ����� ���
SELECT * DEPTNO SAL_DEPT;

SELECT empno, ename, sal, deptno, sal*deptno sal_dept
FROM emp
ORDER BY sal_dept;

ORDERBY1]
SELECT *
FROM dept
ORDER BY dname ASC;

SELECT *
FROM dept
ORDER BY LOC DESC;

ORDERBY2]
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE comm IS NOT NULL
  AND comm != 0
ORDER BY comm DESC, empno ASC;

ORDERBY3]
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job ASC, empno DESC;

ORDERBY4]
SELECT *
FROM emp
WHERE deptno IN(10, 30)
  AND sal > 1500
ORDER BY ename DESC;

����¡ ó���� �ϴ� ����
1. �����Ͱ��ʹ� �����ϱ�
  . �� ȭ�鿡 ������ ��뼺�� ��������.
  . ���ɸ鿡�� ��������.

����Ŭ���� ����¡ ó�� ��� ==> ROWNUM

ROWNUM : SELECT ������� 1������ ���ʴ�� ��ȣ�� �ο����ִ� Ư�� KEYWORD

SELECT ROWNUM, empno, ename
FROM emp;

SELECT *ǥ���ϰ� �޸��� ���� �ٸ� ǥ��(ex ROWNUM)�� ����Ұ��
* �տ� � ���̺� ���Ѱ��� ���̺� ��Ī/��Ī�� ����ؾ� �Ѵ�.
SELECT ROWNUM, *
FROM emp;

SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;

����¡ ó���� ���� �ʿ��� ����
1. ������ ������(10)
2. ������ ���� ����

1-page : 1 ~ 10
2-page : 11 ~ 20 (11~14)���� emp���̺��� 14��°�����ۿ� ���� ������ 11~14�� ����

1. ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

2. ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;

ROWNUM�� Ư¡
1. ORACLE���� ����
   . �ٸ� DBMS�� ��� ����¡ ó���� ���� ������ Ű���尡 ����(LIMIT)
2. 1������ ���������� �д°�츸 ����
    BOWNUM BETWEEN 1 AND 10 ==> 1~10
    BOWNUM BETWEEN 11 AND 20 ==> 1~10�� SKIP�ϰ� 11~20�� �������� �õ�
    
    WHERE ������ ROWNUM�� ����� ��� ���� ����
    ROWNUM = 1;
    ROWNUM BETWEEN 1 AND N;
    ROWNUM <, <= N(1~N)

ROWNUM�� ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM�� ORDER BY ������ ����
SELECT -> ROWNUM -> ORDER BY

ROWNUM�� ��������� ���� ������ �Ȼ��·� ROWNUM�� �ο��Ϸ��� IN-LINE VIEW �� ����ؾ� �Ѵ�.
** IN-LINE : ���� ����� �ߴ�

;

SELECT *
FROM
    (SELECT empno, ename
     FROM emp
     ORDER BY ename);
     
SELECT a.*
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
         FROM emp
         ORDER BY ename) a) a
WHERE rn BETWEEN 11 AND 20;

WHERE rn BETWEEN 1 AND 10;  1 PAGE
WHERE rn BETWEEN 11 AND 20; 2 PAGE
WHERE rn BETWEEN 21 AND 30; 3 PAGE
.
.
.
WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n; n PAGE

SELECT a.*
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
         FROM emp
         ORDER BY ename) a) a
WHERE rn BETWEEN 1 + (:page - 1) * :pageSize AND :page * :pageSize;

����
SELECT *
FROM
(SELECT empno, ename
 FROM emp
 ODER BY ename);
 
 INLINE_VIEW�� �񱳸� ���� VIEW�� ���� ����(�����н�, ���߿� ���´�.)
 VIEW - ���� (view ���̺�-X)
 
 DML - Data Manipulation Language : SELECT, INSERT, UPDATE, DELETE
 DDL - DATEA Definition LAnguage : CREATE, DROP, MODIFY, RENAME
 
 CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;

IN-LINE VIEW�� �ۼ��� ����
SELECT *
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename);

VIEW�� �ۼ��� ����
SELECT *
FROM emp_ord_by_ename;

emp ���̺� �����͸� �߰��ϸ�
in-line view, view�� ����� ������ ����� ��� ������ ������?


���� �ۼ��� ������ ã�ư���
���� ��ǻ�� : ������
������ ������ ���̿� ���� ������ �߻� ==> ������ ���ִ� ����(�����)

java : �����
SQL : ����� ���� ����

����¡ ó�� ==> ����, ROWNUM
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM���� ������ �Ͽ�
���ڰ� ���̴� ���� �߻� == INLINE-VIEW
    ���Ŀ� ���� INLINE-VIEW
    ROWNUM�� ���� INLINE-VIEW

SELECT *
FROM
    (SELECT ROWNUM rn, b.*
     FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename) b)
WHERE rn BETWEEN 11 AND 20;

SELECT *
FROM
    (SELECT ROWNUM rn, b.*
     FROM
        emp_ord_by_ename b)
WHERE rn BETWEEN 11 AND 20;

SELECT *
FROM
    (SELECT  ROWNUM rn, a.*
     FROM
         (SELECT empno, ename
          FROM emp
          ORDER BY ename ASC) a)
WHERE rn BETWEEN 11 AND 14;

**�ű� ����
SELECT *
FROM 
    (SELECT ROWNUM rn, a.*
     FROM
         (SELECT *
          FROM PROD
          ORDER BY prod_lgu DESC, prod_cost ASC)a)
WHERE rn BETWEEN 1 + (:page - 1) * :pageSize AND :page * :pageSize;


