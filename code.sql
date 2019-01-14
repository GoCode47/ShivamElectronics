
create table user(
	username varchar(20) PRIMARY KEY not null,
	password varchar(100) not null,
	fname varchar(20) not null,
	lname varchar(20) not null,
	acNo bigint not null,
	ifsc varchar(20) not null,
	house varchar(50) not null,
	street varchar(50) not null,
	city varchar(50) not null,
	state varchar(50) not null,
	pincode int not null
);

create table userPhone(
	username varchar(20),
	phone bigint,
	PRIMARY key(username,phone),
	foreign key(username) references User(username) on delete cascade on update cascade
);

create table userEmail(
	username varchar(20),
	email varchar(50),
	PRIMARY key(username,email),
	foreign key(username) references User(username) on delete cascade on update cascade
);

create table administrator(
	username varchar(20) not null PRIMARY key,
	password varchar(100) not null,
	fname varchar(20) not null,
	lname varchar(20) not null,
	acNo bigint not null,
	ifsc varchar(50) not null,
	house varchar(50) not null,
	street varchar(50) not null,
	city varchar(50) not null,
	state varchar(50) not null,
	pincode int not null 
);

create table adminPhone(
	username varchar(20),
	phone bigint,
	PRIMARY key(username,phone),
	foreign key(username) references administrator(username) on delete cascade on update cascade
);

create table adminEmail(
	username varchar(20),
	email varchar(50),
	PRIMARY key(username,email),
	foreign key(username) references administrator(username) on delete cascade on update cascade
);

CREATE TABLE Employee(
   EMPID   INT NOT NULL AUTO_INCREMENT,
   EMPNAME VARCHAR(20) NOT NULL,
   EMPAGE  INT NOT NULL,
   SALARY BIGINT NOT NULL,
   house varchar(50) not null,
	street varchar(50) not null,
	city varchar(50) not null,
	state varchar(50) not null,
	pincode int not null,
	adminName varchar(20) not null,
	acNo bigint not null,
	ifsc varchar(20) not null,
   PRIMARY KEY (EMPID),
   foreign key(adminName) references administrator(username) on delete restrict on update cascade
);

create table employeePhone(
	EMPID int,
	phone bigint,
	PRIMARY key(EMPID,phone),
	foreign key(EMPID) references Employee(EMPID) on delete cascade on update cascade
);

create table employeeEmail(
	EMPID int,
	email varchar(50),
	PRIMARY key(EMPID,email),
	foreign key(EMPID) references Employee(EMPID) on delete cascade on update cascade
);

create table salaryLog(
	EMPID int,
	amount int,
	doi date,
	PRIMARY key(EMPID,doi),
	foreign key(EMPID) references Employee(EMPID) on delete cascade on update cascade
);

create table dealer(
	dealerID int not null AUTO_INCREMENT,
	name varchar(40),
	house varchar(50) not null,
	street varchar(50) not null,
	city varchar(50) not null,
	state varchar(50) not null,
	pincode int not null,
	adminName varchar(20) not null,
	PRIMARY key(dealerID),
	foreign key(adminName) references administrator(username) on delete restrict on update cascade
);

create table dealerPhone(
	dealerID int,
	phone bigint,
	PRIMARY key(dealerID,phone),
	foreign key(dealerID) references dealer(dealerID) on delete cascade on update cascade
);

create table dealerEmail(
	dealerID int,
	email varchar(50),
	PRIMARY key(dealerID,email),
	foreign key(dealerID) references dealer(dealerID) on delete cascade on update cascade
);

create table dealerLog(
	dealerID int,
	dealerInvoiceID varchar(20),
	amount int,
	doi date,
	PRIMARY key(dealerID,dealerInvoiceID),
	foreign key(dealerID) references dealer(dealerID) on delete cascade on update cascade
);

create table manufacturer(
	manName varchar(20),
	sdate date,
	edate date,
	did int,
	PRIMARY key(manName),
	foreign key(did) references dealer(dealerID) on delete restrict on update cascade
);

create table manPhone(
	manName varchar(20),
	phone bigint,
	PRIMARY key(manName,phone),
	foreign key(manName) references manufacturer(manName) on delete cascade on update cascade
);

create table manEmail(
	manName varchar(20),
	email varchar(20),
	PRIMARY key(manName,email),
	foreign key(manName) references manufacturer(manName) on delete cascade on update cascade
);

create table transporter(
	transporterID int not null AUTO_INCREMENT,
	name varchar(40),
	house varchar(50) not null,
	street varchar(50) not null,
	city varchar(50) not null,
	state varchar(50) not null,
	pincode int not null,
	adminName varchar(20) not null,
	PRIMARY key(transporterID),
	foreign key(adminName) references administrator(username) on delete restrict on update cascade
);

create table transporterPhone(
	transporterID int,
	phone bigint,
	PRIMARY key(transporterID,phone),
	foreign key(transporterID) references transporter(transporterID) on delete cascade on update cascade
);

create table transporterEmail(
	transporterID int,
	email varchar(50),
	PRIMARY key(transporterID,email),
	foreign key(transporterID) references transporter(transporterID) on delete cascade on update cascade
);

create table transporterLog(
	transporterID int,
	transporterInvoiceID varchar(20),
	amount int,
	doi date,
	PRIMARY key(transporterID,transporterInvoiceID),
	foreign key(transporterID) references transporter(transporterID) on delete cascade on update cascade
);

create table warehouse(
	warehouseID int not null AUTO_INCREMENT,
	capacity int not null,
	filled int not null,
	spaceLeft int not null,
	house varchar(50) not null,
	street varchar(50) not null,
	city varchar(50) not null,
	state varchar(50) not null,
	pincode int not null,
	PRIMARY key(warehouseID)
);

create table article(
	articleID int not null AUTO_INCREMENT,
	name varchar(20) not null,
	type varchar(20) not null,
	price decimal not null,
	warranty int not null,
	warehouseID int not null,
	manufacturer varchar(20) NOT NULL,
	stock int,
	image mediumblob,
	filename varchar(50),
	contentType varchar(50),
	PRIMARY key(articleID),
	foreign key(warehouseID) references warehouse(warehouseID) on delete restrict on update cascade,
	foreign key(manufacturer) references manufacturer(manName) on delete cascade on update cascade
);

create table invoice(
	invoiceID BIGINT not null AUTO_INCREMENT,
	invoiceAmount BIGINT not null,
    delivery boolean not null,
	genDate date,
	customerID varchar(20),
	PRIMARY key(invoiceID),
	foreign key(customerID) references User(username) on delete cascade on update cascade
);

create table invoiceEntry(
	invoiceID BIGINT not null,
    articleID int not null,
    quantity int not null,
    Primary key(invoiceID, articleID),
    foreign key(invoiceID) references invoice(invoiceID) on delete cascade on update cascade,
    foreign key(articleID) references article(articleID) on delete cascade on update cascade
);

create table warehouseTransport(
	warehouseID int not null,
	transporterID int not null,
	PRIMARY key(warehouseID,transporterID),
	foreign key(warehouseID) references warehouse(warehouseID) on delete cascade on update cascade,
	foreign key(transporterID) references transporter(transporterID) on delete cascade on update cascade
);

create table cart(
	username varchar(20) not null,
    articleID int not null,
    quantity int not null,
    primary key(username, articleId),
    foreign key(articleID) references article(articleID) on delete cascade on update cascade,
    foreign key(username) references user(username) on delete cascade on update cascade
);

insert into administrator values('hello','5oGYmUj0lDV21nldVBqy0g==','Suyash','Shukla',31339608617,'SBIN01458','Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005);

insert into administrator values('suyash','5oGYmUj0lDV21nldVBqy0g==','Suyash','Shukla',31339608617,'SBIN01458','Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005);

insert into User values('hello','5oGYmUj0lDV21nldVBqy0g==', 'Suyash', 'Shukla', 4565871516,'SBIN00387','Room 62, CV Raman Hostel', 'IIT BHU', 'Varanasi','UP', 221005);	

insert into User values('suyash','5oGYmUj0lDV21nldVBqy0g==', 'Suyash', 'Shukla', 4565871516,'SBIN00387','Room 62, CV Raman Hostel', 'IIT BHU', 'Varanasi','UP', 221005);		

insert into adminPhone values('hello',7892169621);

insert into adminPhone values('hello',2876862812);

insert into adminPhone values('suyash',7892169621);

insert into adminPhone values('suyash',7892123213);

insert into adminEmail values('suyash','ss@gmail.com');

insert into adminEmail values('hello','ss@gmail.com');

insert into UserPhone values('hello',2177026638);

insert into UserPhone values('hello',7892169621);

insert into UserPhone values('suyash',7892169621);

insert into UserPhone values('suyash',7822169621);

insert into UserEmail values('suyash','ss@gmail.com');

insert into UserEmail values('hello','ss@gmail.com');

insert into dealer(name,house,street,city,state,pincode,adminName) values('CV Traders', 'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'hello');

insert into dealer(name,house,street,city,state,pincode,adminName) values('Hello Traders', 'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'suyash');	

insert into dealer(name,house,street,city,state,pincode,adminName) values('HB Traders', 'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'hello');

insert into dealerPhone values(1,2177026638);

insert into dealerPhone values(2,4177026638);

insert into dealerPhone values(3,4770266383);

insert into dealerEmail values(1,'xyz@gmail.com');

insert into dealerEmail values(2,'ddsz@gmail.com');

insert into dealerEmail values(3,'fgh@gmail.com');

insert into transporter(name,house,street,city,state,pincode,adminName) values('KC Transports', 'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'hello');

insert into transporter(name,house,street,city,state,pincode,adminName) values('Welcome transporters', 'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'suyash');	

insert into transporter(name,house,street,city,state,pincode,adminName) values('A1 Transports', 'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'hello');

insert into transporterPhone values(1,2177026638);

insert into transporterPhone values(2,4177026638);

insert into transporterPhone values(3,4770266383);

insert into transporterEmail values(1,'xyz@gmail.com');

insert into transporterEmail values(2,'ddsz@gmail.com');

insert into transporterEmail values(3,'fgh@gmail.com');

insert into employee(EMPNAME,EMPAGE,SALARY,house,street,city,state,pincode,adminName,acNo,ifsc) values('Raghav',24,10000,'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'hello',31339608617,'SBIN01458');

insert into employee(EMPNAME,EMPAGE,SALARY,house,street,city,state,pincode,adminName,acNo,ifsc) values('Suyash',27,10000,'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'hello',31339608677,'SBIN01458');

insert into employee(EMPNAME,EMPAGE,SALARY,house,street,city,state,pincode,adminName,acNo,ifsc) values('Keshav',24,10000,'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005,'hello',31339603437,'SBIN01458');	

insert into employeePhone values(1,2177026638);

insert into employeePhone values(2,4177026638);

insert into employeePhone values(3,4770266383);

insert into employeeEmail values(1,'xyz@gmail.com');

insert into employeeEmail values(2,'ddsz@gmail.com');

insert into employeeEmail values(3,'fgh@gmail.com');

insert into manufacturer values('Sony','2015-10-20','2020-12-10',1);

insert into manufacturer values('Samsung','2015-10-20','2020-12-10',2);

insert into manufacturer values('Apple','2015-10-20','2020-12-10',1);

insert into manufacturer values('LG','2015-10-20','2020-12-10',2);

insert into manPhone values('Sony',2177026638);

insert into manPhone values('Samsung',4177026638);

insert into manPhone values('Apple',4770266383);

insert into manPhone values('LG',4770266385);

insert into manEmail values('Sony','xyz@gmail.com');

insert into manEmail values('Samsung','ddsz@gmail.com');

insert into manEmail values('LG','fgh@gmail.com');

insert into manEmail values('Apple','fgh@gmail.com');

insert into warehouse(capacity,filled,spaceLeft,house,street,city,state,pincode) values(1000,60,940,'Room 62, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005);

insert into warehouse(capacity,filled,spaceLeft,house,street,city,state,pincode) values(1000,0,1000,'Room 63, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005);	

insert into warehouse(capacity,filled,spaceLeft,house,street,city,state,pincode) values(1000,0,1000,'Room 64, CV Raman Hostel', 'IIT BHU','Varanasi','UP',221005);	

insert into article(name,type,price,warranty,warehouseID,manufacturer,stock) values('Headphones XB50','Earphones',1000.0,2,1,'Sony',10);

insert into article(name,type,price,warranty,warehouseID,manufacturer,stock) values('Iphone X(s)','Phone',120000.0,2,1,'Apple',10);

insert into article(name,type,price,warranty,warehouseID,manufacturer,stock) values('Macbook Pro','Laptop',150000.0,2,1,'Apple',10);

insert into article(name,type,price,warranty,warehouseID,manufacturer,stock) values('Galaxy S10','Phone',80000.0,2,1,'Samsung',10);

insert into article(name,type,price,warranty,warehouseID,manufacturer,stock) values('Turbowash','Washing Machine',15000.0,2,1,'LG',10);

insert into article(name,type,price,warranty,warehouseID,manufacturer,stock) values('Single Door Fridge','Refridgerator',17000.0,2,1,'LG',10);

insert into salaryLog values(1,10000,'2018-09-30');

insert into salaryLog values(2,10000,'2018-09-30');

insert into salaryLog values(3,10000,'2018-09-30');

insert into dealerLog values(1,'1',100000,'2018-09-30');

insert into dealerLog values(2,'1',100000,'2018-09-30');

insert into dealerLog values(3,'1',100000,'2018-09-30');

insert into transporterLog values(1,'1',100000,'2018-09-30');

insert into transporterLog values(2,'1',100000,'2018-09-30');

insert into transporterLog values(3,'1',100000,'2018-09-30');