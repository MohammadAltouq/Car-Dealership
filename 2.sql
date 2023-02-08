CREATE OR REPLACE FUNCTION staffAdd(
	_first_name VARCHAR(50),
	_last_name VARCHAR(50),
	_sales BOOLEAN,
	_mechanic BOOLEAN
)
RETURNS void
AS $MAIN$ 
BEGIN
	INSERT INTO staff( first_name, last_name, sales, mechanic)
	VALUES (_first_name, _last_name, _sales, _mechanic);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT staffAdd('Jane', 'Bennett', False, True);

SELECT *
FROM staff;

CREATE OR REPLACE FUNCTION customeradd(
	_first_name VARCHAR(50),
	_last_name VARCHAR(50),
	_phone VARCHAR(20),
	_address VARCHAR(100)
)
RETURNS void
AS $MAIN$ 
BEGIN
	INSERT INTO customer( first_name, last_name, phone, address)
	VALUES (_first_name, _last_name, _phone, _address);
END;
$MAIN$
LANGUAGE plpgsql;

INSERT INTO customer(idcustomer, first_name, last_name, phone, address)
VALUES (0, 'dealership owned', 'NONE', 'NONE', 'NONE');

SELECT customeradd('Tammy','Sanders','657282285970','47 MySakila Drive');
SELECT customeradd('Lori','Wood','465887807014','28 MySQL Boulevard');
SELECT customeradd('Marilyn','Ross','407752414682','23 Workhaven Lane');
SELECT customeradd('Kathryn','Coleman','949312333307','1795 Santiago de Compostela Way');
SELECT customeradd('Louise','Jenkins','990911107354','613 Korolev Drive');
SELECT customeradd('Sara','Perry','517338314235','1566 Inegl Manor');
SELECT customeradd('Jacqueline','Long','695479687538','692 Joliet Street');
SELECT customeradd('Wanda','Patterson','635297277345','1121 Loja Avenue');
SELECT customeradd('Julia','Flores','648856936185','1913 Hanoi Way');
SELECT customeradd('Lois','Washington','380657522649','1411 Lillydale Drive');

SELECT *
FROM customer;

CREATE OR REPLACE FUNCTION car_detailsadd( 
	_make VARCHAR(50),
	_model VARCHAR(50),
	__year date,
	_color VARCHAR(50),
	_vin VARCHAR(50)
)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO car_details(make, model, _year, color, vin)
	VALUES (_make, _model, __year, _color, _vin);
END
$MAIN$
LANGUAGE plpgsql;  

SELECT *
FROM car_details;

SELECT car_detailsadd('Ford', 'F-150', '2014-01-01', 'Red', '1FTMF1EM0EKG48550');
SELECT car_detailsadd('Acura', 'TSX', '2017-01-01', 'blue', '19UUA9F30E0015093');
SELECT car_detailsadd('Acura', 'MDX', '2015-01-01', 'white', '19UUA765371018427');
SELECT car_detailsadd('Audi', 'A-4', '2016-01-01', 'silver', 'WAURGAFR0C0017283');
SELECT car_detailsadd('BMW', '428', '2014-01-01', 'silver', '2C3CDYCJ9DH641397');
SELECT car_detailsadd('Chevrolet', 'Silverado', '2013-01-01', 'white', 'WBA3N7C53EK220207');
SELECT car_detailsadd('Dodge', 'Challenger', '2013-01-01', 'black', '1GCVKTE20DZ313787');

SELECT *
FROM record;

CREATE OR REPLACE FUNCTION record(
	_idrecord INTEGER,
	_date DATE,
	_idcustomer INTEGER,
	_idcar INTEGER
)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO record(idrecord, "date", idcustomer, idcar)
	VALUES (_idrecord, _date, _idcustomer, _idcar);
END
$MAIN$
LANGUAGE plpgsql;  

SELECT *
FROM inventory;

CREATE OR REPLACE FUNCTION inventory(
	_idrecord INTEGER,
	_date DATE,
	_idcustomer INTEGER,
	_idcar INTEGER
)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO inventory(idrecord, "date", idcustomer, idcar)
	VALUES (_idrecord, _date, _idcustomer, _idcar);
END
$MAIN$
LANGUAGE plpgsql;  



CREATE OR REPLACE PROCEDURE del_inv(
	_idrecord INTEGER
)
LANGUAGE plpgsql
AS $$ 
BEGIN
	DELETE FROM inventory
	WHERE _idrecord = idrecord;
	
	COMMIT;
END;$$

SELECT *
FROM inventory;
SELECT *
FROM car_details;

CALL del_inv(5);

SELECT inventory(3,'2022-12-02',0,1);
SELECT inventory(4,'2022-05-11',0,2);
SELECT inventory(5,'2022-8-15',1,3);
SELECT inventory(6,'2022-7-16',2,4);

SELECT *
FROM record;
SELECT *
FROM car_details;
INSERT INTO record(idrecord, "date", idcustomer, idcar)
VALUES (8, '2022-03-04', 3, 5);
INSERT INTO record(idrecord, "date", idcustomer, idcar)
VALUES (9, '2022-04-14', 4, 6);
INSERT INTO record(idrecord, "date", idcustomer, idcar)
VALUES (11, '2022-07-12', 5, 7);

INSERT INTO sales(idsales, "date", price, idstaff, idrecord)
VALUES (15, '2022-12-14', 10000.20, 1, 11);
INSERT INTO sales(idsales, "date", price, idstaff, idrecord)
VALUES (16, '2022-11-12',8000.88, 2, 9);

INSERT INTO mechanic_record(mrecord,idinvoice,idstaff)
VALUES (2,1,3);
INSERT INTO mechanic_record(mrecord,idinvoice,idstaff)
VALUES (3,1,4);
INSERT INTO mechanic_record(mrecord,idinvoice,idstaff)
VALUES (4,2,3);
INSERT INTO mechanic_record(mrecord,idinvoice,idstaff)
VALUES (5,2,4);

INSERT INTO service_invoice(idinvoice,"DATE",service,"TOTAL", idrecord)
VALUES (4,'2022-05-11','Air Filter Replacement',159.22,8);
INSERT INTO service_invoice(idinvoice,"DATE",service,"TOTAL", idrecord)
VALUES (5,'2022-07-20','Oil Replacement',125.22,11);

ALTER TABLE car_details ADD COLUMN is_serviced BOOLEAN;




CREATE OR REPLACE PROCEDURE serviced()
LANGUAGE plpgsql
AS $$ 
BEGIN
	UPDATE car_details 
	SET is_serviced = true
	WHERE idcar IN(
		SELECT idcar
		FROM record
		WHERE idrecord in (
		SELECT idrecord FROM service_invoice));
		
	COMMIT;
END;$$
SELECT *
FROM car_details;
CALL serviced()