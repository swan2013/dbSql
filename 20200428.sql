������ ���� �ǽ� join0_3]����
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500 AND empno > 7600;

������ ���� �ǽ� join0_4]����
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING(deptno)
WHERE sal > 2500 AND empno > 7600 AND dname = 'RESEARCH';

������ ���� �ǽ� join1]
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);

SELECT prod_lgu, lprod_nm, prod_id, prod_name
FROM prod JOIN (SELECT lprod_gu prod_lgu, lprod_id, lprod_nm FROM lprod) lprod USING(prod_lgu);

������ ���� �ǽ� join2]
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer);

���� ����]
SELECT COUNT(*)
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer;
    
SELECT COUNT(*)
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer);

BUYER_NAME �� �Ǽ� ��ȸ ���� �ۼ�]
SELECT buyer_name,
        COUNT(*)
FROM buyer, prod
WHERE buyer.buyer_id = prod.prod_buyer
GROUP BY buyer_name;

SELECT buyer_name,
        COUNT(*)
FROM buyer JOIN prod ON(buyer.buyer_id = prod.prod_buyer)
GROUP BY buyer_name;

������ ���� �ǽ� join3]
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
            
���� ����
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

cycle : �����ֱ�
cid : �� id
pid : ��ǰ id
day : �������� (�Ͽ���-1, ������-2 ȭ����...)
cnt : ����
SELECT *
FROM cycle;

������ ���� �ǽ� join4]
SELECT *
FROM customer JOIN cycle USING(cid)
WHERE cnm IN('brown', 'sally');

������ ���� �ǽ� join5]
SELECT cycle.cid, cnm, cycle.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND cnm IN('brown', 'sally');
  
������ ���� �ǽ� join6]
SELECT cycle.cid, cnm, cycle.pid, pnm, SUM(cnt)cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)
              JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.cid, cnm, cycle.pid, pnm;

��]
SELECT cycle.cid, cnm, cycle.pid, pnm, cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)
              JOIN product ON(cycle.pid = product.pid);

������ ���� �ǽ� join7]
SELECT cycle.pid, pnm, SUM(cnt)cnt
FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, pnm;

8~13�� ����
SELECT *
FROM jobs;