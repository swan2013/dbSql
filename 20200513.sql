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
�ʿ� ����.


�����ȹ

�����ð��� ��� ����
==> ���� ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� ������ �Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ�
             ���� ������ ��� ����� ���� ���εǴ� ���� ���
self join  : ���� ���̺� ���� ���� �ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û�ϸ� DBMS�� SQL�� �м��ؼ�
��� �� ���̺� ������ ���� ����, 3���� ��������� ���(������ ���� ���, ������� �̾߱�)
1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

OnLine Transaction Processing : �ǽð� ó�� 
                                ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
                                
OnLine Analysis Processing : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿� �� ���
                                        (���� ���� ���, ���� �ѹ��� ���)
