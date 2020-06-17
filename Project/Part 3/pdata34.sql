create sequence physicianID_seq
  start with 34000
  increment by 10;

create sequence healthCareID_seq
  start with 34000
  increment by 10;

create sequence invoiceNumber_seq
  start with 34000
  increment by 10;

-- inserting 13 Doctors
insert into Doctor values(physicianID_seq.nextVal, 'PCP', 'Ed', 'Cispen');
insert into Doctor values(physicianID_seq.nextVal, 'PCP', 'John', 'Proxy');
insert into Doctor values(physicianID_seq.nextVal, 'PCP', 'Mary', 'Mark');
insert into Doctor values(physicianID_seq.nextVal, 'PCP', 'Matt', 'Burns');
insert into Doctor values(physicianID_seq.nextVal, 'PCP', 'Edgar', 'Wright');
insert into Doctor values(physicianID_seq.nextVal, 'Surgeon', 'Steve', 'Wilmington');
insert into Doctor values(physicianID_seq.nextVal, 'Surgeon', 'Joseph', 'Stark');
insert into Doctor values(physicianID_seq.nextVal, 'Surgeon', 'Gabe', 'Yert');
insert into Doctor values(physicianID_seq.nextVal, 'Surgeon', 'Hunter', 'Hunt');
insert into Doctor values(physicianID_seq.nextVal, 'Surgeon', 'Chad', 'Wick');
insert into Doctor values(physicianID_seq.nextVal, 'OP', 'Sam', 'Perton');
insert into Doctor values(physicianID_seq.nextVal, 'OP', 'Hazelugene', 'Bobweiser');
insert into Doctor values(physicianID_seq.nextVal, 'OP', 'Peggy', 'Merlow');

-- inserting 5 PCPs
insert into PCP values(34000, 'PCP', 'Family Medicine', 'Brigham & Womens Hospital');
insert into PCP values(34010, 'PCP', 'Internal Medicine', 'Lawrence General Hospital');
insert into PCP values(34020, 'PCP', 'Pediatrics', 'Boston Childrens Hospital');
insert into PCP values(34030, 'PCP', 'OBGYN', 'Mass General');
insert into PCP values(34040, 'PCP', 'Geriatrics', 'Mass General');

-- inserting 5 surgeons
insert into Surgeon values(34050, 'Surgeon', 'Y');
insert into Surgeon values(34060, 'Surgeon', 'N');
insert into Surgeon values(34070, 'Surgeon', 'Y');
insert into Surgeon values(34080, 'Surgeon', 'Y');
insert into Surgeon values(34090, 'Surgeon', 'N');

-- insert 3 OPs
insert into OP values(34100, 'OP', 'Heart', 'New England Organ Bank');
insert into OP values(34110, 'OP', 'Liver', 'Legacy of Hope');
insert into OP values(34120, 'OP', 'Kidney', 'Donor Alliance');

-- inserting 20 patients-- inserting 20 patients
insert into Patient values(healthCareID_seq.nextVal, 'Olga', 'Ramsey', 'Boston', 'MA', '27-Nov-98', 'O', 34000);
insert into Patient values(healthCareID_seq.nextVal, 'Martin', 'Moss', 'Chicago', 'IL', '9-Jan-98', 'AB', 34010);
insert into Patient values(healthCareID_seq.nextVal, 'Paris', 'Lichen', 'Los Angeles', 'CA', '4-Feb-94', 'B', 34020);
insert into Patient values(healthCareID_seq.nextVal, 'France', 'Lincoln', 'Miami', 'FL', '7-Mar-99', 'A', 34030);
insert into Patient values(healthCareID_seq.nextVal, 'Asia', 'Vanish', 'Denver', 'CO', '12-Apr-99', 'O', 34040);
insert into Patient values(healthCareID_seq.nextVal, 'India', 'Barnish', 'Seattle', 'WA', '5-May-49', 'O', 34000);
insert into Patient values(healthCareID_seq.nextVal, 'Denise', 'Mesquite', 'Portland', 'OR', '21-Jun-67', 'B', 34010);
insert into Patient values(healthCareID_seq.nextVal, 'Courtney', 'Graham', 'Branson', 'MO', '3-Jul-71', 'AB', 34020);
insert into Patient values(healthCareID_seq.nextVal, 'Anthony', 'Lecter', 'Charlestown', 'SC', '7-Aug-97', 'O', 34030);
insert into Patient values(healthCareID_seq.nextVal, 'Jennifer', 'Franklin', 'Plymouth', 'MA', '25-Sep-98', 'AB', 34040);
insert into Patient values(healthCareID_seq.nextVal, 'Art', 'Garza', 'Augusta', 'ME', '28-Nov-00', 'A', 34000);
insert into Patient values(healthCareID_seq.nextVal, 'Menton', 'Denton', 'Austin', 'TX', '29-Oct-98', 'B', 34010);
insert into Patient values(healthCareID_seq.nextVal, 'Charles', 'Tomlinson', 'Las Vegas', 'NV', '18-May-98', 'O', 34020);
insert into Patient values(healthCareID_seq.nextVal, 'Charlie', 'Malek', 'NYC', 'NY', '9-Dec-87', 'A', 34000);
insert into Patient values(healthCareID_seq.nextVal, 'Willy', 'Wonka', 'Itasca', 'IL', '19-Jan-98', 'A', 34010);
insert into Patient values(healthCareID_seq.nextVal, 'Steve', 'Horan', 'Hershey', 'PA', '1-Feb-94', 'B', 34020);
insert into Patient values(healthCareID_seq.nextVal, 'Dartagnan', 'Payne', 'Ithaca', 'NY', '19-Mar-97', 'AB', 34030);
insert into Patient values(healthCareID_seq.nextVal, 'Tamarind', 'Styles', 'Jackson Hole', 'WY', '10-Apr-98', 'O', 34040);
insert into Patient values(healthCareID_seq.nextVal, 'Wilford', 'Washington', 'Bellevue', 'WA', '29-May-96', 'O', 34000);
insert into Patient values(healthCareID_seq.nextVal, 'Winston', 'Churchill', 'Bel Air', 'CA', '1-Jun-45', 'AB', 34010);

-- organ
insert into Organ values(1, 34100, 'A', '9-Dec-18', 34100);
insert into Organ values(2, 34110, 'AB', '3-Jan-13', 34110);
insert into Organ values(3, 34120, 'B', '15-Mar-12', 34120);
insert into Organ values(4, 34100, 'O', '15-Apr-19', 34100);
insert into Organ values(5l, 34110, 'O', '9-May-18', 34110);

-- insert 20 operations
select * from Patient;
insert into Operation values(invoiceNumber_seq.nextVal, '9-Jan-18', 'Y', 1333.09, 34050, 34000);
insert into Operation values(invoiceNumber_seq.nextVal, '19-Jul-18', 'Y', 23.00, 34060, 34010);
insert into Operation values(invoiceNumber_seq.nextVal, '23-Aug-18', 'Y', 4546.45, 34070, 34020);
insert into Operation values(invoiceNumber_seq.nextVal, '24-Mar-18', 'Y', 43243.00, 34080, 34030);
insert into Operation values(invoiceNumber_seq.nextVal, '26-Feb-18',  'Y', 5433.42, 34090, 34040);
insert into Operation values(invoiceNumber_seq.nextVal, '18-Jan-18', 'Y', 123.00, 34050, 34050);
insert into Operation values(invoiceNumber_seq.nextVal, '1-Nov-18', 'Y', 4243.78, 34060, 34060);
insert into Operation values(invoiceNumber_seq.nextVal, '4-May-18', 'N', 786.99, 34070, 34070);
insert into Operation values(invoiceNumber_seq.nextVal, '6-Nov-18', 'Y', 5467.88, 34080, 34080);
insert into Operation values(invoiceNumber_seq.nextVal, '8-Feb-18','Y', 675.99, 34090, 34090);
insert into Operation values(invoiceNumber_seq.nextVal, '13-Jul-18','Y', 3400.99, 34050, 34100);
insert into Operation values(invoiceNumber_seq.nextVal, '3-May-18', 'Y', 7687.56, 34060, 34110);
insert into Operation values(invoiceNumber_seq.nextVal, '9-Nov-18', 'Y', 4567.88, 34070, 34120);
insert into Operation values(invoiceNumber_seq.nextVal, '7-Sep-18',  'Y', 340.67, 34080, 34130);
insert into Operation values(invoiceNumber_seq.nextVal, '3-Dec-18','Y', 678.99, 34090, 34140);
insert into Operation values(invoiceNumber_seq.nextVal, '10-Nov-18','Y', 9889.99, 34050, 34150);
insert into Operation values(invoiceNumber_seq.nextVal, '13-Oct-18','Y', 675.88, 34060, 34160);
insert into Operation values(invoiceNumber_seq.nextVal, '14-Apr-18','Y', 547.77, 34070, 34170);
insert into Operation values(invoiceNumber_seq.nextVal, '7-Nov-18', 'Y', 345.88, 34080, 34180);
insert into Operation values(invoiceNumber_seq.nextVal, '28-Feb-18',  'Y', 98.78, 34090, 34190);

-- surgeon patient
insert into SurgeonPatient values(34050, 34000);
insert into SurgeonPatient values(34060, 34010);
insert into SurgeonPatient values(34070, 34020);
insert into SurgeonPatient values(34080, 34030);
insert into SurgeonPatient values(34090, 34040);
insert into SurgeonPatient values(34050, 34050);
insert into SurgeonPatient values(34060, 34060);
insert into SurgeonPatient values(34070, 34070);
insert into SurgeonPatient values(34080, 34080);
insert into SurgeonPatient values(34090, 34090);
insert into SurgeonPatient values(34050, 34100);
insert into SurgeonPatient values(34060, 34110);
insert into SurgeonPatient values(34070, 34120);
insert into SurgeonPatient values(34080, 34130);
insert into SurgeonPatient values(34090, 34140);
insert into SurgeonPatient values(34050, 34150);
insert into SurgeonPatient values(34060, 34160);
insert into SurgeonPatient values(34070, 34170);
insert into SurgeonPatient values(34080, 34180);
insert into SurgeonPatient values(34090, 34190);