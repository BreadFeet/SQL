/*
 CREATE TABLE----------------------------------------------------------------------
*/
DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
	id CHAR(5),
	pwd VARCHAR(10) NOT NULL,
	name VARCHAR(10) NOT NULL,
);

# 제약사항 설정
ALTER TABLE customer ADD PRIMARY KEY(id);    # primary key는 컬럼당 1개만 지정 가능
ALTER TABLE customer ADD CONSTRAINT UNIQUE(name);
ALTER TABLE customer MODIFY COLUMN name VARCHAR(10);   # NULL 허용하도록 바꿈
ALTER TABLE customer MODIFY COLUMN name VARCHAR(10) NOT NULL;  # NOT NULL로 다시 변경


DROP TABLE IF EXISTS item;
CREATE TABLE item(
	id INT,
	name VARCHAR(20) NOT NULL,
	price INT NOT NULL,
	rate FLOAT,         # 할인율
	regdate DATE NOT NULL
);

# 제약사항 설정
ALTER TABLE item ADD PRIMARY KEY(id);
ALTER TABLE item MODIFY id INT AUTO_INCREMENT;
ALTER TABLE item AUTO_INCREMENT = 1000;       # 시작값 지정. 1씩 증가
ALTER TABLE item ALTER COLUMN rate SET DEFAULT 3.3;


DROP TABLE IF EXISTS cart;
CREATE TABLE cart(
	id VARCHAR(5),
	id2 INT,
	regdate DATE NOT NULL,
	qty INT NOT NULL
);

ALTER TABLE cart ADD PRIMARY KEY(id, id2);  # 자식의 경우 2개의 primary key 가능
ALTER TABLE cart ADD CONSTRAINT FOREIGN KEY(id) REFERENCES customer(id); # id라는 값은  customer 테이블의 id를 가져왔다는 뜻
ALTER TABLE cart ADD CONSTRAINT FOREIGN KEY(id2) REFERENCES item(id);

CREATE TABLE board(
	b_id INT,
	id VARCHAR(10),
	title VARCHAR(200),
	content VARCHAR(2000),
	regdate DATE,
	cnt INT
);

ALTER TABLE board ADD PRIMARY KEY(b_id);
ALTER TABLE board MODIFY b_id INT AUTO_INCREMENT;
ALTER TABLE board AUTO_INCREMENT = 100;
ALTER TABLE board ALTER COLUMN cnt SET DEFAULT 0;
ALTER TABLE board ADD CONSTRAINT FOREIGN KEY(id) REFERENCES customer(id);


/*
 INSERT DATA--------------------------------------------------------------------------------------
*/

# 테이블에 데이터 넣기
INSERT INTO customer VALUES('id01', 'pwd01', '이말숙');
INSERT INTO customer VALUES('id02', 'pwd02', '김말숙');
INSERT INTO customer VALUES('id03', 'pwd03', '박말숙');
INSERT INTO customer VALUES('id04', 'pwd04', '유말숙');
INSERT INTO customer VALUES('id05', 'pwd05', '양말숙');
INSERT INTO customer VALUES('id06', 'pwd05', NULL);  # UNIQUE KEY 조건만 있으면 NULL 추가 가능
INSERT INTO customer(id, pwd) VALUES('id07', 'pwd07');


INSERT INTO item VALUES(10, 'pants', 10000, 3.3, NOW());
INSERT INTO item(name, price, regdate) VALUES('shirts', 20000, CURDATE());
INSERT INTO item(name, price, regdate) VALUES('bag', 30000, CURDATE());
INSERT INTO item(name, price, regdate) VALUES('jacket', 100000, NOW());


INSERT INTO cart VALUES('id01', 1000, CURDATE(), 1);  # 이미 있는 id, id2를 사용해야 함
INSERT INTO cart VALUES('id01', 1002, CURDATE(), 2);  # PRIMARY KEY 2개가 동시에 중복되는 경우가 아니면 됨
INSERT INTO cart VALUES('id02', 1000, CURDATE(), 1);


INSERT INTO board(id, title, content, regdate) VALUES('id05', 'test', 'Hi', CURDATE());


# 오류나는 상황
INSERT INTO customer VALUES('id01', 'pwd01', '김말숙');  # id 중복으로 불가능
INSERT INTO customer(id, pwd) VALUES('id03', 'pwd03');   # name은 NOT NULL이라 뺄 수 없다
INSERT INTO customer(id, name) VALUES('id04', '공말숙');  # pwd NOT NULL
INSERT INTO customer VALUES('id06', 'pwd05', '이말숙');  # name UNIQUE
INSERT INTO customer VALUES('id06', 'pwd06', NULL);  # UNIQUE 때문이 아니라 NOT NULL 때문


/*
 DELETE DATA---------------------------------------------------------------------------
*/
DELETE FROM item WHERE id = 1001;
DELETE FROM customer;   # 조건(where)없이 데이터 싹 다 지움
DELETE FROM customer WHERE name is NULL;   # name = NULL은 작동 안함


/*
 UPDATE DATA---------------------------------------------------------------------------
*/
UPDATE item SET name='cap', price=15000, rate=5.3 WHERE id=10;


SELECT * FROM customer;
SELECT * FROM item;
SELECT * FROM cart;
SELECT * FROM board;

