OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ����
<==> 
INNER JOIN(���ݱ��� ��� ���)

LEFT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN    : ������ �Ǵ� ���̺��� JOIN  Ű���� �����ʿ� ��ġ
FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp ���̺��� �÷� �� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó����
���ο� �����ϱ� ������ 13���� �����͸� ��ȸ�� ��.

INNER ���� ����
������ ���� ����� ���, ����� �̸�, ���� ���, ���� �̸�

������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�.
==> KING�� ����� ����(mgr)�� NULL�̱� ������ ���ο� �����ϰ�
    KING�� ������ ������ �ʴ´�. (emp ���̺� �Ǽ� 14�� ==> ���� ��� 13��)
ANSI-SQL
SELECT e.mgr, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

ORACLE ����
SELECT e.mgr, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;


���� ������ OUTER �������� ����
(KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������, 
 ������ ����� ������ ���� ������ ������ �ʴ´�.);
 
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);

ORACLE-SQL : OUTER
oracle join
1. FROM ���� ������ ���̺� ���(�޸��� ����)
2. WHERE ���� ���� ������ ���
3. ���� �÷�(�����) �� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ��ش�.
   ==> ������ ���̺� �ݴ����� ���̺��� �÷�

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno = 10);

������ WHERE���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE e.deptno =10;

ORACLE-SQL
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+) AND e.deptno = 10;

OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�.

outerjoin1]
SELECT *
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

SELECT * 
FROM prod;

ANSI-SQL
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod ON(prod_id = buy_prod 
                                     AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

ORACLE-SQL                             
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE prod_id = buy_prod(+)
  AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
  
outerjoin2]
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE prod_id = buy_prod(+)
  AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
  
outerjoin3]
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') buy_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0)buy_qty
FROM prod, buyprod
WHERE prod_id = buy_prod(+)
  AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

outerjoin4]
SELECT product.pid pid, pnm, NVL(cid, 1) cid, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product LEFT OUTER JOIN cycle ON(product.pid = cycle.pid AND cid =1);

SELECT product.pid pid, pnm, '1' cid, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product, cycle
WHERE product.pid = cycle.pid(+)
  AND cid(+) =1;

outerjoin5]
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM customer;

SELECT product.pid pid, pnm, NVL(cycle.cid, 1) cid, NVL(cnm, 'brown'), NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product LEFT OUTER JOIN cycle ON(product.pid = cycle.pid AND cid =1)
             LEFT OUTER JOIN customer ON(cycle.cid = customer.cid);
                        
SELECT product.pid pid, pnm, '1' cid, NVL(cnm, 'brown'), NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product, cycle, customer
WHERE product.pid = cycle.pid(+)
  AND cycle.cid = customer.cid(+)
  AND cycle.cid(+) =1;
  
OUTER JOIN SKIP�ϰ� ������ �ٽ� ����

15 ==> 45
3�� ==> customer ���̺��� ���� ����
SELECT *
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�.

emp 14 * dept 4 = 56
SELECT *
FROM emp CROSS JOIN dept;

ORACLE (���� ���̺� ����ϰ� WHERE ���� ������ ������� �ʴ´�.)
SELECT *
FROM emp, dept;

cross join1]
SELECT *
FROM customer, product;

SELECT *
FROM customer CROSS JOIN product;

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
1. SELECT
    SCALAR SUB QUERY
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�.
    EX) DUAL ���̺�
    
2. FROM
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��
    
3. WHERE
    SUB QUERY
    WHERE ���� ���� ����
    
SMITH�� ���� �μ��� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������?
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
    �ι�° ������ ù��°�� ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�.
    (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 10������ 30������ ������ ����
    ==> �������� ���鿡�� ����)
    
ù��° ����;
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

�ι�° ����
SELECT *
FROM emp
WHERE deptno = 20;

���������� ���� ���� ����
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = :ename);
                
sub1]��� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ
SELECT AVG(SAL)
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(SAL)
             FROM emp);
             
sub2]
SELECT *
FROM emp
WHERE sal > (SELECT AVG(SAL)
             FROM emp);