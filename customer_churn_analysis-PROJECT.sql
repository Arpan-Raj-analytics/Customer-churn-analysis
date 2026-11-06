
CREATE TABLE customers (
    "customerID" VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    "SeniorCitizen" INTEGER,
    "Partner" VARCHAR(5),
    "Dependents" VARCHAR(5),
    tenure INTEGER,
    "PhoneService" VARCHAR(5),
    "MultipleLines" VARCHAR(30),
    "InternetService" VARCHAR(20),
    "OnlineSecurity" VARCHAR(20),
    "OnlineBackup" VARCHAR(20),
    "DeviceProtection" VARCHAR(20),
    "TechSupport" VARCHAR(20),
    "StreamingTV" VARCHAR(20),
    "StreamingMovies" VARCHAR(20),
    "Contract" VARCHAR(30),
    "PaperlessBilling" VARCHAR(5),
    "PaymentMethod" VARCHAR(50),
    "MonthlyCharges" NUMERIC(10,2),
    "TotalCharges" NUMERIC(10,2),
    "Churn" VARCHAR(5)
);




select * from customers;

--1. QUESTIN. HOW MANY CUSTOMERS HAVE LEFT THE COMPANY AND HOW MANY HAVE STAYED.


SELECT
    "Churn",
    COUNT(*) AS customer_count
FROM customers
GROUP BY "Churn";

--2. QUESTION. CALCULATE CHURN RATE..


SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN "Churn" = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customers;


--3.QUESTION. HOW MANY CUSTOMER LEFT COMPANY..

select count(*)
from customers 
where "Churn"='Yes';

--4. CUSTOMER WHO STAYED.

select count(*)
from customers 
where "Churn"='No';


--5. ANALYSE CHURN BY CONTRACT..

select "Contract", "Churn",
count(*) as customer_count
from customers
group by "Contract", "Churn"
order by "Contract", "Churn";

--6. ANALYSE CHURN BY CUSTOMER TENURE..

 select 
 case 
    when tenure<=12 then '0-12 months'
	when tenure <=24 then '13-24 moths'
    else '25+ months'
end as tenure_group,
count (*) as total_customers
from customers 
group by tenure_group 
order by tenure_group;


--7..WHICH TENURE GRUOP LOSES THE MOST CUSTOMERS..


select 
 case 
    when tenure<=12 then '0-12 months'
	when tenure <=24 then '13-24 moths'
    else '25+ months'
end as tenure_group,
count (*) as customer_lost
from customers 
where "Churn"= 'Yes'
group by tenure_group 
order by customer_lost desc;


--8.COMAPRE MONTHLY CHARGE OF CUSTOMER WHO LEFT AND STAYED.

select "Churn",
avg("MonthlyCharges")as average_monthly_cahrges
from customers 
group by "Churn";


--9. ANALYSE CHURN BY PAYMENT METHOD

select "PaymentMethod",
count(*) as customers_lost
from customers
where "Churn"='Yes'
group by "PaymentMethod"
order by customers_lost desc;


--10. WHICH INTERNET SERVICE TYPE HAVE MOST CUSTOMER LEAVING.

select "InternetService",
count(*) as customers_lost
from customers
where "Churn"= 'Yes'
group by "InternetService"
order by customers_lost desc;

---11. IS C USTOMER CHURN DIFFERENT BETWEEN SENIOR CITIZEN AND OTHERS.

select "SeniorCitizen",
count(*) as customers_lost
from customers
where "Churn"= 'Yes'
group by "SeniorCitizen";




















