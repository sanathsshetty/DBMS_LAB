SQL> CREATE TABLE BRANCH(
BRANCH_ID VARCHAR(10),
BANK_NAME VARCHAR(15),
BRANCH_NAME VARCHAR(20),
ASSETS INT NOT NULL,
PRIMARY KEY(BRANCH_ID)
);
Table created.

SQL> DESC BRANCH;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 BRANCH_ID                                 NOT NULL VARCHAR2(10)
 BANK_NAME                                          VARCHAR2(15)
 BRANCH_NAME                                        VARCHAR2(20)
 ASSETS                                    NOT NULL NUMBER(38)

SQL> CREATE TABLE CUSTOMER(
CUSTOMER_ID VARCHAR(10),
CUSTOMER_NAME VARCHAR(20),
CUSTOMER_AGE INT,
CUSTOMER_ADDRESS VARCHAR(20),
CUSTOMER_PHONE INT,
PRIMARY KEY(CUSTOMER_ID)
);

Table created.

SQL> DESC CUSTOMER;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CUSTOMER_ID                               NOT NULL VARCHAR2(10)
 CUSTOMER_NAME                                      VARCHAR2(20)
 CUSTOMER_AGE                                       NUMBER(38)
 CUSTOMER_ADDRESS                                   VARCHAR2(20)
 CUSTOMER_PHONE                                     NUMBER(38)

SQL> CREATE TABLE ACCOUNT(
ACC_NO INT,
BRANCH_ID VARCHAR(10),
ACCOUNT_TYPE VARCHAR(10),
ACCOUNT_BALANCE INT,
CUSTOMER_ID VARCHAR(10),
PRIMARY KEY(ACC_NO),
FOREIGN KEY (BRANCH_ID) REFERENCES BRANCH(BRANCH_ID) ON DELETE CASCADE,
FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE
);
Table created.

SQL> DESC ACCOUNT;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ACC_NO                                    NOT NULL NUMBER(38)
 BRANCH_ID                                          VARCHAR2(10)
 ACCOUNT_TYPE                                       VARCHAR2(10)
 ACCOUNT_BALANCE                                    NUMBER(38)
 CUSTOMER_ID                                        VARCHAR2(10)

SQL> CREATE TABLE LOAN(
LOAN_NUMBER VARCHAR2(5),
BRANCH_ID VARCHAR(10),
AMOUNT INT,
CUSTOMER_ID VARCHAR(10),
PRIMARY KEY(LOAN_NUMBER),
FOREIGN KEY (BRANCH_ID) REFERENCES BRANCH(BRANCH_ID) ON DELETE CASCADE,
FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE);

Table created.
SQL> DESC LOAN;
 SQL> desc loan
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 LOAN_NUMBER                               NOT NULL VARCHAR2(5)
 BRANCH_ID                                          VARCHAR2(10)
 AMOUNT                                             NUMBER(38)
 CUSTOMER_ID                                        VARCHAR2(10)



INSERT INTO BRANCH VALUES('B1',' CANARA','MANGALURU',60000000);
INSERT INTO BRANCH VALUES('B2',' BANK OF BARODA','MANGALURU',70000000);
INSERT INTO BRANCH VALUES('B3',' CANARA','KASARAGOD',50000000);
INSERT INTO BRANCH VALUES('B4',' SBI','BENGALURU',30000000);
INSERT INTO BRANCH VALUES('B5',' UNION BANK','DELHI',20000000);



SQL> SELECT * FROM BRANCH;

BRANCH_ID  BANK_NAME       BRANCH_NAME              ASSETS
---------- --------------- -------------------- ----------
B1          CANARA         MANGALURU              60000000
B2         BANK OF BARODA  MANGALURU              70000000
B3         CANARA          KASARAGOD              50000000
B4         SBI             BENGALURU              30000000
B5         UNION BANK      DELHI                  20000000


INSERT INTO CUSTOMER VALUES('C1','RAVI',22,'MANGALURU',8745263);
INSERT INTO CUSTOMER VALUES('C2','ASHA',22,'DELHI',98745641);
INSERT INTO CUSTOMER VALUES('C3','VARUN',22,'KASARGOD',78954623);
INSERT INTO CUSTOMER VALUES('C4','ARPITHA',22,'MANGALURU',9856325);
INSERT INTO CUSTOMER VALUES('C5','SACHIN',22,'BENGALURU',78541365);

SQL> SELECT * FROM CUSTOMER;

CUSTOMER_I CUSTOMER_NAME        CUSTOMER_AGE CUSTOMER_ADDRESS     CUSTOMER_PHONE
---------- -------------------- ------------ -------------------- --------------
C1         RAVI                           22 MANGALURU                   8745263
C2         ASHA                           26 DELHI                      98745641
C3         VARUN                          23 KASARGOD                   78954623
C4         ARPITHA                        22 MANGALURU                   9856325
C5         SACHIN                         23 BENGALORE                  78541365

INSERT INTO ACCOUNT VALUES(123,'B1','SAVINGS',10000,'C1');
INSERT INTO ACCOUNT VALUES(456,'B5','RECURRING',20000,'C2');
INSERT INTO ACCOUNT VALUES(789,'B1','SAVINGS',30000,'C1');
INSERT INTO ACCOUNT VALUES(1122,'B2','FD',5000,'C3');
INSERT INTO ACCOUNT VALUES(1334,'B1','SAVINGS',10000,'C4');
INSERT INTO ACCOUNT VALUES(1234,'B3','FD',90000,'C5');
INSERT INTO ACCOUNT VALUES(5876,'B4','RECURRING',80000,'C3');

SQL> SELECT * FROM ACCOUNT;

    ACC_NO BRANCH_ID  ACCOUNT_TY ACCOUNT_BALANCE CUSTOMER_I
---------- ---------- ---------- --------------- ----------
       123 B1         SAVINGS              10000 C1
       456 B5         RECURRING            20000 C2
       789 B1         SAVINGS              30000 C1
      1122 B2         FD                    5000 C3
      1334 B1         SAVINGS              10000 C4
      1234 B3         FD                   90000 C5
      5876 B4         RECURRING            80000 C3



  INSERT INTO LOAN VALUES('L1','B1',500000,'C1');
  INSERT INTO LOAN VALUES('L2','B2',500000,'C2');
  INSERT INTO LOAN VALUES('L3','B3',500000,'C3');
  INSERT INTO LOAN VALUES('L4','B2',500000,'C4');
  INSERT INTO LOAN VALUES('L5','B4',500000,'C5');
  INSERT INTO LOAN VALUES('L6','B5',500000,'C2');

SQL> SELECT * FROM LOAN ;


LOAN_ BRANCH_ID      AMOUNT CUSTOMER_I
----- ---------- ---------- ----------
L1    B1             500000 C1
L2    B2              50000 C2
L3    B3              40000 C3
L4    B2             565000 C4
L5    B4             955000 C5
L6    B5              20000 C2


QUERY 1
Find all the customers who have at least one account at the “Mangaluru” branch.

SELECT C.CUSTOMER_ID,C.CUSTOMER_NAME FROM CUSTOMER C,ACCOUNT A,BRANCH B
WHERE B.BRANCH_NAME='MANGALURU'AND B.BRANCH_ID=A.BRANCH_ID 
AND A.CUSTOMER_ID=C.CUSTOMER_ID;

CUSTOMER_I CUSTOMER_NAME
---------- --------------------
C1         RAVI
C1         RAVI
C3         VARUN
C4         ARPITHA

QUERY 2
Find all the customers who have an account at all the branches located in a specific city.

SQL>  SELECT C.CUSTOMER_ID,C.CUSTOMER_NAME,A.ACCOUNT_BALANCE FROM 
      CUSTOMER C,ACCOUNT A
      WHERE C.CUSTOMER_ID=A.CUSTOMER_ID AND 
      ACCOUNT_BALANCE=(SELECT MAX(ACCOUNT_BALANCE)FROM ACCOUNT);

CUSTOMER_I CUSTOMER_NAME        ACCOUNT_BALANCE
---------- -------------------- ---------------
C5         SACHIN                         90000

QUERY 3

Retrieve the Customer name and loan amount of a customer who borrowed a loan more than 5,00,000.

SQL> SELECT C.CUSTOMER_NAME C,L.AMOUNT FROM CUSTOMER C,LOAN L 
     WHERE C.CUSTOMER_ID=L.CUSTOMER_ID AND AMOUNT>500000;

C                        AMOUNT
-------------------- ----------
ARPITHA                  565000
SACHIN                   955000

QUERY 4

Retrieve the details of bank branch with maximum and minimum assets among the various branches.

SQL> SELECT BANK_NAME,BRANCH_NAME,ASSETS FROM BRANCH
WHERE ASSETS=(SELECT MAX(ASSETS)FROM BRANCH)
UNION
SELECT BANK_NAME,BRANCH_NAME,ASSETS FROM BRANCH
WHERE ASSETS=(SELECT MIN(ASSETS)FROM BRANCH);

BANK_NAME       BRANCH_NAME              ASSETS
--------------- -------------------- ----------
BANK OF BARODA  MANGALURU              70000000
UNION BANK      DELHI                  20000000

QUERY 5

Demonstrate how you delete all account tuples at every branch located in a specific city.

DELETE FROM BRANCH WHERE BRANCH_NAME='DELHI';
