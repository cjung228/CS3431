-- Maria Medina Martinez and Caitlin Jung

drop table SurgeonPatient;
drop table Operation;
drop table Organ;
drop table Surgeon;
drop table OP;
drop table PCP;
drop table Doctor;
drop table Patient;

drop sequence patient_seq;
drop sequence doctor_seq;
drop sequence operation_seq;

create table Patient(
    healthCareID number,
    firstName varchar2(25),
    lastName varchar2(25),
    city varchar2(25),
    state varchar2(25),
    bloodType varchar2(5),
    birthDate date,
    Constraint patient_pk Primary Key (healthCareID)
);

create sequence patient_seq
start with 100
increment by 5;

create table Doctor(
    doctorID number,
    firstName varchar2(25),
    lastName varchar2(25),
    Constraint doctor_pk Primary Key(doctorID)
);

create sequence doctor_seq
start with 100
increment by 5;

create table Surgeon(
    doctorID number,
    isBoardCertified char(1),
    Constraint surgeon_pk Primary Key (doctorID),
    Constraint surgeon_fk Foreign Key(doctorID) References Doctor(doctorID)
);

create table OP(
    doctorID number,
    organBank varchar2(25),
    Constraint OP_pk Primary Key (doctorID),
    Constraint OP_fk Foreign Key(doctorID) References Doctor(doctorID)
);

create table PCP(
    doctorID number,
    specialty varchar2(25),
    medicalFacility varchar2(25),
    Constraint PCP_pk Primary Key (doctorID),
    Constraint PCP_fk Foreign Key(doctorID) References Doctor(doctorID)
);

create table Organ(
    organID number,
    organType varchar2(25),
    bloodType varchar2(5),
    dateRemoved date,
    doctorID number,
    Constraint Organ_pk Primary Key (organID),
    Constraint Organ_fk Foreign Key(doctorID) References Doctor(doctorID)
);

create table Operation(
    invoiceID number,
    operationDate date,
    totalCost number(7,2),
    isSuccessful char(1),
    doctorID number,
    healthCareID number,
    organID number,
    Constraint Operation_pk Primary Key(invoiceID),
    Constraint Organ_fk1 Foreign Key(doctorID) References Surgeon(doctorID),
    Constraint Organ_fk2 Foreign Key(healthCareID) References Patient(healthCareID),
    Constraint Organ_fk3 Foreign Key(organID) References Organ(organID)
);

create sequence operation_seq
start with 100
increment by 5;

create table SurgeonPatient(
    doctorID number,
    healthCareID number,
    Constraint SurgeonPatient_pk Primary Key(doctorID, healthCareID)
);

-- inserting 13 Doctors
insert into Doctor values(doctor_seq.nextVal, 'Ed','Cispen'); 
insert into Doctor values(doctor_seq.nextVal, 'John','Proxy'); 
insert into Doctor values(doctor_seq.nextVal, 'Mary','Mark'); 
insert into Doctor values(doctor_seq.nextVal, 'Matt','Burns'); 
insert into Doctor values(doctor_seq.nextVal, 'Edgar','Wright'); 
insert into Doctor values(doctor_seq.nextVal, 'Steve','Wilmington'); 
insert into Doctor values(doctor_seq.nextVal, 'Joseph','Stark'); 
insert into Doctor values(doctor_seq.nextVal, 'Gabe','Yert'); 
insert into Doctor values(doctor_seq.nextVal, 'Hunter','Hunt'); 
insert into Doctor values(doctor_seq.nextVal, 'Chad','Wick'); 
insert into Doctor values(doctor_seq.nextVal, 'Sam','Perton'); 
insert into Doctor values(doctor_seq.nextVal, 'Hazelugene','Bobweiser'); 
insert into Doctor values(doctor_seq.nextVal, 'Peggy','Merlow');

-- inserting 5 PCPs
insert into PCP values(100, 'Family Medicine', 'Brigham & Womens Hospital'); 
insert into PCP values(105, 'Internal Medicine', 'Lawrence General Hospital'); 
insert into PCP values(110, 'Pediatrics', 'Boston Childrens Hospital'); 
insert into PCP values(115, 'OBGYN', 'Mass General'); 
insert into PCP values(120, 'Geriatrics', 'Mass General'); 

-- inserting 5 surgeons
insert into Surgeon values(125, 'T'); 
insert into Surgeon values(130, 'F'); 
insert into Surgeon values(135, 'T'); 
insert into Surgeon values(140, 'T'); 
insert into Surgeon values(145, 'F'); 

-- insert 3 OPs
insert into OP values(150, 'New England Organ Bank'); 
insert into OP values(155, 'Legacy of Hope'); 
insert into OP values(160, 'Donor Alliance'); 

-- inserting 20 patients
insert into Patient values(patient_seq.nextVal, 'Olga', 'Ramsey', 'Boston', 'MA' , 'O', '27-Nov-98'); 
insert into Patient values(patient_seq.nextVal, 'Martin', 'Moss', 'Chicago', 'IL', 'AB', '9-Jan-98'); 
insert into Patient values(patient_seq.nextVal, 'Paris', 'Lichen', 'Los Angeles', 'CA' , 'B', '4-Feb-94'); 
insert into Patient values(patient_seq.nextVal, 'France', 'Lincoln', 'Miami', 'FL' , 'A', '7-Mar-99'); 
insert into Patient values(patient_seq.nextVal, 'Asia', 'Vanish', 'Denver', 'CO' , 'O+', '12-Apr-99'); 
insert into Patient values(patient_seq.nextVal, 'India', 'Barnish', 'Seattle', 'WA' , 'O-', '5-May-49'); 
insert into Patient values(patient_seq.nextVal, 'Denise', 'Mesquite', 'Portland', 'OR' , 'B', '21-Jun-67'); 
insert into Patient values(patient_seq.nextVal, 'Courtney', 'Graham', 'Branson', 'MO' , 'AB', '3-Jul-71'); 
insert into Patient values(patient_seq.nextVal, 'Anthony', 'Lecter', 'Charlestown', 'SC' , 'O-', '7-Aug-97'); 
insert into Patient values(patient_seq.nextVal, 'Jennifer', 'Franklin', 'Plymouth', 'MA' , 'AB', '25-Sep-98'); 
insert into Patient values(patient_seq.nextVal, 'Art', 'Garza', 'Augusta', 'ME' , 'A', '28-Nov-00'); 
insert into Patient values(patient_seq.nextVal, 'Menton', 'Denton', 'Austin', 'TX' , 'B', '29-Oct-98'); 
insert into Patient values(patient_seq.nextVal, 'Charles', 'Tomlinson', 'Las Vegas', 'NV' , 'O-', '18-May-98'); 
insert into Patient values(patient_seq.nextVal, 'Charlie', 'Malek', 'NYC', 'NY' , 'A', '9-Dec-87'); 
insert into Patient values(patient_seq.nextVal, 'Willy', 'Wonka', 'Itasca', 'IL' , 'A', '19-Jan-98'); 
insert into Patient values(patient_seq.nextVal, 'Steve', 'Horan', 'Hershey', 'PA' , 'B', '1-Feb-94'); 
insert into Patient values(patient_seq.nextVal, 'Dartagnan', 'Payne', 'Ithaca', 'NY' , 'AB', '19-Mar-97'); 
insert into Patient values(patient_seq.nextVal, 'Tamarind', 'Styles', 'Jackson Hole', 'WY' , 'O-', '10-Apr-98'); 
insert into Patient values(patient_seq.nextVal, 'Wilford', 'Washington', 'Bellevue', 'WA' , 'O+', '29-May-96'); 
insert into Patient values(patient_seq.nextVal, 'Winston', 'Churchill', 'Bel Air', 'CA' , 'AB', '1-Jun-45'); 

-- organ
insert into Organ values(1, 'Liver', 'A', '9-Dec-18',125); 
insert into Organ values(2 , 'Lung', 'AB','3-Jan-13',130); 
insert into Organ values(3, 'Heart','B','15-Mar-12',135); 
insert into Organ values(4, 'Kidney','O+','15-Apr-19',140); 
insert into Organ values(5, 'Pancreas','O-','9-May-18',145); 

-- insert 20 operations
insert into Operation values(operation_seq.nextVal, '9-Jan-18', 1333.09, 'T', 125, 100, 1); 
insert into Operation values(operation_seq.nextVal, '19-Jul-18', 23.00, 'T', 130, 105, 2); 
insert into Operation values(operation_seq.nextVal, '23-Aug-18', 4546.45, 'T', 135, 110, 3); 
insert into Operation values(operation_seq.nextVal, '24-Mar-18', 43243.00, 'T', 140, 115,4); 
insert into Operation values(operation_seq.nextVal, '26-Feb-18', 5433.42, 'T', 145, 120, 5); 
insert into Operation values(operation_seq.nextVal, '18-Jan-18', 123.00, 'T', 125, 125, 1); 
insert into Operation values(operation_seq.nextVal, '1-Nov-18', 4243.78, 'T', 130, 130, 2); 
insert into Operation values(operation_seq.nextVal, '4-May-18', 786.99, 'F', 135, 135, 3); 
insert into Operation values(operation_seq.nextVal, '6-Nov-18', 5467.88, 'T', 140, 140, 4); 
insert into Operation values(operation_seq.nextVal, '8-Feb-18', 675.99, 'T', 145, 145, 5); 
insert into Operation values(operation_seq.nextVal, '13-Jul-18', 10000.99, 'T', 125, 150, 1); 
insert into Operation values(operation_seq.nextVal, '3-May-18', 7687.56, 'T', 130, 155, 2); 
insert into Operation values(operation_seq.nextVal, '9-Nov-18', 4567.88, 'T', 135, 160, 3); 
insert into Operation values(operation_seq.nextVal, '7-Sep-18', 100.67, 'T', 140, 165,4); 
insert into Operation values(operation_seq.nextVal, '3-Dec-18', 678.99, 'T', 145, 170, 5); 
insert into Operation values(operation_seq.nextVal, '10-Nov-18', 9889.99, 'T', 125, 175, 1); 
insert into Operation values(operation_seq.nextVal, '13-Oct-18',675.88 , 'T', 130, 180, 2); 
insert into Operation values(operation_seq.nextVal, '14-Apr-18',547.77 , 'T', 135, 185, 3); 
insert into Operation values(operation_seq.nextVal, '7-Nov-18', 345.88, 'T', 140, 190, 4); 
insert into Operation values(operation_seq.nextVal, '28-Feb-18', 98.78, 'T', 145, 195, 5); 

-- surgeon patient
insert into SurgeonPatient values(125, 100);
insert into SurgeonPatient values(130, 105);
insert into SurgeonPatient values(135, 110);
insert into SurgeonPatient values(140, 115);
insert into SurgeonPatient values(145, 120);
insert into SurgeonPatient values(125, 125);
insert into SurgeonPatient values(130, 130);
insert into SurgeonPatient values(135, 135);
insert into SurgeonPatient values(140, 140);
insert into SurgeonPatient values(145, 145);
insert into SurgeonPatient values(125, 150);
insert into SurgeonPatient values(130, 155);
insert into SurgeonPatient values(135, 160);
insert into SurgeonPatient values(140, 165);
insert into SurgeonPatient values(145, 170);
insert into SurgeonPatient values(125, 175);
insert into SurgeonPatient values(130, 180);
insert into SurgeonPatient values(135, 185);
insert into SurgeonPatient values(140, 190);
insert into SurgeonPatient values(145, 195);

select * from Patient;
select * from Doctor;
select * from Surgeon;
select * from OP;
select * from PCP;
select * from Organ;
select * from Operation;
select * from SurgeonPatient;