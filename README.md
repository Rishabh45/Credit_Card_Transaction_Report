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
### Data Cleaning [Credit_cardDetails]



