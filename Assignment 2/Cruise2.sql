drop table Reservation;
drop table TravelAgent;
drop table Cruise;
drop table Ship;
drop table Company;
drop table Customer;

drop sequence travelAgentID_seq;
drop sequence customerID_seq;
drop sequence cruiseID_seq;
drop sequence reservationID_seq;

create table Company(
    companyName varchar2(15),
    stockSymbol char(4),
    website varchar2(40),
    Constraint Company_pk Primary Key(companyName),
    Constraint Company_U1 Unique(stockSymbol)
);

insert into Company values('Carnival', 'CRVL', 'http://www.carnival.com');
insert into Company values('Celebrity', 'CELB', 'http://www.celebritycruises.com');
insert into Company values('NCL', 'NCLC', 'http://www.ncl.com');
insert into Company values('Princess', 'PRCS', 'http://www.princess.com');

--select * from Company;

create table TravelAgent(
    travelAgentID number,
    firstName varchar2(15),
    lastName varchar2(20),
    title varchar2(15),
    salary number(7, 2),
    Constraint TravelAgent_pk Primary Key(travelAgentID),
    Constraint Customer_title check(title in ('Assistant', 'Agent', 'Manager'))
);

create sequence travelAgentID_seq
start with 1;

insert into TravelAgent values(travelAgentID_seq.nextval, 'Chloe', 'Rodriguez', 'Assistant', 31750.00);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Ben', 'Wilson', 'Agent', 47000.22);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Mia', 'Smith', 'Manager', 75250.00);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Noah', 'Williams', 'Assistant', 32080.90);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Liam', 'Brown', 'Manager', 60500.75);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Mason', 'Jones', 'Manager', 79000.00);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Olivia', 'Miller', 'Agent', 54000.50);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Sofia', 'Davis', 'Agent', 45000.00);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Jason', 'Garcia', 'Manager', 52025.95);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Emily', 'Johnson', 'Assistant', 22000.50);
insert into TravelAgent values(travelAgentID_seq.nextval, 'Ethan', 'Elm', 'Agent', 27044.52);

--select * from TravelAgent;

create table Customer(
    customerID number,
    firstName varchar2(15),
    lastName varchar2(15),
    address varchar2(30),
    phone number(10) not null,
    age number(3),
    Constraint Customer_pk Primary Key(customerID),
    Constraint Customer_U1 Unique(firstName, lastName, phone),
    Constraint Customer_phoneVal check(phone >= 1000000000)
);

create sequence customerID_seq
start with 1;

insert into Customer values(customerID_seq.nextval, 'Dylan', 'Ward', '42 Elm Place', 8915367188, 22);
insert into Customer values(customerID_seq.nextval, 'Austin', 'Ross', '257 Redondo Ave.', 1233753684, 25);
insert into Customer values(customerID_seq.nextval, 'Lisa', 'Powell', '5 Jefferson Ave.', 6428369619, 17);
insert into Customer values(customerID_seq.nextval, 'Brian', 'Martin', '143 Cambridge Ave.', 5082328798, 45);
insert into Customer values(customerID_seq.nextval, 'Nicole', 'White', '77 Massachusetts Ave.', 6174153059, 29);
insert into Customer values(customerID_seq.nextval, 'Tyler', 'Garcia', '175 Forest St.', 9864752346, 57);
insert into Customer values(customerID_seq.nextval, 'Anna', 'Allen', '35 Tremont St.', 8946557732, 73);
insert into Customer values(customerID_seq.nextval, 'Michael', 'Sanchez', '9 Washington Court', 1946825344, 18);
insert into Customer values(customerID_seq.nextval, 'Justin', 'Myers', '98 Lake Hill Drive', 7988641411, 26);
insert into Customer values(customerID_seq.nextval, 'Bruce', 'Clark', '100 Main St.', 2324648888, 68);
insert into Customer values(customerID_seq.nextval, 'Rachel', 'Lee', '42 Oak St.', 2497873464, 19);
insert into Customer values(customerID_seq.nextval, 'Kelly', 'Gray', '1414 Cedar St.', 9865553232, 82);
insert into Customer values(customerID_seq.nextval, 'Madison', 'Young', '8711 Meadow St.', 4546667821, 67);
insert into Customer values(customerID_seq.nextval, 'Ashley', 'Powell', '17 Valley Drive', 2123043923, 20);
insert into Customer values(customerID_seq.nextval, 'Joshua', 'Davis', '1212 8th St.', 7818914567, 18);

--select * from Customer;

create table Ship(
  shipName varchar2(20),
  companyName varchar2(15),
  yearBuilt number(4),
  crew number(4),
  passengers number(4),
  tonnage number(6),
  dailyTips number(5, 2),
  Constraint Ship_pk Primary Key(shipName, companyName),
  Constraint Ship_company_FK Foreign Key(companyName) References Company(companyName),
  Constraint Ship_yearBuilt check(yearBuilt >= 1822),
  Constraint Ship_tonnage check(tonnage >= 50000 AND tonnage <= 110000 OR (tonnage= 65000 OR tonnage= 80000 OR tonnage= 95000))
);

insert into Ship values('Spirit', 'Carnival', 1997, 930, 2124, 95000, 9.95);
insert into Ship values('Equinox', 'Celebrity', 2009, 1255, 2850, 95000, 15.50);
insert into Ship values('Jewel', 'NCL', 2005, 1069, 2376, 50000, 12.75);
insert into Ship values('Pearl', 'NCL', 2006, 1072, 2394, 65000, 12.75);
insert into Ship values('Crown', 'Princess', 2018, 1200, 3080, 110000, 14.00);

select * from Ship;

create table Cruise(
    cruiseID number,
    cruiseName varchar2(25),
    departurePort varchar2(20),
    days number(2),
    companyName varchar2(15),
    shipName varchar2(30),
    price number(7, 2),
    Constraint Cruise_pk Primary Key(cruiseID),
    Constraint Cruise_companyName_FK Foreign Key(companyName) References Company(companyName)
      On Delete Set Null,
    Constraint Cruise_shipName_companyName_FK Foreign Key(shipName, companyName) References Ship(shipName, companyName)
      On Delete Cascade
);

create sequence cruiseID_seq
start with 1;

insert into Cruise values(cruiseID_seq.nextval, 'Mexico', 'Miami', 7, 'NCL', 'Pearl', 799.00);
insert into Cruise values(cruiseID_seq.nextval, 'New England', 'Boston', 7, 'NCL', 'Jewel', 895.75);
insert into Cruise values(cruiseID_seq.nextval, 'ABC Islands', 'Miami', 4, 'Celebrity', 'Equinox', 450.50);
insert into Cruise values(cruiseID_seq.nextval, 'Hawaii', 'San Francisco', 14, 'Princess', 'Crown', 2310.00);
insert into Cruise values(cruiseID_seq.nextval, 'Panama Canal', 'Miami', 10, 'Carnival', 'Spirit', 1432.99);

--select * from Cruise;

create table Reservation(
    reservationID number,
    customerID number,
    cruiseID number,
    travelAgentID number,
    travelDate date,
    paymentDate date,
    Constraint Reservation_pk Primary Key(reservationID),
    Constraint Reservation_customerID_FK Foreign Key(customerID) References Customer(customerID)
      On Delete Cascade,
    Constraint Reservation_cruiseID_FK Foreign Key(cruiseID) References Cruise(cruiseID)
      On Delete Cascade,
    Constraint Reservation_travelAgentID_FK Foreign Key(travelAgentID) References TravelAgent(travelAgentID)
      On Delete Cascade
);

create sequence reservationID_seq
start with 1;

insert into Reservation values(reservationID_seq.nextval, 12, 1, 2, '9-Nov-18', null);
insert into Reservation values(reservationID_seq.nextval, 14, 4, 5, '21-Jan-19', null);
insert into Reservation values(reservationID_seq.nextval, 5, 4, 1, '11-Dec-18', null);
insert into Reservation values(reservationID_seq.nextval, 9, 5, 4, '31-Aug-19', null);
insert into Reservation values(reservationID_seq.nextval, 13, 1, 2, '10-Apr-19', null);
insert into Reservation values(reservationID_seq.nextval, 5, 4, 6, '29-Jul-18', null);
insert into Reservation values(reservationID_seq.nextval, 2, 2, 2, '17-May-19', null);
insert into Reservation values(reservationID_seq.nextval, 4, 1, 10, '11-Apr-19', null);
insert into Reservation values(reservationID_seq.nextval, 10, 5, 3, '3-Jun-18', null);
insert into Reservation values(reservationID_seq.nextval, 5, 3, 9, '15-Oct-18', null);
insert into Reservation values(reservationID_seq.nextval, 1, 2, 7, '8-Mar-19', null);
insert into Reservation values(reservationID_seq.nextval, 5, 4, 7, '24-Nov-18', null);
insert into Reservation values(reservationID_seq.nextval, 8, 1, 1, '3-Aug-19', null);
insert into Reservation values(reservationID_seq.nextval, 15, 5, 10, '13-Dec-18', null);
insert into Reservation values(reservationID_seq.nextval, 4, 3, 7, '6-Feb-19', null);
insert into Reservation values(reservationID_seq.nextval, 6, 4, 5, '12-Aug-19', null);
insert into Reservation values(reservationID_seq.nextval, 14, 2, 8, '22-Jun-19', null);
insert into Reservation values(reservationID_seq.nextval, 11, 5, 9, '1-Feb-19', null);
insert into Reservation values(reservationID_seq.nextval, 7, 4, 8, '15-Mar-19', null);
insert into Reservation values(reservationID_seq.nextval, 14, 4, 3, '28-Feb-19', null);

--select * from Reservation;

--3aa
update Reservation set travelDate= travelDate + 395;
select * from Reservation;

-- 3ab 
update Reservation set paymentDate= greatest(travelDate - 120, TRUNC(SYSDATE));

select * from Reservation;

-- 3ac
update Reservation set paymentDate= TRUNC(SYSDATE)
where travelDate < TRUNC(SYSDATE);

-- 3b
select shipName, companyName, (crew + passengers) AS TotalPeople
from SHIP
where crew+passengers > 3500 AND companyName IN(select companyName from Company where stockSymbol like '%R%');

-- 3c -- calculated per person per day
select shipT.companyName, shipT.shipName, to_char(SUM(cruiseT.price + (shipT.dailyTips * cruiseT.days)), '$99990.99') AS TotalPrice
from Reservation reserv JOIN Cruise cruiseT 
on reserv.cruiseID = cruiseT.cruiseID
JOIN Ship shipT
on shipT.companyName = cruiseT.companyName AND shipT.shipName = cruiseT.shipName
group by rollup (shipT.companyName, shipT.shipName);

-- 3d
select cruiseT2.companyName, Sum(cruiseT2.days) AS SUMDAYS
from Reservation reservT JOIN Cruise cruiseT2 
on cruiseT2.cruiseID = reservT.cruiseID
JOIN Company companyT
on cruiseT2.companyName = companyT.companyName
group by cruiseT2.companyName
having Sum(cruiseT2.days)= (select MAX(CNT) as MaxCount 
    from (select SUM(cruiseT21.days) AS CNT 
            from Reservation reservT1 JOIN Cruise cruiseT21 
            on cruiseT21.cruiseID = reservT1.cruiseID
            JOIN Company companyT1
            on cruiseT21.companyName = companyT1.companyName
            group by cruiseT21.companyName));
