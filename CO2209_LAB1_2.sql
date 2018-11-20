-- 2.1 Create Employee table
CREATE TABLE Employee
(
	eid CHAR(4),
	ename VARCHAR(40),
	age INTEGER,
	salary INTEGER,
	PRIMARY KEY (eid),
	CHECK (age > 18),
	CHECK (salary >= 10000)
);


-- 2.2 Create Department table
CREATE TABLE Department
(
	did CHAR(10),
	budget INTEGER,
	managerid CHAR(4),
	PRIMARY KEY (did),
	FOREIGN KEY (managerid) REFERENCES Employee
);


-- 2.3 Create Works table
CREATE TABLE Works
(
	eid CHAR(4),
	did CHAR(10),
	pctTime INTEGER,
	PRIMARY KEY (eid, did),
	FOREIGN KEY (eid) REFERENCES Employee,
	FOREIGN KEY (did) REFERENCES Department
);


-- 2.4 Insert data
INSERT INTO EMPLOYEE VALUES ('E100','HUDSON',50,6000000);
INSERT INTO EMPLOYEE VALUES ('E101','POTTER',30,28500);
INSERT INTO EMPLOYEE VALUES ('E102','CLARK',19,14500);
INSERT INTO EMPLOYEE VALUES ('E103','JONES',20,18390);
INSERT INTO EMPLOYEE VALUES ('E201','ALLEN',28,36980);
INSERT INTO EMPLOYEE VALUES ('E202','TURNER',35,46980);
INSERT INTO EMPLOYEE VALUES ('E300','JAMES',48,76980);
INSERT INTO EMPLOYEE VALUES ('E301','WARD',19,16980);
INSERT INTO EMPLOYEE VALUES ('E400','FORD',50,10000000);
INSERT INTO EMPLOYEE VALUES ('E401','JONES',20,19020);
INSERT INTO EMPLOYEE VALUES ('E402','SCOTT',32,35660);
INSERT INTO EMPLOYEE VALUES ('E403','ADAMS',29,27880);
INSERT INTO EMPLOYEE VALUES ('E404','MILTON',37,27820);

INSERT INTO DEPARTMENT VALUES ('Hardware',2000000,'E100');
INSERT INTO DEPARTMENT VALUES ('Software',5000000,'E201');
INSERT INTO DEPARTMENT VALUES ('HR',100000,'E300');
INSERT INTO DEPARTMENT VALUES ('Finance',8000000,'E400');
 
INSERT INTO Works VALUES ('E100','Hardware',50);
INSERT INTO Works VALUES ('E101','Hardware',100);
INSERT INTO Works VALUES ('E102','Hardware',40);
INSERT INTO Works VALUES ('E103','Hardware',10);
INSERT INTO Works VALUES ('E100','Software',50);
INSERT INTO Works VALUES ('E201','Software',20);
INSERT INTO Works VALUES ('E202','Software',100);
INSERT INTO Works VALUES ('E102','Software',60);
INSERT INTO Works VALUES ('E300','HR',30);
INSERT INTO Works VALUES ('E301','HR',30);
INSERT INTO Works VALUES ('E400','Finance',100);
INSERT INTO Works VALUES ('E401','Finance',100);
INSERT INTO Works VALUES ('E201','Finance',80);
INSERT INTO Works VALUES ('E402','Finance',40);
INSERT INTO Works VALUES ('E403','Finance',40);
INSERT INTO Works VALUES ('E404','Finance',40);

SELECT * FROM Employee;
-- 2.5 Increase employee salary by 5% except managers get increased by $5000
SELECT * FROM Employee e, Department d WHERE e.eid = d.managerid; -- Selecting all manager
SELECT * FROM Employee WHERE eid NOT IN (SELECT eid FROM Employee e, Department d WHERE e.eid = d.managerid); -- Selecting all non manager
UPDATE Employee SET salary = (salary * 1.05) WHERE eid NOT IN (SELECT eid FROM Employee e, Department d WHERE e.eid = d.managerid);
UPDATE Employee SET salary = (salary + 5000) FROM Employee e, Department d WHERE e.eid = d.managerid;