EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

ROWID : ���̺� ���� ����� �����ּ�
        (java - �ν��Ͻ� ����
            c - ������     )

SELECT ROWID, emp.*
FROM emp;

����ڿ� ���� ROWID ���
SELECT *
FROM emp
WHERE ROWID = 'AAAE7PAAFAAAAFUAAF';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7369)
   
   
   
INDEX �ǽ�
emp���̺� ���� ������ kp_emp PRIMARY KEY ���������� ����
ALTER TABLE emp DROP CONSTRAINT pk_emp;

1.�ε��� ���� empno ���� �̿��Ͽ� ������ ��ȸ
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7782)


2. emp ���̺� empno�÷����� PRImARY KEY �������� ���� �� ���
   (empno�÷����� ������ unique �ε����� ����)

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
   
   
3. 2�� SQL�� ���� (SELECT �÷��� ����)

2��
SELECT *
FROM emp
WHERE empno = 7782;

3��
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 56244932
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |     1 |     4 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_EMP |     1 |     4 |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMPNO"=7782)
   

4. empno�÷��� non-unique �ε����� �����Ǿ� �ִ� ���
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_emp_01 ON emp (empno);


5. emp ��Ƽ���� jab ���� ��ġ�ϴ� �����͸� ã�� ���� ��
���� ���� ���ؽ� inx_emp_01
EXPLAIN PLAN FOR
SELECT * 
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     3 |   114 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     3 |   114 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')

idx_emp_01�� ��� ������ empno�÷� �������� �Ǿ� �ֱ� ������  job�÷��� �����ϴ�
SQL������ ȿ�������� ����� ���� ���� ������ TABLE ��ü �����ϴ� ������ �����ȹ�� ������

==> inx_emp_02 (job) ������ ���� �����ȹ ��
CREATE INDEX idx_emp_02 ON emp (job);

6. emp���̺��� job = 'MANAGER'�̸鼭 ename�� c�� �����ϴ� ����� ��ȸ
�ε��� ��Ȳ
idx_emp_01 : emp
idx_emp_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';
  
SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER')
   

7. emp���̺��� job = 'MANAGER' �̸鼭 ename�� c�� �����ϴ� ����� ��ȸ(��ü�÷� ��ȸ)
�� ���ο� �ε��� �߰� : idx_emp_03 : job, ename
CREATE INDEX idx_emp_03 ON emp (job, ename);

�ε��� ��Ȳ
idx_emp_01 : emp
idx_emp_02 : job
idx_emp_03 : job, ename

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';
  
SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 2549950125
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')
       

8. emp���̺��� job = 'MANAGER' �̸鼭 ename�� c�� ������ ����� ��ȸ(��ü�÷� ��ȸ)
�ε��� ��Ȳ
idx_emp_01 : emp
idx_emp_02 : job
idx_emp_03 : job, ename


EXPLAIN PLAN FOR
SELECT /*+ INDEX( emp IDX_EMP_03) */ *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE '%C';
  
SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 2549950125
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER')
       filter("ENAME" LIKE '%C' AND "ENAME" IS NOT NULL)
       

RULE BASED OPTIMIZER : ��Ģ��� ����ȭ�� (9i)

COST BAsED OPTIMIZER : ����� ����ȭ�� (10g)


9. ���� �÷� �ε����� �÷� ������ �߿伺
�ε��� ���� �÷� : (job, ename) VS (ename, job)
*** �����ؾ� �ϴ� sql�� ���� �ε��� �÷� ������ �����ؾ� �Ѵ�.

���� sql : job=manager, ename�� c�� �����ϴ� ��� ������ ��ȸ(��ü �÷�)
�ε��� idx_emp_03����
DROP INDEX idx_emp_03;

�ε��� �ű� ����
idx_emp_04 : ename, job
CREATE INDEX idx_emp_04 ON emp (ename, job);

SELECT ename, job, ROWID
FROM emp;

�ε��� ��Ȳ
idx_emp_01 : emp
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';
  
SELECT *
FROM TABLE(dbms_xplan.display);

Plan hash value: 4079571388
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_02 |     3 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ENAME" LIKE 'C%')
   2 - access("JOB"='MANAGER')
   

���ο����� �ε���
idx_emp_01 ����(pk_emp �ε����� �ߺ�)
DROP INDEX idx_emp_01;

emp ���̺� empno �÷��� primary key�� �������� ����
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

�ε��� ��Ȳ
pk_emp : empno
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.empno = 7788;

SELECT *
FROM TABLE(dbms_xplan.display);

NESTED LOOP JOIN
HASH JOIN
SORT MERGE JOIN

Plan hash value: 2385808155
 3-2-5-4-1-0
----------------------------------------------------------------------------------------
| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |         |     1 |    58 |     2   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                |         |     1 |    58 |     2   (0)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| EMP     |     1 |    38 |     1   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN         | PK_EMP  |     1 |       |     0   (0)| 00:00:01 |
|   4 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     4 |    80 |     1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN         | PK_DEPT |     1 |       |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   
   
SELECT ROWID, emp.*
FROM emp;

SELECT emp.*,ROWID
FROM emp
ORDER BY job;