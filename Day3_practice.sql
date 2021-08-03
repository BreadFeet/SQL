/* id01의 cart 정보를 출력하시오
날짜 사용자이름 제품이름 금액 수량 총금액 */
SELECT ct.regdate, c.name AS cust_name, i.name AS item_name, price, qty, price*qty AS total_price
FROM cart ct JOIN customer c on ct.id=c.id
             JOIN item i on ct.id2=i.id
WHERE ct.id = 'id01';   


/* 쇼핑몰 ERD 구축하기 */
/* 구매이력 */
DROP TABLE IF EXISTS purchase;
CREATE TABLE purchase(
	p_id INT,
	id VARCHAR(10),
	id2 INT,
	p_qty INT,
	price INT,
	p_price INT
);

ALTER TABLE purchase ADD PRIMARY KEY(p_id);
ALTER TABLE purchase MODIFY p_id INT AUTO_INCREMENT;
ALTER TABLE purchase ADD CONSTRAINT FOREIGN KEY(id) REFERENCES customer(id);
ALTER TABLE purchase ADD CONSTRAINT FOREIGN KEY(id2) REFERENCES item(id);
ALTER TABLE purchase MODIFY p_qty INT NOT NULL;
ALTER TABLE purchase MODIFY price INT NOT NULL;

INSERT INTO purchase(id, id2, p_qty, price, p_price)
VALUES('id03', 1000, 2, 20000, 40000);

SELECT * FROM purchase;


/* 찜한 상품 */
DROP TABLE IF EXISTS wish;
CREATE TABLE wish(
	id VARCHAR(10),
	id2 INT,
	regdate DATE,
	price INT
);

ALTER TABLE wish ADD PRIMARY KEY(id, id2);
ALTER TABLE wish ADD CONSTRAINT FOREIGN KEY(id) REFERENCES customer(id);
ALTER TABLE wish ADD CONSTRAINT FOREIGN KEY(id2) REFERENCES item(id);

INSERT INTO wish VALUES('id04', 1002, CURDATE(), 100000);
SELECT * FROM wish;

