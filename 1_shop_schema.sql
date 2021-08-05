/*
 CREATE TABLE----------------------------------------------------------------------
*/
/* 고객 */
DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
	user_id CHAR(5),
	pwd VARCHAR(10) NOT NULL,
	user_name VARCHAR(10) NOT NULL
);

# 제약사항 설정
ALTER TABLE customer ADD PRIMARY KEY(user_id);    # primary key는 컬럼당 1개만 지정 가능
ALTER TABLE customer ADD CONSTRAINT UNIQUE(user_name);
ALTER TABLE customer MODIFY COLUMN user_name VARCHAR(10);   # NULL 허용하도록 바꿈
ALTER TABLE customer MODIFY COLUMN user_name VARCHAR(10) NOT NULL;  # NOT NULL로 다시 변경


/* 제품 */
DROP TABLE IF EXISTS item;
CREATE TABLE item(
	item_id INT,
	item_name VARCHAR(20) NOT NULL,
	price INT NOT NULL,
	rate FLOAT,         # 할인율
	item_regdate DATE
);

# 제약사항 설정
ALTER TABLE item ADD PRIMARY KEY(item_id);
ALTER TABLE item MODIFY item_id INT AUTO_INCREMENT;
ALTER TABLE item AUTO_INCREMENT = 100;       # 시작값 지정. 1씩 증가
ALTER TABLE item ALTER COLUMN rate SET DEFAULT 3.3;
ALTER TABLE item ALTER COLUMN item_regdate SET DEFAULT CURDATE();


/* 장바구니 */
DROP TABLE IF EXISTS cart;
CREATE TABLE cart(
	user_id VARCHAR(5),
	item_id INT,
	cart_regdate DATE NOT NULL,
	cart_qty INT NOT NULL
);

ALTER TABLE cart ADD PRIMARY KEY(user_id, item_id);  # 자식의 경우 2개의 컬럼으로 primary key 1개 생성 가능
ALTER TABLE cart ADD CONSTRAINT FOREIGN KEY(user_id) REFERENCES customer(user_id); # id라는 값은  customer 테이블의 id를 가져왔다는 뜻
ALTER TABLE cart ADD CONSTRAINT FOREIGN KEY(item_id) REFERENCES item(item_id);
ALTER TABLE cart ALTER COLUMN cart_regdate SET DEFAULT CURDATE();
ALTER TABLE cart ALTER COLUMN cart_qty SET DEFAULT 1;


/* 자유게시판 */
DROP TABLE IF EXISTS board;
CREATE TABLE board(
	post_id INT,
	user_id VARCHAR(10),
	title VARCHAR(200) NOT NULL,
	content VARCHAR(2000) NOT NULL,
	post_regdate DATE,  
	cnt INT
);

ALTER TABLE board ADD PRIMARY KEY(post_id);
ALTER TABLE board MODIFY post_id INT AUTO_INCREMENT;
ALTER TABLE board AUTO_INCREMENT = 100;
ALTER TABLE board ADD CONSTRAINT FOREIGN KEY(user_id) REFERENCES customer(user_id);
ALTER TABLE board ALTER COLUMN post_regdate SET DEFAULT CURDATE();
ALTER TABLE board ALTER COLUMN cnt SET DEFAULT 0;


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
INSERT INTO item(item_name, price, item_regdate) VALUES('shirts', 20000, CURDATE());
INSERT INTO item(item_name, price, item_regdate) VALUES('bag', 30000, CURDATE());
INSERT INTO item(item_id, item_name, price) VALUES(11, 'knit', 55000);
INSERT INTO item(item_name, price, item_regdate) VALUES('jacket', 100000, NOW());
INSERT INTO item(item_name, price) VALUES('jean', 49000);


INSERT INTO cart VALUES('id01', 100, CURDATE(), 1);  # 이미 있는 user_id, item_id를 사용해야 함
INSERT INTO cart VALUES('id01', 102, CURDATE(), 2);  # PRIMARY KEY 2개가 동시에 중복되는 경우가 아니면 됨
INSERT INTO cart VALUES('id02', 100, CURDATE(), 1);
INSERT INTO cart(user_id, item_id, cart_qty) VALUES('id03', 100, 3);
INSERT INTO cart(user_id, item_id, cart_qty) VALUES('id03', 10, 1);


INSERT INTO board(user_id, title, content) VALUES('id01', 'title01', 'Hi');
INSERT INTO board(user_id, title, content, cnt) VALUES('id02', 'title02', 'Hello', 13);
INSERT INTO board(user_id, title, content) VALUES('id03', 'title03', 'Howdy');
INSERT INTO board(user_id, title, content, cnt) VALUES('id04', 'title04', 'Hi', 5);
INSERT INTO board(user_id, title, content) VALUES('id01', 'title011', 'Hi');


# 오류나는 상황
INSERT INTO customer VALUES('id01', 'pwd01', '김말숙');  # id 중복으로 불가능
INSERT INTO customer(id, pwd) VALUES('id03', 'pwd03');   # name은 NOT NULL이라 뺄 수 없다
INSERT INTO customer(id, name) VALUES('id04', '공말숙');  # pwd NOT NULL
INSERT INTO customer VALUES('id06', 'pwd05', '이말숙');  # name UNIQUE
INSERT INTO customer VALUES('id06', 'pwd06', NULL);  # UNIQUE 때문이 아니라 NOT NULL 때문


/*
 DELETE DATA---------------------------------------------------------------------------
*/
DELETE FROM item WHERE item_id = 103;
DELETE FROM customer;   # 조건(where)없이 데이터 싹 다 지움
DELETE FROM customer WHERE name is NULL;   # name = NULL은 작동 안함


/*
 UPDATE DATA---------------------------------------------------------------------------
*/
UPDATE item SET item_name='hat', price=23000, rate=5.3 WHERE item_name='bag';


/*
 SELECT DATA---------------------------------------------------------------------------
*/
SELECT * FROM customer;
SELECT * FROM item;
SELECT * FROM cart;
SELECT * FROM board;
