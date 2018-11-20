-- 1.1 Database Creation
CREATE TABLE Hotel
(
	hotelNo CHAR(3),
	hotelName VARCHAR(30) NOT NULL,
	city VARCHAR(20),
	phoneNo CHAR(7),
	PRIMARY KEY (hotelNo)
);

CREATE TABLE Room
(
	roomNo CHAR(3),
	hotelNo CHAR(3),
	type CHAR(1),
	price DECIMAL(6,2),
	PRIMARY KEY (hotelNo, roomNo),
	FOREIGN KEY (hotelNo) REFERENCES Hotel
);

CREATE TABLE Guest
(
	guestNo CHAR(4),
	guestName VARCHAR(30),
	guestAddress VARCHAR(50),
	PRIMARY KEY (guestNo)
);

CREATE TABLE Booking
(
	hotelNo CHAR(3),
	guestNo CHAR(4),
	dateFrom DATE,
	dateTo  DATE,
	roomNo CHAR(3),
	PRIMARY KEY (hotelNo, guestNo, dateFrom),
	FOREIGN KEY (guestNo) REFERENCES Guest,
	FOREIGN KEY (hotelNo, roomNo) REFERENCES Room,
	CHECK (dateTo >= dateFrom)
);


-- 1.2 Database Population
INSERT INTO Hotel VALUES ('H1', 'Grosvenor', 'London', '4335252');
INSERT INTO Hotel VALUES ('H2', 'Raffles', 'Singapore', '6544532');
INSERT INTO Hotel VALUES ('H3', 'St.James', 'London', '4332133');

INSERT INTO Room VALUES ('001', 'H1', 'S', 200);
INSERT INTO Room VALUES ('002', 'H1', 'S', 300);
INSERT INTO Room VALUES ('003', 'H1', 'D', 350);
INSERT INTO Room VALUES ('004', 'H1', 'F', 600);
INSERT INTO Room VALUES ('001', 'H2', 'S', 300);
INSERT INTO Room VALUES ('002', 'H2', 'D', 1000);
INSERT INTO Room VALUES ('003', 'H2', 'D', 600);
INSERT INTO Room VALUES ('001', 'H3', 'S', 600);
INSERT INTO Room VALUES ('002', 'H3', 'S', 900);
INSERT INTO Room VALUES ('003', 'H3', 'S', 1000);

INSERT INTO Guest VALUES ('G1', 'William Smith', 'Gatswick, England');
INSERT INTO Guest VALUES ('G2', 'Tammy Lee', 'Clementi, Singapore');
INSERT INTO Guest VALUES ('G3', 'Jessica Lee Watts', 'Bangkok, Thailand');
INSERT INTO Guest VALUES ('G4', 'Jonas Tan', 'Jurong, Singapore');
INSERT INTO Guest VALUES ('G5', 'Lee Ming Yong', 'Woodlands, Sinagpore');

INSERT INTO Booking VALUES ('H1','G2','4 Dec 2013','10 Dec 2013','001');
INSERT INTO Booking VALUES ('H1','G1','4 Oct 2013','23 Dec 2013','002');
INSERT INTO Booking VALUES ('H2','G1','1 Oct 2014','3 Oct 2014','001');
INSERT INTO Booking VALUES ('H3','G1','4 Oct 2014','10 Oct 2014','003');
INSERT INTO Booking VALUES ('H2','G2','4 Oct 2014','14 Oct 2014','001');
INSERT INTO Booking VALUES ('H1','G3','1 Oct 2014','13 Oct 2014','001');
INSERT INTO Booking VALUES ('H2','G4','1 Oct 2014','10 Oct 2014','002');
INSERT INTO Booking VALUES ('H1','G2','4 Oct 2014','10 Oct 2014','001');
INSERT INTO Booking VALUES ('H3','G2','29 Oct 2014','23 Nov 2014','001');
INSERT INTO Booking VALUES ('H1','G3','5 Oct 2014','30 Oct 2014','002');
INSERT INTO Booking VALUES ('H1','G2','11 Sep 2014','30 Nov 2014','001');
INSERT INTO Booking VALUES ('H1','G3','11 Sep 2014','27 Dec 2014','002');
INSERT INTO Booking VALUES ('H2','G1','15 Sep 2014','16 Sep 2014','003');


-- 1.3 Add Constraint
-- a
ALTER TABLE Room ADD CONSTRAINT ROOM_TYPE_CONSTRAINT CHECK (type IN ('S', 'D', 'F'));
ALTER TABLE Room ADD CONSTRAINT ROOM_PRICE_RANGE CHECK (price BETWEEN 200 AND 1000);

-- b
ALTER TABLE Hotel ADD UNIQUE (hotelName);

-- c
ALTER TABLE Hotel ALTER COLUMN phoneNo CHAR(11);
ALTER TABLE Hotel ADD contactNo CHAR(11);
UPDATE Hotel SET contactNo = phoneNo;
ALTER TABLE Hotel DROP COLUMN phoneNo;
SELECT * FROM Hotel;

-- d
INSERT INTO hotel VALUES ('H4','Grosvenor','New York','4332133'); -- Hotel name is unique
INSERT INTO hotel VALUES ('H4',null,'San Francisco','4332133'); -- Hotel name cannot be null
INSERT INTO room VALUES ('H2', '004','P',1000); -- Room type cannot be P
INSERT INTO room VALUES ('H3', '004','S',100); -- Room price exceed range
INSERT INTO booking VALUES ('H3','G1','5 Oct 2014','10 Oct 2014',8); -- No room number 8 in Room
INSERT INTO booking VALUES ('H3','G1','4 Oct 2014','10 Oct 2014',1); -- Duplicated key: hotelNo, roomNo, dateFrom
INSERT INTO booking VALUES ('H2','G2','15 Dec 2014','18 Dec 2002',3); -- dateTo is earlier than dateFrom
INSERT INTO booking VALUES ('H2','G8','15 Dec 2014','18 Dec 2014',3); -- No G8 in Guest


-- 1.4 Remove bookings before 2014
DELETE FROM Booking WHERE (dateFrom < '1 Jan 2014');


-- 1.5 Decrease rooms priced at greater than $800 by 10%
UPDATE Room SET price = (price * 0.9) WHERE (price > 800);


-- 1.6 Increase all room prices by 10%
UPDATE Room SET price = (price * 1.1);


-- 1.7 Add city code to hotel phone numbers
UPDATE Hotel SET contactNo = CONCAT('+44', contactNo) WHERE city = 'London';
UPDATE Hotel SET contactNo = CONCAT('+65', contactNo) WHERE city = 'Singapore';


-- 1.8 Insert into booking
INSERT INTO Booking VALUES ('H2', 'G1', '2015-01-15', NULL, '003');