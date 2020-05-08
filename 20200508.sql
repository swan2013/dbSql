SELECT 'TEST1' || 'dummy'
FROM dual;

SELECT *
FROM emp
WHERE deptno != 10
  AND deptno != 20;
; 
10]������ �����߿� mgr�� �����ϴ� ������ ��ȸ;

SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
         (SELECT *
          FROM emp
          ORDER BY hiredate, ename)a)a
WHERE rn BETWEEN ((:page-1)*:size)+1 AND :size * :page;

SELECT emp.empno, emp.ename,
                            (SELECT deptno
                             FROM dept
                             WHERE deptno = emp.deptno)d
FROM emp;                             
    
    
12]
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;


��������
1. PRIMARY KEY
2. UNIQUE
3. FOREIGN KEY
4. CHECK
    .NOT NULL
5] NOT NULL
    CHECK ���� ���������� ���� ����ϱ� ������ ������ KEYWORD�� ����

    

NOT NULL ��������
:�÷��� ���� NULL�� ������ ���� �����ϴ� ���� ����

DROP TABLE dept_test;

CREATE TABLE dept_test(
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) NOT NULL,
	loc VARCHAR2(13)
);

dname �÷��� ������ NOT NULL �������ǿ� ���� �Ʒ� INSERT ������ �����Ѵ�.
INSERT INTO dept_test VALUES(99, NULL, 'daejeon);

���ڿ��� ��� ''�� NULL�� �ν��Ѵ�.
�Ʒ��� INSERT ������ ����
INSERT INTO dept_test VALUES(99, '', 'daejeon);


UNIQUE ����
�ش��÷��� ������ ���� �ߺ����� �ʵ��� ����
���̺��� ������� �ش� �÷��� ���� �ߺ����� �ʰ� �����ؾߵ�
EX : ���� ���̺��� ��� �÷�, �л� ���̺��� �й� �÷�

DROP TABLE dept_test;

CREATE TABLE dept_test(
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) UNIQUE,
	loc VARCHAR2(13)
);

dept_test ���̺��� dname �÷��� UNIQUE ������ �ֱ� ������ ������ ���� ���� ����.
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon);
INSERT INTO dept_test VALUES(98, 'ddit', 'daejeon);

���� �÷��� ���� UNIQUE ���� ����
DROP TABLE dept_test;

CREATE TABLE dept_test(
	deptno NUMBER(2, 0),
	dname VARCHAR2(14),
	loc VARCHAR2(13),
    
    CONSTRAINT u_dept_test UNIQUE (dname, loc)
);

dname�÷��� loc�÷��� ���ÿ� ������ ���̾�߸� �ߺ����� �ν�
�ؿ� �ΰ��� ������ ������ �ߺ��� �ƴϹǷ� ���� ����
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');

�Ʒ������� UNIQUE ���� ���ǿ� ���� �Էµ��� �ʴ´�.
INSERT INTO dept_test VALUES (97, 'ddit', '����');



SELECT *
FROM dept_test;


FOREIGN KEY ��������
�Է��ϰ��� �Ѵ� �����Ͱ� �����ϴ� �޺� ������ ���� �Է� ���
ex : emp ���̺� �����͸� �Է��� �� deptno Ŀ���� ���� dept ���̺� �����ϴ� deptno���̾�� �Է� ����

������ �Է½�(emp) �����ϴ� ���̺�(dept)�� ������ ���� ������ ������ �˱� ���ؼ�
�����ϴ� ���̺�(dept)�� �÷�(deptno)�� �ε����� �ݵ�� ���� �Ǿ� �־�߸�
FOREIGN KEY ���������� �߰� �� �� �ִ�.

UNIQUE ���������� ������ ��� �ش� �÷��� �� �ߺ� üũ�� ������ �ϱ� ���ؼ�
����Ŭ������ �ش� �÷��� �ε����� ���� ��� �ڵ����� �����Ѵ�.

PRIMARY KEY �������� : UNIQUE ���� + NOT NULL
PRIMARY KEY �������Ǹ� �����ص� �ش� �÷����� �ε����� ���� ���ش�.


FOREIGN KEY ���������� �����ϴ� ���̺��� �ֱ� ������ �ΰ��� ���̺� �����Ѵ�.


DROP TABLE dept_test;

CREATE TABLE dept_test(
	deptno NUMBER(2, 0)PRIMARY KEY,
	dname VARCHAR2(14),
	loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
COMMIT;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno)
);

���� �μ� ���̺��� 99�� �μ��� ����
foreign key �������ǿ� ���� emp ���̺��� deptno �÷����� 99�� �̿��� �μ���ȣ�� �Էµ� �� ����.

99�� �μ��� ���� �ϹǷ� ���������� �Է� ����
INSERT INTO emp_test VALUES (9999, 'brown', 99);

98�� �μ��� ���� ���� �����Ƿ� ���������� �Է� �� �� ����.
INSERT INTO emp_tset VALUES (9998, 'sally', 98);


DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0),
    
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno)
);

rollback;

�ܷ�Ű�� ������ ����
INSERT INTO emp_test VALUES (9999, 'brown', 99);
COMMIT;

(9999, 'brown', 99) ===> (99, 'ddit', 'daejeon');
emp_test.deptno ===> dept_test.deptno ������.

dept_test���̺��� 99�� �μ��� �����͸� ����� ��� �ɱ�?
(9999, 'brown', 99) ===>

�θ� ���ڵ�(dept_test.deptno)�� �����ϰ� �ִ� �ڽ� ���ڵ�(emp_test.deptno)��
�����ϱ� ������ �ڽ� ���� ���忡���� ������ ���Ἲ�� ������ �Ǿ�
���������� ���� �� �� ����.
DELETE dept_test
WHERE deptno = 99;


����Ű�� ���õ� �����͸� ������ �ο��� �� �ִ� �ɼ�

�θ� �����͸� ������..
FOREIGN KEY �ɼǿ� ���� �ڽ� �����͸� ó���� �� �ִ� �ɼ�
1. defualt ==> �����ϰ� �ִ� �θ� ���� �� �� ����.
2. ON DELETE CASCADE ==> �θ� �����Ǹ� �����ϰ� �ִ� �ڽ� �����͵� ���� ����
3. ON DELETE SET NULL ==> �θ� �����Ǹ� �����ϰ� �ִ� �ڽ� �����͸� NULL�� ����

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0),
    
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno)
    REFERENCES dept_test (deptno)
);

�ְ����� �ǰ� : default
1. �����ڰ� ���̺��� ������ ��Ȯ�ϰ� �˰� �־������ ���� ������ �� ����
    ==> ����ų�, �Է��� �������� ������ �˰� �־�� ��.
2. ���̺� ������ ��Ȯ���� ������ �ű� �����ڴ� �ش� ������ �� ���� ����
    (java�ڵ� + ���̺� ���� Ȯ�� �ʿ�)
    java�ڵ忡�� dept���̺� �����Ѵ� �ڵ尡 �ִµ�
    �ű��ϰԵ� emp���̺��� �����Ͱ� �����ǰų� null�� �����Ǵ� ��츦 �� �� ����
    

CHECK ��������
�÷��� ���� �����Ѵ� ���� ����

emp ���̺��� �޿�����(sal)�� ���� �Ҷ� sall �÷��� ���� 0���� ���� ���� ���� ����
���������� �̻���.
sal �÷��� ���� ������ ���� �ʵ��� üũ ���� ������ �̿��Ͽ� ���� �� �� �ִ�.

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7, 2) CHECK (sal >= 0),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno)
);

INSERT INTO emp_test VALUES (9999, 'brown', 1000, 99);

sal �÷��� ������ check ��������(sal > 0 )�� ���� ���������� ������� �ʴ´�.
INSERT INTO emp_test VALUES (9998, 'sally', -1000, 99);


DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7, 2),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno),
    --���̺� ���� sal üũ �������� ����� �׽�Ʈ
    CONSTRAINT c_sal CHECK (sal >= 0)
);

INSERT INTO emp_test VALUES (9999, 'brown', 1000, 99);


CREATE TABLE emp_2020_05_08 AS
SELECT *
FROM emp;

CATS : Create Table AS
SELECT ����� �̿��Ͽ� ���̺��� �����ϴ� ���
NOT NULL �������� ������ �ٸ� ���������� ������� �ʴ´�.
�뵵
    1. ������ ������ ���
    2. ������ ������ �׽�Ʈ
    
����
CREATE TABLE ���̺�� [(�÷���1, .....)] AS
SELECT ����;

dept_tset ���̺��� ���� ==> dept_test_copy
CREATE TABLE dept_test_copy AS
SELECT *
FROM dept_test;

���̺� ���� ���̺��� ���� �ϰ� ���� ��, �÷��� �����ϰ� ���� ��
CREATE TABLE dept_test_copy2 AS
SELECT *
FROM dept_test
WHERE 1 != 1;

SELECT *
FROM dept_test_copy;

SELECT *
FROM dept_test_copy2;

JAVA JDBC (Java DataBase Connection)
String eql = "������ sql";

���� �˻� ����� ����
�䱸���� : ���� �̸����� �˻�, ��ü �˻�, �ݿ� �˻�;
���� �̸� �˻�
SELECT *
FROM emp
WHERE ename LIKE '%' || �˻� Ű���� || '%';

��ü �˻�
SELECT *
FROM emp;

�޿� �˻�
SELECT *
FROM emp
WHERE sal > �˻���


String sql = "SELECT * "
       sql+= "FROM emp"
       slq+= "WHERE 1=1";
       
if(����ڰ� �޿��˻��� ��û �ߴٸ�){
    sql += " AND sal > " + ����ڰ� �Է��� �˻���;
}
if(����ڰ� ���� �̸� �˻��� ��û �ߴٸ�){
    sql += " AND ename LIKE '%' || " + ����ڰ� �Է��� �̸� �˻��� + "|| '%'";
}


TABLE ����
���ݱ��� ������ TABLE ������ ����
�̹� ������ ���̺��� ���� �� ���� ����
    1. ���ο� �÷��� �߰�
     *******���ο� �÷��� ���̺��� ������ �÷����� �߰��� �ȴ�.
     *******���� �����Ǿ� �ִ� �÷� �߰����� ���ο� �÷��� �߰��� ���� ����.
            ==> ���� ���̺��� �����ϰ� �÷������� ������ ���ο� ���̺� ���� DDL��
                ���Ӱ� ���̺��� ������ ��.
                ����̶�� �̹� �����Ͱ� �׿����� ���¼��� ������ ����
                ==> ���̺��� ������ �� �����ϰ� �÷� ������ ���
    2. ���� �÷� ����, �÷� �̸� ����, �÷� ������ ����, (Ÿ�Ե� ���������� ���� ����)
       ����Ű�� �ɷ��ִ� ���̺��� �÷� �̸��� �����ϴ��� �����ϴ� ���̺��� �����̰��� ����
       (�˾Ƽ� �̸��� ���� ���ش�)
       emp_test.deptno ==> dept_test.deptno ����
       dept_test.deptno �̸������Ͽ� dept_test.dno�� �����ϴ��� fk�� ����� �̸�����
       �� ������ �ȴ�.
   
    3. ���� �����߰�
    
    
���� ���̺� ���ο� �÷� �߰�
ALTER TABLE ���̺�� ADD (�÷��� �÷�Ÿ��);

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno)
);

DESC emp_test;

emp_test ���̺��� hp �÷�(VARCHAR2(20))�� �űԷ� �߰�

ALTER TABLE ���̺�� ADD (�÷��� �÷�Ÿ��);

ALTER TABLE emp_test ADD (hp VARCHAR2(20));

SELECT *
FROM emp_test;

DESC emp_test;

�÷� ������, Ÿ�� ����
ALTER TABLE ���̺�� MODIFY (�÷��� �÷�Ÿ��);

������ �߰��� hp �÷��� �÷� ����� 20���� 30���� ����

ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));

DESC emp_test;

�÷� Ÿ�� ����
������ �߰��� hp�÷��� Ÿ���� VARCHAR2(30)���� DATE�� ����

ALTER TABLE emp_test MODIFY (hp DATE);

DESC emp_test;

SELECT *
FROM emp_test;

�����Ͱ� �����ϴ� �÷��� ���ؼ��� Ÿ�� ������ �Ұ��� �ϴ�. --������ ������ ����
INSERT INTO emp_test VALUES (9999, 'brown', 99, sysdate);
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));


�÷� �̸� ���� -- ����Ű ������̿��� ����
ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO �ű��÷���;

������ �߰��� emp_tset ���̺��� hp �÷��� hp_n���� �̸� ����

ALTER TABLE emp_test RENAME COLUMN hp To hp_n;
DESC emp_test;


�÷� ����
ALTER TABLE ���̺�� DROP (������ �÷���)
ALTER TABLE ���̺�� DROP COLUMN ������ �÷���

������ �߰��� emp_test���̺��� hp_n �÷��� ����;
ALTER TABLE emp_test DROP (hp_n);

SQL����
DML : SELECT, INSERT, UPDATE, DELETE ==> Ʈ����� ���� ���� (��� ����)
DDL : CREATE...., ALTER.....==> Ʈ����� ���� �Ұ��� (��Ұ� �ȵȴ�) / �ڵ� Ŀ��

ROLLBACK;

SELECT *
FROM emp_test;

���� ename�� brown ==> sally�� ����
UPDATE emp_test SET ename = 'sally'
WHERE empno = 9999;

SELECT *
FROM emp_test;

�ѹ� �Ǵ� Ŀ���� ����.

ALTER TABLE emp_test ADD (hp NUMBER);

DESC emp_test;

ROLLBACK;

SELECT *
FROM emp_test;

DDL�� �ڵ� Ŀ���̱� ������ DML ���忡�� ������ �޴´�.
DDL�� ������ ��� ������� ������ �ߴ� �۾��� ���캼 �ʿ䰡 �ִ�.
SQLD ���迡�� �߳����� ����