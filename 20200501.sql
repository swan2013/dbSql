�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
ex : ��ü ������ �޿� ���, SMITH ������ ���� �μ��� �μ���ȣ

WHERE���� ��밡���� ������
WHERE deptno = 10
==>

�μ� ��ȣ�� 10 Ȥ�� 30���� ���
WHERE deptno IN(10, 30)
WHERE deptno = 10 OR deptno =30

������ ������
�������� ��ȸ�ϴ� ���������� ���  = �����ڸ� ���Ұ�
WHERE deptno IN(�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����)

SMITH = 20, ALLEN�� 30�� �μ��� ����

SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������ ������ ��ȸ

���� ��������, �÷��� �ϳ���
==> ������������ ��밡���� ������ IN(���� ��, �߿�), (ANY, ALL, �󵵰� ����)
IN : ���������� ������� ������ ���� ���� �� TRUE
    WHERE �÷�|ǥ���� IN (���� ����)

ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
    WHERE �÷�|ǥ���� ������ ANY (��������)
    
ALL : ���������� ��� ���� �����ڸ� ������ �� TRUE
    WHERE �÷�|ǥ���� ������ ALL(��������)
    
SMITH �Ǵ� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ

1. ���������� ������� ���� ��� : �ΰ��� ������ ����
1-1] SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ����

SELECT deptno
FROM emp
WHERE ename IN ('SMITH', 'ALLEN');

1-2] 1-1]���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno IN(20, 30);

==> ���������� �̿��ϸ� �ϳ��� SQL���� ���డ��
SELECT *
FROM emp
WhERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'ALLEN'));
                 
sub3]
SELECT *
FROM emp
WhERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));
                 
ANY, ALL
SMITH(800)�� WARD(1250) �λ���� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
==> sal < 1250
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));
                 
SMITH(800)�� WARD(1250) �λ���� �޿� ���� ���� �޿��� �޴� ���� ��ȸ
==> sal > 1250
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));
                
IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30�� ���
WHERE deptno IN(20, 30;

�ҼӺμ��� 20, 30�� ������ �ʴ� ���
WHERE deptno NOT IN(20, 30)
NOT IN�����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���ΰ� �߿�

�Ʒ� ������ ��ȸ�ϴ� ����� � �ǹ��ΰ�? ����� �Ŵ����� �ƴ� ���
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr 
                    FROM emp);
NULL���� ���� ���� ����
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr 
                    FROM emp
                    WHERE mgr IS NOT NULL);
NULLó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ             
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, -1) 
                    FROM emp);
                    
���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� ��������
PAIRWISE ���� (������) ==> ���ÿ� ����

SELECT mgr, deptno
FROM emp
WHERE empno IN (7499,7782);

7499, 7482����� ������ ���� �μ�, ���� �Ŵ����� ��� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno IN(10, 30)
  AND mgr IN (7698,7839);

PAIRWISE ����(���� �������� ����� �Ѱ� ����.)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));
                        
�������� ���� - ��� ��ġ
SELECT - ��Į�� ���� ����
FROM - �ζ��� ��
WHERE - ��������

�������� ���� - ��ȯ�ϴ� ��, �÷��� ��
���� ��
    ���� �÷�(��Į�� ���� ����)
    ���� �÷�
���� ��
    ���� �÷�(���� ���� ����)
    ���� �÷�

��Į�� ��������
SELECT ���� ǥ���Ǵ� ��������
������ ���� �÷��� �����ϴ� ���������� ��� ����
���� ������ �ϳ��� �÷� ó�� �ν�;

SELECT 'X', (SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���� ������ �ϳ��� �� �ϳ��� �÷��� ��ȯ �ؾ� �Ѵ�.

���� �ϳ����� �÷��� 2������ ����
SELECT 'x', (SELECT empno, ename FROM emp WHERE ename = 'SMITH')
FROM dual;

������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� ==> ����
SELECT 'x', (SELECT empno FROM emp)
FROM dual;

emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �˼��� ����. ==>�׷��� ������ ���

Ư�� �μ��� �μ��̸��� ��ȸ�ϴ� ����
SELECT dname
FROM dept
WHERE deptno = 10;

�� ������ ��Į�� ���������� ����

join���� ����
SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING(deptno);

�� ������ ��Į�� ���������� ����
SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno) 
FROM emp;

�������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
��ȣ���� ��������(corelated sub query)
    .���� ������ ���� �Ǿ�� ���� ������ ������ �����ϴ�.
    
���ȣ ���� ��������(non corelated sub query)
    .main ������ ���̺��� ���� ��ȸ �� ���� �ְ�
     sub ������ ���̺��� ������ ��ȸ �� �� �� �ִ�.
     ==> ����Ŭ�� �Ǵ� ���� �� ���ɻ� ������ �������� ���� ������ ����


��� ������ �޿���� ���� ���� �޿��� �޴� ������ ��ȸ�ϴ� ������ �ۼ� �ϼ���(���� ���� �̿�)
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�?���ȣ


������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���

Ư�� �μ�(10)�� �޿� ����� ���ϴ� SQL
SELECT AVG(sal)
FROM emp
WHERE deptno =10;

SELECT *
FROM emp e
WHERE sal > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = e.deptno);



INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

SELECT *
FROM dept;

emp���̺� ��ϵ� �������� 10, 20, 30�� �μ����� �Ҽ��� �Ǿ�����
������ �Ҽӵ��� ���� �μ� : 40, 99

sub4]
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                     WHERE deptno = dept.deptno);
                     GROUP BY deptno);

������ ���� �μ� ���� ��ȸ(������ �Ѹ��̶� �����ϴ� �μ�)
SELECT *
FROM dept
WHERE deptno IN(SELECT deptno
                     FROM emp
                     WHERE deptno = dept.deptno);
  
���������� �̿��� �̿��Ͽ� IN�����߸� ���� ��ġ�Ѵ� ���� �ִ��� ������ ��
���� ������ �־ ��� ����.(����)

WHERE deptno IN(10,10,10);
WHERE deptno = 10
   OR deptno = 10
   OR deptno = 10;
   
������ �μ���ȣ�� ������������ ��ȸ���� �ʵ��� ���� �ҷ��� �׷� ������ �� ���(���� �´�)
SELECT deptno NOT IN (SELECT deptno
                      FROM emp
                      GROUP BY deptno);
                      
sub5]
SELECT *
FROM product
WHERE pid NOT IN(SELECT pid
                 FROM cycle
                 WHERE cid =1);
     
sub6]
1�� ���� ������ǰ ������ ��ȸ�� �Ѵ�.
�� 2�� ���� �Դ� ������ǰ�� ��ȸ�� �Ѵ�.

1] 1�� ���� �Դ� ������ǰ ����
2] 2�� ���� �Դ� ������ǰ ����
SELECT *
FROM cycle c
WHERE pid IN (SELECT pid
              FROM cycle
              WHERE cid=2)
  AND cid = 1;

sub7]
SELECT cid, (SELECT cnm FROM customer WHERE cid = c.cid)cnm, pid, (SELECT pnm FROM product WHERE pid = c.pid)pnm, day, cnt
FROM cycle c
WHERE pid IN (SELECT pid
              FROM cycle
              WHERE cid=2)
  AND cid = 1;

������ �̿��� ���
SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid =1
  AND cycle.cid = customer.cid
  AND cycle.pid = product.pid
  AND cycle.pid IN(SELECT pid FROM cycle WHERE cid =2);

cid, pid, day, cnt;
SELECT *
FROM cycle;

pid, pnm;
SELECT *
FROM product;

cid, cnm;
SELECT *
FROM customer;