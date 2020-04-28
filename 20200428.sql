데이터 결합 실습 join0_3]과제
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500 AND empno > 7600;

데이터 결합 실습 join0_4]과제
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500 AND empno > 7600 AND dname = 'RESEARCH';

데이터 결합 실습 join1]
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);

SELECT prod_lgu, lprod_nm, prod_id, prod_name
FROM prod JOIN (SELECT lprod_gu prod_lgu, lprod_id, lprod_nm FROM lprod) lprod USING(prod_lgu);

데이터 결합 실습 join2]
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer);

행의 갯수]
SELECT COUNT(*)
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer;
    
SELECT COUNT(*)
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer);

BUYER_NAME 별 건수 조회 쿼리 작성]
SELECT buyer_name,
        COUNT(*)
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer
GROUP BY buyer_name;

SELECT buyer_name,
        COUNT(*)
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer)
GROUP BY buyer_name;

데이터 결합 실습 join3]
SELECT mem_id, mem_name, prod_name, cart_qty
FROM member,
    (SELECT *
    FROM cart, prod
    WHERE cart.cart_prod = prod.prod_id)a
WHERE member.mem_id = a.cart_member;

SELECT mem_id, mem_name, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
    AND cart.cart_prod = prod.prod_id;
    
SELECT mem_id, mem_name, prod_name, cart_qty
FROM member JOIN cart ON(member.mem_id = cart.cart_member)
            JOIN prod ON(cart.cart_prod = prod.prod_id);
            
참고 사항
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING deptno = 30;

cid :   customer id
cmm :   customer number
SELECT *
FROM customer;

pid : product id
pnm : product name
SELECT *
FROM product;

cycle : 애음주기
cid : 고객 id
pid : 제품 id
day : 애음요일 (일요일-1, 월요일-2 화요일...)
cnt : 수량
SELECT *
FROM cycle;

데이터 결합 실습 join4]
SELECT *
FROM customer JOIN cycle USING(cid)
WHERE cnm IN('brown', 'sally');

데이터 결합 실습 join5]
SELECT cycle.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND cnm IN('brown', 'sally');
  
데이터 결합 실습 join6]
SELECT cycle.cid, cnm, cycle.pid, pnm, SUM(cnt)cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)
              JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.cid, cnm, cycle.pid, pnm;

비교]
SELECT cycle.cid, cnm, cycle.pid, pnm, cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)
              JOIN product ON(cycle.pid = product.pid);

데이터 결합 실습 join7]
SELECT cycle.pid, pnm, SUM(cnt)cnt
FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, pnm;

8~13번 과제
SELECT *
FROM jobs;