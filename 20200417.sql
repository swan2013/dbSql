SELECT ���� ����:
    ��¥ ����(+,-) : ��¥ + ����, -���� : ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    ���� ����(....): �����ð��� �ٷ��� ����...
    ���ڿ� ����
        ���ͷ� : ǥ����
            ���� ���ͷ� : ���ڷ� ǥ��
            ���� ���ͷ� : java : "���ڿ�" / sql : 'sql'
                    SELECT SELECT * FROM || table_name
                    SELECT 'SELECT * FROM' || table name
                ���ڿ� ���տ��� : +�� �ƴ϶� || (java ������ +)
            ��¥?? : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ���� ����')
                TO_DATE('20200417', 'yyyyMMdd')
                
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����
;
SELECT *
FROM users
WHERE 1 = 1;

SELECT *
FROM users
WHERE 1 = 2;

SELECT *
FROM users
WHERE 1 != 1;

SELECT *
FROM users
WHERE userid = 'brown';

sal���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==>BETWEEN AND;
�񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
���۰��� �������� ��ġ�� �ٲٸ� ���� �������� ����



SELECT *
FROM emp;

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

exclusive or (��Ÿ�� or)
a or b  a= true, b = true ==> true
a exclusive or b a = true, b = true ==> false

SELECT *
FROM emp
WHERE 1000 <= sal
  AND sal <= 2000;

--where2]  
emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
�� �����ڴ� between�� ����Ѵ�.

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE(19820101, 'YYYYMMDD') AND TO_DATE(19830101, 'YYYYMMDD');


IN ������
�÷�:Ư���� IN (��1. ��2, ....)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�ϸ� TRUE

SELECT *
FROM emp
WHERE deptno IN (10, 30);
==> deptno�� 10�̰ų� 30���� ����
deptno = 10 or deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   or deptno = 30;

-IN �ǽ� WHERE3]
users ���̺��� userid�� brown, cony , sally�� �����͸� ������ ���� ��ȸ �Ͻÿ�(IN ������ ���)

SELECT userid AS ���̵�, usernm AS �̸�, alias AS ����
FROM users;
WHERE userid IN ('brown', 'cony', 'sally');

���ڿ� ��Ī ���� : LIKE ���� JAVA : startWith(prefix), endsWith(suffix)
����ŷ ���ڿ� : % - ��� ���ڿ�(���� ����)
              _ - � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE

�÷�| Ư���� LIKE ���� ���ڿ�

'cony'  : cony�� ���ڿ�
'co%'   : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� �� �ִ� ���ڿ�
          'cony', 'con', 'co'
'%co%'  : co�� �����ϴ� ���ڿ�
          'cony', 'sally cony'
'co__'  : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
'_on_'  : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �� �� �ִ� ���ڿ�

���� �̸�(ename)�� �빮�� S�� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--WHERE4]
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--WHERE5]
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

NULL ��
SQL �� ������ :
    WHERE usernm = 'brown'

MGR�÷� ���� ���� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr = null;

SQL���� NULL ���� ���� ��� �Ϲ�������
�񱳿�����(=)�� ��� ���ϰ� IS �����ڸ� ���
SELECT *
FROM emp
WHERE mgr IS NULL;

���� �ִ� ��Ȳ���� � �� : =, !=, <>
NULL : IS NULL, IS NOT NULL

emp���̺��� mgr �÷� ���� NULL�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

where6]
SELECT *
FROM emp;
WHERE comm IS NOT NULL;

SELECT *
FROM emp;

SELECT *
FROM emp
WHERE mgr IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);
==> WHERE mgr = 7698 or mgr = 7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);
==> WHERE mgr != 7698 ADN mgr != 7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);    //����

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
   OR mgr IS NULL;

IN �����ڸ� �� �����ڷ� ����



WHERE7]
SELECT *
FROM emp
WHERE job = 'SALESMAN'
    AND hiredate >= TO_DATE('19810601', 'YYYYMMDD')
    AND sal > 1300;

WHERE8]
SELECT *
FROM emp
WhERE deptno != 10
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
  
WHERE9]
SELECT *
FROM emp
WhERE deptno NOT IN(10)
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
  
WHERE10]
SELECT *
FROM emp
WhERE deptno IN(20, 30)
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
  
WHERE11]
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
  OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');
  
WHERE12]
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
   OR empno LIKE '78%';
   
WHERE13]

DESC emp;

SELECT *
FROM emp
WHERE job IN ('SALESMAN')
   OR empno = 78
   OR empno BETWEEN 780 AND 789
   OR empno BETWEEN 7800 AND 7899;
   
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%'
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');
  
���� : (a. b. c) == {a, c, b}

table���� ��ȸ, ����� ������ ����(������� ����)
==> ���нð��� ���հ� ������ ����

SQL������ �����͸� �����Ϸ��� ������ ������ �ʿ�
ORDER BY �÷��� [��������], �÷���2 [��������].....

������ ���� : ��������(DEFAULT) - ASC, �������� - DESC

���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename ASC;

���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename DESC;

SELECT *
FROM emp
ORDER BY comm DESC;