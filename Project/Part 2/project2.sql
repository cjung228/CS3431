-- Maria Medina Martinez and Caitlin Jung

drop table Doctor cascade constraint;
drop table OP cascade constraint;
drop table PCP cascade constraint;
drop table Surgeon cascade constraint;
drop table Organ cascade constraint;
drop table Patient cascade constraint;
drop table Operation cascade constraint;
drop table SurgeonPatient cascade constraint;
drop sequence physicianID_seq;
drop sequence healthCareID_seq;
drop sequence invoiceNumber_seq;

create table Doctor (
    physicianID number,
    Role varchar2(25),
    firstName varchar2(25),
    lastName varchar2(25),
    constraint Doctor_PK primary key (physicianID),
    constraint Doctor_UN unique (physicianID, Role),
    constraint DoctorRoleVal check (Role in ('OP', 'PCP', 'Surgeon', 'Other'))
);

create sequence physicianID_seq
  start with 100
  increment by 5;

create table OP (
    physicianID number,
    Role varchar2(25) default 'OP' not null,
    organType varchar2(25),
    organBank varchar2(25),
    constraint OP_PK primary key (physicianID),
    constraint OPRoleVal check (Role in ('OP')),
    constraint OP_FK foreign key (physicianID, Role) references Doctor (physicianID, Role)
);

create table PCP (
    physicianID number,
    Role varchar2(25) default 'PCP' not null,
    specialty varchar2(25),
    medicalFacility varchar2(25),
    constraint PCP_PK primary key (physicianID),
    constraint PCPRoleVal check (Role in ('PCP')),
    constraint PCP_FK foreign key (physicianID, Role) references Doctor (physicianID, Role)
);

create table Surgeon (
    physicianID number,
    Role varchar2(25) default 'Surgeon' not null,
    boardCertified char(1),
    constraint Surgeon_PK primary key (physicianID),
    constraint SurgeonRoleVal check (Role in ('Surgeon')),
    constraint SurgeonBoardCertifiedVal check (boardCertified in ('T', 'F')),
    constraint Surgeon_FK foreign key (physicianID, Role) references Doctor (physicianID, Role)
);

create table Patient (
    healthCareID number,
    firstName varchar2(25),
    lastName varchar2(25),
    city varchar2(25),
    state char(2),
    birthDate date,
    bloodType varchar2(25),
    physicianID number,
    constraint Patient_PK primary key (healthCareID),
    constraint Patient_FK foreign key (physicianID) references PCP(physicianID),
    constraint PatientVal check (bloodType in ('A', 'B', 'AB', 'O'))
);

-- You could have included a value check for blood type as one of the following:
-- A, B, AB, O

create sequence healthCareID_seq
  start with 100
  increment by 5;

create table Organ (
    organID number,
    physicianID number,
    bloodType varchar2(25),
    dateRemoved date,
    healthCareID number,
    constraint Organ_PK primary key (organID, physicianID),
    constraint Organ_FK1 foreign key (physicianID) references OP(physicianID),
    constraint Organ_FK2 foreign key (healthCareID) references Patient(healthCareID),
    constraint OrganVal check (bloodType in ('A', 'B', 'AB', 'O'))
);

create table Operation (
    invoiceNumber number,
    operationDate date,
    isSuccessful char(1),
    cost number(9,2),
    physicianID number,
    healthCareID number,
    constraint Operation_PK primary key (invoiceNumber),
    constraint Operation_FK1 foreign key (physicianID) references Surgeon (physicianID),
    constraint Operation_FK2 foreign key (healthCareID) references Patient(healthCareID),
    constraint OperationVal check (isSuccessful in ('T', 'F'))
);

create sequence invoiceNumber_seq
  start with 100
  increment by 5;

create table SurgeonPatient (
    physicianID number,
    healthCareID number,
    constraint SurgeonPatient_PK primary key (physicianID, healthCareID),
    constraint SurgeonPatient_FK1 foreign key (physicianID) references Surgeon (physicianID),
    constraint SurgeonPatient_FK2 foreign key (healthCareID) references Patient(healthCareID)
);

-- Question 1

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
insert into PCP values(100, 'PCP', 'Family Medicine', 'Brigham & Womens Hospital');
insert into PCP values(105, 'PCP', 'Internal Medicine', 'Lawrence General Hospital');
insert into PCP values(110, 'PCP', 'Pediatrics', 'Boston Childrens Hospital');
insert into PCP values(115, 'PCP', 'OBGYN', 'Mass General');
insert into PCP values(120, 'PCP', 'Geriatrics', 'Mass General');

-- inserting 5 surgeons
insert into Surgeon values(125, 'Surgeon', 'T');
insert into Surgeon values(130, 'Surgeon', 'F');
insert into Surgeon values(135, 'Surgeon', 'T');
insert into Surgeon values(140, 'Surgeon', 'T');
insert into Surgeon values(145, 'Surgeon', 'F');

-- insert 3 OPs
insert into OP values(150, 'OP', 'Heart', 'New England Organ Bank');
insert into OP values(155, 'OP', 'Liver', 'Legacy of Hope');
insert into OP values(160, 'OP', 'Kidney', 'Donor Alliance');

-- inserting 20 patients
insert into Patient values(healthCareID_seq.nextVal, 'Olga', 'Ramsey', 'Boston', 'MA', '27-Nov-98', 'O', 100);
insert into Patient values(healthCareID_seq.nextVal, 'Martin', 'Moss', 'Chicago', 'IL', '9-Jan-98', 'AB', 105);
insert into Patient values(healthCareID_seq.nextVal, 'Paris', 'Lichen', 'Los Angeles', 'CA', '4-Feb-94', 'B', 110);
insert into Patient values(healthCareID_seq.nextVal, 'France', 'Lincoln', 'Miami', 'FL', '7-Mar-99', 'A', 115);
insert into Patient values(healthCareID_seq.nextVal, 'Asia', 'Vanish', 'Denver', 'CO', '12-Apr-99', 'O', 120);
insert into Patient values(healthCareID_seq.nextVal, 'India', 'Barnish', 'Seattle', 'WA', '5-May-49', 'O', 125);
insert into Patient values(healthCareID_seq.nextVal, 'Denise', 'Mesquite', 'Portland', 'OR', '21-Jun-67', 'B', 130);
insert into Patient values(healthCareID_seq.nextVal, 'Courtney', 'Graham', 'Branson', 'MO', '3-Jul-71', 'AB', 135);
insert into Patient values(healthCareID_seq.nextVal, 'Anthony', 'Lecter', 'Charlestown', 'SC', '7-Aug-97', 'O', 140);
insert into Patient values(healthCareID_seq.nextVal, 'Jennifer', 'Franklin', 'Plymouth', 'MA', '25-Sep-98', 'AB', 145);
insert into Patient values(healthCareID_seq.nextVal, 'Art', 'Garza', 'Augusta', 'ME', '28-Nov-00', 'A', 150);
insert into Patient values(healthCareID_seq.nextVal, 'Menton', 'Denton', 'Austin', 'TX', '29-Oct-98', 'B', 155);
insert into Patient values(healthCareID_seq.nextVal, 'Charles', 'Tomlinson', 'Las Vegas', 'NV', '18-May-98', 'O', 160);
insert into Patient values(healthCareID_seq.nextVal, 'Charlie', 'Malek', 'NYC', 'NY', '9-Dec-87', 'A', 100);
insert into Patient values(healthCareID_seq.nextVal, 'Willy', 'Wonka', 'Itasca', 'IL', '19-Jan-98', 'A', 105);
insert into Patient values(healthCareID_seq.nextVal, 'Steve', 'Horan', 'Hershey', 'PA', '1-Feb-94', 'B', 110);
insert into Patient values(healthCareID_seq.nextVal, 'Dartagnan', 'Payne', 'Ithaca', 'NY', '19-Mar-97', 'AB', 115);
insert into Patient values(healthCareID_seq.nextVal, 'Tamarind', 'Styles', 'Jackson Hole', 'WY', '10-Apr-98', 'O', 120);
insert into Patient values(healthCareID_seq.nextVal, 'Wilford', 'Washington', 'Bellevue', 'WA', '29-May-96', 'O', 125);
insert into Patient values(healthCareID_seq.nextVal, 'Winston', 'Churchill', 'Bel Air', 'CA', '1-Jun-45', 'AB', 130);

-- organ
insert into Organ values(1, 150, 'A', '9-Dec-18', 150);
insert into Organ values(2, 155, 'AB', '3-Jan-13', 155);
insert into Organ values(3, 160, 'B', '15-Mar-12', 160);
insert into Organ values(4, 150, 'O', '15-Apr-19', 150);
insert into Organ values(5, 155, 'O', '9-May-18', 155);

-- insert 20 operations
insert into Operation values(invoiceNumber_seq.nextVal, '9-Jan-18', 'T', 1333.09, 125, 100);
insert into Operation values(invoiceNumber_seq.nextVal, '19-Jul-18', 'T', 23.00, 130, 105);
insert into Operation values(invoiceNumber_seq.nextVal, '23-Aug-18', 'T', 4546.45, 135, 110);
insert into Operation values(invoiceNumber_seq.nextVal, '24-Mar-18', 'T', 43243.00, 140, 115);
insert into Operation values(invoiceNumber_seq.nextVal, '26-Feb-18',  'T', 5433.42, 145, 120);
insert into Operation values(invoiceNumber_seq.nextVal, '18-Jan-18', 'T', 123.00, 125, 125);
insert into Operation values(invoiceNumber_seq.nextVal, '1-Nov-18', 'T', 4243.78, 130, 130);
insert into Operation values(invoiceNumber_seq.nextVal, '4-May-18', 'F', 786.99, 135, 135);
insert into Operation values(invoiceNumber_seq.nextVal, '6-Nov-18', 'T', 5467.88, 140, 140);
insert into Operation values(invoiceNumber_seq.nextVal, '8-Feb-18','T', 675.99, 145, 145);
insert into Operation values(invoiceNumber_seq.nextVal, '13-Jul-18','T', 10000.99, 125, 150);
insert into Operation values(invoiceNumber_seq.nextVal, '3-May-18', 'T', 7687.56, 130, 155);
insert into Operation values(invoiceNumber_seq.nextVal, '9-Nov-18', 'T', 4567.88, 135, 160);
insert into Operation values(invoiceNumber_seq.nextVal, '7-Sep-18',  'T', 100.67, 140, 165);
insert into Operation values(invoiceNumber_seq.nextVal, '3-Dec-18','T', 678.99, 145, 170);
insert into Operation values(invoiceNumber_seq.nextVal, '10-Nov-18','T', 9889.99, 125, 175);
insert into Operation values(invoiceNumber_seq.nextVal, '13-Oct-18','T', 675.88, 130, 180);
insert into Operation values(invoiceNumber_seq.nextVal, '14-Apr-18','T', 547.77, 135, 185);
insert into Operation values(invoiceNumber_seq.nextVal, '7-Nov-18', 'T', 345.88, 140, 190);
insert into Operation values(invoiceNumber_seq.nextVal, '28-Feb-18',  'T', 98.78, 145, 195);

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


-- Question 2
create or replace view MatchingBloodTypes as 
    select oop.organType, P.bloodType, count(P.bloodtype) AS NumberOfPatients
    from Organ O JOIN Patient P
    on O.healthcareID = P.healthcareID
    JOIN OP oop
    on O.physicianID = oop.physicianID
    group by rollup(oop.organType, P.bloodType)
    order by oop.organType, P.bloodType asc;

-- Question 3
create or replace procedure SurgeonOperations(f in varchar2, l in varchar2) is
    tot_ops number; 
    firstN varchar(25);
    lastN varchar(25);
    BEGIN
        select D.firstName, D.lastName, count(O.invoiceNumber) into firstN, lastN, tot_ops
        from Surgeon S join Doctor D
        on S.physicianID = D.physicianID
        join Operation O
        on S.physicianID = O.physicianID
        where D.firstName = f and D.lastName = l
        group by (D.firstName, D.lastName);

        dbms_output.put_line('Dr. ' || f || ' ' || l || ': ' || tot_ops || ' operations');
        
    exception
        when NO_DATA_FOUND then
            raise_application_error(-20001, 'There is no surgeon who has operated with the name of Dr. ' || f || ' ' || l);
    END SurgeonOperations;
/

-- Question 4
create or replace trigger InsertErrorBirthDates
before insert on Patient
for each row
begin
    if :new.birthDate > SYSDATE then
        raise_application_error(-20001, 'Birth date must be before current date');
    end if;
end; 
/

-- Question 5
create or replace trigger BadBloodType
after insert on Operation
for each row
declare
    organBType varchar2(2);
    patientBType varchar2(2);
begin
    select bloodType into organBType
    from Organ
    where Organ.healthCareID = :new.healthCareID;
    
    select bloodType into patientBType
    from Patient
    where Patient.healthCareID = :new.healthCareID;

    if organBType != patientBType then
        raise_application_error(-20002, 'Patient blood type must match organ blood type');
    end if;
end; 
/

-- ALTER TRIGGER BadBloodType DISABLE;

-- Question 6
create or replace trigger FailedOperation
before insert on Operation
for each row
declare
    organBType varchar2(2);
    patientBType varchar2(2);
begin
    select bloodType into organBType
    from Organ
    where Organ.healthCareID = :new.healthCareID;
    
    select bloodType into patientBType
    from Patient
    where Patient.healthCareID = :new.healthCareID;

    if organBType != patientBType then
        :new.isSuccessful := 'F';
    end if;
end; 
/

-- Question 7
create or replace trigger NoMatch
before insert on Operation
for each row
declare
    patientID number;
    surgeonID number;
    surgpat_rec SurgeonPatient%ROWTYPE;
begin
    select healthCareID into patientID
    from Patient
    where Patient.healthCareID = :new.healthCareID;
    
    select physicianID into surgeonID
    from Surgeon
    where Surgeon.physicianID = :new.physicianID;

    select *  into surgpat_rec from SurgeonPatient SP
    where patientID = SP.healthcareid and surgeonID = sp.physicianid;
    
    exception
        when NO_DATA_FOUND then
            raise_application_error(-20001, 'The surgeon-patient match does not exist');
end; 
/