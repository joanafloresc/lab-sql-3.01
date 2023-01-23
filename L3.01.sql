DROP DATABASE IF EXISTS bank_demo;

CREATE DATABASE bank_demo;

USE bank_demo;

DROP TABLE IF EXISTS district_demo;

CREATE TABLE IF NOT EXISTS district_demo (
district_id int UNIQUE,
district_name varchar(50),
region_name varchar(50),
population int,
average_salary float
);

SELECT * FROM district_demo;

INSERT INTO district_demo (district_id, district_name, region_name, population, average_salary) 
VALUES
(1,'Hl.m. Praha','Prague',123456,159);

SELECT * FROM district_demo;

-- multiple rows, type interpretation, appends, does not override
INSERT INTO district_demo(district_id, district_name, region_name, population, average_salary) 
VALUES
(2,'Benesov','central Bohemia',87756.33,'234'),
(3,'Beroun','central Bohemia',84623,149);

SELECT * FROM district_demo;

-- atomicity of statement, irreconcilable type interpretations
INSERT INTO district_demo(district_id, district_name, region_name, population, average_salary)
VALUES
(4,'Kladno','central Bohemia',2000,130),
(5,'Hl.p. Praha','Prague','over nine million',251);

SELECT * FROM district_demo;

-- no constraints
INSERT INTO district_demo(district_id, district_name, region_name, population, average_salary) 
VALUES
(1,'Hl.m. Praha','Prague',123456,159),
(2,'Benesov','central Bohemia',87756,234),
(3,'Beroun','central Bohemia',84623,149),
(4,'Kladno','central Bohemia',20000,130);

SELECT * FROM district_demo;

DROP TABLE IF EXISTS district_demo;

-- contraints on content
CREATE TABLE IF NOT EXISTS district_demo (
district_id SERIAL,
district_name varchar(50) UNIQUE NOT NULL,
region_name varchar(50) DEFAULT NULL,
population int DEFAULT 0,
average_salary float DEFAULT NULL
);

SELECT * FROM district_demo;

INSERT INTO district_demo(district_name, region_name, population, average_salary) 
VALUES
('Hl.m. Praha','Prague',123456,159),
('Benesov','central Bohemia',87756,234);

SELECT * FROM district_demo;

-- protected from duplicates
INSERT INTO district_demo(district_name, region_name, population, average_salary) 
VALUES
('Benesov','central Bohemia',87756,234),
('Beroun','central Bohemia',84623,149),
('Kladno','central Bohemia',20000,130);

-- default values. Notice SERIAL "issue"
INSERT INTO district_demo(district_name, region_name, average_salary) 
VALUES
('Beroun','central Bohemia',149),
('Kladno','central Bohemia',130);

SELECT * FROM district_demo;

-- another table and constraints..

DROP TABLE IF EXISTS account_demo;

CREATE TABLE account_demo (
  account_id SERIAL,
  district_id int DEFAULT NULL,
  frequency text,
  date int DEFAULT NULL
) ;

INSERT INTO account_demo(district_id,frequency,date) 
VALUES
(4,'POPLATEK MESICNE',950324),
(1,'POPLATEK MESICNE',930226),
(5,'POPLATEK MESICNE',970707);

SELECT * FROM account_demo;

SELECT * FROM district_demo;

SELECT * FROM district_demo as d
JOIN account_demo as a
on d.district_id = a.district_id;

-- what is the issue? REFERENTIAL INTEGRITY
DROP TABLE IF EXISTS district_demo;

-- contraints on content
CREATE TABLE IF NOT EXISTS district_demo (
district_id SERIAL PRIMARY KEY,
district_name varchar(50) UNIQUE NOT NULL,
region_name varchar(50) DEFAULT NULL,
population int DEFAULT 0,
average_salary float DEFAULT NULL
);

INSERT INTO district_demo(district_name, region_name, population, average_salary) 
VALUES
('Hl.m. Praha','Prague',123456,159),
('Benesov','central Bohemia',87756,234),
('Beroun','central Bohemia',84623,149),
('Kladno','central Bohemia',20000,130);

SELECT * FROM district_demo;

DROP TABLE IF EXISTS account_demo;

CREATE TABLE account_demo (
  account_id SERIAL PRIMARY KEY,
  district_id bigint unsigned NOT NULL,
  frequency text,
  date int DEFAULT NULL,
  CONSTRAINT FOREIGN KEY (district_id) REFERENCES district_demo(district_id)
);

SELECT * FROM district_demo;

INSERT INTO account_demo(district_id,frequency,date) 
VALUES
(4,'POPLATEK MESICNE',950324),
(1,'POPLATEK MESICNE',930226),
(5,'POPLATEK MESICNE',970707);
-- value 5 is not in distric_id

INSERT INTO account_demo(district_id,frequency,date) 
VALUES
(4,'POPLATEK MESICNE',950324),
(1,'POPLATEK MESICNE',930226),
(4,'POPLATEK MESICNE',970707);

SELECT * FROM account_demo;

SELECT *  FROM district_demo as d
JOIN account_demo as a
on d.district_id = a.district_id;
 
 
-- changing tables
ALTER TABLE account_demo
MODIFY date date;

SELECT * FROM account_demo;

ALTER TABLE account_demo
RENAME TO accountDemo;

ALTER TABLE district_demo
RENAME COLUMN district_id to dist_id;

SELECT * FROM district_demo;

INSERT INTO district_demo(district_name, region_name, population, average_salary) 
VALUES
('Hl.p. Praha','Prague',20000,130);

ALTER TABLE accountDemo
ADD COLUMN balance int AFTER date;

SELECT * FROM accountDemo;

-- watch out for defaults!
ALTER TABLE accountDemo
ADD COLUMN balance2 int NOT NULL AFTER balance;

SELECT * FROM accountDemo;


-- DELETE AND DROP

DELETE FROM accountDemo
WHERE account_id=1;

SELECT * FROM accountDemo;

DELETE FROM accountDemo;

SELECT * FROM accountDemo;

DROP TABLE accountDemo;

SELECT * FROM accountDemo;

-- UPDATE

SELECT * FROM district_demo;

UPDATE district_demo
SET population = 0, average_salary = 0
WHERE region_name = 'Prague';

SELECT * FROM district_demo;

UPDATE district_demo
SET population = 1;

SELECT * FROM district_demo;

ALTER TABLE district_demo
ADD location VARCHAR(30);

SELECT * FROM district_demo;

UPDATE district_demo set location =
  CASE
  WHEN dist_id > 3 THEN 'north' 
  ELSE 'south'
  END;

SELECT * FROM district_demo;
