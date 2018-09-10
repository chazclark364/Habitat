create table Person(
Name char (20),
ID char (9) not null,
Address char (30),
DOB date,
Primary key (ID));

create table Pet(
Name char (20),
Breed char (20),
Owner char(20) references Person
);

insert into Person(Name, ID, Address, DOB) values('Max Minard', '075555504', '1359 Lakeway Blvd', '4-22-1998');
insert into Person(Name, ID, Address, DOB) values('test person', '123456789', '10001 WhiteHouse Blvd', '6-13-1990');
insert into Pet(Name, Breed, Owner) values('Scout', 'Beagle', 'Max Minard');


Select * from Person where ID = '075555504';
Select * from Person where Name = 'test person';

delete from Person where ID = '123456789';

select * from Pet where Owner in (select * from Person where Name = 'Max Minard');
