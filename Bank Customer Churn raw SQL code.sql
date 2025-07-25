-- Created database

CREATE DATABASE customer_churn;

-- Created table

CREATE TABLE churn(
	RowNumber INT,
    CustomerId	INT,
    Surname	VARCHAR(50),
    CreditScore	INT,
    Geography VARCHAR(50),
    Gender VARCHAR(50),
    Age	INT,
    Tenure	INT,
    Balance	DECIMAL(20,2),
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember INT,
    EstimatedSalary	DECIMAL(20,2),
    Exited INT,
    Complain INT,
    Satisfaction_Score INT,
    `Card Type` VARCHAR(20),
    `Point Earned` INT
    );

SELECT *
FROM churn;

-- Imported data into table

SET GLOBAL LOCAL_INFILE=1;

LOAD DATA LOCAL INFILE 'D:/Customer-Churn-Records.csv'
INTO TABLE churn
CHARACTER SET latin1  -- or try 'windows-1252'
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT @@local_infile;

-- Cleaned table & Feature engineering

SELECT balance, COUNT(balance)
FROM churn
WHERE balance = '0.00';

UPDATE churn
SET balance = NULL
WHERE balance = '0.00';

ALTER TABLE churn
MODIFY COLUMN hascrcard VARCHAR(50);

UPDATE churn
SET hascrcard = 'Yes'
WHERE hascrcard = 1;

UPDATE churn
SET hascrcard = 'No'
WHERE hascrcard LIKE 0;

ALTER TABLE churn
MODIFY COLUMN IsActiveMember VARCHAR(50);

UPDATE churn
SET IsActiveMember = 'Yes'
WHERE IsActiveMember LIKE 1;

UPDATE churn
SET IsActiveMember = 'No'
WHERE IsActiveMember LIKE 0;

ALTER TABLE churn
MODIFY COLUMN Exited VARCHAR(50);

UPDATE churn
SET Exited = 'Yes'
WHERE Exited LIKE 1;

UPDATE churn
SET Exited = 'No'
WHERE Exited LIKE 0;

ALTER TABLE churn
MODIFY COLUMN Complain VARCHAR(50);

UPDATE churn
SET Complain = 'Yes'
WHERE Complain LIKE 1;

UPDATE churn
SET Complain = 'No'
WHERE Complain LIKE 0;

ALTER TABLE churn
DROP COLUMN RowNumber;

-- Feature engineering

-- What country has the most customers? France

SELECT *
FROM churn;

SELECT geography, COUNT(geography)
FROM churn
GROUP BY geography;

-- Average credit score of customers that have and have not exited? 
-- Exited = 645; Not exited = 651

SELECT AVG(creditscore)
FROM churn
WHERE exited = 'Yes'
GROUP BY exited;

SELECT AVG(creditscore)
FROM churn
WHERE exited = 'No'
GROUP BY exited;

-- Minimum credit score of customers that have and have not exited? Exited = 350; Not exited = 405

SELECT MIN(creditscore)
FROM churn
WHERE exited = 'Yes'
GROUP BY exited;

SELECT MAX(creditscore)
FROM churn
WHERE exited = 'No'
GROUP BY exited;

-- How many customers by gender? Male = 5457; Female = 4543

SELECT gender, COUNT(gender)
FROM churn
GROUP BY gender;

-- How many customers by gender has exited? Male = 899 Female = 1139

SELECT gender, COUNT(gender)
FROM churn
WHERE exited = 'Yes'
GROUP BY gender;

SELECT exited, complain
FROM churn;

-- Querying data for further analysis

SELECT numofproducts, COUNT(numofproducts)
FROM churn
GROUP BY numofproducts
ORDER BY 1;

SELECT hascrcard, exited, COUNT(hascrcard)
FROM churn
WHERE exited = 0
GROUP BY hascrcard
ORDER BY 1 DESC;

SELECT MAX(rownumber)
FROM churn
GROUP BY rownumber
ORDER BY 1 DESC;

SELECT *
FROM churn;

SELECT gender, AVG(age)
FROM churn
GROUP BY gender;

SELECT complain, COUNT(complain)
FROM churn
GROUP BY complain;

SELECT exited, COUNT(exited)
FROM churn
GROUP BY exited;

SELECT complain, exited
FROM churn
WHERE complain = 1;

SELECT exited, AVG(creditscore)
FROM churn
GROUP BY 1;

SELECT exited, AVG(estimatedsalary)
FROM churn
GROUP BY 1;

SELECT exited, AVG(`point earned`)
FROM churn
GROUP BY 1;

SELECT geography, COUNT(exited), exited
FROM churn
WHERE exited = 1
GROUP BY 1;

SELECT geography, COUNT(exited), exited
FROM churn
WHERE exited = 0
GROUP BY 1;

SELECT `card type`, exited, COUNT(`card type`)
FROM churn
GROUP BY `card type`, exited
ORDER BY 1 DESC;

-- https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn