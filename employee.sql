  CREATE TABLE EMPLOYEE(
  EID INT PRIMARY KEY,
  NAME VARCHAR2(20),
  ADDRESS VARCHAR2(20),
  GENDER CHAR(1) CHECK(GENDER='M' OR GENDER='F'),
  SALARY NUMBER(6),
  SUPEREID REFERENCES EMPLOYEE(EID),
  DNO NUMBER);

INSERT INTO EMPLOYEE VALUES(1,'RAHUL','MANGALURU','M',35000,1,NULL);
INSERT INTO EMPLOYEE VALUES(2,'SAHANA','MANGALURU','F',35000,1,NULL);
INSERT INTO EMPLOYEE VALUES(3,'SAGAR','BENGALURU','M',35000,1,NULL);
INSERT INTO EMPLOYEE VALUES(4,'SAGARIK','MANGALURU','M',35000,1,NULL);
INSERT INTO EMPLOYEE VALUES(5,'SAJAAN','MYSORE','M',600000,1,NULL);


SET PAGESIZE 200 LINESIZE 3000;
SELECT * FROM EMPLOYEE;


  CREATE TABLE DEPARTMENT(
  DNUM NUMBER(5) PRIMARY KEY,
  DNAME VARCHAR2(10),
  DMGR_ID REFERENCES EMPLOYEE(EID),
  MGR_START_DATE DATE);


INSERT INTO DEPARTMENT VALUES(1,'CSE',1,'2-NOV-2007');
INSERT INTO DEPARTMENT VALUES(2,'IOT',2,'2-NOV-2007');
INSERT INTO DEPARTMENT VALUES(3,'ACCOUNT',2,'2-NOV-2017');
INSERT INTO DEPARTMENT VALUES(4,'ISE',1,'2-NOV-2000');
INSERT INTO DEPARTMENT VALUES(5,'FINANCE',1,'3-NOV-2001');

 SELECT * FROM DEPARTMENT;


ALTER TABLE EMPLOYEE ADD CONSTRAINT FK FOREIGN KEY(DNO) REFERENCES DEPARTMENT(DNUM);

UPDATE EMPLOYEE SET DNO=4 WHERE EID=1;
UPDATE EMPLOYEE SET DNO=1 WHERE EID=2;
UPDATE EMPLOYEE SET DNO=3 WHERE EID=3;
UPDATE EMPLOYEE SET DNO=3 WHERE EID=4;
UPDATE EMPLOYEE SET DNO=3 WHERE EID=5;

SELECT * FROM EMPLOYEE;
CREATE TABLE DLOCATION(
DNO REFERENCES DEPARTMENT(DNUM),
LOCATION VARCHAR2(10),
PRIMARY KEY(DNO,LOCATION));

INSERT INTO DLOCATION VALUES(1,'MANGALURU');
INSERT INTO DLOCATION VALUES(1,'MYSORE');
INSERT INTO DLOCATION VALUES(2,'MANGALURU');
INSERT INTO DLOCATION VALUES(3,'BENGALURU');
INSERT INTO DLOCATION VALUES(4,'MANGALURU');
INSERT INTO DLOCATION VALUES(5,'MANGALURU');


SELECT * FROM DLOCATION;

  CREATE TABLE PROJECT(
  PNUM NUMBER(2) PRIMARY KEY,
  PNAME VARCHAR2(20),
  PLOCATION VARCHAR2(20),
  DNO NUMBER REFERENCES DEPARTMENT(DNUM));



INSERT INTO PROJECT VALUES(1,'IOT','MANGALURU',1);
INSERT INTO PROJECT VALUES(2,'DATA MINING','MANGALURU',1);
INSERT INTO PROJECT VALUES(3,'CC','HUBLI',3);
INSERT INTO PROJECT VALUES(4,'IMAGE PROCESSING','MANGALURU',4);
INSERT INTO PROJECT VALUES(5,'RESEARCH','MANGALURU',5);

SELECT * FROM PROJECT;


CREATE TABLE DEPENDENT(
EMPID INT CONSTRAINT DEP_EMPID_PK PRIMARY KEY,
DEP_NAME VARCHAR2(12),
 GENDER VARCHAR2(5),
BDATE DATE,
RELATIONSHIP VARCHAR2(12), 
FOREIGN KEY(EMPID)REFERENCES EMPLOYEE(EID) ON DELETE CASCADE);


INSERT INTO DEPENDENT VALUES(1,'SHREYA','F','22-JAN-75','WIFE');
INSERT INTO DEPENDENT VALUES(2,'AKASH','M','15-JUN-77','BROTHER');
INSERT INTO DEPENDENT VALUES(3,'PRIYA','F','10-SEP-80','SISTER');
INSERT INTO DEPENDENT VALUES(4,'NIKHIL','M','02-FEB-79','FATHER');
INSERT INTO DEPENDENT VALUES(5,'AKSHA','F','30-OCT-75','MOTHER');
SELECT * FROM DEPENDENT;




CREATE TABLE WORKSON(
Eid NUMBER(5) REFERENCES employee(EID),
Pno NUMBER(2) REFERENCES project (Pnum),HOURS number(5,2),
primary key(Eid,Pno));

INSERT INTO WORKSON VALUES(1,1,4);
INSERT INTO WORKSON VALUES(2,1,5);
INSERT INTO WORKSON VALUES(3,2,4);
INSERT INTO WORKSON VALUES(4,3,4);
INSERT INTO WORKSON VALUES(5,5,4);


      
QUERIE1:-
SELECT PNO FROM WORKSON WHERE EID IN
(SELECT EID FROM EMPLOYEE WHERE NAME='RAHUL')
UNION SELECT PNUM FROM PROJECT WHERE DNO IN
(SELECT DNUM FROM DEPARTMENT WHERE DMGR_ID IN
(SELECT EID FROM EMPLOYEE WHERE NAME ='RAHUL'));


QUERY 2:-
SELECT EID,NAME,SALARY,SALARY+0.1*SALARY AS UPDATED_SALARY
FROM EMPLOYEE
WHERE EID IN 
(SELECT EID FROM WORKSON WHERE PNO IN(
SELECT PNUM FROM PROJECT WHERE PNAME='IOT'));



QUERY 3:-
SELECT SUM(SALARY),AVG(SALARY),MAX(SALARY),MIN(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE D.Dnum=E.Dno AND Dname='ACCOUNT';


QUERY 4:-
SELECT Eid ,NAME FROM EMPLOYEE E WHERE NOT EXISTS(
(SELECT PNUM FROM PROJECT WHERE Dno=5) MINUS
(SELECT Pno FROM WORKSON W WHERE W.Eid=E.Eid));


QUERY 5:-
CREATE VIEW DEPTINFO (NAME,COUNT_EMP,SUM_SAL)AS
SELECT D.DNAME, COUNT(*),SUM(SALARY)
FROM DEPARTMENT D INNER JOIN EMPLOYEE E
ON E.DNO = D.DNUM
GROUP BY D.DNAME;

SELECT * FROM DEPTINFO;
