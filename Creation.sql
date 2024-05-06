create table Stock_Exchange(
	exchange_id varchar(20) not null,
	exchange_name varchar(40),
	opening_time varchar(10) DEFAULT '10:00 AM',--USED DEFAULT
	closing_time varchar(10));

    create table users(
	user_id varchar(20) not null,	
	ac_no number(20),
	balance number(20,2) CHECK (balance>0),--USED CHECK 
	extra varchar(12),
	reg_date Date,
	primary key(user_id));

    create table company_stock(
	company_id varchar(20) NOT NULL,
	company_name varchar(20),
	PRIMARY KEY (company_id));

    create table offer_to_sell(
	exchange_id varchar(20) NOT NULL,
	company_id varchar(20) NOT NULL,
	Price varchar(20),
	volume number(10),
	PRIMARY KEY (exchange_id, company_id),
	foreign key (company_id) REFERENCES company_stock (company_id) on DELETE CASCADE,
	foreign key (exchange_id) REFERENCES stock_exchange (exchange_id) 
	on DELETE CASCADE);


create table buy_sell(
	user_id varchar(20) NOT NULL,
	exchange_id varchar(20) NOT NULL,
	primary key (user_id,exchange_id),
	foreign key (exchange_id) REFERENCES stock_exchange (exchange_id) 
	on DELETE CASCADE);

    create table yearly_revenue(
	amount number(20,3),
	user_id varchar(20) NOT NULL,
	company_id varchar(20)NOT NULL,
	exchange_id varchar(20) NOT NULL,
	PRIMARY KEY (user_id, company_id,exchange_id),
	foreign key (user_id) REFERENCES users (user_id) on DELETE CASCADE,
	foreign key (company_id) REFERENCES company_stock (company_id) 
	on DELETE CASCADE,
	foreign key (exchange_id) REFERENCES stock_exchange(exchange_id) on DELETE CASCADE);

Create Table Owned_stock(
	company_name varchar(20),
	quantity number(20),
	buy_price number(20),
	user_id varchar(20) NOT NULL,
	exchange_id varchar(20) NOT NULL,
	company_id varchar(20) NOT NULL,
	PRIMARY KEY (user_id, company_id,exchange_id),
	foreign key (user_id) REFERENCES users (user_id) on DELETE CASCADE,
	foreign key (company_id) REFERENCES company_stock (company_id) 
	on DELETE CASCADE,
	foreign key (exchange_id) REFERENCES stock_exchange (exchange_id) 
	on DELETE CASCADE);

