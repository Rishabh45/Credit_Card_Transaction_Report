-- Data cleaning (Credit_cardDetails) table
-- 1. Removing all the duplicates values from the Credit_cardDetails table.

DELETE FROM Credit_cardDetails
WHERE client_num 
      in ( SELECT 
	            client_num
		   FROM( SELECT 
		              client_num, 
					  COUNT(client_num) AS row_counts 
				 FROM Credit_cardDetails 
				 GROUP BY client_num) 
		   t1 
	       WHERE row_counts > 1
);


-- 2. Removing Extra space from the table with the help of TRIM function.

UPDATE credit_carddetails
SET card_category = TRIM(card_category),
    week_num = TRIM(week_num),
	qtr = TRIM(qtr),
	use_chip = TRIM(use_chip),
	exp_type = TRIM(exp_type);
	

-- 3. Replacing values of week_start_date Column to date format type eg. YYYY-MM-DD.

UPDATE Credit_cardDetails
SET week_start_date = TO_DATE(week_start_date,'DD-MM-YYYY');


-- 4. Converting Data Type of columns.

ALTER TABLE credit_carddetails
ALTER COLUMN week_start_date TYPE DATE
USING week_start_date :: DATE;

ALTER TABLE credit_carddetails
ALTER COLUMN delinquent_acc TYPE INTEGER
USING delinquent_acc :: INTEGER;