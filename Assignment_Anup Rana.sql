# Assignment by Anup Rana
# MySQL Workbench version 8.0 CE

#-----------------------------------Task 1--------------------------------------
#Create a new table named 'bajaj1' containing the date, close price, 20 Day MA 
#and 50 Day MA. (This has to be done for all 6 stocks)

create table bajaj1 as
select str_to_date(Date, '%d-%M-%Y') as 'Date', `Close Price`,  # back quote for the column name with space
avg(`Close Price`) over (order by `Date` asc rows 19 preceding) as "20 Day MA",
avg(`Close Price`) over (order by `Date` asc rows 49 preceding) as "50 Day MA"
from `Bajaj Auto`;

create table eicher1 as
select str_to_date(Date, '%d-%M-%Y') as 'Date', `Close Price`, 
avg(`Close Price`) over (order by `Date` asc rows 19 preceding) as "20 Day MA",
avg(`Close Price`) over (order by `Date` asc rows 49 preceding) as "50 Day MA"
from `Eicher Motors`;

create table hero1 as
select str_to_date(Date, '%d-%M-%Y') as 'Date', `Close Price`, 
avg(`Close Price`) over (order by `Date` asc rows 19 preceding) as "20 Day MA",
avg(`Close Price`) over (order by `Date` asc rows 49 preceding) as "50 Day MA"
from `Hero Motocorp`;

create table infosys1 as
select str_to_date(Date, '%d-%M-%Y') as 'Date', `Close Price`, 
avg(`Close Price`) over (order by `Date` asc rows 19 preceding) as "20 Day MA",
avg(`Close Price`) over (order by `Date` asc rows 49 preceding) as "50 Day MA"
from Infosys;

create table tcs1 as
select str_to_date(Date, '%d-%M-%Y') as 'Date', `Close Price`, 
avg(`Close Price`) over (order by `Date` asc rows 19 preceding) as "20 Day MA",
avg(`Close Price`) over (order by `Date` asc rows 49 preceding) as "50 Day MA"
from TCS;

create table tvs1 as
select str_to_date(Date, '%d-%M-%Y') as 'Date', `Close Price`, 
avg(`Close Price`) over (order by `Date` asc rows 19 preceding) as "20 Day MA",
avg(`Close Price`) over (order by `Date` asc rows 49 preceding) as "50 Day MA"
from `TVS Motors`;

#-----------------------------------Task 2--------------------------------------
#Create a master table containing the date and close price of all the six stocks. 
#(Column header for the price is the name of the stock)

create table `Master Table` (`Date` DATE, `Bajaj` DOUBLE, `TCS` DOUBLE, `TVS` DOUBLE, `Infosys` DOUBLE, `Eicher` DOUBLE, 
`Hero` DOUBLE);

insert into `Master Table`
select str_to_date(Bajaj.`Date`,'%d-%M-%Y'),
Bajaj.`Close Price` as "Bajaj",
Infosys.`Close Price` as "Infosys",
Eicher.`Close Price` as "Eicher",
TVS.`Close Price` as "TVS",
Hero.`Close Price` as "Hero",
TCS.`Close Price` as "TCS"
from `Bajaj Auto` Bajaj inner join `TCS` TCS on Bajaj.`Date`= TCS.`Date`
inner join `TVS Motors` TVS on TCS.`Date` = TVS.`Date`
inner join `Hero Motocorp` Hero on TVS.`Date` = Hero.`Date`
inner join `Eicher Motors` Eicher on Hero.`Date` = Eicher.`Date`
inner join `Infosys` Infosys on Eicher.`Date` = Infosys.`Date`;

#-----------------------------------Task 3--------------------------------------
#Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. 
#Perform this operation for all stocks.

create table bajaj2 (`Date` DATE, `Close Price` DOUBLE, `Signal` varchar(50));
insert into bajaj2
select `Date`, `Close Price`,
case
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) <= lag(`50 Day MA`, 1) over (order by `Date`) then 'Buy'
	when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) >= lag(`50 Day MA`, 1) over (order by `Date`) then 'Sell'
	else 'Hold'
end as "Signal"
from bajaj1;

create table eicher2 (`Date` DATE, `Close Price` DOUBLE, `Signal` varchar(50));
insert into eicher2
select `Date`, `Close Price`,
case
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) <= lag(`50 Day MA`, 1) over (order by `Date`) then 'Buy'
	when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) >= lag(`50 Day MA`, 1) over (order by `Date`) then 'Sell'
	else 'Hold'
end as "Signal"
from eicher1;

create table hero2 (`Date` DATE, `Close Price` DOUBLE, `Signal` varchar(50));
insert into hero2
select `Date`, `Close Price`,
case
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) <= lag(`50 Day MA`, 1) over (order by `Date`) then 'Buy'
	when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) >= lag(`50 Day MA`, 1) over (order by `Date`) then 'Sell'
	else 'Hold'
end as "Signal"
from hero1;

create table infosys2 (`Date` DATE, `Close Price` DOUBLE, `Signal` varchar(50));
insert into infosys2
select `Date`, `Close Price`,
case
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) <= lag(`50 Day MA`, 1) over (order by `Date`) then 'Buy'
	when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) >= lag(`50 Day MA`, 1) over (order by `Date`) then 'Sell'
	else 'Hold'
end as "Signal"
from infosys1;

create table tcs2 (`Date` DATE, `Close Price` DOUBLE, `Signal` varchar(50));
insert into tcs2
select `Date`, `Close Price`,
case
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) <= lag(`50 Day MA`, 1) over (order by `Date`) then 'Buy'
	when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) >= lag(`50 Day MA`, 1) over (order by `Date`) then 'Sell'
	else 'Hold'
end as "Signal"
from tcs1;

create table tvs2 (`Date` DATE, `Close Price` DOUBLE, `Signal` varchar(50));
insert into tvs2
select `Date`, `Close Price`,
case
	when `20 Day MA` > `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) <= lag(`50 Day MA`, 1) over (order by `Date`) then 'Buy'
	when `20 Day MA` < `50 Day MA` and lag(`20 Day MA`, 1) over (order by `Date`) >= lag(`50 Day MA`, 1) over (order by `Date`) then 'Sell'
	else 'Hold'
end as "Signal"
from tvs1;

#-----------------------------------Task 4--------------------------------------
#Create a User defined function, that takes the date as input and returns the signal for that particular day 
#(Buy/Sell/Hold) for the Bajaj stock.

create function Signal_check (d varchar(20))
returns varchar(20) deterministic
return 
(select `Signal`
from bajaj2
where bajaj2.`Date` = d);

#select Signal_check('2015-05-18');

#-----------------------------------Task 5--------------------------------------
#Write a brief summary of the results obtained and what inferences you can draw from the analysis performed. 
#(Less than 250 words to be submitted in a pdf file)

#The pdf file is attached separately