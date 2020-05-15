ROLLUP ; ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1. GROUP BY job, deptno
2. GROUP by job
3. GROUP BY ==> ��ü

ROLLUP���� �����Ǵ� ����׷��� ���� : ROLLUP�� ����� �÷��� + 1;

GROUP_AD2]
SELECT DECODE(GROUPING(job), 
                0, job,
                1, '�Ѱ�'), deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT CASE 
        WHEN GROUPING(job) = 0 THEN job
        ELSE '�Ѱ�'
       END job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD2_1]
SELECT 
    CASE 
        WHEN GROUPING(job) = 0 THEN job
        ELSE '��'
    END job, 
    CASE
        WHEN GROUPING(deptno) = 0 THEN TO_CHAR(deptno)
        WHEN GROUPING(job) = 0 THEN '�Ұ�'
        ELSE '��'
    END deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT DECODE(GROUPING(job), 
                0, job,
                1, '�Ѱ�')job,
       DECODE(GROUPING(deptno) + GROUPING(job),
                0, TO_CHAR(deptno),
                1, '�Ұ�',
                2, '��')deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP_AD3]
SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno, job);

ROLLUP ���� ��� �ȴ� �÷��� ������ ��ȸ ����� ������ ��ģ��.
(***** ���� �׷��� ����� �÷��� �����ʺ��� ������ �����鼭 ����)
GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);

GROUP_AD4]
SELECT dname, job, SUM(sal)
FROM emp LEFT OUTER JOIN dept ON(emp.deptno = dept.deptno)
GROUP BY ROLLUP(dname, job)
ORDER BY dname, job DESC;

GROUP_AD5]
SELECT DECODE(GROUPING(dname),0,dname,1,'�Ѱ�')dname, job, SUM(sal)
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
GROUP BY ROLLUP(dname, job)
ORDER BY dname, job DESC;


2. GROUPING SETS
ROLLUP�� ����  : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�.
                ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
                ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
               
GROUPING SETS   : �����ڰ� ���� ������ ����׷��� ���
                  ROLLUP���� �ٸ��� ���⼺�� ����.
���� : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col1, col2)
GROUP BY GROUPING SETS (col2, col1)

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

�׷������
1. job, deptno
2. mgr

GROUP BY GROUPING SETS ((job, deptno), mgr)

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);


3. CUBE
���� : GROUP BY CUBE (col1, col2)
����� �÷��� ������ ��� ���� (������ ��Ų��.)

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


�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
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




��ȣ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ� emp_test ���̺� ����
    ==> ������ ������ emp_test ���̺� ���� ���� ����
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp
WHERE 1=1;

SELECT *
FROM emp_test;

2. emp_test ���̺� dname�÷� �߰� (dept ���̺� ����)
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));


3. subquery�� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ���� �ۼ�
emp_test�� �÷��� ���� dept ���̺��� dname�÷����� update
emp_test���̺��� deptno���� Ȯ���ؼ� dept���̺��� deptno���̶� ��ġ�ϴ� dname�÷����� ������ update

emp_test���̺��� dname �÷��� dept ���̺� �̿��ؼ� dname�� ��ȸ�Ͽ� ������Ʈ
update ����� �ȴ� �� : 14 ==> WHERE �� ������� ����

UPDATE emp_test
  SET dname = (SELECT dname FROM dept WHERE emp_test.deptno = deptno);

SELECT *
FROM emp_test;

sub_a1]
1. dept���̺��� �̿��Ͽ� dept_test ���̺� ����
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

2. dept_test���̺� empcnt (NUMBER) �÷� �߰�
DESC dept_test;

ALTER TABLE dept_test ADD empcnt NUMBER(2);

3. subquery�� �̿��Ͽ� dept_test ���̺��� empcnt �÷��� �ش� �μ��� ���� update�ϴ� ������ �ۼ��ϼ���.
UPDATE dept_test
  SET empcnt = (SELECT COUNT(*) FROM emp WHERE dept_test.deptno = deptno);

SELECT ��� ��ÿ�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������� 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����.
SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;

SELECT *
FROM dept_test;

