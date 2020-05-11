�θ�-�ڽ� ���̺� ����

1. ���̺� ������ ����
 1]�θ� (dept)
 2]�ڽ� (emp)
 
2. ������ ������(insert) ����
 1]�θ� (dept)
 2]�ڽ� (emp)
 
3. ������ ������(delete) ����
 1]�ڽ� (emp)
 2]�θ� (dept)
 
���̺� ���� ��(���̺��� �̹� �����Ǿ� �ִ� ���) �������� �߰�/����

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0),
    ename VARCHAR2(10),
    deptno NUMBER(2, 0)
);

�� ���̺� ���� �� ���������� Ư���� �������� ����
���̺� ������ ���� RIMARY KEY �߰�
���� : ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������Ÿ�� (�������÷�[, ...]);
�������� ; PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);


���̺� ����� �������� ����
���� : ALTER TABLE ���̺� �̸� DROP CONSTRAINT �������Ǹ�;

������ �߰��� �������� pk_emp_test ����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

���̺� �������� �ܷ�Ű �������� �߰� �ǽ�
emp_test.deptno ===> dept_test.deptno

dept_test���̺��� deptno�� �ε��� ���� �Ǿ��ִ��� Ȯ��

ALTER TABLE ���̺�� ADD CONSTRAINT  FOREIGN KEY (�÷���) REFERENCES �������̺�� (�������̺� �÷���);

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) 
                   REFERENCES dept_test (deptno);
                   
������ ����;

�������� ȣ��ȭ ��Ȱ��ȭ
���̺� ������ ���������� ���� �ϴ� ���� �ƴ϶� ��� ����� ����, Ű�� ����
���� : ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������� ��;

������ ������ fk_emp_tset_dept_test FOREIGN KEY ���������� ��Ȱ��ȭ;

ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

dept(�θ�)���̺��� 99�� �μ��� �����ϴ� ��Ȳ
SELECT *
FROM dept_test;

fk_emp_test_dept_test ���������� ��Ȱ��ȭ�Ǿ� �ֱ� ������ emp_test ���̺��� 99 �μ� �̿���
���� �Է� ������ ��Ȳ


dept_test ���̺� 88�� �μ��� ������ �Ʒ� ������ ���������� ����
INSERT INTO emp_test VALUES (9999, 'brown', 88);


���� ��Ȳ : emp_test ���̺� dept_test ���̺� �������� �ʴ� 88�� �μ��� ����ϰ� �ִ� ��Ȳ
           fk_emp_test_detp_test ���������� ��Ȱ��ȭ�� ����
           
�������� ���Ἲ�� ���� ���¿��� fk_emp_tset_dept_test�� Ȱ��ȭ ��Ű��???
==>������ ���Ἲ�� ��ų�� �����Ƿ� Ȱ��ȭ �� �� ����.

ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;


emp, dept ���̺��� ���� PRIMARY KEY, FOREIGN KEY ������ �ɷ� ���� ���� ��Ȳ
emp���̺��� empno�� Key��
dept ���̺��� deptno�� Key�� �ϴ� PRIMARY KEY ������ �߰��ϰ�

emp.deptno ==> dept.deptno�� �����ϵ��� FOREIGE KEY�� �߰�

�������� ���� �����ð��� �ȳ��� ������� ���.
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT pk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);


�������� Ȯ��
������ �������ִ� �޴�(���̺� ���� ==> �������� tab)
USER_CONS_COLUMNS : �������� ����(MASTER);

USER_CONSTRAINTS : �������� �÷� ����(��);

SELECT *
FROM USER_CONSTRAINTS;

SELECT *
FROM USER_CONS_COLUMNS;

�÷�Ȯ��
��
SELECT *
DESC
USER_TAB_COLUMS (data dictionary, ����Ŭ���� ���������� �����Ѵ� view);

SELECT *
FROM user_tab_columns
WHERE TABLE_NAME = 'EMP';


SELECT 'SELECT * FROM ' || TABLE_NAME || ';'
FROM USER_TABLES;

���̺�, �÷� �ּ� : USER_TAB_COMMENTS, USER_COL_COMMENTS;

SELECT *
FROM user_tab_comments;

���� ���񽺼� ���Ǵ� ���̺��� ���� ���ʰ��� ������ �ʴ� ��찡 ����.
���̺��� : ī�װ�+�Ϸù�ȣ

���̺��� �ּ� �����ϱ�
���� : COMMENT ON TABLE ���̺�� IS '�ּ�';
emp ���̺� �ּ� �����ϱ�
COMMENT ON TABLE emp IS '����';

SELECT *
FROM user_tab_comments;

Ŀ���ּ� Ȯ��
SELECT *
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

�÷� �ּ� ����
COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�';

empno, ename, hiredate
COMMENT ON COLUMN emp.empno IS '���';
COMMENT ON COLUMN emp.ename IS '�̸�';
COMMENT ON COLUMN emp.hiredate is '�Ի�����';

SELECT *
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

SELECT 'COMMENT ON COLUMN' || table_name || '.' || column_name || ' IS [�ڸ�Ʈ]'
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

�ǽ� comment1]
SELECT tab.table_name, table_type, tab.comments tab_comment, column_name, col.comments col_comment
FROM user_tab_comments tab, user_col_comments col
WHERE tab.table_name = col.table_name
  AND tab.table_name IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY');
  
SELECT table_name, table_type, tab.comments tab_comment, column_name, col.comments col_comment
FROM user_tab_comments tab JOIN user_col_comments col USING(table_name)
WHERE table_name IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY');


View �� ������
������ ������ ���� = SQL
�������� ������ ������ �ƴϴ�

View ��� �뵵
 . ������ ����(���ʿ��� �÷� ������ ����)
 . ���ֻ���ϴ� ������ ���� ����
  . IN-LINE VIEW

view�� �����ϱ� ���ؼ��� CREATE VIEW ������ ���� �־�� �Ѵ� (DBA����)

SYSTEM ������ ����
GRANT CREATE VIEW TO ����������� �ο��� ������;

���� : CREATE [OR REPLACE] VIEW ���̸� [�÷���Ī1, �÷���Ī2....] AS
        SELECT ����;

emp���̺��� sal, comm �÷��� ������ 6���� �÷��� ��ȸ�� ������ v_emp view�� ����

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

view (v_emp)�� ���� ������ ��ȸ
SELECT *
FROM v_emp;

v_emp view �� sem���� ����
HR�������� �λ� �ý��� ������ ���ؼ� EMP���̺��� �ƴ� SAL, COMM ��ȸ�� ���ѵ�
V-emp view�� ��ȸ�� �� �ֵ��� ������ �ο�


���� �ο��� hr �������� v_emp ��ȸ
SELECT *
FROM sem.v_emp;

[sam�������� ����] sem�������� hr�������� v_emp view�� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON v_emp TO hr;

[hr�������� ����] v_emp view ������ hr ������ �ο��� ���� ��ȸ �׽�Ʈ
SELECT *
FROM PC07.v_emp;


�ǽ�]
v_emp_dept �並 ����
emp, dept ���̺��� deptno�÷����� �����ϰ�
emp.empno, ename, dept.deptno, dname 4���� �÷����� ����
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING(deptno);

SELECT *
FROM v_emp_dept;

DROP VIEW v_emp;


VIEW�� ���� DML ó��
SIMPLE VIEW�� ���� ����

SIMPLE VIEW : ���ε��� �ʰ�, �Լ�, GROUP BY, ROWNUM�� ������� ���� ������ ������ VIEW
COMPLEX VIEW : SIMPLE VIEW�� �ƴ� ����

SELECT *
FROM v_emp;

v_emp�� ���� 7369 SMITH ����� �̸��� brown���� ����
UPDATE v_emp SET ename = 'brown'
WHERE empno = 7369;

v_emp �÷����� sal �÷��� �������� �ʱ� ������ ����
UPDATE v_emp SET ename = 'brown'
WHERE empno = 7369;

rollback;

SEQUENCE
������ �������� �������ִ� ����Ŭ ��ü
�����ĺ��� ���� ������ �� �ַ� ���

�ĺ��� ==> �ش� ���� �����ϰ� ������ �� �ִ� ��
 ���� <==> ���� �ĺ���
 
���� : ���� �׷��� ��
���� : �ٸ糽 ��

�Ϲ������� � ���̺�(����Ƽ)�� �ĺ��ڸ� ���ϴ� �����
[����], [����], [������]

�Խ����� �Խñ� : �Խñ� �ۼ��ڰ� ���� ����� �ۼ� �ߴ���
�Խñ��� �ĺ��� : �ۼ���id, �ۼ��Ͻ�, ������
    ==> ���� �ĺ��ڰ� �ʹ� �����ϱ� ������ ������ ���̼��� ����
        ���� �ĺ��ڸ� ��ü�Ҽ� �ִ� (�ߺ����� �ʴ�) ���� �ĺ��ڸ� ���

������ �ϴٺ��� ������ ���� �����ؾ��� ���� ����
ex : ���, �й�, �Խñ� ��ȣ
     ���, �й� : ü��
     ��� : 15101001 - ȸ�� �������� 15 , 10�� 10��, �ش� ��¥�� ù��° �Ի��� ��� 01
     �й� : 201306300
     
     ü�谡 �ִ� ���� �ڵ�ȭ�Ǳ� ���ٴ� ����� ���� Ÿ�� ��찡 ����
     
     �Խñ� ��ȣ : ü�谡...., ��ġ�� �ʴ� ����
     ü�谡 ���°��� �ڵ�ȭ�� ���� ==> SEQUENCE ��ü�� Ȱ���Ͽ� �ս��� ���� ����
                                ==> �ߺ����� �ʴ� ���� ���� ��ȯ

�ߺ����� �ʴ� ���� �����ϴ� ���
1. KEY table�� ����
   ==> SELECT FOR UPDATE �ٸ� ����� ���ÿ� ������� ���ϵ��� ���°� ����
   ==> ���� ���� ���� ��, ������ ���� �̻ڰ� �����ϴ°� ����(SEQUENCE ������ �Ұ���)
   
2. JAVA�� UUID Ŭ������ Ȱ��, ������ ���̺귯�� Ȱ��(����) ==> ������, ����, ī��
   ==> jsp �Խ��� ����
   
3. ORACLE DB - SEQUENCE


SEQUENCE ����
���� : CREATE SEQUENCE ������ ��;

seq_emp��� �������� ����
CREATE SEQUENCE seq_emp;

���� : ��ü���� �������ִ� �Լ��� ���ؼ� ���� �޾ƿ´�.
NEXTVAL : �������� ���� ���ο� ���� �޾ƿ´�.
CURRVAL : ������ ��ü�� NEXTVAL�� ���� ���� ���� �ٽ��ѹ� Ȯ���� �� ���
          (Ʈ����ǿ��� NEXTVAL �����ϰ� ���� ����� ����)
       
SELECT seq_emp.NEXTVAL
FROM dual;

SELECT seq_emp.CURRVAL
FROM dual;

SELECT *
FROM emp_test;

SEQUENCE�� ���� �ߺ����� �ʴ� empno �� ���� �Ͽ� insert �ϱ�
INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'sally', 88);

SELECT *
FROM emp_test;
 