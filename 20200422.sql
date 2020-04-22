
   
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
 �����ȹ�� ���� ����(id)
 * �鿩���� �Ǿ������� �ڽ� ���ۤ��̼�
 1. ������ �Ʒ���
    *�� �ڽ� ���۷��̼��� ������ �ڽ� ���� �д´�.
    
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


NULL�� ���õ� �Լ�
NVL
NVL2
NULLIF
COALESCE;

�� null ó���� �ؾ��ұ�?
NULL�� ���� �������� NULL�̴�

���� �� emp ���̺� �����ϴ� sal, comm �ΰ��� �÷� ���� ���� ���� �˰� �;
������ ���� SQL�� �ۼ�.

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1�� null�̸� expr2���� �����ϰ�
expr1�� null�� �ƴϸ� sxpr1�� ����

SELECT empno, ename, sal, comm, sal+NVL(comm, 0) sal_pluse_comm
FROM emp;

REG_DT �÷��� NULL�� ��� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
SELECT userid, usernm, reg_dt
FROM users;

SELECT userid, usernm, reg_dt, NVL(reg_dt, LAST_DAY(SYSDATE))
FROM users;