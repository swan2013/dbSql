group function �ǽ� grp7]
SELECT
    COUNT(deptno)cnt
FROM
    (SELECT deptno
    FROM emp
    GROUP BY deptno);
    
    
DBMS : DATABASE Management System
==> db
RDMS : Relational DataBase Managerment System
==> ������ �����ͺ��̽� ���� �ý���

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE)

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �� �� �ִ� �÷��� ������ ��������.(���� Ȯ��)

���ѿ��� ==> ���� Ȯ��(���� ��������.)

NATRAL JOIN
    . �����Ϸ��� �� ���̺��� ����� �÷��� �̸� ���� ���
    . emp, dept ���̺��� deptno��� �����(������ �̸�, Ÿ�Ե� ����) ����� �ø��� ����
    . �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������
      ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����.

�� ���̺��� �̸��� ������ �÷����� �����Ѵ�.
==>deptno

���� �Ϸ����ϴ� �÷��� ���� ������� ����
SELECT *
FROM emp NATURAL JOIN dept;

ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
����Ŭ ���� ����
1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� (,)
2. ����� ������ WHERE���� ����ϸ� �ȴ�. (ex : WHERE emp.deptno = dept.deptno)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno�� 10���� �����鸸 ��ȸ
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
    AND emp.deptno = 10;
    
ANSI-SQL : JOIN with USING
    . join �Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��� ��
    . �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���
    
SELECT *
FROM emp JOIN dept USING (deptno);

ANSI-SQL : JOIN with ON
    . ���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
    . ON���� ����� ������ ���
;
SELECT *
FROM emp JOIN dept ON(emp.deptno = dept.deptno);

ORACLE �������� �� SQL�� �ۼ�
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

JOIN�� ������ ����
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
EMP ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����
�ش� ������ �������� �̸��� �˰���� ��

ANSI-SQL�� SQL ���� : 
�����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
              ����� �÷� : ����.MGR = ������.EMPTNO
               ==> ���� �÷� �̸��� �ٸ���(MGR, EMPNO)
                    ==> NATURAL, JOIN, JOIN WITH USING�� ����� �Ұ����� ����
                        ==> JOIN with ON
                
ANSI-SQL�� �ۼ�
(����Ŭ)
SELECT *
FROM emp e, emp m
WHERE e.mgr = m.empno;
(ANSI)
SELECT *
FROM emp e JOIN emp m  ON(e.mgr = m.empno);

NONEUQU1 JOIN : ����� ������ =�� �ƴҶ�

�׵��� WHERE���� ����� ������ :   =, !=, <>, <=, <, >, >=
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

==> ORACLE ���� �������� ����
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

������ ���� �ǽ�join0]
emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���

����Ŭ
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

������ ���� �ǽ� join0_1]
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

������ ���� �ǽ� join0_2]
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

������ ���� �ǽ� join0_3]����
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500 AND empno > 7600;

������ ���� �ǽ� join0_4]����
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500 AND empno > 7600 AND dname = 'RESEARCH';

�����غ���
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;


������ ���� �ǽ� join1]
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);

SELECT prod_lgu, lprod_nm, prod_id, prod_name
FROM prod JOIN (SELECT lprod_gu prod_lgu, lprod_id, lprod_nm FROM lprod) lprod USING(prod_lgu);

�ߺ� ����
DELETE FROM dept a
WHERE ROWID > (SELECT MIN(ROWID) FROM dept b
  WHERE b.deptno = a.deptno);
