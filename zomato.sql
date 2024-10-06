create database zomato;

use zomato;
set autocommit = 0;
set SQL_SAFE_UPDATES = 0;
SET sql_mode='';


create table date(
Datekey_Opening date primary key
);

select * from date;
desc date;
select count(*) from date;
alter table main modify Datekey_Opening date;
desc main;
select * from main;
select count(*) from main;

--------------------------------------------------------------------------------
-- Calendar Table
select * from date;
-- Year
alter table date add column Year varchar(10) not null;
update date set Year = year(datekey_opening);

-- MonthNo
alter table date add column Month_No int not null;
update date set Month_No = month(datekey_opening);

-- MonthName
alter table date add column Month_Name varchar(20) not null;
update date set Month_Name = monthname(datekey_opening);

-- Quarter
alter table date add column Quarter varchar(10) not null;
update date set Quarter = concat("Q",quarter(datekey_opening));

-- YearMonth
alter table date add column YearMonth varchar(20) not null;
update date set YearMonth = date_format(datekey_opening,"%Y-%M");

-- WeekdayNo
alter table date add column WeekDayNo int not null;
update date set WeekDayNo = weekday(datekey_opening);

-- WeekDayName
alter table date add column WeekDayName varchar(10) not null;
update date set WeekDayName = date_format(datekey_opening,"%W");

-- FinancialMonth
alter table date add column FinancialMonth varchar(10) not null;
update date set FinancialMonth=concat("FM-",FinancialMonth) where Financialmonth=
case 
when month(datekey_opening)>=4 then month(datekey_opening)-3
when month(datekey_opening)<4 then month(datekey_opening)+9
end;

-- FinancialQuarter
alter table date add column FinancialQuarter varchar(10) not null;
update date set FinancialQuarter=concat("FQ-",FinancialQuarter) where FinancialQuarter=
case 
when quarter(datekey_opening)=1 then 4
when quarter(datekey_opening)=2 then 1
when quarter(datekey_opening)=3 then 2
when quarter(datekey_opening)=4 then 3
end;

-- Average cost for Two USD
select * from main;
alter table main add column Average_Cost_For_Two_USD double not null;

update main join currency on main.currency=currency.currency 
set main.Average_Cost_For_Two_USD= main.Average_Cost_for_two*currency.`USD Rate`;

-- Find the Numbers of Resturants based on City and Country.
-- CountryWise
create view countrywise as
select countryname,count(restaurantid) No_Of_Restaurants from main m 
join country c on c.countryid = m.countrycode
group by countryname
order by No_Of_Restaurants desc;
select * from countrywise;

-- CityWise
create view citywise as
select city,count(restaurantid) No_Of_Restaurants from main
group by city
order by No_Of_Restaurants desc;
select * from citywise;

-- Numbers of Resturants opening based on Year , Quarter , Month
-- Yearwise
create view Yearwise as
select year(datekey_opening) Year,count(restaurantid) No_of_restaurants from main
group by year
order by year asc;
select * from Yearwise;

-- Monthwise
create view Monthwise as
select monthname(datekey_opening) month,count(restaurantid) No_of_restaurants from main
group by month
order by month(datekey_opening) asc;
select * from Monthwise;

-- Quarterwise
create view Quarterwise as
select concat("Q",quarter(datekey_opening))Quarter,count(restaurantid) No_Of_Restaurants from main 
group by Quarter 
order by quarter asc;
select * from Quarterwise;

-- Count of Resturants based on Average Ratings
alter table main add column Average_Rating_Bucket varchar(10) not null;
update main set Average_Rating_Bucket=
case when 
Rating>=1 AND Rating<2 THEN "1-2"
when 
Rating>=2 AND Rating<3 THEN "2-3"
when
Rating>=3 AND  Rating<4 THEN "3-4"
when
Rating>=4 AND  Rating<=5 THEN "4-5"
END;

create view average_ratingwise as
select Average_Rating_Bucket,count(restaurantid) No_Of_Restaurants from main
group by Average_Rating_Bucket 
order by Average_Rating_Bucket asc;

select * from average_ratingwise;

-- Create buckets based on Average Price of reasonable size 
--  and find out how many resturants falls in each buckets
alter table main add column Average_Price_Bucket varchar(10) not null;
update main set Average_Price_Bucket=
case 
when
Average_Cost_For_Two_USD>=0 AND Average_Cost_For_Two_USD<50 THEN "0-50"
when 
Average_Cost_For_Two_USD>=50 AND Average_Cost_For_Two_USD<100 THEN "50-100"
when 
Average_Cost_For_Two_USD>=100 AND Average_Cost_For_Two_USD<150 THEN "100-150"
when
Average_Cost_For_Two_USD>=150 AND Average_Cost_For_Two_USD<200 THEN "150-200"
when
Average_Cost_For_Two_USD>=200 AND Average_Cost_For_Two_USD<250 THEN "200-250"
when
Average_Cost_For_Two_USD>=250 AND Average_Cost_For_Two_USD<300 THEN "250-300"
when
Average_Cost_For_Two_USD>=300 AND Average_Cost_For_Two_USD<350 THEN "300-350"
when
Average_Cost_For_Two_USD>=350 AND Average_Cost_For_Two_USD<400 THEN "350-400"
when
Average_Cost_For_Two_USD>=400 AND Average_Cost_For_Two_USD<450 THEN "400-450"
when
Average_Cost_For_Two_USD>=450 AND Average_Cost_For_Two_USD<=500 THEN "450-500"
END;

create view average_pricewise as
select Average_Price_Bucket,count(restaurantid) No_Of_Restaurants from main
group by Average_Price_Bucket 
order by Average_Price_Bucket asc;

select * from average_pricewise;

-- Percentage of Resturants based on "Has_Table_booking"
create view Has_Table_Booking as
select  Has_Table_Booking,concat(count(restaurantid)," ",
"(",count(restaurantid)/(select count(restaurantid) from main)*100,"%",")") No_Of_Restaurants
from main 
group by Has_Table_Booking;
select * from Has_Table_Booking;

-- Percentage of Resturants based on "Has_Online_Delivery"
create view Has_Online_Delivery as
select  Has_Online_Delivery,concat(count(restaurantid)," ",
"(",count(restaurantid)/(select count(restaurantid) from main)*100,"%",")") No_Of_Restaurants
from main 
group by Has_Online_Delivery;
select * from Has_Online_Delivery;

-- Cuisines Based on Average Cost Of Two
create view cuisines as
select cuisines,concat("$"," ",round(avg(Average_Cost_For_Two_USD), 2)) Average_Cost_For_2
from main group by cuisines
order by avg(Average_Cost_For_Two_USD) desc;
select * from cuisines;

-- City Based On Average Cost Of Two
create view City_Cost as
select city,concat("$"," ",round(avg(Average_Cost_For_Two_USD), 2)) Average_Cost_For_2
from main group by city
order by avg(Average_Cost_For_Two_USD) desc;
select * from City_Cost;

-- Average Rating Based On Average Cost Of Two
create view Average_Rating_Cost as
select Average_Rating_Bucket,concat("$"," ",round(avg(Average_Cost_For_Two_USD), 2)) Average_Cost_For_2
from main group by Average_Rating_Bucket
order by avg(Average_Cost_For_Two_USD) desc;
select * from Average_Rating_Cost;

-- Views
select * from date;
select * from countrywise;
select * from citywise;
select * from Yearwise;
select * from Monthwise;
select * from Quarterwise;
select * from average_ratingwise;
select * from average_pricewise;
select * from Has_Table_Booking;
select * from Has_Online_Delivery;
select * from cuisines;
select * from City_Cost;
select * from Average_Rating_Cost;