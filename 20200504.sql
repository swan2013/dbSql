������ 

��Ģ ������ : +, -, *, / : ���� ������
���� ������ : ? 1==1 ? true ���� : false�� �� ����

SQL ������ 
= : �÷�|ǥ���� = ��
    = 1
    
IN : �÷�|ǥ���� IN (����)
    detpno IN(10, 30) ==> IN(10, 30), deptno(10, 30)
    
EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

��IN�� �Ұ�ȣ ������ ���������� ���ؼ� ���� ����������
  EXISTS�� ���� ������ �����ϰ� �� ������ ���� 
  EXISTS������ ���������� �����Ͽ� ���� ���� �����Ͽ� �����ڴ��� Ȯ��

���������� ���� ���� ���� ���������� ���� ����� �׻� ���� �ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�.

�Ʒ� ������ ���ȣ ��������
�Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� ���̻� Ž���� ���� �ʰ� �ߴ�.
���� ���� ���ο� ������ ���� �� ���

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
              FROM dept);

�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ���� : 14-KING = 13���� ����

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno); 

IS NOT NULL�� ���ؼ��� ������ ����� ����� �� �� �ִ�.
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

join
SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;

sub9]
SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE product.pid = cycle.pid
                AND cid = 1);

sub10]
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
                  FROM cycle
                  WHERE cycle.pid = product.pid
                    AND cid = 1);
                    
SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
                  FROM cycle
                  WHERE cycle.pid = product.pid
                    AND pid NOT IN(SELECT pid FROM cycle WHERE cid = 1));

SELECT *
FROM cycle;

SELECT *
FROM product;

���տ���
������
{1, 5, 3} U {2, 3} = {1, 2, 3, 5}

SQL���� �����ϴ� UNION ALL (�ߺ� �����͸� ���� ���� �ʴ´�)
{1, 5, 3} U {2, 3} = {1, 5, 3, 2, 3}

������
{1, 5, 3} ������ {2, 3} = {3}

������
{1, 5, 3} - {2, 3} = {1, 5}

SQL������ ���տ���
������ �� UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ�� (��, �Ʒ��� ���� �ȴ�.)

UNION ������ : �ߺ�����(������ ������ ���հ� ����)

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)


UNION ALL ������ : �ߺ� ���

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)


INTERSECT ������ : �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)


MINUS ������ : ,���� ���տ��� �Ʒ��� ���� ��Ҹ� ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)


SQL ���տ������� Ư¡

���� �̸� : ù�� SQL�� �÷��� ���󰣴�.

ù��° ������ �÷��� ��Ī �ο�
SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN(7698);

2.������ �ϰ� ���� ��� �������� ���� ����
  ���� SQL���� ORDER BY �Ұ� (�ζ��� �並 ����Ͽ� ������������ ORDER BY�� ������� ������ ����)
SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)
--ORDER BY nm,�߰� ������ ���� �Ұ�
UNION

SELECT ename, empno
FROM emp
WHERE empno IN(7698)
ORDER BY nm;


3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�.(������ ���� ����� ����), �� UNION ALL�� �ߺ� ���

4, �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �������ϴ� �۾��� �ʿ�
 _>����ڿ��� ����� �����ִ� �������� ������
    ==> UNION ALL�� ����� �� �ִ� ��Ȳ�� ��� UNION
�˰���(����-��ǰ, ��������, ���� ����,....
          �ڷ� ���� : .Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
                    heap
                    stack, queue
                    list
                    
���տ��꿡�� �߿��� ���� : �ߺ�����;


SELECT ROWNUM, x.*
FROM
    (SELECT aa.sido, aa.sigungu, round(a/b, 2) d
    FROM (SELECT sido, sigungu
          FROM FASTFOOD
          GROUP BY sido, sigungu)aa, (SELECT sido, sigungu, count(gb) a
                                               FROM FASTFOOD
                                               WHERE gb IN ('����ŷ', '�Ƶ�����', 'KFC')
                                               GROUP BY sido, sigungu)bb, (SELECT sido, sigungu, count(gb) b
                                                                           FROM FASTFOOD
                                                                           WHERE gb = '�Ե�����'
                                                                           GROUP BY sido, sigungu)cc
    WHERE aa.sido = bb.sido AND bb.sido = cc.sido AND aa.sigungu = bb.sigungu AND bb.sigungu = cc.sigungu
    ORDER BY d DESC)x;

SELECT*
FROM tax;

����] fastfood ���̺�� tax���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL�ۼ�
1. ���ù��������� ���ϰ�
2. �δ� ���� �İ���� ���� �õ� �ñ������� ������ ���Ͽ�
3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù��� ����, ����û �õ�, ����û �ñ��� ����û �������� �ݾ� 1�δ� �Ű��

����2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ����Ͽ��µ� (fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺��� 1���� ���)
CASE, DECODE
