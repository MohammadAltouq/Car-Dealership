CREATE TABLE "car_details" (
  "idcar" SERIAL PRIMARY KEY,
  "make" VARCHAR(50),
  "model" VARCHAR(50),
  "year" DATE,
  "color" VARCHAR(50),
  "VIN" VARCHAR(50)
);

CREATE TABLE "customer" (
  "idcustomer" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "phone" INTEGER,
  "address" VARCHAR(100)
);
CREATE TABLE "staff" (
  "idstaff" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "sales" BOOLEAN,
  "mechanic" BOOLEAN
);
CREATE TABLE "record" (
  "idrecord" INTEGER PRIMARY KEY,
  "ownership" VARCHAR(50),
  "date" timestamp without time zone,
  "idcustomer" INTEGER REFERENCES "customer"("idcustomer"),
  "idcar" INTEGER REFERENCES "car_details"("idcar")
);
CREATE TABLE "inventory" (
  "idrecord" SERIAL PRIMARY KEY,
  "ownership" VARCHAR(50),
  "date" timestamp without time zone,
  "idcustomer" INTEGER REFERENCES "customer"("idcustomer"),
  "idcar" INTEGER REFERENCES "car_details"("idcar")
);
CREATE TABLE "sales" (
  "idsales" SERIAL PRIMARY KEY,
  "date" timestamp without time zone,
  "price" NUMERIC(8,2),
  "idstaff" INTEGER REFERENCES "staff"("idstaff"),
  "idrecord" INTEGER REFERENCES "record"("idrecord")
);

CREATE TABLE "service_invoice" (
  "idinvoice" SERIAL PRIMARY KEY,
  "DATE" timestamp without time zone,
  "service" TEXT,
  "TOTAL" NUMERIC(8,2),
  "idstaff" INTEGER REFERENCES "staff"("idstaff"),
  "idrecord" INTEGER REFERENCES "record"("idrecord")
);

ALTER TABLE customer ALTER COLUMN phone TYPE VARCHAR(20);

CREATE TABLE "mechanic_record" (
  "mrecord" SERIAL PRIMARY KEY,
  "idinvoice" INTEGER REFERENCES "service_invoice"("idinvoice"),
  "idstaff" INTEGER REFERENCES "staff"("idstaff")
);
DROP TABLE "service_invoice"
CASCADE;
CREATE TABLE "service_invoice" (
  "idinvoice" SERIAL PRIMARY KEY,
  "DATE" timestamp without time zone,
  "service" TEXT,
  "TOTAL" NUMERIC(8,2),
  "idrecord" INTEGER REFERENCES "record"("idrecord")
);
ALTER TABLE record DROP COLUMN ownership;
ALTER TABLE inventory DROP COLUMN ownership;
