����1] fastfood ���̺�� tax���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL�ۼ�
1. ���ù��������� ���ϰ�
2. �δ� ���� �İ���� ���� �õ� �ñ������� ������ ���Ͽ�
3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù��� ����, ����û �õ�, ����û �ñ��� ����û �������� �ݾ� 1�δ� �Ű��

SELECT tax.rn, hamber.sido, hamber.sigungu, hamber.city, tax.sido, tax.sigungu, tax.avg
FROM
    (SELECT ROWNUM rn, hamber.*
     FROM
         (SELECT bmk.sido, bmk.sigungu, ROUND(bmk.cnt/lot.cnt, 2) city
          FROM
              (SELECT sido, sigungu, count(*) cnt
               FROM fastfood
               WHERE gb IN('����ŷ', '�Ƶ�����', 'KFC')
               GROUP BY sido, sigungu) bmk,
              
              (SELECT sido, sigungu, count(*) cnt
               FROM fastfood
               WHERE gb = '�Ե�����'
               GROUP BY sido, sigungu)lot
          WHERE bmk.sido = lot.sido AND bmk.sigungu = lot.sigungu
          ORDER BY city DESC)hamber)hamber,
              
    (SELECT ROWNUM rn, tax.*
     FROM
         (SELECT sido, sigungu, ROUND(SUM(sal)/SUM(people), 2) avg
          FROM tax
          GROUP BY sido, sigungu
          ORDER BY avg DESC)tax)tax
WHERE hamber.rn(+) = tax.rn
ORDER BY tax.rn ASC;

����2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ����Ͽ��µ� (fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺��� 1���� ���)
CASE, DECODE   

SELECT ROWNUM rn, sido, sigungu, city
FROM
    (SELECT sido, sigungu, NVL(ROUND(SUM(bmk)/SUM(lot), 2), 0) city
     FROM
        (SELECT sido, sigungu, gb,
           CASE
               WHEN gb IN('����ŷ', '�Ƶ�����', 'KFC') THEN count(*)
           END bmk,
           CASE
               WHEN gb IN('�Ե�����') THEN count(*)
           END lot
         FROM fastfood
         GROUP BY sido, sigungu, gb)fastfood
    GROUP BY sido, sigungu
    ORDER BY city DESC)fastfood;


����3]
�ܹ��� ���� sql�� �ٸ� ���·� �����ϱ�

SELECT �õ�, �ñ���, (KFC ��Į�� ��������), (����ŷ ��Į�� ��������), (....)

���� �ܹ������� �ּ�(�����̽�, ������ġ �����ϰ� ���)
SELECT ROWNUM, sido, sigungu, city_idx
FROM
    (SELECT sido, sigungu, ROUND((kfc+mac+bk)/lot, 2) city_idx
    FROM
        (SELECT sido, sigungu,
                NVL(SUM(CASE WHEN gb = '�Ե�����' THEN 1 END), 1) lot, NVL(SUM(CASE WHEN gb = 'KFC' THEN 1 END), 0) kfc,
                NVL(SUM(CASE WHEN gb = '�Ƶ�����' THEN 1 END), 0) mac, NVL(SUM(CASE WHEN gb = '����ŷ' THEN 1 END), 0) bk
        FROM fastfood
        WHERE gb IN('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
        GROUP BY sido, sigungu)
    ORDER BY city_idx DESC);