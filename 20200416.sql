SELECT *    --��� Ŀ�������� ��ȸ
FROM prod;   --�����͸� ��ȸ�� ���̺� ���

Ư�� �÷��� ���ؼ��� ��ȸ : SELECT �÷�1, �÷�2...
prod_id, prod_name�÷��� prod ���̺��� ��ȸ;

--SELECT(�ǽ� )
SELECT prod_id, prod_name
FROM prod;

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SQL ���� : JAVA�� �ٸ��� ���� X, �Ϲ��� ��Ģ����

SQL ������ Ÿ�� : ����, ����, ��¥(date)

USERS ���̺��� (4/14 ����� ����) ����
USERS ���̺��� ��� �����͸� ��ȸ

��¥ Ÿ�Կ� ���� ���� : ��¥�� +, - ���� ����
date type + ���� : date���� ������ ¥��ŭ �̷� ��¥�� �̵�
date type - ���� : date���� ������ ¥��ŭ ���� ��¥�� �̵�

SELECT *
FROM users;

SELECT userid, reg_dt, reg_dt + 5 after_5day, reg_dt - 5
FROM users;

�÷� ��Ī : ���� �÷����� ���� �ϰ� ���� ��
syntax : ���� �÷��� [as] ��Ī��Ī 
��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ���� �����̼����� ���´�.
���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ���
���� �����̼��� ����Ѵ�.

SELECT userid as id, userid id2, userid "�� �� ��"
FROM users;

--column alias (�ǽ� select2)
SELECT prod_id id, prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;

���ڿ� ����(���տ���) : || (���ڿ� ������ + �����ڰ� �ƴϴ�)
SELECT /*userid + 'test'*/ userid || 'test', reg_dt + 5, 'test', 15
FROM users;

�� �̸� ��
SELECT '�� ' ||  userid || ' ��'
FROM users;

SELECT userid, usernm, userid || usernm
FROM users;

SELECT userid || usernm AS id_name
FROM users;

SELECT userid || usernm AS id_name,
       CONCAT(userid, usernm) AS concat_id_name
FROM users;

--sel_con1
user_tables : oracle �����ϴ� ���̺� ������ ��� �ִ� ���̺�(view) ==>data dictionary

SELECT table_name
FROM user_tables;

SELECT table_name, 'SELECT * FROM ' || table_name || ';' AS "QUERY"
FROM user_tables;

SELECT table_name,
       CONCAT('SELECT * FROM ',table_name || ';') AS QUERY
FROM user_tables;


���̺��� ���� �÷��� Ȯ��
1. tool(sql developer)�� ���� Ȯ��
    ���̺� - Ȯ���ϰ��� �ϴ� ���̺� 
2.  SELECT *
    FROM ���̺�
    �ϴ� ��ü ��ȸ --> ��� �ķ��� ǥ��
3. DESC ���̺��
4. data dictionary : user_tab_columns

DESC emp;

SELECT *
FROM user_tab_columns;

���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �ķ� ��� : SELECT
��ȸ�� ���̺� ��� : FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
WHERE ���� ����� ������ ��(TRUE)�� �� ����� ��ȸ

java�� �� ���� : a������ b������ ���� ������ ��
sql�� �� ���� : =
int a = 5;
int b = 2;
a�� b�� ���� ���� ���� Ư������  ����
if(a==b){

}

SELECT *
FROM users
WHERE userid = 'cony';

SELECT *
FROM users
WHERE userid = userid;

emp���̺��� �÷��� ������ Ÿ���� Ȯ��
DESC emp;


SELECT *
FROM emp;
emp : employee
empno : �����ȣ
ename : ��� �̸�
job : ������(��å)
mgr : �����(������)
hiredate : �Ի�����
sal : �޿�
coom : ������
deptno : �μ���ȣ

SELECT * FROM dept;

emp ���̺��� ������ ���� �μ���ȣ�� 30�� ���� ū(>) �μ��� ���� ������ ��ȸ

SELECT *
FROM emp
WHERE deptno > 30;

!= �ٸ���
users ���̺��� ����� ���̵�(userid)�� brown�� �ƴ� ����ڸ� ��ȸ
SELECT *
FROM users
WHERE userid != 'brown';

SQL ���ͷ�
���� : 1234
���� : '�̱� �����̼�' : 'hello world'
��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ����');

1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
SELECT *
FROM emp
WHERE hiredate < TO_DATE(19820101, 'YYYYMMDD');


