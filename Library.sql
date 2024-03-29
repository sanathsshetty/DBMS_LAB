CREATE TABLE PUBLISHER (
NAME VARCHAR2(20) PRIMARY KEY,
ADDRESS VARCHAR2(20),
PHONE NUMBER(10));

INSERT INTO PUBLISHER VALUES('Pearson', 'London', 9874522224);
INSERT INTO PUBLISHER VALUES('TataMcGraw', 'NewYork', 9858523565);
INSERT INTO PUBLISHER VALUES('Oxford', 'UK', 9885121112);
INSERT INTO PUBLISHER VALUES('Cambridge', 'UK', 9785634615);
INSERT INTO PUBLISHER VALUES('OReilly', 'California', 9994125455);

SELECT * FROM PUBLISHER;


CREATE TABLE BOOK(
BOOK_ID VARCHAR2(20) PRIMARY KEY,
TITLE VARCHAR2(40),
PUBLISHER_NAME VARCHAR2(20) REFERENCES PUBLISHER(NAME) ON DELETE CASCADE,
PUB_YEAR INT
);


INSERT INTO BOOK VALUES('B101', 'DBMS', 'Pearson', 2017);
INSERT INTO BOOK VALUES('B102', 'AIML', 'TataMcGraw', 2009);
INSERT INTO BOOK VALUES('B103', 'DCN', 'Pearson', 2017);
INSERT INTO BOOK VALUES('B104', 'ATC', 'Oxford', 2017);
INSERT INTO BOOK VALUES('B105', 'Python', 'OReilly', 2014);
INSERT INTO BOOK VALUES('B106', 'Hadoop', 'Pearson', 2000);

SELECT * FROM BOOK;


CREATE TABLE BOOK_AUTHORS(
BOOK_ID VARCHAR(20),
AUTHOR_NAME VARCHAR2(20),
PRIMARY KEY(BOOK_ID, AUTHOR_NAME),
FOREIGN KEY(BOOK_ID) REFERENCES BOOK ON DELETE CASCADE
);

INSERT INTO BOOK_AUTHORS VALUES('B101', 'Elmarsi');
INSERT INTO BOOK_AUTHORS VALUES('B101', 'Navathe');
INSERT INTO BOOK_AUTHORS VALUES('B101', 'Ramakrishnan');
INSERT INTO BOOK_AUTHORS VALUES('B106', 'Douglas');
INSERT INTO BOOK_AUTHORS VALUES('B102', 'Elaine');
INSERT INTO BOOK_AUTHORS VALUES('B105', 'Srinivasan');

SELECT * FROM BOOK_AUTHORS;

CREATE TABLE LIBRARY_PROGRAMME(
PROGRAMME_ID VARCHAR(20) PRIMARY KEY,
PROGRAMME_NAME VARCHAR(10),
ADDRESS VARCHAR(20));

INSERT INTO LIBRARY_PROGRAMME VALUES('L1','SAHYADRI','MANGALORE');
INSERT INTO LIBRARY_PROGRAMME VALUES('L2','SAPNA','MANGALORE');
INSERT INTO LIBRARY_PROGRAMME VALUES('L3','SANKALP','BANGALORE');
INSERT INTO LIBRARY_PROGRAMME VALUES('L4','PENGUIN','CHENNAI');
INSERT INTO LIBRARY_PROGRAMME VALUES('L5','AGNES','CHENNAI');

SELECT * FROM LIBRARY_PROGRAMME;

CREATE TABLE BOOK_COPIES(
BOOK_ID VARCHAR(20) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
PROGRAMME_ID VARCHAR(20) REFERENCES LIBRARY_PROGRAMME(PROGRAMME_ID) ON DELETE CASCADE,
NO_OF_COPIES NUMBER(2),
PRIMARY KEY (BOOK_ID,PROGRAMME_ID));

INSERT INTO BOOK_COPIES VALUES('B101','L1',99);
INSERT INTO BOOK_COPIES VALUES('B102','L1',99);
INSERT INTO BOOK_COPIES VALUES('B102','L2',99);
INSERT INTO BOOK_COPIES VALUES('B103','L1',99);

SELECT * FROM BOOK_COPIES;

CREATE TABLE BOOK_LENDING(
BOOK_ID VARCHAR(20),
PROGRAMME_ID VARCHAR(20),
CARD_NO VARCHAR(20),
DATE_OUT DATE,
DUE_DATE DATE,
PRIMARY KEY (PROGRAMME_ID, BOOK_ID, CARD_NO),
FOREIGN KEY(BOOK_ID)
REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
FOREIGN KEY (PROGRAMME_ID)
REFERENCES LIBRARY_PROGRAMME(PROGRAMME_ID) ON DELETE CASCADE,
CONSTRAINT ck1 CHECK (DUE_DATE>DATE_OUT));

INSERT INTO BOOK_LENDING VALUES('B101', 'L1', 'FA101', '02-JAN-21', '09-JAN-21');
INSERT INTO BOOK_LENDING VALUES('B101', 'L1', 'FA102', '02-MAR-23', '09-MAR-23');
INSERT INTO BOOK_LENDING VALUES('B102', 'L1', 'FA102', '02-MAR-23', '09-MAR-23');
INSERT INTO BOOK_LENDING VALUES('B101', 'L2', 'FA102', '02-MAR-23', '09-MAR-23');
INSERT INTO BOOK_LENDING VALUES('B101', 'L1', 'S103', '04-APR-22', '30-JUN-22');

SELECT * FROM BOOK_LENDING;


********************************* Query ********************************

Query 1 :
SELECT B.BOOK_ID,TITLE,PUBLISHER_NAME,AUTHOR_NAME,NO_OF_COPIES FROM BOOK B, BOOK_AUTHORS A, BOOK_COPIES BC
WHERE B.BOOK_ID = BC.BOOK_ID AND B.BOOK_ID = A.BOOK_ID;

Query 2:
SELECT CARD_NO FROM BOOK_LENDING
WHERE DATE_OUT
BETWEEN '01-JAN-2023' AND '30-JUN-2023'
GROUP BY CARD_NO HAVING COUNT(*)>=3;

Query 3:
DELETE FROM BOOK WHERE BOOK_ID=&bid; //&bid is used to give input during execution

Query 4:
CREATE TABLE BOOK1(
BOOK_ID VARCHAR(40) PRIMARY KEY,
TITLE VARCHAR(40),
PUBLISHER_NAME VARCHAR(20) references
PUBLISHER(NAME) on delete cascade,
PUB_YEAR INT)
PARTITION BY RANGE(PUB_YEAR)
(PARTITION p1 VALUES LESS THAN(2001),
PARTITION p2 VALUES LESS THAN(2005),
PARTITION p3 VALUES LESS THAN(2010),
PARTITION p4 VALUES LESS THAN(MAXVALUE));

INSERT INTO BOOK1 VALUES ('B101','DBMS','Pearson',2017);
INSERT INTO BOOK1 VALUES ('B102','AIML','TataMcGraw',2009);
INSERT INTO BOOK1 VALUES ('B103','DCN','Pearson',2017);
INSERT INTO BOOK1 VALUES ('B104','ATC','Oxford',2017);
INSERT INTO BOOK1 VALUES ('B105','Python','OReilly',2014);
INSERT INTO BOOK1 VALUES ('B106','Hadoop','Pearson',2000);

SELECT * FROM BOOK1 PARTITION(P1);
SELECT * FROM BOOK1 PARTITION(P2);
SELECT * FROM BOOK1 PARTITION(P3);
SELECT * FROM BOOK1 PARTITION(P4);
