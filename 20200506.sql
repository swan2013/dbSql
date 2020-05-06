1����]
SELECT job, COUNT(*)
FROM emp
GROUP BY job;

2����]
SELECT mgr, COUNT(*)
FROM emp 
GROUP BY mgr;

DML
�����͸� �Է�(INSERT), ����(UPDATE), ����(DELETE), �� �� ����ϴ� SQL

INSERT

����
INSERT INTO ���̺�� [(���̺��� �÷���, ...)] VALUES (�Է��� ��, ...);

ũ�� ���� �ΰ��� ���·� ���
1. ���̺��� ��� �÷��� ���� �Է��ϴ� ���, �÷����� �������� �ʾƵ� �ȴ�.
   �� �Է��� ���� ������ ���̺� ���ǵ� �÷� ������ �νĵȴ�.
INSERT INTO ���̺�� VALUES (�Է��� ��, �Է��� ��2....);

2. �Է��ϰ��� �ϴ� �÷��� ����ϴ� ���
    ����ڰ� �Է��ϰ��� �ϴ� �÷��� �����Ͽ� �����͸� �Է��� ���,
    �� ���̺� NOT NULL ������ �Ǿ��ִ� �÷��� �����Ǹ� INSERT�� �����Ѵ�.
INSERT INTO ���̺�� (�÷�1, �÷�2) VALUES (�Է��� ��, �Է��� ��2);

3. SELECT ����� INSERT
   SELECT ������ �̿��ؼ� ������ ���� ��ȸ�Ǵ� ����� ���̺� �Է� ����
   ==> �������� �����͸� �ϳ��� ������ �Է� ����(ONE-QUERY) ==> ���� ����
   
   ����ڷκ��� �����͸� ���� �Է� �޴� ��� (ex ȸ������)�� ������ �Ұ�
   db�� �����ϴ� �����͸� ���� �����ϴ� ��� Ȱ�� ����(�̷� ��찡 ����)
   
   INSERT INTO ���̺�� [(�÷���1, �÷���2,...)]
   SELECT ......
   FROM .....

dept ���̺� deptno 99, dname DDIT, loc daejeon ���� �Է��ϴ� INSERT ���� �ۼ�

INSERT INTO dept VALUES (99, 'DDIT', 'daejeon');

������ �Է��� Ȯ�� �������� : commit - Ʈ����� �Ϸ�
������ �Է��� ��� �Ϸ��� : rollback - Ʈ����� ���

rollback;

INSERT INTO dept(loc, deptno, dname) VALUES ('daejeon', 99, 'DDIT');

rollback;

���� INSERT ������ ������ ���ڿ�, ����� �Է��� ���
INSERT �������� ��Į�� ��������, �Լ��� ��� ����
EX ; ���̺� �����Ͱ� �� ����� �Ͻ������� ��� �ϴ� ��찡 ���� ==> SYSDATE

SELECT *
FROM emp;

1.
emp���̺��� ��� �÷� �� ������ 8��, NOT NULL�� 1��(EMPNO)
empno�� 9999�̰� ename�� ���� �̸�, hiredate�� ���� �Ͻø� �����ϴ� INSERT ������ �ۼ�

INSERT INTO emp VALUES(9999, '�Ƚ¿�', null, null, SYSDATE, null, null, null);
INSERT INTO emp(empno, ename, hiredate) VALUES(9999, '�Ƚ¿�', SYSDATE);

2.
9998�� �������  jw����� �Է�, �Ի����ڴ� 2020�� 4�� 13�Ϸ� �����Ͽ� ������ �Է�
INSERT INTO emp(empno, ename, hiredate) VALUES(9998, 'jw', TO_DATE('20200413', 'YYYYMMDD'));

3.
SELECT ����� ���̺� �Է��ϱ� (�뷮 �Է�)

DESC dept;

dept ���̺��� 4���� �����Ͱ� ����(10~40)
�Ʒ� ������ �����ϸ� ���� ���� 4�� + SELECT�� �ԷµǴ� 4�� �� 8���� �����Ͱ� dept ���̺� �Էµ�
INSERT INTO dept
SELECT *
FROM dept;

������ �۾��� INSERT ������ ���
ROLLBACK;

UPDATE ; ������ ����
UPDATE ���̺�� set ������ �÷�1 = ������ ��1,
                   [������ �÷�1 = ������ ��1, ....]
[WHERE condition-SELECT ������ ��� WHERE���� ����
        ������ ���� �ν��Ѵ� ������ ���
        
dept ���̺� 99, DDIT, daejeon;
INSERT INTO dept VALUES (99, 'DDIT', 'daejeon');

������ �Է� Ȯ��
SELECT *
FROM dept;

        
99�� �μ��� �μ����� ���IT��, ��ġ�� ���κ������� ����
UPDATE dept SET dname ='���IT',
                loc = '���κ���'
WHERE deptno = 99;

�Ʒ� ������ dept ���̺��� ��� ���� �μ���� ��ġ�� �����ϴ� ����
UPDATE dept SET dname ='���IT',
                loc = '���κ���'

INSERT : ���� �� ���� ����
UPDATE, DELETD : ������ �ִ°� ����, ����
 ==> ������ �ۼ��� ��� ����
    1. WHERE���� �������� �ʾҴ���
    2. UPDATE, DELECT ���� �����ϱ� ���� WHERE���� �����ؼ� SELECT�� �Ͽ�
       ������ ���� ���� ������ Ȯ��

ORACLE ����ڿ��Դ� UPDATE, DELETE�� �Ǽ� ���� ��� �ѹ��� ��ȸ�� ����
ROLLBACK;

���������� �̿��� ������ ����
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);

9999���� ������ deptno, job �ΰ��� �÷��� SMITH ����� ������ �����ϰ� ����
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               job = (SELECT job FROM emp WHERE ename = 'SMITH'),
               sal = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

�Ϲ����� UPDATE ���������� �÷����� ���������� �ۼ��Ͽ� ��ȿ���� ����
==> MERGE ������ ���� ��ȿ���� ������ �� �ִ�.

������� ���
ROLLBACK;


DELETE ; ���̺� �����ϴ� �����͸� ����
����
DELETE [FROM] ���̺��
[WHERE condition]

������
1. Ư�� �÷��� ���� ���� ==> �ش� �÷��� NULL�� UPDATE
    DELETE���� �� ��ü�� ����
2. UPDATE ���������� DELETE ������ �����ϱ� ���� SELECT�� ���� ���� ����� �Ǵ� ���� ��ȸ, Ȯ������

���� �׽�Ʈ ����Ʈ �Է�]
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);

����� 9999���� ���� ���� �ϴ� ���� �ۼ�
DELETE emp
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

ROLLBACK;

�Ʒ� ������ �ǹ� : emp ���̺��� ��� ���� ����
DELETE emp;

SELECT *
FROM emp;

ROLLBACK;

UPDATE, DELETE ���� ��� ���̺� �����ϴ� �����Ϳ� ����, ������ �ϴ� ���̱� ������
��� ���� �����ϱ� ���� WHERE ���� ����� �� �ְ�
WHERE���� SELECT ������ ����� ������ ������ �� �ִ�.
���� ��� ���������� ���� ���� ������ ����

�Ŵ����� 7698�� �������� ��� ���� �ϰ� ���� ��



DELETE emp
WHERE empno IN(SELECT empno 
               FROM emp 
               WHERE mgr = 7698);
               
ROLLBACK;

SELECT, INSERT, UPDATE, DELETE
WHERE ���� ��� ������ DML : SELECT, UPDATE, DELETE
    3�� ������ �����͸� �ĺ��ϴ� WHERE���� ���� �� �ִ�.
    �����͸� �ĺ��ϴ� �ӵ��� ���� ������ ���� ������ �¿� ��.
    ==>INDEX ��ü�� ���� �ӵ� ����� ����
    
INSERT : ������� �ű� �����͸� �Է� �ϴ� ��
         ������� �ĺ��ϴ°� �߷�
         ==> �����ڰ� �� �� �ִ� Ʃ�� ����Ʈ�� ���� ����
         

���̺��� �����͸� ����� ��� (��� ������ �����)
1. DELETE : WHERE���� ������� ������ ��
2. TRUNCATE
    ���� ; TRUNCATE TABLE ���̺��
    Ư¡ ; 1) ������ �α׸� ������ ����
             ==> ������ �Ұ���
          2) �α׸� ������ �ʱ� ������ ���� �ӵ��� ������.
             ==> �ȯ�濡���� �� ������� ���� (������ �ȵǱ� ������)
                 �׽�Ʈ ȯ�濡�� �ַ� ���
                 
�����͸� �����Ͽ� ���̺� ����(���� �غ���)

CREATE TABLE emp_copy AS
SELECT *
FROM emp;

SELECT *
FROM emp;

SELECT *
FROM emp_copy;

emp_copy ���̺��� TRUNCATE ����� ���� ��� �����͸� ����
TRUNCATE TABLE emp_copy;

SELECT *
FROM emp_copy;

ROLLBACK;


Ʈ����� : ������ ���� ����
ex : ATM- ��ݰ� �Ա��� �Ѵ� ���������� �̷������ ������ �߻����� ����
          ����� ���� ó�� �Ǿ����� �Ա��� ������ ó�� �Ǿ��ٸ�
          ���� ó���� ��ݵ� ��Ҹ� ����� �Ѵ�.
          
���
�Ա�(����)
ROLLBACK;

����Ŭ������ ù��° DML�� ������ �Ǹ� Ʈ���� �������� �ν�
Ʈ������� ROLLBACK, COMMIT�� ���� ���ᰡ �ȴ�.

Ʈ����� ���� �� ���ο� DML�� ����Ǹ� ���ο� Ʈ������� ����


��� ����ϴ� �Խ����� �����غ���
�Խñ� �Է��� �� �Է� �ϴ°� : ����(1��), ����(1��), ÷������(���� ����)
RDBMS������ �Ӽ��� �ߺ��� ��� ������ ����Ƽ(���̺�)�� �и��� �Ѵ�.
�Խñ� ���̺�(����, ����) / �Խñ� ÷������ ���̺�(÷�����Ͽ� ���� ����)

�Խñ��� �ϳ� ����� �ϴ���
�Խñ� ���̺��, �Խñ� ÷������ ���̺� �����͸� �űԷ� ����� �Ѵ�.
INSERT INTO �Խñ� ���̺�(����, ����, �����, ����Ͻ�) VALUES (......);
INSERT INTO �Խñ� ÷������ ���̺� (÷�����ϸ�, ÷������ ������) VALUES (......);

�ΰ��� INSERT ������ �Խñ� ����� Ʈ����� ����
�� �ΰ��߿� �ϳ��� ������ ����� �Ϲ������� ROLLBACK�� ���� �� ���� INSERT ������ ���.
