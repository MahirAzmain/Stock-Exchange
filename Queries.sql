-- adding Primary Key
alter table Stock_Exchange ADD PRIMARY KEY (exchange_id);

-- ADDING NEW COLUMN
Alter table users ADD name varchar(20);
-- Drop A column
Alter table users drop COLUMN extra;

-- MODIFY PRICE COLUMN
Alter table offer_to_sell MODIFY Price number(10,3);

--ADDED FOREIGN KEY
Alter table buy_sell ADD foreign key (user_id) REFERENCES users (user_id) on DELETE CASCADE;

--DESCRIBE COMMAND
DESCRIBE Stock_Exchange;
DESCRIBE USERS;
DESCRIBE company_stock;
DESCRIBE owned_stock;
DESCRIBE buy_sell;
DESCRIBE offer_to_sell;
DESCRIBE yearly_revenue;

--SELECT * COMMAND
select * from Stock_Exchange;
select * from USERS;
select * from company_stock;
select * from owned_stock;
select * from buy_sell;
select * from offer_to_sell;
select * from yearly_revenue;

--UPDATING A DATA/ ROW with UPDATE
select * from Stock_Exchange where exchange_id='101';
UPDATE  Stock_Exchange
SET exchange_name='Dhaka Stock Exchange' where exchange_id='101';
select * from Stock_Exchange where exchange_id='101';

--DELETED ONE ENTRY/DATA
DELETE from company_stock
where company_id='C-100';


--With Clause

Show the user Name and Joining Year Of Each User. What is the count of users in the yearly_revenue table whose yearly revenue exceeds the average revenue?
  

select name, EXTRACT(YEAR from reg_date) AS JOINING_YEAR from users; 
with high_revenue_users as (
   select user_id
   from yearly_revenue
   where amount > (select avg(amount) from yearly_revenue)
)
select count(*) as high_revenue_users_count
from high_revenue_users;

--Aggregate function

select count(*) from users;--users in the database
select count(*) from offer_to_sell where exchange_id = '101';--companies have listed their stocks for sale on the "Dhaka Stock Exchange"  
select count(distinct user_id) from buy_sell where exchange_id in ('101', '103');--users have made transactions in both the "Dhaka Stock Exchange" and the "New York Stock Exchange"   
select sum(volume) from offer_to_sell;--total quantity of stocks listed for sale across all stock exchanges

select (amount/12) from yearly_revenue;

select company_id, sum(volume)
 from offer_to_sell group by company_id having sum(volume)>1000;--GROUP BY HAVING

 select exchange_id ,sum(volume) from offer_to_sell group by exchange_id;
 --Shows the Total Volume Each Stock Exchange Currently Selling

 select company_id, avg(Price) from offer_to_sell group by company_id;
 --Show On average Stock Price of a company

 select company_id, avg(Price) from offer_to_sell group by company_id
 having avg(price)>500;
 --Shows which company has a price of more than $500

select company_name from company_stock where company_id in 
(select DISTINCT company_id from offer_to_sell);--USAGE OF DISTINCT AND NESTED QUERY

select name from users where balance between 100000 and 200000;--between command
--showing who has a balance between 100000 and 200000

select user_id from buy_sell where exchange_id IN ('101', '103');
--This shows who has purchased history in stock_exchange 101 and 103

--some/all/exists/unique	
select * from users u JOIN owned_stock o
USING (user_id);--Show full details of the users who have stocks
select * from users
where balance > all (select balance from stock_exchange);--Retrieve all users who have a balance greater than all balances in the Stock_Exchange table
select * from users
where balance < some (select balance from stock_exchange);--Retrieve all users who have a balance less than some balances in the Stock_Exchange table                   
select * from users
where exists (select 1 from stock_exchange where users.ac_no = stock_exchange.exchange_id);--Check if there exists any user whose account number matches with any exchange ID.


select name from users where  name LIKE 'S%';
--SHOWS THE USER WHO HAS 'S' at First OF their Name

select * from owned_stock order by quantity desc;
--Shows all users based on their quantity of stock in descending order


select company_name from company_stock 
where company_id in (select company_id from offer_to_sell 
	where price>500)
UNION --USAGE OF UNION
select company_name from company_stock where company_id in (select company_id from offer_to_sell
	where volume<12000);
 --Shows the stocks that have a price greater than 500 or a volume is less than 12000



select company_name from company_stock 
where company_id in (select company_id from offer_to_sell 
	where price>500)
INTERSECT --USAGE OF INTERSECT
select company_name from company_stock where company_id in (select company_id from offer_to_sell
	where volume<12000);
--Shows the stocks that have a price greater than 500 AND a volume is less than 12000



select company_name from company_stock where company_id in (select company_id from offer_to_sell
	where volume<12000)
MINUS
select company_name from company_stock 
where company_id in (select company_id from offer_to_sell 
	where price>500);
--First Query Returns ford, tesla, Exim. Second Returns Ford and Tesla. So the Final Result is Exim.



select company_name from company_stock 
where company_id in (select company_id from offer_to_sell 
	where price>500)
UNION
select company_name from company_stock where company_id in 
(select company_id from offer_to_sell where volume<12000)
INTERSECT
select company_name from company_stock where company_id in
(select company_id from offer_to_sell where exchange_id='101');
--Here Union would be Executed At first as It is on the left of the Intersect

 select * from users u JOIN owned_stock o
 USING (user_id);-- USING KEYWORD USED HERE
 --QUERY show full details of the users who have stocks.

select u.name from 
users, u JOIN owned_stock o
on u.user_id=o.user_id;
--THE QUERY SHOWS THE USER WHO HAVE STOCKS

select name, company_name from users natural JOIN OWNED_STOCK;
--USE OF NATURAL JOIN

select exchange_name,user_id,company_name from Stock_Exchange s cross JOIN owned_stock o
where s.exchange_id=o.exchange_id;
--USED CROSS JOIN WITH where Condition.


select name,exchange_id from users u left outer JOIN buy_sell b on u.user_id=b.user_id;
--USED LEFT OUTER JOIN
--QUERY RETURNS ALL the user names and Exchange IDs for the users who have made the transaction
--also returns the name of users who have not made any transaction yet

select s.exchange_name,b.exchange_id from buy_sell b
right outer JOIN stock_exchange s on s.exchange_id=b.exchange_id;
--RIGHT OUTER JOIN
--QUERY RETURNS THE stock exchange who has already sold some stocks
--Also returns the exchange name and ID who has not sold any stock.


select s1.exchange_name from 
stock_exchange s1 JOIN stock_exchange s2 
on s1.opening_time=s2.closing_time;
--SELF JOIN
--RETURNS THE Stock Exchanges if Some stock Exchange's 
--Closing time is another one's opening time


select name, EXTRACT(YEAR from reg_date) AS JOINING_YEAR from users;
--Shows the user Name and Joining Year Of Each User.
--Usage of AS
