# MySQL-Project-Bank-Customer-Churn

## Overview

SQL-based data cleaning and analysis of a bank's customer churn dataset

## Business Task

This analysis aims to find patterns that indicate that a customer is likely to stop doing business with the bank.

## Data Source

This dataset was obtained on Kaggle, and it can be found here

## Tools

MySQL Workbench

## Process

### Initial data exploration and preprocessing

* I downloaded the CSV file of this dataset and opened it on Microsoft Excel to get a feel for it and understand the kind of information it contains. I believe this step is important because it helps me know what to look for and what to expect when I start exploratory data analysis. The dataset contained 18 columns and 10,000 rows.

* Upon my initial exploration of the dataset, I noticed the data was not that dirty, but some values needed to be standardized to make the information more easily understood by anyone who looks at it. I closed MS Excel and opened MySQL Workbench and created a database to house the dataset. Next, I created a table called "churn" with each column having the data type most appropriate for the values in the column.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image6.png?raw=true)

* I imported the dataset using the LOAD DATA LOCAL INFILE query to save time.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image10.png?raw=true)

### Data Cleaning

* I began to clean the data and observed that several entries in the balance column were listed as “0”. While it is possible for customers to have a zero balance, this seemed more like an entry error to me because the other entries in the column had two decimal places, and the zero balances did not. The other entries had five or six figures before the decimal point, making the zeroes seem odd. Also, looking at the entries in the columns of the affected rows, there was no concrete pattern that stood out. Some people with zero balance had credit scores over 800 and estimated salaries in the six-figure range. Therefore, I assigned NULL values to the rows with zero balance, so it would not affect any calculation I may make later, like when calculating aggregate functions.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image3.png?raw=true)

* I also took a look at several columns that had binary values (0 & 1) and realized that the 0s and 1s denoted No and Yes, respectively. I decided to change those binary values to No and Yes, so they will make the dataset easier to analyse. Firstly, I changed the data type of the Has Credit Card, Is Active Member, Exited, and Complain columns from INT to VARCHAR and used the UPDATE function to change 1 to ‘Yes’ and 0 to “No”.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image1.png?raw=true)

* Lastly, I dropped the row number column in the dataset because it served no purpose in the analysis.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image4.png?raw=true)

### Data exploration and analysis

* Once the data was cleaned, I began to query it to uncover patterns indicative of customers who left the bank. During my exploration and analysis of the data, I sought answers to the following questions.

Average credit score of customers who have and have not exited (stopped doing business with the bank)? Exited = 645; Not exited = 651

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image11.png?raw=true)

What country has the most customers? France

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image2.png?raw=true)

Minimum credit score of customers that have and have not exited? Exited = 350; Not exited = 405

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image5.png?raw=true)

How many customers by gender? Male = 5457; Female = 4543

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image9.png?raw=true)

How many customers by gender have exited? Male = 899 Female = 1139  ! More females are leaving

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image8.png?raw=true)

Is there a correlation between customers who complained and those who exited? Yes, in almost all cases, customers who exited had complained

![image alt](https://github.com/jefferyokpala/MySQL-Project-Bank-Customer-Churn/blob/main/images/image7.png?raw=true)

## Conclusion

* My exploration and analysis revealed that the most significant factor that determines whether a customer will leave is whether they complain about the service they receive. Therefore, the bank should strengthen its customer support staff and work harder to address complaints before they lead to churn. The bank can offer incentives to customers who complain to persuade them to stay.

* Also, females are more likely than males to exit. The bank should investigate this and put more effort and resources into it. Into retaining their female customers.

* It is also worth noting that people with poor credit scores are more likely to exit, since the minimum credit score of customers who left is 350.  Those who remain as customers have a minimum score of 405, which is still considered poor but is better than 405. To retain such customers, the bank can offer financial services that will appeal to them.



