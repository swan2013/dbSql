NULLó�� �ϴ� ��� (4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
NVL, NVL2..

DESC emp;

SELECT NVL(empno, 0), ename, NVL(sal, 0), NVL(comm, 0)
FROM emp;

condition : CASE, DECODE

�����ȹ : �����ȹ�� ����
          ���� ����
          

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100->105)

�ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸� SAL���� 30% �λ�� �ݾ��� ���ʽ��� ����
                            �� ���� �μ��� ���ϴ� ����� 10% �λ�� �ݾ��� ���ʽ��� ����

�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʼҷ� ����
�׿� �������� sal��ŭ�� ����
DECODE�� ��� (case �� ��� ����)
SELECT DECODE(job,
                'SALESMAN', sal*1.05,
                'MANAGER', DECODE(deptno,
                                        10, sal*1.3, sal*1.1
                                 ),
                'PRESIDENT', sal*1.2, sal
             ) bonus
FROM emp;


���� A = (10, 15, 18, 23, 24, 25, 29, 30, 35, 37)
�Ҽ� : (23, 29, 37) : COUNT-3, MAX-37, MIN-23, AVG-29.66, SUM-89
��Ҽ� : (10, 15, 18, 25, 30, 35);

10 - 3
20 - 5
30 - 6
SELECT *
FROM emp
ORDER BY deptno;


GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�.
EX : �μ��� �޿� ���
    emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30)�� ���� �ִ�.
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.

GROUP BY ����� ���� ���� : SELECT ����� �� �ִ� �÷��� ���ѵ�

SELECT �׷��� ���� �÷�, �׷��Լ�
FORM ���̺��
GROUP BY �׷��� ���� �÷�
[ORDER BY];


�μ����� ���� ���� �޿�
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno,
        MAX(sal),   -- �μ����� ���� ���� �޿� ��
        MIN(sal),   -- �μ����� ���� ���� �޿� ��
        AVG(sal),   -- �μ��� �޿� ���
        SUM(sal),   -- �μ��� �޿� ��
        COUNT(sal),  -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� ��)
        COUNT(*)    -- �μ��� ���� ��
FROM emp
GROUP BY deptno;

* �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
  ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����.
  --> �߱� WINDOM/�м� RUNCTION�� ���� �ذ� ����
  
  emp ���̺��� �׷� ������ �μ���ȣ
SELECT deptno,
        MAX(sal),   -- �μ����� ���� ���� �޿� ��
        MIN(sal),   -- �μ����� ���� ���� �޿� ��
        AVG(sal),   -- �μ��� �޿� ���
        SUM(sal),   -- �μ��� �޿� ��
        COUNT(sal), -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� ��)
        COUNT(*),   -- �μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;

2020.04.27�� ��ǥ �� ���� Ȯ��
GROUP BY ���� ����� �÷���
    SELECT ���� ������ ������ ???
    ��� �÷��� ����
    
GROUP BY ���� ������� ���� �÷���
    SELECT ���� ������ ???

�׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ�.(���� �ƴ�);
SELECT deptno, 'TEST', 1,
        MAX(sal),   -- �μ����� ���� ���� �޿� ��
        MIN(sal),   -- �μ����� ���� ���� �޿� ��
        AVG(sal),   -- �μ��� �޿� ���
        SUM(sal),   -- �μ��� �޿� ��
        COUNT(sal), -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� ��)
        COUNT(*),   -- �μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�.
30�� �μ����� NULL���� ���� ���� ������ SUM(COMM)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10, 20�� �μ��� SUM(comm) �÷��� NULL�� �ƴ϶� 0�� �������� NULLó��
* Ư���� ������ �ƴϸ� �׷��Լ� ������� NULLó���� �ϴ� ���� ���ɻ� ����

NVL(SUM(comm), 0) : COMMĿ���� SUM �׷��Լ��� �����ϰ� �ְ� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm, 0)) : ��� comm�÷��� NVL �Լ��� ���� ��(�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����

SELECT deptno, NVL(SUM(comm), 0), SUM(NVL(comm,0))
FROM emp
GROUP BY deptno;

single row �Լ��� where���� ����� �� ������
multi row �Լ�(group �Լ�)�� where���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

single row �Լ��� WHERE ������ ��� ����
* ���� ��� ������ WHERE���� ������ �������� ����
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 5000
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


group function �ǽ� grp1]
SELECT
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp;

group function �ǽ� grp2]
SELECT deptno,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp
GROUP BY deptno;

SELECT *
FROM emp;

SELECT *
FROM dept;

group function �ǽ� grp3]*����
SELECT DECODE(deptno,
                10, 'ACCOUNTING',
                20, 'RESEARCH',
                30, 'SALES'
             )DNAME,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

group function �ǽ� grp4]
SELECT hire_yyyymm,
        COUNT(hire_yyyymm)cnt
FROM 
    (SELECT TO_CHAR(hiredate, 'YYYYMM')hire_yyyymm
    FROM emp)
GROUP BY hire_yyyymm;

SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm,
        COUNT(hiredate)cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');
    
group function �ǽ� grp5]
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyy,
        COUNT(hiredate)cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

group function �ǽ� grp6]
SELECT
        COUNT(deptno)cnt
FROM dept;

SELECT *
FROM dept;

group function �ǽ� grp7]
SELECT
    COUNT(deptno)cnt
FROM
    (SELECT deptno
    FROM emp
    GROUP BY deptno);
