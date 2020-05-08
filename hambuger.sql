과제1] fastfood 테이블과 tax테이블을 이용하여 다음과 같이 조회되도록 SQL작성
1. 도시발전지수를 구하고
2. 인당 연말 식고액이 높은 시도 시군구별로 순위를 구하여
3. 도시발전지수와 인당 신고액 순위가 같은 데이터 끼리 조인하여 아래와 같이 컬럼이 조회되도록 SQL 작성
순위, 햄버거 시도, 햄버거 시군구, 햄버거 도시발전 지수, 국세청 시도, 국세청 시군구 국세청 연말정산 금액 1인당 신고액

SELECT tax.rn, hamber.sido, hamber.sigungu, hamber.city, tax.sido, tax.sigungu, tax.avg
FROM
    (SELECT ROWNUM rn, hamber.*
     FROM
         (SELECT bmk.sido, bmk.sigungu, ROUND(bmk.cnt/lot.cnt, 2) city
          FROM
              (SELECT sido, sigungu, count(*) cnt
               FROM fastfood
               WHERE gb IN('버거킹', '맥도날드', 'KFC')
               GROUP BY sido, sigungu) bmk,
              
              (SELECT sido, sigungu, count(*) cnt
               FROM fastfood
               WHERE gb = '롯데리아'
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

과제2]
햄버거 도시발전 지수를 구하기 위해 4개의 인라인 뷰를 사용하였는데 (fastfood 테이블을 4번 사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선 (fastfood 테이블을 1번만 사용)
CASE, DECODE   

SELECT ROWNUM rn, sido, sigungu, city
FROM
    (SELECT sido, sigungu, NVL(ROUND(SUM(bmk)/SUM(lot), 2), 0) city
     FROM
        (SELECT sido, sigungu, gb,
           CASE
               WHEN gb IN('버거킹', '맥도날드', 'KFC') THEN count(*)
           END bmk,
           CASE
               WHEN gb IN('롯데리아') THEN count(*)
           END lot
         FROM fastfood
         GROUP BY sido, sigungu, gb)fastfood
    GROUP BY sido, sigungu
    ORDER BY city DESC)fastfood;


과제3]
햄버거 지수 sql을 다른 형태로 도전하기

SELECT 시도, 시군구, (KFC 스칼라 서브쿼리), (버거킹 스칼라 서브쿼리), (....)

개별 햄버거점의 주소(파파이스, 맘스터치 제외하고 계산)
SELECT ROWNUM, sido, sigungu, city_idx
FROM
    (SELECT sido, sigungu, ROUND((kfc+mac+bk)/lot, 2) city_idx
    FROM
        (SELECT sido, sigungu,
                NVL(SUM(CASE WHEN gb = '롯데리아' THEN 1 END), 1) lot, NVL(SUM(CASE WHEN gb = 'KFC' THEN 1 END), 0) kfc,
                NVL(SUM(CASE WHEN gb = '맥도날드' THEN 1 END), 0) mac, NVL(SUM(CASE WHEN gb = '버거킹' THEN 1 END), 0) bk
        FROM fastfood
        WHERE gb IN('버거킹', 'KFC', '맥도날드', '롯데리아')
        GROUP BY sido, sigungu)
    ORDER BY city_idx DESC);