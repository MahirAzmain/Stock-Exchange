-- Add users
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-24', 'Azmain', 2007118, 10000000.25);
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-98', 'Azhar', 2007112, 100234.25);
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-21', 'Tirtho', 2007117, 123451.54);
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-3', 'Faiyaz', 2007103, 54102.75);
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-29', 'Bishal', 2007098, 500000.29);
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-118', 'Sourov', 2007109, 525000.65);
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-70', 'Choyan', 2007101, 9401011.65);
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-73', 'Plaban', 2007111, 876301.65);
INSERT INTO users(user_id, user_name, user_join_date, user_balance) VALUES ('U-20', 'Dipto', 2007119, 606301.65);

-- Add stock exchanges
INSERT INTO stock_exchange(exchange_id, exchange_name, opening_time, closing_time) VALUES ('101', 'DSE', '10:00 AM', '1:00 PM');
INSERT INTO stock_exchange(exchange_id, exchange_name, opening_time, closing_time) VALUES ('102', 'CHITTOGONG Stock Exchange', '11:00 AM', '2:00 PM');
INSERT INTO stock_exchange(exchange_id, exchange_name, opening_time, closing_time) VALUES ('103', 'NEWYORK Stock Exchange', '11:00 AM', '2:00 PM');
INSERT INTO stock_exchange(exchange_id, exchange_name, opening_time, closing_time) VALUES ('104', 'London Stock Exchange', '11:00 AM', '2:00 PM');
INSERT INTO stock_exchange(exchange_id, exchange_name, opening_time, closing_time) VALUES ('105', 'National Stock Exchange of INDIA', '12:00 AM', '4:00 PM');
INSERT INTO stock_exchange(exchange_id, exchange_name, opening_time, closing_time) VALUES ('106', 'Colombo Stock Exchange', '10:05 AM', '10:05 AM');

-- Add company stocks
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-1', 'Exim Bank');
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-2', 'BRAC Bank');
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-3', 'TESLA');
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-4', 'FORD');
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-5', 'JANATA Bank');
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-6', 'Square');
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-7', 'APEX');
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-8', 'FACEBOOK');
INSERT INTO company_stock(stock_id, company_name) VALUES ('C-100', 'TO BE DELETED');

-- Add offers to sell
INSERT INTO offer_to_sell(exchange_id, stock_id, price, quantity) VALUES ('101', 'C-1', 101.1, 10000);
INSERT INTO offer_to_sell(exchange_id, stock_id, price, quantity) VALUES ('102', 'C-1', 97.5, 20000);
INSERT INTO offer_to_sell(exchange_id, stock_id, price, quantity) VALUES ('103', 'C-3', 1000, 5000);
INSERT INTO offer_to_sell(exchange_id, stock_id, price, quantity) VALUES ('104', 'C-4', 975, 7000);
INSERT INTO offer_to_sell(exchange_id, stock_id, price, quantity) VALUES ('102', 'C-2', 75, 15000);
INSERT INTO offer_to_sell(exchange_id, stock_id, price, quantity) VALUES ('104', 'C-6', 401, 15750);
INSERT INTO offer_to_sell(exchange_id, stock_id, price, quantity) VALUES ('101', 'C-7', 98, 100000);
INSERT INTO offer_to_sell(exchange_id, stock_id, price, quantity) VALUES ('103', 'C-8', 947, 23033);

-- Add owned stocks
INSERT INTO owned_stock(company_name, quantity, price, user_id, exchange_id, stock_id) VALUES ('TESLA', 1000, 990, 'U-24', '103', 'C-3');
INSERT INTO owned_stock(company_name, quantity, price, user_id, exchange_id, stock_id) VALUES ('APEX', 5000, 70, 'U-98', '101', 'C-7');
INSERT INTO owned_stock(company_name, quantity, price, user_id, exchange_id, stock_id) VALUES ('Square', 1400, 350, 'U-21', '104', 'C-6');
INSERT INTO owned_stock(company_name, quantity, price, user_id, exchange_id, stock_id) VALUES ('TESLA', 1000, 970, 'U-29', '103', 'C-3');
INSERT INTO owned_stock(company_name, quantity, price, user_id, exchange_id, stock_id) VALUES ('BRAC Bank', 700, 90, 'U-20', '102', 'C-2');
INSERT INTO owned_stock(company_name, quantity, price, user_id, exchange_id, stock_id) VALUES ('FACEBOOK', 300, 800, 'U-24', '103', 'C-8');

-- Add yearly revenues
INSERT INTO yearly_revenue(revenue_amount, user_id, company_name, exchange_id) VALUES (12540.5, 'U-24', 'C-3', '103');
INSERT INTO yearly_revenue(revenue_amount, user_id, company_name, exchange_id) VALUES (20045, 'U-98', 'C-7', '101');
INSERT INTO yearly_revenue(revenue_amount, user_id, company_name, exchange_id) VALUES (12761, 'U-21', 'C-6', '104');
INSERT INTO yearly_revenue(revenue_amount, user_id, company_name, exchange_id) VALUES (14292.5, 'U-29', 'C-3', '103');
INSERT INTO yearly_revenue(revenue_amount, user_id, company_name, exchange_id) VALUES (5000, 'U-20', 'C-2', '102');
INSERT INTO yearly_revenue(revenue_amount, user_id, company_name, exchange_id) VALUES (10342, 'U-24', 'C-8', '103');







BEGIN

add_users('U-24','Azmain',2007118,10000000.25);
add_users('U-98','Azhar',2007112,100234.25);
add_users('U-21','Tirtho',2007117, 123451.54);
add_users('U-3', 'Faiyaz',2007103,54102.75);
add_users('U-29','Bishal', 2007098,500000.29);
add_users('U-118','Sourov', 2007109,525000.65);
add_users('U-70','Choyan', 2007101,9401011.65);
add_users('U-73','plaban', 2007111,876301.65);
add_users('U-20','dipto', 2007119,606301.65);



add_stock_exchange('101','DSE','10:00 AM','1:00 PM');
add_stock_exchange('102','CHITTOGONG Stock Exchange','11:00 AM','2:00 PM');
add_stock_exchange('103','NEWYORK Stock Exchange','11:00 AM','2:00 PM');
add_stock_exchange('104','London Stock Exchange','11:00 AM','2:00 PM');
add_stock_exchange('105','National Stock Exchange of INDIA','12:00 AM','4:00 PM');
add_stock_exchange('106','Colombo Stock Exchange','10:05 AM','10:05 AM');


add_company_stock('C-1','Exim Bank');
add_company_stock('C-2','BRAC Bank');
add_company_stock('C-3','TESLA');
add_company_stock('C-4','FORD');
add_company_stock('C-5','JANATA Bank');
add_company_stock('C-6','Square');
add_company_stock('C-7','APEX');
add_company_stock('C-8','FACEBOOK');
add_company_stock('C-100','TO BE DELETED');

add_offer_to_sell('101','C-1',101.1,10000);
add_offer_to_sell('102','C-1',97.5,20000);
add_offer_to_sell('103','C-3',1000,5000);
add_offer_to_sell('104','C-4',975,7000);
add_offer_to_sell('102','C-2',75,15000);
add_offer_to_sell('104','C-6',401,15750);
add_offer_to_sell('101','C-7',98,100000);
add_offer_to_sell('103','C-8',947,23033);

add_owned_stock('TESLA',1000,990,'U-24','103','C-3');
add_owned_stock('APEX',5000,70,'U-98','101','C-7');
add_owned_stock('Square',1400,350,'U-21','104','C-6');
add_owned_stock('TESLA',1000,970,'U-29','103','C-3');
add_owned_stock('BRAC Bank',700,90,'U-20','102','C-2');
add_owned_stock('FACEBOOK',300,800,'U-24','103','C-8');



add_yearly_revenue(12540.5,'U-24','C-3','103'); 
add_yearly_revenue(20045,'U-98','C-7','101');
add_yearly_revenue(12761,'U-21','C-6','104');
add_yearly_revenue(14292.5,'U-29','C-3','103');
add_yearly_revenue(5000,'U-20','C-2','102');
add_yearly_revenue(10342,'U-24','C-8','103');
END;
/