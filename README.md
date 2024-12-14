## Credit Card Transaction Report

---
### Overview
This project focuses on credit card transaction analysis and includes SQL scripts for cleaning and managing data. It provides schemas for Credit_cardDetails and customer_details tables, detailing customer and transaction attributes. The data cleaning scripts address duplicates and format inconsistencies. Additionally, a Power BI report visualizes trends, customer demographics, and transaction insights.

---
### Objective 
**1. Data Quality Improvement:** Clean and standardize credit card and customer data by removing duplicates and correcting inconsistencies.

**2. Data Organization:** Define robust database schemas to efficiently store and manage customer and transaction information.

**3. Insight Generation:** Leverage Power BI dashboards to visualize trends in credit card transactions, customer behavior, and demographics.

**4. Enhanced Decision-Making:** Provide actionable insights for stakeholders to improve customer satisfaction and optimize financial strategies.

**5. Streamlined Analysis:** Facilitate easy querying and analysis of credit card and customer data using structured SQL scripts.

---
### Dataset
Datasets are provided  in the repository.

---
### Schemas
Schema for Credit_cardDetails
```sql
DROP TABLE IF EXISTS Credit_cardDetails;
CREATE table Credit_cardDetails(
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)

);

SELECT * FROM Credit_cardDetails;
```

schema for customer_details
```sql
DROP TABLE If EXISTS customer_details;
CREATE TABLE customer_details(
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
);

SELECT * FROM customer_details;
```

---
### Data Cleaning (Credit_cardDetails)
#### 1. Removing all the duplicates values from the Credit_cardDetails table.
``` sql
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
```

---
#### 2. Removing Extra space from the table with the help of TRIM function.
```sql
UPDATE credit_carddetails
SET card_category = TRIM(card_category),
    week_num = TRIM(week_num),
	qtr = TRIM(qtr),
	use_chip = TRIM(use_chip),
	exp_type = TRIM(exp_type);
```

---
#### 3. Replacing values of week_start_date Column to date format type eg. YYYY-MM-DD.
```sql
UPDATE Credit_cardDetails
SET week_start_date = TO_DATE(week_start_date,'DD-MM-YYYY');
```

---
#### 4. Converting Data Type of columns.
``` sql
ALTER TABLE credit_carddetails
ALTER COLUMN week_start_date TYPE DATE
USING week_start_date :: DATE;

ALTER TABLE credit_carddetails
ALTER COLUMN delinquent_acc TYPE INTEGER
USING delinquent_acc :: INTEGER;
```

---
### Data Cleaning (customer_details)
#### 1. Removing all the duplicates values from the customer_details table.
```sql
-- a. Create CTE(No_Duplicates) with by removing all duplicates values from customer_details.
WITH No_Duplicates AS ( SELECT * 
                        FROM ( SELECT *, 
				      ROW_NUMBER() OVER(PARTITION BY client_num, state_cd, zipcode) AS row_num
                               FROM customer_details )k 
	                WHERE k.row_num = 1 )
SELECT * FROM No_Duplicates;

-- b. Copy the clean data into another table(customer_details1)
CREATE TABLE customer_details1 
AS SELECT * FROM 
	      (SELECT * 
                        FROM ( SELECT *, 
				      ROW_NUMBER() OVER(PARTITION BY client_num, 
	                                                             state_cd, 
	                                                             zipcode)
	                                           AS row_num
                               FROM customer_details ) k 
	                WHERE k.row_num = 1);

SELECT * FROM customer_details1;

```

---
#### 2. Data standardization
``` sql
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
```

---
##### 3. Delete Unnecessary columns from the table. 
```sql
ALTER TABLE customer_details1
DROP COLUMN row_num;
```
