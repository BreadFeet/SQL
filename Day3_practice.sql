/* id01의 cart 정보를 출력하시오
날짜 사용자이름 제품이름 금액 수량 총금액 */
SELECT ct.regdate, c.name AS cust_name, i.name AS item_name, price, qty, price*qty AS total_price
FROM cart ct JOIN customer c on ct.id=c.id
             JOIN item i on ct.id2=i.id
WHERE ct.id = 'id01';   


/* 쇼핑몰 ERD 나머지 구축하기 */
/* 구매정보 */
DROP TABLE IF EXISTS orderlist;
CREATE TABLE orderlist(
	order_id CHAR(19),           # 12345678/2021-08-04 19자리
	user_id VARCHAR(10),
	order_price INT NOT NULL
);

ALTER TABLE orderlist ADD PRIMARY KEY(order_id);
ALTER TABLE orderlist ADD CONSTRAINT FOREIGN KEY(user_id) REFERENCES customer(user_id);

INSERT INTO orderlist VALUES('12341234/2021-08-04', 'id01', 65000);


/* 구매상세 */
DROP TABLE IF EXISTS od_detail;
CREATE TABLE od_detail(
	order_id CHAR(19),
	item_id INT,
	detail_qty INT,
	price INT,
	detail_price INT
);

ALTER TABLE od_detail ADD PRIMARY KEY(order_id, item_id);
ALTER TABLE od_detail ADD CONSTRAINT FOREIGN KEY(order_id) REFERENCES orderlist(order_id);
ALTER TABLE od_detail ADD CONSTRAINT FOREIGN KEY(item_id) REFERENCES item(item_id);
ALTER TABLE od_detail ALTER COLUMN detail_qty SET DEFAULT 1;
ALTER TABLE od_detail MODIFY price INT NOT NULL;
ALTER TABLE od_detail MODIFY detail_price INT NOT NULL;

INSERT INTO od_detail(order_id, item_id, price, detail_price) VALUES('12341234/2021-08-04', 10, 10000, 10000);
INSERT INTO od_detail(order_id, item_id, price, detail_price) VALUES('12341234/2021-08-04', 11, 55000, 55000);

SELECT * FROM purchase;


/* 찜한 상품 */
DROP TABLE IF EXISTS wish;
CREATE TABLE wish(
	user_id VARCHAR(10),
	item_id INT,
	wish_regdate DATE,
	price INT NOT NULL
);

ALTER TABLE wish ADD PRIMARY KEY(user_id, item_id);
ALTER TABLE wish ADD CONSTRAINT FOREIGN KEY(user_id) REFERENCES customer(user_id);
ALTER TABLE wish ADD CONSTRAINT FOREIGN KEY(item_id) REFERENCES item(item_id);
ALTER TABLE wish ALTER COLUMN wish_regdate SET DEFAULT CURDATE();

INSERT INTO wish VALUES('id04', 101, '2021-08-01', 23000);
INSERT INTO wish(user_id, item_id, price) VALUES('id05', 102, 100000);

SELECT * FROM wish;

SELECT * FROM information_schema.table_constraints WHERE table_name='wish';   # constraint 이름 확인


/* 제품 순위 */
DROP TABLE IF EXISTS ranking;
CREATE TABLE ranking(
	item_id INT,
	likes INT
);

ALTER TABLE ranking ADD PRIMARY KEY(item_id);
ALTER TABLE ranking ADD CONSTRAINT FOREIGN KEY(item_id) REFERENCES item(item_id);
ALTER TABLE ranking MODIFY likes INT NOT NULL;

INSERT INTO ranking VALUES(100, 55);
INSERT INTO ranking VALUES(101, 30);
INSERT INTO ranking VALUES(10, 17);