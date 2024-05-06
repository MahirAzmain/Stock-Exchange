
CREATE OR REPLACE PROCEDURE add_users(
user_id1 users.user_id%TYPE,
name1 users.name%type,
ac_no1 users.ac_no%type,
balance1 users.balance%type) IS
BEGIN
	INSERT INTO USERS (user_id,name,ac_no,balance) 
	values (user_id1,name1,ac_no1,balance1);	
END add_users;
/
SHOW ERROR

CREATE OR REPLACE PROCEDURE add_stock_Exchange(
exchange_id1 stock_exchange.exchange_id%TYPE,
ex_name stock_exchange.exchange_name%type,
open1 stock_exchange.opening_time%TYPE,
close1 stock_exchange.closing_time%TYPE) IS
BEGIN
	INSERT INTO stock_exchange (exchange_id ,exchange_name,opening_time,CLOSING_TIME) 
	values (exchange_id1,ex_name,open1,close1);
	
END add_stock_Exchange;
/

create or replace procedure add_company_stock(
id company_stock.company_id%type,
name company_stock.company_name%type) IS
BEGIN
	INSERT into company_stock(company_id,company_name)
	values (id,name);
END add_company_stock;
/

create or replace procedure add_owned_stock(
name owned_stock.company_name%type,
quan owned_stock.quantity%type,
buyPrice owned_stock.buy_price%type,
uid owned_stock.user_id%type,
eid owned_stock.exchange_id%type,
cid owned_stock.company_id%type) IS
BEGIN
	Insert into OWNED_STOCK (company_name,quantity,buy_price,user_id,company_id,exchange_id)
	values (name,quan,buyPrice,uid,cid,eid);
END add_owned_stock;
/

CREATE or REPLACE PROCEDURE add_offer_to_sell(
eid offer_to_sell.exchange_id%type,
cid offer_to_sell.company_id%type,
price1 offer_to_sell.Price%type,
volume1 offer_to_sell.volume%type) IS
BEGIN
	INSERT into offer_to_sell (exchange_id,company_id,Price,volume)
	values(eid,cid,price1,volume1);


END add_offer_to_sell;
/

SET SERVEROUTPUT ON
create or replace procedure add_yearly_revenue(	
	am1 yearly_revenue.amount%type,
	uid users.user_id%type,
	cid company_stock.company_id%type,
	eid stock_exchange.exchange_id%type) IS
	--<ADDED LOCAL VARIABLE TO PL/SQL PROCEDURE>
	c number;
BEGIN
--<THIS IS FOR CHECKING IF THE USER HAS STOCK FROM THIS COMPANY>--
	select count(1) into c from owned_stock where cid=company_id and eid=owned_stock.exchange_id 
		and uid=owned_stock.user_id;
	if (c=1) then
		INSERT into yearly_revenue(amount,user_id,company_id,exchange_id)
		values(am1,uid,cid,eid);
	else
		RAISE_APPLICATION_ERROR(-122,'User does not have stock');
	end if;
END add_yearly_revenue;
/


-- Automatically Insert The Register Date in the User Table
create or REPLACE TRIGGER update_date_users BEFORE INSERT on users
	FOR EACH ROW
DECLARE
	var users.reg_date%type;
BEGIN
	select sysdate into var from dual;
	:new.reg_date:=var;
END;
/	


SET SERVEROUTPUT ON
DECLARE 
	open stock_exchange.opening_time%type;
	lim varchar(40);
BEGIN
	lim:='Dhaka Stock Exchange';
	select opening_time into open from Stock_Exchange 
	where exchange_name=lim;
	DBMS_OUTPUT.PUT_LINE('OPENING TIME OF '||lim||' is '||open);	
END;
/
--This Query Returns the opening time of DSE 
--Usages of PL SQL block


DECLARE
	CURSOR star_customer IS select name from users
	where user_id in( select user_id from owned_stock group by user_id 
	having sum(quantity)>=1000);
	s_cur star_customer%ROWTYPE;
	c number;
BEGIN
OPEN star_customer;
	c:=1;
	LOOP
		FETCH star_customer into s_cur;
		EXIT when star_customer%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE ('Star Customer '||c||': '||s_cur.name);
		c:=c+1;
		END LOOP;
CLOSE star_customer;
END;
/
--If any customer has more than 1000 Stocks, he/she is a star customer
--This Query Returns the name of Star Customers
-- Usage of CURSOR



create or replace view Revenue_View AS
	select u.name,user_id, sum(amount) AS TOTAL_REVENUE from users u natural JOIN yearly_revenue y group by (user_id,name); 
--THIS view shows the total revenue of each users;


select name, (TOTAL_REVENUE*.25) AS TAX_PAYABLE from Revenue_View where TOTAL_REVENUE>5000;
--Shows the user name and Total Tax of Each user who have earned more than 5000 in previous year.


SET SERVEROUTPUT ON
BEGIN
dbms_output.put_line('Total REVENUE OF USER ABRAR IS: '|| show_revenue('U-24'));
dbms_output.put_line('Total REVENUE OF USER SADMAN IS: '|| show_revenue('U-20'));
END;
/
--Prints the total Revenue against  user ID;



BEGIN
 calculate_profit_loss(300,'U-24','C-3','103');
END;
 /
 --Returns the Profit/Loss if this stock is sold

--USE OF savepoint
SAVEPOINT s1;

insert into company_stock values ('C-1234','DEMO COMPANY' );

select * from company_stock;

ROLLBACK to s1;

select * from company_stock;

SET SERVEROUTPUT ON
DECLARE
v_num1 Number;
v_num2 Number;
v_sum  Number;

BEGIN
V_num1 := &Number1;
V_num2 := &Number2;

V_sum := v_num1 + v_num2 ;

Dbms_Output.Put_Line ('The Sum of number is :' || v_sum);

END;
/

--THIS FUNCTION SHOWS THE YEARLY REVENUE OF AN USER
CREATE OR REPLACE FUNCTION show_revenue
(uid yearly_revenue.user_id%type)
RETURN yearly_revenue.amount%type IS
ret_value yearly_revenue.amount%type;
BEGIN
	select sum(amount) into ret_value 
	from yearly_revenue where yearly_revenue.user_id=uid;
	RETURN ret_value;
END show_revenue;
/

--This Procedure Returns The Amount Of Profit OR Loss Of a User against His stock
SET SERVEROUTPUT ON
create or REPLACE PROCEDURE calculate_profit_loss
	(
	quan owned_stock.quantity%type,
	uid owned_stock.user_id%type,
	cid owned_stock.company_id%type,
	eid owned_stock.exchange_id%type)IS
	cur_price offer_to_sell.Price%type;
	b_price owned_stock.buy_price%type;
	q1 owned_stock.quantity%type; 
BEGIN
	select price into cur_price from offer_to_sell
	where company_id=cid and exchange_id=eid;

	select buy_price,quantity into b_price,q1 from owned_stock
	where user_id=uid and company_id=cid and exchange_id=eid;

	if b_price>cur_price then
		DBMS_OUTPUT.PUT('LOSS: ');
		DBMS_OUTPUT.PUT_LINE(quan*b_price-quan*cur_price);
	elsif b_price<cur_price then
		DBMS_OUTPUT.PUT_LINE(b_price);
		DBMS_OUTPUT.PUT_LINE(cur_price);
		DBMS_OUTPUT.PUT('PROFIT :');
		DBMS_OUTPUT.PUT_LINE(quan*cur_price-quan*b_price);
	else
		DBMS_OUTPUT.PUT_LINE('No profit or Loss');
	end if;
END calculate_profit_loss;
/

--THIS TRIGGER WILL AUTOMATICALLY ADD DATA TO buy_sell table when someone buys/sells stocks;
CREATE OR REPLACE TRIGGER check_buy_sell BEFORE INSERT OR UPDATE ON
owned_stock
FOR EACH ROW
DECLARE
c number;
BEGIN
	select count(1) into c from buy_sell 
		where :new.user_id=buy_sell.user_id and :new.exchange_id=buy_sell.exchange_id;
	if(c=0) then
	INSERT INTO buy_sell(user_id,exchange_id) values (:new.user_id,:new.exchange_id);
	end if;
END;
/