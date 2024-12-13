-- Data cleaning (customer_details) table

-- 1. Removing all the duplicates values from the customer_details table.
-- a. Create CTE(No_Duplicates) with by removing all duplicates values from customer_details.
WITH No_Duplicates AS ( SELECT * 
                        FROM ( SELECT *, 
						               ROW_NUMBER() OVER(PARTITION BY client_num, state_cd, zipcode) AS row_num
                               FROM customer_details )
						k WHERE k.row_num = 1
					   )
SELECT * FROM No_Duplicates;

-- b. Copy the clean data into another table(customer_details1)
CREATE TABLE customer_details1 AS SELECT * FROM (SELECT * 
                        FROM ( SELECT *, 
						               ROW_NUMBER() OVER(PARTITION BY client_num, state_cd, zipcode) AS row_num
                               FROM customer_details )
						k WHERE k.row_num = 1);

SELECT * FROM customer_details1;

-- 2. Data standardization
-- a. Correcting mistakes from the values.
UPDATE customer_details1
SET customer_job = 'Self-Employeed'
WHERE customer_job ='Self-employeed';

-- b. Converting the Initial letter of words into Upper Case.
UPDATE customer_details1
SET car_owner = INITCAP(car_owner),
    house_owner = INITCAP(house_owner),
    personal_loan = INITCAP(personal_loan),
    contact = INITCAP(contact),
    customer_job = INITCAP(customer_job);
	
-- c. Converting Data types into there appropiate format.
ALTER TABLE customer_details1
ALTER COLUMN zipcode TYPE INTEGER
USING zipcode :: INTEGER;


-- 3. Delete Unnecessary columns from the table. 

ALTER TABLE customer_details1
DROP COLUMN row_num;

SELECT * FROM customer_details1;

